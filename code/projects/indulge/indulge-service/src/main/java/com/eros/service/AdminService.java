/**
 * indulge-service
 * author vikas created on Apr 22, 2015
 */
package com.eros.service;

import java.util.HashMap;
import java.util.List;

import com.eros.service.search.SearchResponse;

/**
 * @author vikas
 *
 */
public interface AdminService {

	/**
	 * @return
	 */
	List<HashMap<String, String>> getMerchantsSummary() throws Exception;

	/**
	 * @param s
	 * @param page
	 * @param limit
	 * @return
	 */
	SearchResponse searchMerchant(String s, Integer page, Integer limit);

	/**
	 * @param id 
	 * @param b
	 */
	void changeMerchantStatus(Integer id, boolean b);

}