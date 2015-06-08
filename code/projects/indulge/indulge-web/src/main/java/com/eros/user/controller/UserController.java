package com.eros.user.controller;

import static com.eros.constants.RequestConstants.DEAL_ID_PARAM;
import static com.eros.constants.RequestConstants.EMAIL_PARAM;
import static com.eros.constants.RequestConstants.ERROR_PARAM;
import static com.eros.constants.RequestConstants.PASS_PHRASE;
import static com.eros.constants.RequestConstants.REVIEW_PARAM;
import static com.eros.constants.RequestConstants.USER_ID;
import static com.eros.constants.RequestConstants.USER_PARAM;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eros.core.BaseController;
import com.eros.core.model.ReportedError;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.utils.RequestUtils;

/**
 * indulge-web author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	protected static Log LOGGER = LogFactory.getLog(UserController.class);

	/**
	 * 
	 * @param map
	 *            Should include {@link User} Object with "user" key
	 * @return map including status (true/false) , Optional error ( message) ,
	 *         user ( User)
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public @ResponseBody
	Map saveUser(@RequestBody Map map) {
		Map userMap = (Map) map.get(USER_PARAM);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put(STATUS, true);
		User user = null;
		try {
			user = RequestUtils.populateUserObject(userMap);
			if (user == null) {
				throw new Exception("Invalid param map User missing");
			}
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map, e);
			returnMap.put(ERROR, "Invalid User");
			returnMap.put(STATUS, false);
			return returnMap;
		}

		try {
			User savedUser = userService.saveUser(user);
			if (savedUser != null) {
				returnMap.put(USER_ID, savedUser.getId());
			}
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map, e);
			returnMap.put(ERROR, "Error in updating User");
			returnMap.put(STATUS, false);
		}
		return returnMap;

	}

	/**
	 * 
	 * @param map
	 *            Should include {@link UserReview} Object with "review" key
	 * @return map including status (true/false) , Optional error ( message)
	 */
	@RequestMapping(value = "/saveReview", method = RequestMethod.POST)
	public @ResponseBody
	Map saveUserReview(@RequestBody Map map) {
		Map reviewMap = (Map) map.get(REVIEW_PARAM);
		UserReview review = null;
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put(STATUS, true);
		try {
			review = RequestUtils.populateReview(reviewMap);
			if (review == null) {
				throw new Exception("Invalid param map Review missing");
			}
			userService.saveReview(review);
		} catch (Exception e) {
			LOGGER.error("Error in saving review " + map, e);
			returnMap.put(ERROR, "Error in saving review");
			returnMap.put(STATUS, false);
		}
		return returnMap;

	}

	/**
	 * 
	 * @param map
	 *            Should include {@link User} Object with "user" key
	 * @return map including status (true/false) , Optional error ( message) ,
	 *         user ( User)
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public @ResponseBody
	Map updateUser(@RequestBody Map map) {
		User user = (User) map.get(USER_PARAM);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put(STATUS, true);
		try {
			if (user == null) {
				throw new Exception("Invalid param map User missing");
			}
			userService.updateUser(user);
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map, e);
			returnMap.put(ERROR, "Error in updating User");
			returnMap.put(STATUS, false);
		}

		returnMap.put(USER_PARAM, user);
		return returnMap;

	}

	/**
	 * 
	 * @param userEmail
	 * @param passPhrase
	 * @return including status (true/false) , Optional error ( message)
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public @ResponseBody
	Map login(@RequestParam(EMAIL_PARAM) String userEmail,
			@RequestParam(PASS_PHRASE) String passPhrase) {
		Boolean loggedIn = true;
		User user = null;
		try {
			user = userService.loginUser(userEmail, passPhrase);
		} catch (Exception e) {
			LOGGER.error("Error in login for user " + userEmail, e);
			loggedIn = false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(EMAIL_PARAM, userEmail);
		if (!loggedIn) {
			map.put(ERROR, "Error in login");
		}
		map.put(STATUS, loggedIn);
		map.put(USER, user);
		return map;

	}

	/**
	 * 
	 * @param userEmail
	 * @param dealId
	 *            (path variable)
	 * @return including status (true/false) , Optional error ( message)
	 */
	@RequestMapping(value = "/redeem/{dealId}", method = RequestMethod.GET)
	public @ResponseBody
	Map redeemDeal(@RequestParam(EMAIL_PARAM) String userEmail,
			@PathVariable(DEAL_ID_PARAM) String dealId) {
		Boolean success = false;
		String couponCode = null;
		try {
			couponCode = userService.redeemDeal(userEmail, dealId);
			success = true;
		} catch (Exception e) {
			LOGGER.error("Error in redeeming deal ::" + dealId + " for user "
					+ userEmail, e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(EMAIL_PARAM, userEmail);
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in deal redemption");

		} else {
			map.put("coupon", couponCode);
		}
		return map;

	}

	/**
	 * 
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	@RequestMapping(value = "/confirm/{dealId}", method = RequestMethod.GET)
	public @ResponseBody
	Map confirmDeal(@RequestParam(EMAIL_PARAM) String userEmail,
			@PathVariable(DEAL_ID_PARAM) String dealId) {
		Boolean success = false;
		try {
			success = userService.confirmDeal(userEmail, dealId);
		} catch (Exception e) {
			LOGGER.error("Error in confirming deal ::" + dealId + " for user "
					+ userEmail, e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(EMAIL_PARAM, userEmail);
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in deal redemption");
		}
		return map;

	}

	@RequestMapping(value = "/reportError", method = RequestMethod.POST)
	public @ResponseBody
	Map reportError(@RequestBody Map map) {
		Map<String, Object> errorObj = (Map<String, Object>) map
				.get(ERROR_PARAM);
		ReportedError error = null;
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put(STATUS, true);
		try {
			error = RequestUtils.fillError(errorObj);
			if (error == null) {
				throw new Exception("Invalid param map error missing");
			}
			userService.saveReportedError(error);
		} catch (Exception e) {
			LOGGER.error("Error in saving Error ::", e);
			returnMap.put(ERROR, "Error in saving reported error");
			returnMap.put(STATUS, false);
		}

		return returnMap;

	}

	@ExceptionHandler(Exception.class)
	public @ResponseBody
	Map handleCustomException(Exception ex) {

		Map returnMap = new HashMap<String, Object>();
		returnMap.put(ERROR, ex);
		returnMap.put(STATUS, false);
		return returnMap;

	}

	/**
	 * 
	 * @param userEmail
	 * @param dealId
	 *            (path variable)
	 * @return including status (true/false) , Optional error ( message)
	 */
	@RequestMapping(value = "/resource/{type}/{id}", method = RequestMethod.GET)
	public @ResponseBody
	byte[] redeemDeal(@PathVariable("type") String type,
			@PathVariable("id") Integer id) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			byte[] imageBytes = userService.fetchResource(type, id);
			return imageBytes;
		} catch (Exception e) {
			LOGGER.error(
					"Error in fetching image ::" + id + " of type " + type, e);

		}
		return null;

	}

	/**
	 * Change password for existing user.
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public @ResponseBody
	Map changePasword(@RequestParam("userEmail") String email,
			@RequestParam("oldPassphrase") String oldPassphrase,
			@RequestParam("passphrase") String passphrase) {
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			if (StringUtils.isBlank(email)
					|| StringUtils.isBlank(oldPassphrase)
					|| StringUtils.isBlank(passphrase)) {
				throw new Exception("Invalid parameters for change password");
			}
			userService.changePassword(email, oldPassphrase, passphrase);

		} catch (Exception e) {
			error = true;
			errorMessage.append("Error in changing password for ::");
			errorMessage.append(email);
			errorMessage.append(" Reason :" + e.getMessage());
			LOGGER.error("Error in changing password for:::" + email, e);
		}
		map.put(STATUS, true);
		map.put("userEmail", email);

		if (error) {
			map.put(ERROR, errorMessage.toString());
			map.put("status", false);
		}
		return map;

	}

}
