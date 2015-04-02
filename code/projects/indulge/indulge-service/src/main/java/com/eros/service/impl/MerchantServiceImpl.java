package com.eros.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eros.core.model.DealRequest;
import com.eros.core.model.DealService;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantPhone;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.UserReview;
import com.eros.service.MerchantCustomService;
import com.eros.service.db.MerchantDBService;

/**
 * 
 * @author vikas
 * 
 */
@Service("merchantService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class MerchantServiceImpl implements MerchantCustomService {
	private static final Logger LOG = LoggerFactory
			.getLogger(MerchantServiceImpl.class);

	@Autowired
	protected MerchantDBService merchantDBService;

	@Value("${merchant.base.path}")
	private String MERCHANT_BASE_PATH;

	public Merchant getMerchantByEmail(String email) {
		if (StringUtils.isEmpty(email)) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(email);
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;
	}

	public Merchant registerMerchant(Merchant merchant) {
		if (merchant == null) {
			return null;
		}
		try {
			Merchant savedMerchant = merchantDBService
					.registerMerchant(merchant);
			return savedMerchant;
		} catch (Exception e) {
			LOG.error("Error in saving basic profile : ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantService#saveLocation(com.eros.core.model.Merchant
	 * )
	 */
	@Override
	public Boolean saveLocation(Merchant merchant) {
		if (merchant == null) {
			return false;
		}
		try {
			merchantDBService.saveLocation(merchant);
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving location profile : ", e);
		}
		return false;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantService#saveMerchantImage(byte[])
	 */
	@Override
	public String saveMerchantImage(byte[] bytes, Integer id, String fileName) {
		try {

			File file = new File(MERCHANT_BASE_PATH + File.separator + id);
			if (!file.exists()) {
				file.mkdir();
			}
			File uploadedFile = new File(file, fileName);
			if (!uploadedFile.exists()) {
				uploadedFile.createNewFile();
			}
			
			BufferedOutputStream stream = new BufferedOutputStream(
					new FileOutputStream(uploadedFile));
			stream.write(bytes);
			stream.close();
			return new StringBuilder().append(id).append(File.separator)
					.append(fileName).toString();

		} catch (Exception e) {
			LOG.error("Error in saving merchant image : ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantService#saveAddress(com.eros.core.model.Merchant
	 * )
	 */
	@Override
	public Boolean saveAddress(Merchant merchant) {
		if (merchant == null) {
			return false;
		}
		try {
			merchantDBService.saveAddress(merchant);
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving merchant address: ", e);
		}
		return false;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantService#saveContact(com.eros.core.model.Merchant
	 * , java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public Boolean saveContact(Merchant merchant, String phone1, String phone2,
			String phone3) throws Exception{
		List<MerchantPhone> phoneList = new ArrayList<MerchantPhone>(3);
		if (StringUtils.isNotBlank(phone1)) {
			MerchantPhone phone = new MerchantPhone(phone1, merchant.getId());
			phoneList.add(phone);
		}
		if (StringUtils.isNotBlank(phone2)) {
			MerchantPhone phone = new MerchantPhone(phone2, merchant.getId());
			phoneList.add(phone);
		}
		if (StringUtils.isNotBlank(phone3)) {
			MerchantPhone phone = new MerchantPhone(phone3, merchant.getId());
			phoneList.add(phone);
		}
		if (phoneList.isEmpty()) {
			return false;
		} else {
			merchant.setPhones(phoneList);
		}
		try {
			merchantDBService.cleanContacts(merchant);
			merchantDBService.saveContact(merchant);
			if(StringUtils.isNotBlank(merchant.getSoftware())){
				merchantDBService.saveSoftware(merchant);
			}
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving merchant phones: ", e);
			throw new Exception("error in saving contact",e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantService#saveSchedule(com.eros.core.model.Merchant
	 * )
	 */
	@Override
	public Boolean saveSchedule(Merchant contextMerchant) {
		try{
			merchantDBService.saveSchedule(contextMerchant);
			return true;
		}catch (Exception e) {
			LOG.error("Error in saving merchant phones: ", e);
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantService#savePhoto(byte[],
	 * java.lang.Integer, java.lang.String)
	 */
	@Override
	public Boolean savePhoto(MerchantImage image) {
		try {
			merchantDBService.savePhoto(image);
			
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving merchant images: ", e);
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantService#completeProfile(com.eros.core.model.Merchant)
	 */
	@Override
	public void completeProfile(Merchant merchant) {
		try {
			merchantDBService.completeProfile(merchant);
			
		} catch (Exception e) {
			LOG.error("Error in saving merchant images: ", e);
		}
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantService#fetchReviews(int, int)
	 */
	@Override
	public Reviews fetchReviews(Integer merchantId, int i, int j) {
		try{
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("id", merchantId);
			params.put("start", i);
			params.put("rows", j);
			Integer total = merchantDBService.fetchTotalMerchantReviews(merchantId);
			Reviews reviews = null;
			if(total != null && total > 0){
			List<UserReview> userReviews = merchantDBService.fetchMerchantReviews(params);
			reviews = new Reviews(total);
			reviews.setUserReviews(userReviews);
			}
			return reviews;
		}catch (Exception e) {
			LOG.error("Error in fetching merchant reviews: ", e);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantService#fetchAllServices()
	 */
	@Override
	public List<ServiceCategory> fetchAllServices() {
		try{
		List<ServiceCategory> categories =  merchantDBService.fetchAllServiceCategories();
		return categories;
		}catch (Exception e) {
			LOG.error("Error in fetching all services: ", e);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#saveDeal(com.eros.core.model.MerchantDeal)
	 */
	@Override
	public Boolean saveDeal(MerchantDeal deal) throws Exception {
		try{
			Integer id = merchantDBService.saveDeal(deal);
			List<DealService> services = deal.getServices();
			for (DealService dealService : services) {
				dealService.setDealId(id);
				
			}
			Map<String, Object> param = new HashMap<String, Object>(1);
			param.put("list",services);
			merchantDBService.saveDealServices(param);
			return true;
			}catch (Exception e) {
				LOG.error("Error in fetching all services: ", e);
				throw new Exception("Error in saving deal",e);
			}
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#fetchDeals(java.lang.Integer, int, int)
	 */
	@Override
	public List<MerchantDeal> fetchDeals(Integer id, int start, int rows) {
		try{
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("id", id);
			params.put("start", start);
			params.put("rows", rows);
			List<MerchantDeal> merchantDeals = merchantDBService.fetchMerchantDeals(params);
			return merchantDeals;
		}catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#fetchDealRequest(java.lang.Integer)
	 */
	@Override
	public List<DealRequest> fetchDealRequest(Integer merchantId) {
		try{
			List<DealRequest> request = merchantDBService.fetchDealRequests(merchantId);
			return request;
		}catch (Exception e) {
			LOG.error("Error in fetching all deal requests: ", e);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#saveServices(com.eros.core.model.Merchant)
	 */
	@Override
	public Boolean saveServices(Merchant contextMerchant) throws Exception{
		try{
			Map<String, Object> param = new HashMap<String, Object>(1);
			param.put("list",contextMerchant.getServices());
			merchantDBService.saveServices(param);
			return true;
		}catch (Exception e) {
			LOG.error("Error in saving Services: ", e);
			throw new Exception("Error in saving merchant services",e);
		}
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#saveDigitalMenus(java.util.List)
	 */
	@Override
	public Boolean saveDigitalMenus(Merchant contextMerchant)  throws Exception{
		try{
			Map<String, Object> param = new HashMap<String, Object>(1);
			param.put("list",contextMerchant.getMenus());
			merchantDBService.saveMerchantMenu(param);
			merchantDBService.updateServiceMeta(contextMerchant);
			return true;
		}catch (Exception e) {
			LOG.error("Error in saving Services: ", e);
			throw new Exception("Error in saving digital menus",e);
		}
	}
	
	
}
