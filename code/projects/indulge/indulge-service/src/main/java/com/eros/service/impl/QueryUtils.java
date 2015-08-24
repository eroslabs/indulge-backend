/**
 * indulge-service
 * author vikas created on Apr 13, 2015
 */
package com.eros.service.impl;

import static org.elasticsearch.index.query.FilterBuilders.andFilter;
import static org.elasticsearch.index.query.FilterBuilders.boolFilter;
import static org.elasticsearch.index.query.FilterBuilders.geoDistanceFilter;
import static org.elasticsearch.index.query.FilterBuilders.inFilter;
import static org.elasticsearch.index.query.FilterBuilders.rangeFilter;
import static org.elasticsearch.index.query.FilterBuilders.termFilter;
import static org.elasticsearch.index.query.FilterBuilders.termsFilter;
import static org.elasticsearch.index.query.QueryBuilders.boolQuery;
import static org.elasticsearch.index.query.QueryBuilders.matchAllQuery;
import static org.elasticsearch.index.query.QueryBuilders.queryString;
import static org.elasticsearch.index.query.QueryBuilders.termQuery;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.common.geo.GeoDistance;
import org.elasticsearch.common.unit.DistanceUnit;
import org.elasticsearch.index.query.AndFilterBuilder;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.FilterBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.search.sort.SortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;

import com.eros.service.search.Filter;


/**
 * @author vikas
 *
 */
public class QueryUtils implements SearchConstants{

	private static SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	

	private static final Object DEFAULT_HOMESERVICE = new Integer(2);

	/**
	 * @param filter
	 * @return
	 */
	public static SortBuilder generateSortBuilder(Filter filter) {
		SortBuilder sort = null;
		if(filter.getSortField() == null){
			sort = SortBuilders.scoreSort();
		}else{
			if(filter.getSortField().equalsIgnoreCase(DISTANCE_PARAMETER) && filter.getPoint() != null){
				sort = SortBuilders.geoDistanceSort(GEO_FIELD).point(filter.getPoint().getLat(), filter.getPoint().getLon()).order(SortOrder.ASC).unit(DistanceUnit.KILOMETERS).missing("_last");
			}else if(filter.getSortField().equalsIgnoreCase(PRICE_PARAMETER) ){
				sort = SortBuilders.fieldSort(PRICE_FIELD).order(filter.getDirection());
			}else if(filter.getSortField().equalsIgnoreCase(POPULARITY_PARAMETER) ){
				sort = SortBuilders.fieldSort(REVIEWS_FIELD).order(filter.getDirection());
			}else{
				sort = SortBuilders.fieldSort(RATING_FIELD).order(filter.getDirection());
			}
			
				
		}
		return sort;
	}

	/**
	 * @param filter
	 * @param mERCHANT_SEARCH_FIELDS
	 * @param mERCHANT_FIELDS_BOOST
	 * @return
	 */
	public static QueryBuilder buildQuery(Filter filter,
			String configuredFields, String configuredBoost) {
		QueryBuilder queryBuilder = null;
		BoolQueryBuilder boolQueryBuilder = null;
		if (StringUtils.isNotBlank(filter.getSearch())) {
			
			
			String[] searchFields = null;
			String[] boost = null;
			if(StringUtils.isNotBlank(configuredFields) && !configuredFields.contains("$")){
				searchFields = configuredFields.split(COMMA_SPLITTER);
				if(StringUtils.isNotBlank(configuredBoost)){
					boost = configuredBoost.split(COMMA_SPLITTER);
				}
			}
			if(searchFields != null && searchFields.length ==6 && boost != null && boost.length ==6 ){
				boolQueryBuilder = boolQuery().should(
						queryString(ALL_REGEX + filter.getSearch() + ALL_REGEX)
								.analyzeWildcard(true).field(searchFields[0],Float.parseFloat(boost[0]) )
								.field(searchFields[1],Float.parseFloat(boost[1])).field(searchFields[2],Float.parseFloat(boost[2]))
								.field(searchFields[3],Float.parseFloat(boost[3])).field(searchFields[4],Float.parseFloat(boost[4]))
								.field(searchFields[5],Float.parseFloat(boost[5])));
				
			}else{
				boolQueryBuilder = boolQuery().should(
					queryString(ALL_REGEX + filter.getSearch() + ALL_REGEX)
							.analyzeWildcard(true)
							.field(NAME_FIELD, 5.0f)
							.field(ADDRESS_FIELD, 1.5f)
							.field(SERVICES_NAME_FIELD,2.0f));
			}
			if(StringUtils.isNotBlank(filter.getCity())){
				boolQueryBuilder.must(termQuery(CITY_FIELD, filter.getCity()));
			}
			queryBuilder = boolQueryBuilder;
			 
		} else {
			queryBuilder = matchAllQuery();
		}

		return queryBuilder;
	}

	/**
	 * @param filter
	 * @return
	 */
	public static AndFilterBuilder generateFilters(Filter filter , String distance) {
		AndFilterBuilder andBuilder = null;
		
		ArrayList<FilterBuilder> filterBuilderList = new ArrayList<FilterBuilder>();

		if (filter.getGenderSupport() != null) {
			filterBuilderList.add(boolFilter().must( 
					inFilter(GENDER_FIELD, filter.getGenderSupport(),DEFAULT_HOMESERVICE )));
		}
		if (filter.getPriceTo() != null) {
			filterBuilderList.add(rangeFilter(PRICE_FIELD).from(filter.getPriceFrom()).to(
							filter.getPriceTo()).includeUpper(false));
		}
		if (filter.getHomeService() != null ) {
			filterBuilderList.add(boolFilter().must(inFilter(HOME_SERVICE_FIELD,filter.getHomeService(),DEFAULT_HOMESERVICE)));
		}
		if (StringUtils.isNotBlank(filter.getType()) && filter.getType().indexOf("deal") != -1) {
			filterBuilderList.add(boolFilter().must(rangeFilter(VALID_TILL_DATE_FIELD).gt(sdfDate.format(new Date()))));
		}
		if (filter.getLuxury() != null ) {
			filterBuilderList.add(boolFilter().must(
					termFilter(LUXURY_FIELD, filter.getLuxury())));
		}
		if (filter.getServices() != null && filter.getServices().length >0) {
			filterBuilderList.add(termsFilter(SERVICES_ID_FIELD, filter.getServices()));
		}
		 if(filter.getPoint() != null){
			 filterBuilderList.add(geoDistanceFilter(GEO_FIELD)    
			    .point(filter.getPoint().getLat(), filter.getPoint().getLon())                                         
			    .distance(StringUtils.isNotBlank(distance)?Integer.parseInt(distance):100, DistanceUnit.KILOMETERS)                 
			    .optimizeBbox(MEMORY)                                 
			    .geoDistance(GeoDistance.ARC));
		 }
		if (filterBuilderList.size() > 0) {
			for (FilterBuilder builder : filterBuilderList) {
				if(andBuilder == null){
					andBuilder = andFilter(builder);	
				}else{
					andBuilder.add(builder);
				}
				
			}

		}
		return andBuilder;
	}

	/**
	 * @param filter.gets
	 * @return
	 */
	public static HashMap<String, QueryBuilder> buildSuggestQuery(Filter filter) {
		HashMap<String, QueryBuilder> returnQueries = new HashMap<String, QueryBuilder>();
		QueryBuilder serviceBuilder = boolQuery().should(
				queryString(ALL_REGEX + filter.getSearch() + ALL_REGEX)
				.analyzeWildcard(true).field(SERVICES_NAME_FIELD));
		returnQueries.put(SERVICES_NAME_FIELD, serviceBuilder);
		BoolQueryBuilder queryBuilder = boolQuery().should(
					queryString(ALL_REGEX + filter.getSearch() + ALL_REGEX)
					.analyzeWildcard(true).field(NAME_FIELD, 5.0f)
					.field(ADDRESS_FIELD, 0.1f));
		if(StringUtils.isNotBlank(filter.getCity())){
			queryBuilder.must(termQuery(CITY_FIELD, filter.getCity()));
		}
		returnQueries.put(NAME_FIELD, queryBuilder);
//			queryBuilder = new RegexpQueryBuilder(NAME_FIELD,filter.getSearch() + "."+ALL_REGEX);
		return returnQueries;
	}

	

}
