/**
 * indulge-service
 * author vikas created on Apr 16, 2015
 */
package com.eros.service.elasticsearch;

import static org.elasticsearch.index.query.QueryBuilders.boolQuery;
import static org.elasticsearch.index.query.QueryBuilders.queryString;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.Client;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.AndFilterBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.sort.SortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.service.impl.QueryUtils;
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
	/**
	 * 
	 */
	private static final Integer MAX_RECORDS = 100;
	private static final Logger LOGGER = LoggerFactory
			.getLogger(CustomRepository.class);
	private static final String autosuggestKey = "name";
	@Autowired
	private Client client;
	
	@Value("${merchant.search.fields}")
	private String MERCHANT_SEARCH_FIELDS;
	
	@Value("${merchant.fields.boost}")
	private String MERCHANT_FIELDS_BOOST;
	
	@Value("${indulge.geo.distance}")
	private String distance;

public SearchResponse search(Filter filter) throws Exception {
		if(filter.getAutoSuggest() != null && filter.getAutoSuggest()){
			return searchAutoSuggest(filter);
		}
		QueryBuilder queryBuilder = QueryUtils.buildQuery(filter, MERCHANT_SEARCH_FIELDS,MERCHANT_FIELDS_BOOST);
		
		AndFilterBuilder andBuilder = QueryUtils.generateFilters(filter,distance);
		SortBuilder sortBuilder =  QueryUtils.generateSortBuilder(filter);
		org.elasticsearch.action.search.SearchResponse response = null;
		SearchResponse returnResponse = new SearchResponse();
		try {
			response = client.prepareSearch(filter.getIndex()).setTypes(filter.getType())
					.setSearchType(SearchType.DFS_QUERY_THEN_FETCH)
					.setQuery(queryBuilder)
					.setPostFilter(andBuilder)
//					.setFrom(filter.getPage())
					.setSize(MAX_RECORDS)
					.addSort(sortBuilder)
					.setExplain(false).execute().actionGet();

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
 * @param filter
 * @return
 */
private SearchResponse searchAutoSuggest(Filter filter) throws Exception{
	HashMap<String,QueryBuilder> queryBuilder = QueryUtils.buildSuggestQuery(filter);
	org.elasticsearch.action.search.SearchResponse response = null;
	SearchResponse returnResponse = new SearchResponse();
	try {
		List<Object> list = new ArrayList<Object>();
		for (String key : queryBuilder.keySet()) {
			response = client.prepareSearch(filter.getIndex()).setTypes(filter.getType())
					.setSearchType(SearchType.DFS_QUERY_THEN_FETCH).addField(key)
					.setQuery(queryBuilder.get(key)).setScroll(new TimeValue(60000))
					.setFrom(filter.getPage()).setSize(key.equals(QueryUtils.NAME_FIELD) ? 10 : 2)
					.setExplain(false).addSort(SortBuilders.scoreSort()).execute().actionGet();
			
			    for (SearchHit hit : response.getHits()) {
			    	if(hit.getFields() != null && hit.getFields().get(key) != null){
			    	 String val = hit.getFields().get(key).getValue();
			    	 if(!list.contains(val)){
			    		 list.add(val);
			    	 }
			    	}
			    }
				
		}
		returnResponse.setTotal(Long.valueOf(list.size()));
		returnResponse.setResponse(list);
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
