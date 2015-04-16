
package com.eros.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eros.core.model.user.User;
import com.eros.service.UserService;

/**
 * indulge-web
 * author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/registerUser")
public class UserRegistrationController {
	
	protected static Log LOGGER = LogFactory
			.getLog(UserRegistrationController.class);
	
	@Resource(name = "userService")
	protected UserService userService;
	
	/**
	 * 
	 * @param requestMap
	 * including "user" Key with {@link User} Object as mandatory field 
	 * @return Map including status (true/false) , error ( message) , user ( User)
	 */
	@RequestMapping(method = RequestMethod.POST)
	public @ResponseBody Map register(@RequestBody Map requestMap) {
		User user =(User)requestMap.get("user");
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		User savedUser = null;
		try {
			savedUser =userService.saveUser(user);
			if(user.getImage() != null){
				String path = userService.saveUserImage(user.getImage(), savedUser.getId(), savedUser.getId()+".jpg");
				savedUser.setImagePath(path);
				userService.updateUser(savedUser);
			}
			
		} catch (Exception e) {
			error = true;
			errorMessage.append(e.getMessage());
			LOGGER.error("Error in registering user with email :::" +user.getMail());
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", savedUser);
		map.put("status", true);
		if(error){
			map.put("error", errorMessage.toString());
			map.put("status", false);
			map.put("user", user);
		}
		return map;
 
	}
	/**
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping(value="/triggerForgot",method = RequestMethod.GET)
	public @ResponseBody Map forgotPasword(@RequestParam("userEmail") String email) {
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Integer id = userService.saveForgotPasswordRequest(email,1);
			map.put("requestId", id);
			
		} catch (Exception e) {
			error = true;
			errorMessage.append("error in initiating forgot password request for ::" + email);
			LOGGER.error("Error in initiating forgot password request for:::" +email);
		}
		map.put("status", true);
		map.put("userEmail", email);
		
		if(error){
			map.put("error", errorMessage.toString());
			map.put("status", false);
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
	@RequestMapping(value="/changePassword",method = RequestMethod.GET)
	public @ResponseBody Map forgotPasword(@RequestParam("userEmail") String email,@RequestParam("requestId") String requestId,@RequestParam("passphrase") String passphrase) {
		Boolean error = false;
		StringBuilder errorMessage = new StringBuilder();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			userService.changePassword(email,requestId,passphrase);
			
		} catch (Exception e) {
			error = true;
			errorMessage.append("Error in changing password for ::" + email);
			LOGGER.error("Error in changing password for:::" +email);
		}
		map.put("status", true);
		map.put("userEmail", email);
		
		if(error){
			map.put("error", errorMessage.toString());
			map.put("status", false);
		}
		return map;
 
	}

}
