/**
 * indulge-service
 * author vikas created on Apr 9, 2015
 */
package com.eros.service;

import java.util.List;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.service.search.Filter;
import com.eros.service.search.SearchResponse;

/**
 * @author vikas
 *
 */
public interface SearchService {
	
	
	public Merchant findByEmail(String email);
	
	public SearchResponse search(Filter filter) throws Exception;



	/**
	 * @param id
	 */
	public void loadDeal(Integer id);

	/**
	 * @param email
	 */
	public void loadMerchant(String email);

}
