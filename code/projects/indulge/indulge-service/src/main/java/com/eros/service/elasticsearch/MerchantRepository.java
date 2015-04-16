/**
 * indulge-service
 * author vikas created on Apr 8, 2015
 */
package com.eros.service.elasticsearch;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.eros.core.model.Merchant;

/**
 * @author vikas
 *
 */
public interface MerchantRepository extends ElasticsearchRepository<Merchant, String>{
	
	Merchant findByEmail(String email);
}
