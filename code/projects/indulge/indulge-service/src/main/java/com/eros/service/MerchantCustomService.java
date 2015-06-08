package com.eros.service;

import java.util.List;
import java.util.Set;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Issue;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantService;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.State;



/**
 * 
 * @author vikas
 */
public interface MerchantCustomService extends Constants{

	public Merchant getMerchantByEmail(String Email);
	public void registerMerchant(Merchant merchant) throws Exception;
	/**
	 * @param merchant
	 */
	public Boolean saveLocation(Merchant merchant)throws Exception;
	/**
	 * @param bytes
	 * @param id 
	 * @return
	 */
	public String saveMerchantImage(byte[] bytes, Integer id,String fileName);
	/**
	 * @param merchant
	 */
	public Boolean saveAddress(Merchant merchant);
	/**
	 * @param contextMerchant
	 * @return
	 */
	public Boolean saveSchedule(Merchant contextMerchant);
	
	public Boolean savePhoto(MerchantImage image) throws Exception;
	/**
	 * @param merchant
	 */
	public void completeProfile(Merchant merchant);
	/**
	 * @param i
	 * @param j
	 * @return
	 */
	public Reviews fetchReviews(Integer merchantId, int i, int j);
	/**
	 * @return
	 */
	public List<ServiceCategory> fetchAllServices();
	/**
	 * @param deal
	 * @param serviceTypeIds 
	 * @param serviceIds 
	 * @param categoryIds 
	 * @return
	 */
	public Boolean saveDeal(MerchantDeal deal, List<Integer> categoryIds, List<Integer> serviceIds, List<Integer> serviceTypeIds)throws Exception;
	/**
	 * @param id
	 * @param coupon 
	 * @param start
	 * @param rows
	 * @return
	 */
	public List<MerchantDeal> fetchDeals(Integer id, String coupon, Integer start, Integer rows);
	public List<MerchantDeal> fetchDeals(Integer id, Integer start, Integer rows);
	public Boolean killDeal(Integer merchantId, Integer dealId) ;
	public List<DealRequest> fetchDealRequest(Merchant contextMerchant);
	/**
	 * @param contextMerchant
	 * @return
	 */
	public Boolean saveServices(Merchant contextMerchant) throws Exception;
	/**
	 * @param contextMerchant
	 * @return
	 */
	public Boolean saveDigitalMenus(Merchant contextMerchant) throws Exception;
	/**
	 * 
	 * @param id
	 * @return
	 */
	public List<MerchantDeal> fetchDealWithMerchant(Integer id);
	/**
	 * @return
	 */
	public List<State> fetchStates();
	/**
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @throws Exception
	 */
	void changePassword(String email, String requestId, String passphrase)
			throws Exception;
	/**
	 * @param email
	 * @param i 
	 * @return
	 * @throws Exception
	 */
	public String saveForgotPasswordRequest(String email, Integer i) throws Exception;
	public Boolean ifMerchantExist(String email, String phone);
	/**
	 * @param name
	 * @return
	 */
	public Merchant getMerchantByEmailOrPhone(String name);
	/**
	 * @param id
	 */
	public Merchant getMerchantById(Integer id);
	/**
	 * @param id
	 * @return
	 */
	public List<MerchantService> fetchMerchantServices(Integer id);
	/**
	 * @param contextMerchant
	 * @param phones
	 * @return
	 */
	public Boolean saveContact(Merchant contextMerchant, Set<String> phones) throws Exception;
	/**
	 * @param issue
	 * @return
	 */
	public Boolean saveIssue(Issue issue);
	/**
	 * @param identifier
	 * @param id
	 */
	public void verifyMerchant(String identifier, String id) throws Exception;
	/**
	 * @param string
	 * @param oldPassphrase
	 * @param passphrase
	 */
	public void updatePassword(String string, String oldPassphrase,
			String passphrase)  throws Exception;
	/**
	 * @param id
	 * @param merchantId 
	 */
	public void deleteImage(Integer imageId, Integer merchantId)  throws Exception;
}
