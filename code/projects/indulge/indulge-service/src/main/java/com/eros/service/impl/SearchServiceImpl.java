/**
 * indulge-service
 * author vikas created on Apr 9, 2015
 */
package com.eros.service.impl;

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
import org.springframework.data.elasticsearch.core.query.Criteria;
import org.springframework.stereotype.Service;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.service.MerchantCustomService;
import com.eros.service.SearchService;
import com.eros.service.db.UserDBService;
import com.eros.service.elasticsearch.CustomRepository;
import com.eros.service.elasticsearch.MerchantDealRepository;
import com.eros.service.elasticsearch.MerchantRepository;
import com.eros.service.search.Filter;
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
@Service("searchService")
public class SearchServiceImpl implements SearchService {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(SearchServiceImpl.class);

	@Autowired
	protected UserDBService userDBService;
	
	@Autowired
	protected MerchantCustomService merchantService;
	
	@Autowired
	private MerchantRepository repository;
	
	@Autowired
	private CustomRepository customRepository;
	
	@Autowired
	private MerchantDealRepository dealRepository;
	
	

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.SearchService#findByEmail(java.lang.String)
	 */
	@Override
	public Merchant findByEmail(String email) {
		return repository.findByEmail(email);
	}

	public SearchResponse search(Filter filter) throws Exception {
		
		return customRepository.search(filter);
	}

	


	/* (non-Javadoc)
	 * @see com.eros.service.SearchService#loadDeal(java.lang.Integer)
	 */
	@Override
	public void loadDeal(Integer id) {
		List<MerchantDeal> deals = merchantService.fetchDealWithMerchant(id);
		if(deals != null && deals.size() > 0)
			for (MerchantDeal merchantDeal : deals) {
				dealRepository.index(merchantDeal);	
			}
			
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.SearchService#loadMerchant(java.lang.String)
	 */
	@Override
	public void loadMerchant(String email) {
		Merchant merchant= merchantService.getMerchantByEmail(email);
		if(merchant != null)
			repository.index(merchant);
		
	}
}
