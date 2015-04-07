package com.eros.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.service.UserService;
import com.eros.service.db.MerchantDBService;
import com.eros.service.db.UserDBService;

/**
 * 
 * @author vikas
 * 
 */
@Service("userService")
public class UserServiceImpl implements UserService {
	/**
	 * 
	 */
	private static final int LOGGEDIN = 1;
	private static final int LOGGEDOUT = 0;
	private static final Logger LOG = LoggerFactory
			.getLogger(UserServiceImpl.class);

	
	@Autowired
	protected UserDBService userDBService;
	
	@Value("${user.base.path}")
	private String USER_BASE_PATH;

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#saveUser(com.eros.core.model.user.User)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public User saveUser(User user) throws Exception{
		if (user == null) {
			return null;
		}
		try {
			userDBService.registerUser(user);
			User savedUser= userDBService.fetchUser(user.getMail());
			return savedUser;
		} catch (Exception e) {
			LOG.error("Error in saving User basic profile : ", e);
			if(e instanceof org.springframework.dao.DuplicateKeyException){
				throw new Exception("User with this mail id already exist",e);
			}
		}
		return null;
		
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#loginUser(java.lang.String, java.lang.String)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean loginUser(String userEmail, String passPhrase) {
		if(StringUtils.isNotBlank(userEmail) && StringUtils.isNotBlank(passPhrase)){
			try{
			String passString = userDBService.fetchPassForLogin(userEmail);
			if(StringUtils.isNotBlank(passString)){
				Boolean login = passPhrase.trim().equalsIgnoreCase(passString.trim());
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("mail", userEmail);
				param.put("status", LOGGEDIN);
				userDBService.markLoggedStatus(param);
				return login;
			}
			}catch (Exception e) {
				 LOG.error("Error in login for user :: " + userEmail,e);
			}
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#updateUser(com.eros.core.model.user.User)
	 */
	@Override
	public void updateUser(User user) throws Exception{
		if (user == null) {
			return ;
		}
		try {
			userDBService.updateUser(user);
			return ;
		} catch (Exception e) {
			LOG.error("Error in saving User basic profile : ", e);
			if(e instanceof org.springframework.dao.DuplicateKeyException){
				throw new Exception("Unable to update user ::" +user.getMail(),e);
			}
		}
		return ;
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#redeemDeal(java.lang.String, java.lang.String)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public String redeemDeal(String userEmail, String dealId) throws Exception{
		try{
		 User user = userDBService.fetchUser(userEmail);
		 Map<String, Object> param = new HashMap<String, Object>(3);
		 param.put("userId", user.getId());
		 param.put("dealId", dealId);
		 param.put("couponCode", null);
		 userDBService.redeemDeal(param);
		 if(param.containsKey("couponCode") && StringUtils.isNotBlank(param.get("couponCode").toString())){
			 return param.get("couponCode").toString();
		 }
		}catch (Exception e) {
			throw new Exception("Error in redeeming Deal Id "+dealId ,e);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#confirmDeal(java.lang.String, java.lang.String)
	 */
	@Override
	public Boolean confirmDeal(String userEmail, String dealId) throws Exception {
		try{
			 User user = userDBService.fetchUser(userEmail);
			 Map<String, Object> param = new HashMap<String, Object>(3);
			 param.put("userId", user.getId());
			 param.put("dealId", dealId);
			 param.put("confirmStatus", null);
			 userDBService.confirmDeal(param);
			 if(param.containsKey("confirmStatus") && StringUtils.isNotBlank(param.get("confirmStatus").toString())){
				 return (Boolean)param.get("confirmStatus");
			 }
			}catch (Exception e) {
				throw new Exception("Error in confirming Deal Id "+dealId ,e);
			}
			return null;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#saveReview(com.eros.core.model.UserReview)
	 */
	@Override
	public void saveReview(UserReview review) throws Exception {
		if (review == null) {
			return ;
		}
		try {
			userDBService.saveReview(review);
			return ;
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("User review cannot be saved",e);
		}
		
	}
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void updateReview(UserReview review) throws Exception {
		if (review == null) {
			return ;
		}
		try {
			 Map<String, Object> param = new HashMap<String, Object>(3);
			 param.put("merchantId", review.getMerchantId());
			userDBService.updateReview(param);
			return ;
		} catch (Exception e) {
			LOG.error("Error in updating User review ratings to merchant : ", e);
			throw new Exception("User reviews cannot be updated for merchant",e);
		}
		
	}
	
	
	/*
	 * (non-Javadoc)
	 * 
	 * 
	 */
	@Override
	public String saveUserImage(byte[] bytes, Integer id, String fileName) {
		try {

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

	/* (non-Javadoc)
	 * @see com.eros.service.UserService#saveForgotPasswordRequest(java.lang.String, java.lang.Integer)
	 */
	@Override
	public Integer saveForgotPasswordRequest(String email, Integer type) throws Exception{
		
		try {
			Map<String, Object> param = new HashMap<String, Object>(3);
			 param.put("email", email);
			 param.put("type", type);
			 param.put("id", 0);
			 userDBService.saveForgotRequest(param);
			 
			return (Integer)param.get("id");
		} catch (Exception e) {
			LOG.error("Error in saving User review : ", e);
			throw new Exception("Forgot request cannot be saved",e);
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
		 userDBService.updatePassword(param);
		}catch (Exception e) {
			LOG.error("Error in changing password : ", e);
			throw new Exception("Change password unsuccessful",e);
		}
	}

	

	}
