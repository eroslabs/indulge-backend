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
public interface MerchantDBService {

    public Merchant fetchMerchant(String email);
    public Integer registerMerchant(Merchant merchant);
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
	public List<State> fetchStates();
	/**
	 * @param param
	 * @return
	 */
	public Map<String, String> loadMerchantByUsernameOrPhone(
			Map<String, String> param);
	/**
	 * @param params
	 */
	public Integer killDeal(HashMap<String, Object> params);
	/**
	 * @param param
	 */
	public void saveForgotRequest(Map<String, Object> param);
	/**
	 * @param param
	 */
	public void updatePassword(Map<String, Object> param);
	
	
}
