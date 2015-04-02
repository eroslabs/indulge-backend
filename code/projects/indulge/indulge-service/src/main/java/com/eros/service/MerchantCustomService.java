package com.eros.service;

import java.util.List;

import com.eros.core.model.DealRequest;
import com.eros.core.model.DigitalMenuImage;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;



/**
 * 
 * @author vikas
 */
public interface MerchantCustomService {

	public Merchant getMerchantByEmail(String Email);
	public Merchant registerMerchant(Merchant merchant);
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
	 * @param merchant
	 * @param phone1
	 * @param phone12
	 * @param phone3
	 * @return
	 */
	public Boolean saveContact(Merchant merchant, String phone1,
			String phone12, String phone3)throws Exception;
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
	 * @return
	 */
	public Boolean saveDeal(MerchantDeal deal)throws Exception;
	/**
	 * @param id
	 * @param start
	 * @param rows
	 * @return
	 */
	public List<MerchantDeal> fetchDeals(Integer id, int start, int rows);
	
	public List<DealRequest> fetchDealRequest(Integer id);
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
	
}
