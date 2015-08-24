package com.eros.service.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.ReportedError;
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
	Integer countMerchant(Map<String,Object> param);

	/**
	 * @param param
	 * @return
	 */
	List<Merchant> listMerchant(Map<String, Object> param);


	/**
	 * @param param
	 * @return 
	 */
	Integer updateMerchantStatus(Map<String, Object> param);


	/**
	 * @return
	 */
	List<Integer> getAllActiveMerchantsId();


	/**
	 * @param merchant
	 */
	void saveLatLng(Merchant merchant);


	/**
	 * @param param
	 * @return
	 */
	Integer updateMerchantLuxuryRating(Map<String, Object> param);


	/**
	 * @return
	 */
	List<HashMap<String, String>> fetchRedemptionReport();


	/**
	 * @param param
	 * @return
	 */
	List<HashMap<String, String>> fetchDeals(Map<String, Object> param);


	/**
	 * @param param
	 * @return
	 */
	List<ReportedError> fetchErrors(Map<String, Object> param);

	/**
	 * @param param
	 * @return
	 */
	public Integer updateLogin(Map<String, Object> param);
	   
   }
