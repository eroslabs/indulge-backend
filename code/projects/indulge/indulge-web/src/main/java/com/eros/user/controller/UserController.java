package com.eros.user.controller;

import static com.eros.constants.RequestConstants.DEAL_ID_PARAM;
import static com.eros.constants.RequestConstants.EMAIL;
import static com.eros.constants.RequestConstants.EMAIL_PARAM;
import static com.eros.constants.RequestConstants.PASS_PHRASE;
import static com.eros.constants.RequestConstants.REVIEW_PARAM;
import static com.eros.constants.RequestConstants.USER_PARAM;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.core.BaseController;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.service.SearchService;
import com.eros.service.UserService;
import com.eros.service.search.Filter;
import com.eros.service.search.IndexType;
import com.eros.service.search.SearchResponse;
import com.eros.utils.RequestUtils;

/**
 * indulge-web author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	protected static Log LOGGER = LogFactory.getLog(UserController.class);

	@Resource(name = "userServiceImpl")
	protected UserService userService;

	@Resource(name = "searchService")
	protected SearchService searchService;

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
		User user = (User) map.get(USER_PARAM);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put(STATUS, true);
		try {
			if (user == null) {
				throw new Exception("Invalid param map User missing");
			}
			userService.saveUser(user);
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
	 * @param map
	 *            Should include {@link UserReview} Object with "review" key
	 * @return map including status (true/false) , Optional error ( message)
	 */
	@RequestMapping(value = "/saveReview", method = RequestMethod.POST)
	public @ResponseBody
	Map saveUserReview(@RequestBody Map map) {
		UserReview review = (UserReview) map.get(REVIEW_PARAM);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put(STATUS, true);
		try {
			if (review == null) {
				throw new Exception("Invalid param map Review missing");
			}
			userService.saveReview(review);
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
		Boolean loggedIn = false;
		try {
			loggedIn = userService.loginUser(userEmail, passPhrase);
		} catch (Exception e) {
			LOGGER.error("Error in login for user " + userEmail, e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(EMAIL_PARAM, userEmail);
		if (!loggedIn) {
			map.put(ERROR, "Error in login");
		}
		map.put(STATUS, loggedIn);
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
	public @ResponseBody Map reportError(
			@ModelAttribute("error") com.eros.core.model.ReportedError error,
			final RedirectAttributes redirectAttributes) {
		Boolean success = false;
		try {
			userService.saveReportedError(error);
			success = true;
		} catch (Exception e) {
			LOGGER.error("Error in saving Error ::" , e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in saving reported error");
		}
		return map;

	}

	@ExceptionHandler(Exception.class)
	public @ResponseBody
	Map handleCustomException(Exception ex) {

		Map returnMap = new HashMap<String, Object>();
		returnMap.put(ERROR, ex);
		returnMap.put(STATUS, false);
		return returnMap;

	}
}
