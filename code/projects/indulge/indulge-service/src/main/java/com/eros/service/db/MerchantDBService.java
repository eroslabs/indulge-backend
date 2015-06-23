package com.eros.service.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Issue;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantService;
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
	 * @param params
	 * @return
	 */
	public List<MerchantDeal> fetchMerchantDeals(HashMap<String, Object> params);
	
	public List<DealRequest> fetchDealRequests(Merchant merchant);
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
	
	public void deleteServices(Merchant contextMerchant);
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
	public Map<String, Object> loadMerchantByUsernameOrPhone(
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
	public Integer updatePassword(Map<String, Object> param);
	public List<MerchantService> selectMerchantServices(Integer id);
	/**
	 * @param string
	 * @return
	 */
	public Merchant fetchMerchantById(Integer val);
	/**
	 * @param params
	 */
	public void saveDealServices(HashMap<String, Object> params);
	/**
	 * @param param
	 * @return
	 */
	public Merchant merchantExist(HashMap<String, Object> param);
	/**
	 * @param issue
	 */
	public void saveIssue(Issue issue);
	/**
	 * @param param
	 * @return
	 */
	public Integer verify(Map param);
	/**
	 * Replaces the old password if old password is correct
	 * @param param
	 * @return
	 */
	public Integer changePassword(Map<String, Object> param);
	/**
	 * @param param
	 * @return
	 */
	public Integer disableImage(Map<String, Object> param);
	/**
	 * @param param
	 * @return
	 */
	public Integer disableMenuImage(Map<String, Object> param);
	/**
	 * @param merchantIdentifier
	 * @return
	 */
	public List<Merchant> fetchChainIds(String merchantIdentifier);
	
}
