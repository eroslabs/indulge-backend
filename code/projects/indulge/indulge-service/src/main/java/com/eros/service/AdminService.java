/**
 * indulge-service
 * author vikas created on Apr 22, 2015
 */
package com.eros.service;

import java.util.HashMap;
import java.util.List;

import com.eros.core.model.Merchant;
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
	 * @param phone 
	 * @param email 
	 * @param type 
	 * @param locality 
	 * @param city 
	 * @param page
	 * @param limit
	 * @return
	 */
	SearchResponse searchMerchant(String s, String city, String locality, String type, String email, String phone, Integer page, Integer limit);

	/**
	 * @param id 
	 * @param b
	 */
	void changeMerchantStatus(Integer id, boolean b);

	/**
	 * 
	 */
	void uploadAllActiveMerchants();
	/**
	 * 
	 * @param id
	 */
	public void addToCache(Integer id);

	/**
	 * @param page
	 * @param limit
	 * @return
	 */
	SearchResponse fetchDeactiveMerchant(Integer page, Integer limit);

	/**
	 * @param id
	 */
	void fetchAndUpdateLatLng(List<Integer> id)  throws Exception;

	/**
	 * @param id
	 * @param rating
	 */
	void setMerchantLuxuryRating(Integer id, Integer rating);
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, String>> getRedemptionReport() throws Exception ;

	/**
	 * @param page
	 * @param limit
	 * @return
	 */
	public SearchResponse fetchDeals(Integer page, Integer limit);

	/**
	 * @param page
	 * @param limit
	 * @return
	 */
	SearchResponse fetchErrors(Integer page, Integer limit);
	
	public Merchant getMerchantById(Integer id);
	
	public void updateMerchantLogin(Integer id,String email,String phone,String role);
}
