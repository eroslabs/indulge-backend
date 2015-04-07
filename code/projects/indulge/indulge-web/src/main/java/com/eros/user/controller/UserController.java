
package com.eros.user.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.service.UserService;

/**
 * indulge-web
 * author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/user")
public class UserController {
	
	/**
	 * 
	 */
	private static final String ERROR = "error";

	protected static Log LOGGER = LogFactory
			.getLog(UserRegistrationController.class);
	
	@Resource(name = "userService")
	protected UserService userService;
	
	@RequestMapping(value = "/save",method = RequestMethod.POST)
	public @ResponseBody Map saveUser(@RequestBody Map map) {
		User user = (User)map.get("user");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("status", true);
		try {
			if(user == null){
				throw new Exception("Invalid param map User missing");
			}
			userService.saveUser(user);
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map,e);
			returnMap.put("error", "Error in updating User");
			returnMap.put("status", false);
		}
		returnMap.put("user", user);
		return returnMap;
 
	}
	@RequestMapping(value = "/saveReview",method = RequestMethod.POST)
	public @ResponseBody Map saveUserReview(@RequestBody Map map) {
		UserReview review = (UserReview)map.get("review");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("status", true);
		try {
			if(review == null){
				throw new Exception("Invalid param map Review missing");
			}
			userService.saveReview(review);
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map,e);
			returnMap.put("error", "Error in updating User");
			returnMap.put("status", false);
		}
		return returnMap;
 
	}
	
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Map updateUser(@RequestBody Map map) {
		User user = (User)map.get("user");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status", true);
		try {
			if(user == null){
				throw new Exception("Invalid param map User missing");
			}
			userService.updateUser(user);
		} catch (Exception e) {
			LOGGER.error("Error in updating user " + map,e);
			returnMap.put("error", "Error in updating User");
			returnMap.put("status", false);
		}
		
		returnMap.put("user", user);
		return returnMap;
 
	}
	
	@RequestMapping(value = "/login",method = RequestMethod.GET)
	public @ResponseBody Map login(@RequestParam("userEmail") String userEmail,@RequestParam("passphrase") String passPhrase) {
		Boolean loggedIn = false;
		try {
			loggedIn = userService.loginUser(userEmail, passPhrase);
		} catch (Exception e) {
			LOGGER.error("Error in login for user "+userEmail,e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userEmail", userEmail);
		if(!loggedIn){
			map.put(ERROR, "Error in login");
		}
		map.put("status", loggedIn);
		return map;
 
	}
	
	@RequestMapping(value = "/redeem/{dealId}",method = RequestMethod.GET)
	public @ResponseBody Map redeemDeal(@RequestParam("userEmail") String userEmail,@PathVariable("dealId") String dealId) {
		Boolean success = false;
		String couponCode = null;
		try {
			couponCode = userService.redeemDeal(userEmail, dealId);
			success = true;
		} catch (Exception e) {
			LOGGER.error("Error in redeeming deal ::"+dealId+" for user "+userEmail,e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userEmail", userEmail);
		map.put("status", success);
		if(!success){
			map.put(ERROR, "Error in deal redemption");
			
		}else{
			map.put("coupon", couponCode);
		}
		return map;
 
	}
	
	@RequestMapping(value = "/confirm/{dealId}",method = RequestMethod.GET)
	public @ResponseBody Map confirmDeal(@RequestParam("userEmail") String userEmail,@PathVariable("dealId") String dealId) {
		Boolean success = false;
		try {
			success = userService.confirmDeal(userEmail, dealId);
		} catch (Exception e) {
			LOGGER.error("Error in confirming deal ::"+dealId+" for user "+userEmail,e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userEmail", userEmail);
		map.put("status", success);
		if(!success){
			map.put(ERROR, "Error in deal redemption");
		}
		return map;
 
	}
	
	
	
}
