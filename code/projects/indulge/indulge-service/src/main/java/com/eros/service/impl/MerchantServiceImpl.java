package com.eros.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eros.core.model.DealRequest;
import com.eros.core.model.Issue;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantPhone;
import com.eros.core.model.MerchantSchedule;
import com.eros.core.model.MerchantService;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.State;
import com.eros.core.model.UserReview;
import com.eros.notification.utils.Message;
import com.eros.notification.utils.NotificationService;
import com.eros.notification.utils.NotificationType;
import com.eros.service.MerchantCustomService;
import com.eros.service.db.MerchantDBService;
import com.eros.service.elasticsearch.MerchantDealRepository;
import com.eros.service.util.NotificationCategory;
import com.eros.service.util.TinyUrlUtility;

/**
 * 
 * @author vikas
 * 
 */
@Service("merchantService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class MerchantServiceImpl implements MerchantCustomService {

	/**
	 * 
	 */
	

	/**
	 * 
	 */
	

	private static final Logger LOG = LoggerFactory
			.getLogger(MerchantServiceImpl.class);

	private static final int MAX_DEALS = 100;

	private static final int MAX_REVIEWS = 3;

	private static final Object BLANK_SCHEDULE = "0000000";

	@Autowired
	protected MerchantDBService merchantDBService;

	@Autowired
	protected NotificationService notificationService;

	@Autowired
	private MerchantDealRepository dealRepository;

	@Value("${merchant.base.path}")
	private String MERCHANT_BASE_PATH;

	@Value("${merchant.enable.sms}")
	private Boolean MERCHANT_ENABLE_SMS;

	public Merchant ifMerchantExist(String email, String phone) {
		HashMap<String, Object> param = new HashMap<String, Object>(3);
		// blank is being passed
		if(StringUtils.isBlank(email)){
			email=null;
		}
		param.put(EMAIL, email);
		param.put(PHONE, phone);
		param.put(EXIST, null);
		Merchant merchant = merchantDBService.merchantExist(param);

		return merchant;
	}

	public Merchant getMerchantByEmail(String email) {
		if (StringUtils.isEmpty(email)) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(email);
			if (merchant != null) {
				merchant.setDeals(fetchDeals(merchant.getId(), 0, MAX_DEALS));
				Reviews reviews = fetchReviews(merchant.getId(), 0, MAX_REVIEWS);
				if (reviews != null && reviews.getUserReviews() != null) {
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
	public void registerMerchant(Merchant merchant) throws Exception {
		if (merchant == null) {
			return;
		}
		try {
			Integer saved = merchantDBService.registerMerchant(merchant);
			if (StringUtils.isNotEmpty(merchant.getEmail())) {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put(EMAIL, merchant.getEmail());
				params.put(MERCHANT, merchant);
				sendNotification(NotificationCategory.registerNewMerchant,
						merchant, null);
			}

			return;
		} catch (Exception e) {
			LOG.error("Error in saving basic profile : ", e);
			if (e instanceof org.springframework.dao.DuplicateKeyException) {
				throw new Exception("Merchant with this mail id already exist",
						e);
			}
			throw new Exception(e.getMessage());
		}
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
				file.mkdirs();
			}
			String name = RandomStringUtils.random(8, false, true);
			if(StringUtils.isNotBlank(fileName) && fileName.indexOf(".") != -1){
				name = name + fileName.substring(fileName.lastIndexOf("."));
			}
			File uploadedFile = new File(file, name);
			if (!uploadedFile.exists()) {
				uploadedFile.createNewFile();
			}

			BufferedOutputStream stream = new BufferedOutputStream(
					new FileOutputStream(uploadedFile));
			stream.write(bytes);
			stream.close();
			return new StringBuilder().append(id).append(File.separator)
					.append(name).toString();

		} catch (Exception e) {
			LOG.error("Error in saving merchant image : " + MERCHANT_BASE_PATH
					+ File.separator + id, e);
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
	 * , java.util.set)
	 */
	@Override
	public Boolean saveContact(Merchant merchant, Set<String> phones)
			throws Exception {
		List<MerchantPhone> phoneList = new ArrayList<MerchantPhone>(3);
		for (String phone : phones) {

			if (StringUtils.isNotBlank(phone)) {
				MerchantPhone merchantPhone = new MerchantPhone(phone,
						merchant.getId());
				phoneList.add(merchantPhone);
			}
		}
		if (phoneList.isEmpty()) {
			return false;
		} else {
			merchant.setPhones(phoneList);
		}
		try {
			merchantDBService.cleanContacts(merchant);
			merchantDBService.saveContact(merchant);
			if (StringUtils.isNotBlank(merchant.getSoftware())) {
				merchantDBService.saveSoftware(merchant);
			}
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving merchant phones: ", e);
			throw new Exception("error in saving contact", e);
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
		try {
			if (contextMerchant.getSchedule() != null
					&& contextMerchant.getSchedule().size() > 0) {
				for (Iterator<MerchantSchedule> it = contextMerchant.getSchedule().iterator(); it.hasNext();) {
					MerchantSchedule schedule = it.next();
				    if (StringUtils.isBlank(schedule.getOpeningTime()) || StringUtils.isBlank(schedule.getClosingTime()) || StringUtils.isBlank(schedule.getWeekSchedule()) || schedule.getWeekSchedule().trim().equals(BLANK_SCHEDULE)) { 
				        it.remove(); 
				    }
				}
				merchantDBService.cleanSchedule(contextMerchant);
				merchantDBService.saveSchedule(contextMerchant);
			}
			return true;
		} catch (Exception e) {
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantService#completeProfile(com.eros.core.model.
	 * Merchant)
	 */
	@Override
	public void completeProfile(Merchant merchant) {
		try {
			merchantDBService.completeProfile(merchant);

		} catch (Exception e) {
			LOG.error("Error in saving merchant images: ", e);
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantService#fetchReviews(int, int)
	 */
	@Override
	public Reviews fetchReviews(Integer merchantId, int i, int j) {
		try {
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put(ID, merchantId);
			params.put(START, i);
			params.put(ROWS, j);
			Integer total = merchantDBService
					.fetchTotalMerchantReviews(merchantId);
			Reviews reviews = null;
			if (total != null && total > 0) {
				List<UserReview> userReviews = merchantDBService
						.fetchMerchantReviews(params);
				reviews = new Reviews(total);
				reviews.setUserReviews(userReviews);
			}
			return reviews;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant reviews: ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantService#fetchAllServices()
	 */
	@Override
	public List<ServiceCategory> fetchAllServices() {
		try {
			List<ServiceCategory> categories = merchantDBService
					.fetchAllServiceCategories();
			return categories;
		} catch (Exception e) {
			LOG.error("Error in fetching all services: ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantCustomService#saveDeal(com.eros.core.model.
	 * MerchantDeal)
	 */
	@Override
	public Boolean saveDeal(MerchantDeal deal, List<Integer> categoryIds,
			List<Integer> serviceIds, List<Integer> serviceTypeIds)
			throws Exception {

		try {
			merchantDBService.saveDeal(deal);
			if (deal.getId() != null) {
				HashMap<String, Object> params = new HashMap<String, Object>(3);
				params.put(
						SERVICE_IDS_PARAM,
						serviceIds != null && serviceIds.size() > 0 ? serviceIds
								: null);
				params.put(SERVICE_TYPE_IDS_PARAM, serviceTypeIds != null
						&& serviceTypeIds.size() > 0 ? serviceTypeIds : null);
				params.put(
						CATEGORY_IDS_PARAM,
						categoryIds != null && categoryIds.size() > 0 ? categoryIds
								: null);
				params.put(DEAL_ID, deal.getId());
				params.put(MERCHANT_ID, deal.getMerchantId());
				merchantDBService.saveDealServices(params);
//				delete and save all merchant deals to elastic cache
				dealRepository.deleteByMerchantId(deal.getMerchantId());
				List<MerchantDeal> deals = fetchDealWithMerchant(deal.getMerchantId());
				if (deals != null && deals.size() > 0) { 
					for (MerchantDeal merchantDeal : deals) {
						dealRepository.index(merchantDeal);	
					}
					
				}
			}
			return true;
		} catch (Exception e) {
			LOG.error("Error in fetching all services: ", e);
			throw new Exception("Error in saving deal", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantCustomService#fetchDeals(java.lang.Integer,
	 * int, int)
	 */
	@Override
	public List<MerchantDeal> fetchDeals(Integer id, Integer start, Integer rows) {
		return fetchDeals(id, null, start, rows);
	}

	@Override
	public List<MerchantDeal> fetchDeals(Integer id, String coupon,
			Integer start, Integer rows) {
		try {
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put(ID, id);
			params.put(START, start);
			params.put(ROWS, rows);
			params.put("coupon", coupon);
			List<MerchantDeal> merchantDeals = merchantDBService
					.fetchMerchantDeals(params);
			return merchantDeals;
		} catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return null;
	}

	@Override
	public Boolean killDeal(Integer merchantId, Integer id) {
		try {
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put("merchantId", merchantId);
			params.put("dealId", id);
			Integer i = merchantDBService.killDeal(params);
			// removing from cache if present
			dealRepository.delete(id);
			if (i > 0) {
				return true;
			}
		} catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return false;
	}

	@Override
	public List<MerchantDeal> fetchDealWithMerchant(Integer id) {
		try {
			HashMap<String, Object> params = new HashMap<String, Object>(3);
			params.put(ID, id);
			List<MerchantDeal> merchantDeals = merchantDBService
					.fetchDealWithMerchant(id);
			return merchantDeals;
		} catch (Exception e) {
			LOG.error("Error in fetching deals services: ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#fetchDealRequest(java.lang.Integer
	 * )
	 */
	@Override
	public List<DealRequest> fetchDealRequest(Merchant merchant) {
		try {
			List<DealRequest> request = merchantDBService
					.fetchDealRequests(merchant);
			return request;
		} catch (Exception e) {
			LOG.error("Error in fetching all deal requests: ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#saveServices(com.eros.core.model
	 * .Merchant)
	 */
	@Override
	public Merchant saveServices(Merchant contextMerchant) throws Exception {
		try {
			if(contextMerchant.getServices() != null && contextMerchant.getServices().size() > 0){
				merchantDBService.deleteServices(contextMerchant);
				Map<String, Object> param = new HashMap<String, Object>(1);
				param.put("list", contextMerchant.getServices());
				merchantDBService.saveServices(param);
			}
			contextMerchant = getMerchantById(contextMerchant.getId());
			return contextMerchant;
		} catch (Exception e) {
			LOG.error("Error in saving Services: ", e);
			throw new Exception("Error in saving merchant services", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#saveDigitalMenus(java.util.List)
	 */
	@Override
	public Boolean saveDigitalMenus(Merchant contextMerchant) throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(1);
			if(contextMerchant.getMenus() != null && contextMerchant.getMenus().size() > 0){
			param.put("list", contextMerchant.getMenus());
			merchantDBService.saveMerchantMenu(param);
			}
			merchantDBService.updateServiceMeta(contextMerchant);
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving Services: ", e);
			throw new Exception("Error in saving digital menus", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.MerchantCustomService#fetchStates()
	 */
	@Override
	public List<State> fetchStates() {
		try {
			return merchantDBService.fetchStates();
		} catch (Exception e) {
			LOG.error("Error in fetching States: ", e);
		}
		return null;
	}

	@Override
	public String saveForgotPasswordRequest(String merchantIdentifier,
			Integer type) throws Exception {

		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(EMAIL, merchantIdentifier);
			param.put(TYPE, type);
			param.put(IDENTIFIER, RandomStringUtils.random(8, false, true));
			Merchant merchant = getMerchantByEmailOrPhone(merchantIdentifier);
			if (merchant == null) {
				throw new Exception("Merchant doesnt exist with this email");
			}
			merchantDBService.saveForgotRequest(param);
			param.put(MERCHANT, merchant);
			sendNotification(NotificationCategory.forgotPasswordTemplate,
					merchant, param.get(IDENTIFIER).toString());
			return param.get(IDENTIFIER).toString();
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("Forgot request cannot be saved", e);
		}
	}

	/**
	 * @param string
	 * @param param
	 */
	private void sendNotification(String template, Merchant merchant,
			String identifier) throws Exception {
		try {
			if (StringUtils.isBlank(template)) {
				return;
			}
			Message message = new Message(NotificationType.BOTH);
			if (MERCHANT_ENABLE_SMS
					&& StringUtils.isNotBlank(merchant.getPhone())) {
				message.setPhoneNumbers(new String[] { merchant.getPhone() });
			}

			if (StringUtils.isNotBlank(merchant.getEmail())) {
				message.setToEmails(new String[] { merchant.getEmail() });
			}
			Map<String, Object> map = new HashMap<String, Object>();
			if (template.equals(NotificationCategory.registerNewMerchant)) {
				map.put(VERIFICATION_URL, TinyUrlUtility.getTinyUrl(String
						.format(VERIFY_MARCHANT_TEMPLATE,
								merchant.getEmail() != null ? merchant
										.getEmail() : merchant.getPhone(),
								merchant.getId())));
			} else if (template
					.equals(NotificationCategory.forgotPasswordTemplate)) {
				map.put(VERIFICATION_URL, TinyUrlUtility.getTinyUrl(String
						.format(FORGOT_PASSWORD_URL_TEMPLATE, merchant
								.getEmail() != null ? merchant.getEmail()
								: merchant.getPhone(), identifier)));
			}
			map.put(MERCHANT, merchant);
			message.setDataMap(map);
			message.setMessageTemplate(template);
			notificationService.sendNotification(message);
		} catch (Exception e) {
			LOG.error(
					"Please check : There is some error in sending notification ",
					e);
		}

	}

	/*
	 * Changes The password for change password request (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#changePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void changePassword(String email, String requestId, String passphrase)
			throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(EMAIL, email);
			param.put(REQUEST_ID, requestId);
			param.put(PASSPHRASE, passphrase);
			Integer i = merchantDBService.updatePassword(param);
			if (i <= 0) {
				throw new Exception("Error in update password");
			}
		} catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#getMerchantByEmailOrPhone(java
	 * .lang.String)
	 */
	@Override
	public Merchant getMerchantByEmailOrPhone(String name) {
		if (StringUtils.isEmpty(name)) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchant(name);
			if (merchant != null) {
				merchant.setDeals(fetchDeals(merchant.getId(), 0, MAX_DEALS));
			}
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#getMerchantById(java.lang.Integer)
	 */
	@Override
	public Merchant getMerchantById(Integer id) {
		if (id == null) {
			return null;
		}
		try {
			Merchant merchant = merchantDBService.fetchMerchantById(id);
			if (merchant != null) {
				merchant.setDeals(fetchDealWithMerchant(merchant.getId()));
				if (merchant.getTotalReviews() > 0) {
					Reviews reviews = fetchReviews(merchant.getId(), 0,
							MAX_REVIEWS);
					if (reviews != null && reviews.getUserReviews() != null) {
						merchant.setReviews(reviews.getUserReviews());
					}
				}
			}
			return merchant;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#fetchMerchantServices(java.lang
	 * .Integer)
	 */
	@Override
	public List<MerchantService> fetchMerchantServices(Integer id) {
		if (id == null) {
			return null;
		}
		try {
			List<MerchantService> services = merchantDBService
					.selectMerchantServices(id);
			return services;
		} catch (Exception e) {
			LOG.error("Error in fetching merchant", e);
		}
		return null;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#saveIssue(com.eros.core.model.
	 * Issue)
	 */
	@Override
	public Boolean saveIssue(Issue issue) {
		try {
			if (issue == null) {
				throw new Exception("Issue doesnt exist. ");
			}
			merchantDBService.saveIssue(issue);
			return true;
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
		}

		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#verifyMerchant(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	public void verifyMerchant(String identifier, String id) throws Exception {
		if (StringUtils.isBlank(id) || StringUtils.isBlank(identifier)) {
			throw new Exception("Invalid verification request");
		}
		try {
			Map param = new HashMap<String, String>();
			param.put(IDENTIFIER, identifier);
			param.put(ID, id);
			Integer count = merchantDBService.verify(param);
			if (count == null || count == 0) {
				throw new Exception("Invalid verification request");
			}
		} catch (Exception e) {
			LOG.error("Invalid verification request", e);
			throw e;
		}

	}

	/*
	 * Replaces the merchant password (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.MerchantCustomService#updatePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void updatePassword(String identifier, String oldPassphrase,
			String passphrase) throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(IDENTIFIER, identifier);
			param.put(OLD_PASSPHRASE, oldPassphrase);
			param.put(PASSPHRASE, passphrase);
			Integer i = merchantDBService.changePassword(param);
			if (i <= 0) {
				throw new Exception("Error in update password");
			}
		} catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful", e);
		}

	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#deleteImage(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public void deleteImage(Integer imageId, Integer merchantId) throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(MERCHANT_ID, merchantId);
			param.put(IMAGE_ID, imageId);
			Integer i = merchantDBService.disableImage(param);
			if (i <= 0) {
				throw new Exception("Error in disabling Image" + imageId);
			}
		} catch (Exception e) {
			LOG.error("Error in disabling image : ", e);
			throw new Exception("Error in disabling image", e);
		}
		
	}
	
	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#deleteImage(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public void deleteMenuImage(Integer imageId, Integer merchantId) throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(MERCHANT_ID, merchantId);
			param.put(IMAGE_ID, imageId);
			Integer i = merchantDBService.disableMenuImage(param);
			if (i <= 0) {
				throw new Exception("Error in removing Image" + imageId);
			}
		} catch (Exception e) {
			LOG.error("Error in disabling image : ", e);
			throw new Exception("Error in disabling image", e);
		}
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#getChainInfo(java.lang.String)
	 */
	@Override
	public List<Merchant> getChainInfo(String merchantIdentifier) {
		List<Merchant> chainList = null;
		try{
			chainList = merchantDBService.fetchChainIds(merchantIdentifier);
		} catch (Exception e) {
			//ignoring since it will be called everytime.
		}
		return chainList;
	}

}
