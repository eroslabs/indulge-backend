package com.eros.service.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.UserReview;

/**
 * 
 * @author vikas
 */
public interface MerchantDBService {

    public Merchant fetchMerchant(String email);
    public Merchant registerMerchant(Merchant merchant);
	/**
	 * @param merchant
	 */
	public Integer saveLocation(Merchant merchant);
	/**
	 * @param merchant
	 */
	public void saveAddress(Merchant merchant);
	/**
	 * @param merchant
	 */
	public void saveContact(Merchant merchant);
	/**
	 * 
	 */
	public void saveSchedule(Merchant merchant);
	
	public void savePhoto(MerchantImage image);
	/**
	 * @param merchant
	 */
	public Integer saveSoftware(Merchant merchant);
	/**
	 * @param merchant
	 */
	public void completeProfile(Merchant merchant);
	/**
	 * @param params
	 * @return
	 */
	public List<UserReview> fetchMerchantReviews(HashMap<String, Object> params);
	/**
	 * @param merchantId
	 * @return
	 */
	public Integer fetchTotalMerchantReviews(Integer merchantId);
	/**
	 * @return
	 */
	public List<ServiceCategory> fetchAllServiceCategories();
	/**
	 * 
	 */
	public Integer saveDeal(MerchantDeal deal);
	/**
	 * @param param
	 */
	public void saveDealServices(Map<String, Object> param);
	/**
	 * @param params
	 * @return
	 */
	public List<MerchantDeal> fetchMerchantDeals(HashMap<String, Object> params);
	
	public List<DealRequest> fetchDealRequests(Integer id);
	/**
	 * @param param
	 */
	public void saveServices(Map<String, Object> param);
	/**
	 * @param contextMerchant
	 */
	public Integer updateServiceMeta(Merchant contextMerchant);
	/**
	 * @param param
	 */
	public void saveMerchantMenu(Map<String, Object> param);
	/**
	 * @param merchant
	 */
	public void cleanContacts(Merchant merchant);
	/**
	 * @param contextMerchant
	 */
	public void cleanSchedule(Merchant contextMerchant);
	/**
	 * @param id
	 * @return
	 */
	public List<MerchantDeal> fetchDealWithMerchant(Integer id);
	
}
