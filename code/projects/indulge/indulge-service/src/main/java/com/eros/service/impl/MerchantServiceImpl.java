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
import com.eros.core.model.State;
import com.eros.core.model.UserReview;
import com.eros.notification.utils.Message;
import com.eros.notification.utils.NotificationService;
import com.eros.notification.utils.NotificationType;
import com.eros.service.MerchantCustomService;
import com.eros.service.db.MerchantDBService;
import com.eros.service.util.NotificationCategory;

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

	private static final int MAX_DEALS = 100;

	private static final int MAX_REVIEWS = 3;

	@Autowired
	protected MerchantDBService merchantDBService;

	@Autowired
	protected NotificationService notificationService;
	
	@Value("${merchant.base.path}")
	private String MERCHANT_BASE_PATH;

	public Merchant getMerchantByEmail(String email) {
		if (StringUtils.isEmpty(email)) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(email);
			if(merchant != null){
				merchant.setDeals(fetchDeals(merchant.getId(), 0, MAX_DEALS));
				Reviews reviews = fetchReviews(merchant.getId(), 0, MAX_REVIEWS);
				if(reviews != null && reviews.getUserReviews() != null){
					merchant.setReviews(reviews.getUserReviews());
				}
			}
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;
	}
	@Override
	public void registerMerchant(Merchant merchant) throws Exception{
		if (merchant == null) {
			return ;
		}
		try {
			Integer saved = merchantDBService
					.registerMerchant(merchant);
			if(StringUtils.isNotEmpty(merchant.getEmail())){
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("email", merchant.getEmail());
				params.put("merchant", merchant);
				sendNotification(NotificationCategory.registerNewMerchant ,params);	
			}
			
			return ;
		} catch (Exception e) {
			LOG.error("Error in saving basic profile : ", e);
			if(e instanceof org.springframework.dao.DuplicateKeyException){
				throw new Exception("Merchant with this mail id already exist",e);
			}
		}
		return ;
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
			merchantDBService.cleanSchedule(contextMerchant);
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
		return fetchDeals(id,null, start, rows);
	}
	
	@Override
	public List<MerchantDeal> fetchDeals(Integer id,String coupon, int start, int rows) {
		try{
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("id", id);
			params.put("start", start);
			params.put("rows", rows);
			params.put("coupon", coupon);
			List<MerchantDeal> merchantDeals = merchantDBService.fetchMerchantDeals(params);
			return merchantDeals;
		}catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return null;
	}
	
	@Override
	public Boolean killDeal(Integer merchantId,Integer id) {
		try{
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("merchantId", merchantId);
			params.put("dealId", id);
			Integer i = merchantDBService.killDeal(params);
			if(i> 0){return true;}
		}catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return false;
	}
	
	@Override
	public List<MerchantDeal> fetchDealWithMerchant(Integer id) {
		try{
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("id", id);
			List<MerchantDeal> merchantDeals = merchantDBService.fetchDealWithMerchant(id);
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
	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#fetchStates()
	 */
	@Override
	public List<State> fetchStates() {
		try{
			return merchantDBService.fetchStates();
		}catch (Exception e) {
			LOG.error("Error in fetching States: ", e);
		}
		return null;
	}
	
	@Override
	public Integer saveForgotPasswordRequest(String email) throws Exception{
		
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			 param.put("email", email);
			 param.put("type", 0);
			 param.put("id", 0);
			 merchantDBService.saveForgotRequest(param);
			 sendNotification(NotificationCategory.forgotPasswordTemplate ,param);
			return (Integer)param.get("id");
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("Forgot request cannot be saved",e);
		}
	}

	/**
	 * @param string
	 * @param param
	 */
	private void sendNotification(String string, Map<String, Object> param) throws Exception{
		try{
		Message message = new Message(NotificationType.MAIL);
		message.setToEmails(new String[] {param.get("email").toString()});
		message.setDataMap(param);
		message.setMessageTemplate(string);
		notificationService.sendNotification(message);
		}catch (Exception e) {
			LOG.error("Please check : There is some error in sending notification ", e);
		}
		
	}
	/* (non-Javadoc)
	 * @see com.eros.service.UserService#changePassword(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public void changePassword(String email, String requestId, String passphrase)
			throws Exception {
		try{
		Map<String, Object> param = new HashMap<String, Object>(3);
		 param.put("email", email);
		 param.put("requestId", requestId);
		 param.put("passphrase", passphrase);
		 merchantDBService.updatePassword(param);
		}catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful",e);
		}
	}
	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#getMerchantByEmailOrPhone(java.lang.String)
	 */
	@Override
	public Merchant getMerchantByEmailOrPhone(String name) {
		if (StringUtils.isEmpty(name)) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(name);
			if(merchant != null){
				merchant.setDeals(fetchDeals(merchant.getId(), 0, MAX_DEALS));
			}
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;

	}
	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#getMerchantById(java.lang.Integer)
	 */
	@Override
	public Merchant getMerchantById(Integer id) {
		if (id == null) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(id.toString());
			if(merchant != null){
				merchant.setDeals(fetchDeals(merchant.getId(), 0, MAX_DEALS));
				Reviews reviews = fetchReviews(merchant.getId(), 0, MAX_REVIEWS);
				if(reviews != null && reviews.getUserReviews() != null){
					merchant.setReviews(reviews.getUserReviews());
				}
			}
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;

		
	}	
}
