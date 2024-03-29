package com.eros.service;

import com.eros.core.model.Merchant;
import com.eros.core.model.ReportedError;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;



/**
 * 
 * @author vikas
 */
public interface UserService extends Constants {

	public User saveUser(User user)  throws Exception;

	/**
	 * @param userEmail
	 * @param passPhrase
	 * @return
	 */
	public User loginUser(String userEmail, String passPhrase);

	/**
	 * @param user
	 */
	public void updateUser(User user)  throws Exception;

	/**
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	public String redeemDeal(String userEmail, String dealId) throws Exception;

	/**
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	public Boolean confirmDeal(String userEmail, String dealId) throws Exception;

	/**
	 * @param review
	 */
	public void saveReview(UserReview review)  throws Exception;
	
	public void updateReview(UserReview review) throws Exception;
	
	public String saveUserImage(byte[] bytes, Integer id, String fileName);

	/**
	 * @param email
	 */
	public void saveForgotPasswordRequest(String email, Integer type) throws Exception;

	/**
	 * @param email
	 * @param requestId
	 * @param passphrase
	 */
	public void changePassword(String email, String requestId, String passphrase) throws Exception;

	/**
	 * @param error
	 * @throws Exception
	 */
	void saveReportedError(ReportedError error) throws Exception;

	/**
	 * @param type
	 * @param id
	 * @return
	 */
	public byte[] fetchResource(String type, Integer id);
	
	public void forgotPassword(String email, String requestId, String password)
			throws Exception;

}
