package com.eros.service.db;

import java.util.HashMap;
import java.util.Map;

import com.eros.core.model.Coupon;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.ReportedError;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;

/**
 * 
 * @author vikas
 */
public interface UserDBService {

    public Integer registerUser(User user);

	/**
	 * @param userEmail
	 * @return
	 */
	public String fetchPassForLogin(String userEmail);

	/**
	 * @param param
	 */
	public void markLoggedStatus(Map<String, Object> param);

	/**
	 * @param user
	 */
	public void updateUser(User user);

	/**
	 * @param param
	 */
	public Map<String, String> redeemDeal(Map param);

	/**
	 * @param userEmail
	 * @return
	 */
	public User fetchUser(String userEmail);

	/**
	 * @param param
	 */
	public void confirmDeal(Map<String, Object> param);

	/**
	 * @param review
	 * @return
	 */
	public User saveReview(UserReview review);

	/**
	 * @param param
	 */
	public void updateReview(Map<String, Object> param);

	/**
	 * @param param
	 */
	public void saveForgotRequest(Map<String, Object> param);

	public void saveReportedError(ReportedError error);
	/**
	 * @param param
	 */
	public void updatePassword(Map<String, Object> param);

	/**
	 * @param param
	 */
	public void updateProfilePic(HashMap<String, String> param);
}
