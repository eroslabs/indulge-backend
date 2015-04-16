/**
 * indulge-service
 * author vikas created on Apr 8, 2015
 */
package com.eros.service.elasticsearch;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;

/**
 * @author vikas
 *
 */
public interface MerchantDealRepository extends ElasticsearchRepository<MerchantDeal, String>{
	
	MerchantDeal findById(String email);
}
