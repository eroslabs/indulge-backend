package com.eros.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.core.BaseController;
import com.eros.core.model.user.User;

/**
 * indulge-web author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/registerUser")
public class UserRegistrationController extends BaseController {

	protected static Log LOGGER = LogFactory
			.getLog(UserRegistrationController.class);

	/**
	 * 
	 * @param requestMap
	 *            including "user" Key with {@link User} Object as mandatory
	 *            field
	 * @return Map including status (true/false) , error ( message) , user (
	 *         User)
	 */
	@RequestMapping(method = RequestMethod.POST)
	public @ResponseBody
	Map register(@RequestBody Map requestMap) {
		User user = (User) requestMap.get(USER);
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		User savedUser = null;
		try {
			savedUser = userService.saveUser(user);
			if (user.getImage() != null) {
				String path = userService.saveUserImage(user.getImage(),
						savedUser.getId(), savedUser.getId() + ".jpg");
				savedUser.setImagePath(path);
				userService.updateUser(savedUser);
			}

		} catch (Exception e) {
			error = true;
			errorMessage.append(e.getMessage());
			LOGGER.error("Error in registering user with email :::"
					+ user.getMail());
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(USER, savedUser);
		map.put(STATUS, true);
		if (error) {
			map.put(ERROR, errorMessage.toString());
			map.put(STATUS, false);
			map.put(USER, user);
		}
		return map;

	}

	/**
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping(value = "/triggerForgot", method = RequestMethod.GET)
	public @ResponseBody
	Map forgotPasword(@RequestParam("userEmail") String email) {
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			userService.saveForgotPasswordRequest(email, 1);
		} catch (Exception e) {
			error = true;
			errorMessage
					.append("error in initiating forgot password request for ::"
							+ email);
			LOGGER.error("Error in initiating forgot password request for:::"
					+ email);
		}
		map.put(STATUS, true);
		map.put("userEmail", email);

		if (error) {
			map.put(ERROR, errorMessage.toString());
			map.put(STATUS, false);
		}
		return map;

	}

	/**
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/inputPassword", method = RequestMethod.GET)
	public String inputPasword(@RequestParam(IDENTIFIER) String identifier,
			@RequestParam(REQUEST_ID) String requestId,
			final RedirectAttributes redirectAttributes, ModelMap modelMap) {
		Boolean error = false;

		if (StringUtils.isBlank(requestId) || StringUtils.isBlank(identifier)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in changing password. Invalid request.");
			return "redirect:/merchant/login";
		}
		modelMap.put(IDENTIFIER, identifier);
		modelMap.put(REQUEST_ID, requestId);
		return "inputPassword";

	}

	/**
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String forgotPasword(@RequestParam(IDENTIFIER) String identifier,
			@RequestParam(REQUEST_ID) String requestId,
			@RequestParam("passphrase") String passphrase,
			final RedirectAttributes redirectAttributes) {
		Boolean error = false;
		if (StringUtils.isBlank(requestId) || StringUtils.isBlank(identifier)
				|| StringUtils.isBlank(passphrase)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in changing password. Invalid request.");
			throw new IllegalArgumentException();
		}
		try {
			userService.forgotPassword(identifier, requestId, passphrase);

		} catch (Exception e) {
			error = true;
			LOGGER.error("Error in changing password for:::" + identifier);
		}
		if (error) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in changing password");

		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Password changed successfully");

		return "redirect:/merchant/login";

	}

}
