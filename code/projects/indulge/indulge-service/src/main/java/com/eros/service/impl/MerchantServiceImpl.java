package com.eros.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
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
	private static final String VERIFICATION_URL = "verificationUrl";

	/**
	 * 
	 */
	private static final String FORGOT_PASSWORD_URL_TEMPLATE = "http://justindulge.in/register/inputPassword?identifier=%s&requestId=%s";

	/**
	 * 
	 */
	private static final String VERIFY_MARCHANT_TEMPLATE = "http://justindulge.in/register/verifyMerchant?identifier=%s&id=%s";

	private static final Logger LOG = LoggerFactory
			.getLogger(MerchantServiceImpl.class);

	private static final int MAX_DEALS = 100;

	private static final int MAX_REVIEWS = 3;

	@Autowired
	protected MerchantDBService merchantDBService;

	@Autowired
	protected NotificationService notificationService;

	@Autowired
	private MerchantDealRepository dealRepository;

	@Value("${merchant.base.path}")
	private String MERCHANT_BASE_PATH;

	public Boolean ifMerchantExist(String email, String phone) {
		HashMap<String, Object> param = new HashMap<String, Object>(3);
		param.put("email", email);
		param.put("phone", phone);
		param.put("exist", null);
		Merchant merchant = merchantDBService.merchantExist(param);

		return (merchant == null ? false : true);
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
				params.put("email", merchant.getEmail());
				params.put("merchant", merchant);
				sendNotification(NotificationCategory.registerNewMerchant,
						merchant);
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
			merchantDBService.cleanSchedule(contextMerchant);
			merchantDBService.saveSchedule(contextMerchant);
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
			params.put("id", merchantId);
			params.put("start", i);
			params.put("rows", j);
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
						"serviceIds",
						serviceIds != null && serviceIds.size() > 0 ? serviceIds
								: null);
				params.put("serviceTypeIds", serviceTypeIds != null
						&& serviceTypeIds.size() > 0 ? serviceTypeIds : null);
				params.put(
						"categoryIds",
						categoryIds != null && categoryIds.size() > 0 ? categoryIds
								: null);
				params.put("dealId", deal.getId());
				params.put("merchantId", deal.getMerchantId());
				merchantDBService.saveDealServices(params);
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
			params.put("id", id);
			params.put("start", start);
			params.put("rows", rows);
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
			params.put("id", id);
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
	public Boolean saveServices(Merchant contextMerchant) throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(1);
			param.put("list", contextMerchant.getServices());
			merchantDBService.saveServices(param);
			return true;
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
			param.put("list", contextMerchant.getMenus());
			merchantDBService.saveMerchantMenu(param);
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
	public String saveForgotPasswordRequest(String merchantIdentifier)
			throws Exception {

		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put("email", merchantIdentifier);
			param.put("type", 0);
			param.put("identifier", RandomStringUtils.random(8, false, true));
			Merchant merchant = getMerchantByEmailOrPhone(merchantIdentifier);
			if (merchant == null) {
				throw new Exception("Merchant doesnt exist with this email");
			}
			merchantDBService.saveForgotRequest(param);
			param.put("merchant", merchant);
			sendNotification(NotificationCategory.forgotPasswordTemplate,
					merchant);
			return param.get("identifier").toString();
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("Forgot request cannot be saved", e);
		}
	}

	/**
	 * @param string
	 * @param param
	 */
	private void sendNotification(String template, Merchant merchant)
			throws Exception {
		try {
			if (StringUtils.isBlank(template)) {
				return;
			}
			Message message = new Message(NotificationType.BOTH);
			if (StringUtils.isNotBlank(merchant.getPhone())) {
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
								: merchant.getPhone(), merchant.getId())));
			}
			map.put("merchant", merchant);
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
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#changePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void changePassword(String email, String requestId, String passphrase)
			throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put("email", email);
			param.put("requestId", requestId);
			param.put("passphrase", passphrase);
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

	/* (non-Javadoc)
	 * @see com.eros.service.MerchantCustomService#verifyMerchant(java.lang.String, java.lang.String)
	 */
	@Override
	public void verifyMerchant(String identifier, String id) throws Exception {
		if(StringUtils.isBlank(id) || StringUtils.isBlank(identifier)){
			throw new Exception("Invalid verification request");
		}
		try{
			Map param = new HashMap<String, String>();
			param.put("identifier", identifier);
			param.put("id", id);
			Integer count = merchantDBService.verify(param);
			if(count == null || count ==0){
				throw new Exception("Invalid verification request");
			}
		}catch (Exception e) {
			LOG.error("Invalid verification request" ,e);
			throw e;
		}
		
	}
}
