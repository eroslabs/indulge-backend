package com.eros.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.solr.common.util.Hash;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eros.core.model.Merchant;
import com.eros.core.model.ReportedError;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.notification.utils.Message;
import com.eros.notification.utils.NotificationService;
import com.eros.notification.utils.NotificationType;
import com.eros.service.MerchantCustomService;
import com.eros.service.UserService;
import com.eros.service.db.UserDBService;
import com.eros.service.util.NotificationCategory;
import com.eros.service.util.TinyUrlUtility;

/**
 * 
 * @author vikas
 * 
 */
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	/**
	 * 
	 */
	

	private static final Logger LOG = LoggerFactory
			.getLogger(UserServiceImpl.class);

	@Autowired
	protected UserDBService userDBService;

	@Autowired
	protected NotificationService notificationService;
	
	@Autowired
	protected MerchantCustomService merchantService;

	@Value("${user.base.path}")
	private String USER_BASE_PATH;

	@Value("${merchant.base.path}")
	private String MERCHANT_BASE_PATH;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#saveUser(com.eros.core.model.user.User)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public User saveUser(User user) throws Exception {
		if (user == null) {
			return null;
		}
		User savedUser = null;
		try {
			if(StringUtils.isNotBlank(user.getFacebook()) || StringUtils.isNotBlank(user.getGoogle())){
				savedUser = userDBService.fetchUserBySocialAuth(StringUtils.isNotBlank(user.getFacebook()) ? user.getFacebook() : user.getGoogle());
				if(savedUser != null){
				return savedUser;}
			}
			userDBService.registerUser(user);
			savedUser = userDBService.fetchUser(user.getMail());
			if(user.getImage() != null){
				String profilePhoto = saveUserImage(user.getImage(), savedUser.getId(), savedUser.getId()+".png");
				HashMap<String, String> param = new HashMap<String, String>();
				param.put(USER_ID, savedUser.getId().toString());
				param.put(PATH, profilePhoto);
				userDBService.updateProfilePic(param);
			}
			return savedUser;
		} catch (Exception e) {
			LOG.error("Error in saving User basic profile : ", e);
			if (e instanceof org.springframework.dao.DuplicateKeyException) {
				throw new Exception("User with this mail id already exist", e);
			}
		}
		return null;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#loginUser(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public User loginUser(String userEmail, String passPhrase) {
		if (StringUtils.isNotBlank(userEmail)
				&& StringUtils.isNotBlank(passPhrase)) {
			try {
				String passString = userDBService.fetchPassForLogin(userEmail);
				if (StringUtils.isNotBlank(passString)) {
					Boolean login = passPhrase.trim().equalsIgnoreCase(
							passString.trim());
					Map<String, Object> param = new HashMap<String, Object>();
					param.put(MAIL, userEmail);
					param.put(STATUS, LOGGEDIN);
					userDBService.markLoggedStatus(param);
					User user = userDBService.fetchUser(userEmail);
					return user;
				}
			} catch (Exception e) {
				LOG.error("Error in login for user :: " + userEmail, e);
			}
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.UserService#updateUser(com.eros.core.model.user.User)
	 */
	@Override
	public void updateUser(User user) throws Exception {
		if (user == null) {
			return;
		}
		try {
			userDBService.updateUser(user);
			return;
		} catch (Exception e) {
			LOG.error("Error in saving User basic profile : ", e);
			if (e instanceof org.springframework.dao.DuplicateKeyException) {
				throw new Exception(
						"Unable to update user ::" + user.getMail(), e);
			}
		}
		return;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#redeemDeal(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public String redeemDeal(String userEmail, String dealId) throws Exception {
		try {
			User user = userDBService.fetchUser(userEmail);
			if(user == null){
				throw new Exception("Invalid user : "+userEmail);
			}
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(USER_ID, user.getId());
			param.put(DEAL_ID, dealId);
			String coupon = RandomStringUtils.randomAlphanumeric(20)
					.toUpperCase();
			param.put(COUPON_CODE, coupon);
			userDBService.redeemDeal(param);
			return coupon;
		} catch (Exception e) {
			throw new Exception("Error in redeeming Deal Id " + dealId, e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#confirmDeal(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	public Boolean confirmDeal(String userEmail, String dealId)
			throws Exception {
		try {
			User user = userDBService.fetchUser(userEmail);
			if(user == null){
				throw new Exception("Invalid user : "+userEmail);
			}
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(USER_ID, user.getId());
			param.put(DEAL_ID, dealId);
			param.put(CONFIRM_STATUS, null);
			userDBService.confirmDeal(param);
			if (param.containsKey(CONFIRM_STATUS)
					&& StringUtils.isNotBlank(param.get(CONFIRM_STATUS)
							.toString())) {
				return (Boolean) param.get(CONFIRM_STATUS);
			}
		} catch (Exception e) {
			throw new Exception("Error in confirming Deal Id " + dealId, e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.UserService#saveReview(com.eros.core.model.UserReview)
	 */
	@Override
	public void saveReview(UserReview review) throws Exception {
		if (review == null) {
			return;
		}
		try {
			userDBService.saveReview(review);
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put(MERCHANT_ID, review.getMerchantId());
			userDBService.updateRating(param);
			return;
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("User review cannot be saved", e);
		}

	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void updateReview(UserReview review) throws Exception {
		if (review == null) {
			return;
		}
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(MERCHANT_ID, review.getMerchantId());
			userDBService.updateReview(param);
			return;
		} catch (Exception e) {
			LOG.error("Error in updating User review ratings to merchant : ", e);
			throw new Exception("User reviews cannot be updated for merchant",
					e);
		}

	}

	/*
	 * (non-Javadoc)
	 */
	@Override
	public String saveUserImage(byte[] bytes, Integer id, String fileName) {
		try {
			if(bytes == null){
				return null;
			}
			File file = new File(USER_BASE_PATH + File.separator + id);
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
			LOG.error("Error in saving user image : ", e);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.eros.service.UserService#saveForgotPasswordRequest(java.lang.String,
	 * java.lang.Integer)
	 */
	@Override
	public void saveForgotPasswordRequest(String email, Integer requestType)
			throws Exception {

		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(EMAIL_PARAM, email);
			param.put(TYPE, requestType);
			param.put(IDENTIFIER, RandomStringUtils.random(8, false, true));
			userDBService.saveForgotRequest(param);
			sendNotification(NotificationCategory.forgotPasswordUserTemplate,
					param);
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("Forgot request cannot be saved", e);
		}
	}

	@Override
	public void saveReportedError(ReportedError error) throws Exception {
		if (error.getUserId() == null || error.getMerchantId() == null) {
			throw new IllegalArgumentException(
					"User/Merchant information missing ");
		}
		try {
			userDBService.saveReportedError(error);
		} catch (Exception e) {
			LOG.error("Error in saving User error : ", e);
			throw new Exception("Error in saving error reported", e);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#changePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void forgotPassword(String email, String requestId, String password)
			throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(EMAIL_PARAM, email);
			param.put(REQUEST_ID, requestId);
			param.put(PASSPHRASE, password);
			userDBService.updatePassword(param);
		} catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#changePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void changePassword(String email, String oldPassphrase, String passphrase)
			throws Exception {
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			param.put(EMAIL_PARAM, email);
			param.put(OLD_PASSPHRASE, oldPassphrase);
			param.put(PASSPHRASE, passphrase);
			Integer updatedRows = userDBService.changePassword(param);
			if(updatedRows == null || updatedRows ==0){
				throw new Exception("Invalid email/ old password");
			}
		} catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.UserService#fetchResource(java.lang.String,
	 * java.lang.Integer)
	 */
	@Override
	public byte[] fetchResource(String type, Integer id) {
		if (StringUtils.isNotBlank(type) && id != null) {
			if (type.equalsIgnoreCase(MERCHANT)) {
				Merchant merchant = merchantService.getMerchantById(id);
				if (merchant != null
						&& StringUtils.isNotBlank(merchant.getImage())) {
					return fetchImage(MERCHANT_BASE_PATH + File.separator
							+ merchant.getImage());
				}
			} else if (type.equalsIgnoreCase(USER)) {
				// we can fetch by id and email both
				User user = userDBService.fetchUser(id.toString());
				if (user != null && StringUtils.isNotBlank(user.getImagePath())) {
					LOG.error("----------------------------"+USER_BASE_PATH + File.separator
							+ user.getImagePath());
					return fetchImage(USER_BASE_PATH + File.separator
							+ user.getImagePath());
				}
			} else {
				return null;
			}

		}
		return null;
	}

	/**
	 * @param string
	 * @return
	 */
	private byte[] fetchImage(String string) {
		// try {
		if (StringUtils.isBlank(string)) {
			return null;
		}
		File file = new File(string);
		if (!file.exists()) {
			return null;
		}
		try {
			FileInputStream fileInputStream = null;
			byte[] bFile = new byte[(int) file.length()];
			fileInputStream = new FileInputStream(file);
			fileInputStream.read(bFile);
			fileInputStream.close();
			return bFile;
		} catch (Exception e) {
			LOG.error("Error in fetching image: ", e);
		}
		return null;

	}

	/**
	 * @param string
	 * @param param
	 */
	private void sendNotification(String template, Map<String, Object> param)
			throws Exception {
		try {
			if (StringUtils.isBlank(template)) {
				return;
			}
			Message message = new Message(NotificationType.MAIL);
			

			if (param.get(EMAIL_PARAM) == null) {
				return;
			}
			message.setToEmails(new String[] { param.get(EMAIL_PARAM).toString() });
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(VERIFICATION_URL, TinyUrlUtility.getTinyUrl(String
						.format(CHANGE_USER_PASSWORD_TEMPLATE,param.get(EMAIL_PARAM),param.get(IDENTIFIER))));
			
			map.putAll(param);
			message.setDataMap(map);
			message.setMessageTemplate(template);
			notificationService.sendNotification(message);
		} catch (Exception e) {
			LOG.error(
					"Please check : There is some error in sending notification ",
					e);
		}

	}

}
