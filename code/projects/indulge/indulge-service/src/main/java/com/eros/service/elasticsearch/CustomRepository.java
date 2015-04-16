/**
 * indulge-service
 * author vikas created on Apr 16, 2015
 */
package com.eros.service.elasticsearch;

import static org.elasticsearch.index.query.FilterBuilders.andFilter;
import static org.elasticsearch.index.query.FilterBuilders.boolFilter;
import static org.elasticsearch.index.query.FilterBuilders.geoDistanceFilter;
import static org.elasticsearch.index.query.FilterBuilders.rangeFilter;
import static org.elasticsearch.index.query.FilterBuilders.termFilter;
import static org.elasticsearch.index.query.FilterBuilders.termsFilter;
import static org.elasticsearch.index.query.QueryBuilders.boolQuery;
import static org.elasticsearch.index.query.QueryBuilders.matchAllQuery;
import static org.elasticsearch.index.query.QueryBuilders.queryString;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.Client;
import org.elasticsearch.common.geo.GeoDistance;
import org.elasticsearch.common.unit.DistanceUnit;
import org.elasticsearch.index.query.AndFilterBuilder;
import org.elasticsearch.index.query.FilterBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.sort.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.service.impl.SearchServiceImpl;
import com.eros.service.search.Filter;
import com.eros.service.search.IndexType;
import com.eros.service.search.SearchResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

/**
 * @author vikas
 *
 */

@Service("customRepository")
public class CustomRepository {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(CustomRepository.class);
	@Autowired
	private Client client;
	
	@Value("${merchant.search.fields}")
	private String MERCHANT_SEARCH_FIELDS;
	
	@Value("${merchant.fields.boost}")
	private String MERCHANT_FIELDS_BOOST;
	
	@Value("${indulge.geo.distance}")
	private String distance;

public SearchResponse search(Filter filter) throws Exception {
		
		QueryBuilder queryBuilder = null;
		if (StringUtils.isNotBlank(filter.getSearch())) {
			String[] searchFields = null;
			String[] boost = null;
			if(StringUtils.isNotBlank(MERCHANT_SEARCH_FIELDS) && !MERCHANT_SEARCH_FIELDS.contains("$")){
				searchFields = MERCHANT_SEARCH_FIELDS.split(",");
				if(StringUtils.isNotBlank(MERCHANT_FIELDS_BOOST)){
					boost = MERCHANT_FIELDS_BOOST.split(",");
				}
			}
			if(searchFields != null && searchFields.length ==6 && boost != null && boost.length ==6 ){
				queryBuilder = boolQuery().should(
						queryString("*" + filter.getSearch() + "*")
								.analyzeWildcard(true).field(searchFields[0],Float.parseFloat(boost[0]) )
								.field(searchFields[1],Float.parseFloat(boost[1])).field(searchFields[2],Float.parseFloat(boost[2]))
								.field(searchFields[3],Float.parseFloat(boost[3])).field(searchFields[4],Float.parseFloat(boost[4]))
								.field(searchFields[5],Float.parseFloat(boost[5])));
			}else{
			queryBuilder = boolQuery().should(
					queryString("*" + filter.getSearch() + "*")
							.analyzeWildcard(true).field("name", 2.0f)
							.field("building", 1.0f).field("landmark", 1.5f)
							.field("state", 2.0f).field("pincode",2.0f).field("services.name",2.0f));
			}
			 
		} else {
			queryBuilder = matchAllQuery();
		}

		ArrayList<FilterBuilder> filterBuilderList = new ArrayList<FilterBuilder>();

		if (filter.getGenderSupport() != null) {
			filterBuilderList.add(boolFilter().must(
					termFilter("genderSupport", filter.getGenderSupport())));
		}
		if (filter.getPriceTo() != null) {
			filterBuilderList.add(rangeFilter("services.price").from(filter.getPriceFrom()).to(
							filter.getPriceTo()).includeUpper(false));
		}
		if (filter.getHomeService() != null) {
			filterBuilderList.add(boolFilter().must(
					termFilter("homeService", filter.getHomeService())));
		}
		if (filter.getServices() != null) {
			filterBuilderList.add(termsFilter("services.id", filter.getServices()));
		}
		 if(filter.getPoint() != null){
			 filterBuilderList.add(geoDistanceFilter("geo")    
			    .point(filter.getPoint().getLat(), filter.getPoint().getLon())                                         
			    .distance(StringUtils.isNotBlank(distance)?Integer.parseInt(distance):100, DistanceUnit.KILOMETERS)                 
			    .optimizeBbox("memory")                                 
			    .geoDistance(GeoDistance.ARC));
		 }
		AndFilterBuilder andBuilder = null;
		if (filterBuilderList.size() > 0) {
			for (FilterBuilder builder : filterBuilderList) {
				if(andBuilder == null){
					andBuilder = andFilter(builder);	
				}else{
					andBuilder.add(builder);
				}
				
			}

		}

		org.elasticsearch.action.search.SearchResponse response = null;
		SearchResponse returnResponse = new SearchResponse();
		try {
			response = client.prepareSearch(filter.getIndex()).setTypes(filter.getType())
					.setSearchType(SearchType.DFS_QUERY_THEN_FETCH)
					.setQuery(queryBuilder)
					// Query
					.setPostFilter(andBuilder)
					// Filter
					.setFrom(filter.getPage()).setSize(filter.getLimit()).addSort(filter.getSortField(), (filter.getDirection().equalsIgnoreCase("asc")?SortOrder.ASC:SortOrder.DESC))
					.setExplain(true).execute().actionGet();

			if (response != null && response.getHits() != null) {
				returnResponse.setTotal(response.getHits().getTotalHits());
				List<Object> list = new ArrayList<Object>();
				for (SearchHit hit : response.getHits()) {
					String source = hit.sourceAsString();
					Object t =  getGson().fromJson(source,
							filter.getType().equalsIgnoreCase(IndexType.MERCHANT.getText()) ? Merchant.class : MerchantDeal.class);
					list.add(t);

				}
				returnResponse.setResponse(list);
			}
		} catch (Exception e) {
			LOGGER.error(
					"Error in executing search with filter "
							+ filter.toString(), e);
			throw new Exception("Error in executing search");
		}
		return returnResponse;
	}

	/**
	 * @return
	 */
	private Gson getGson() {
		GsonBuilder builder = new GsonBuilder();

		// Register an adapter to manage the date types as long values
		builder.registerTypeAdapter(Date.class, new JsonDeserializer<Date>() {
			public Date deserialize(JsonElement json, Type typeOfT,
					JsonDeserializationContext context)
					throws JsonParseException {
				return new Date(json.getAsJsonPrimitive().getAsLong());
			}
		});

		Gson gson = builder.create();
		return gson;
	}

}
