package com.eros.service.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.State;
import com.eros.core.model.UserReview;

/**
 * 
 * @author vikas
 */
public interface AdminDBService {

	/**
	 * @return
	 */
	List<HashMap<String, String>> fetchMerchantsStatus();


	/**
	 * @param s
	 * @return
	 */
	Integer countMerchant(String s);

	/**
	 * @param param
	 * @return
	 */
	List<Merchant> listMerchant(Map<String, Object> param);


	/**
	 * @param param
	 */
	void updateMerchantStatus(Map<String, Object> param);

   
   }
