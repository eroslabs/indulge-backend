package com.eros.merchant.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.service.MerchantCustomService;

/**
 * 
 * @author 
 * 
 */
@Controller
@RequestMapping(value = "/register")
public class RegistrationController {

	protected static Log LOGGER = LogFactory.getLog(RegistrationController.class);

	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;

	@RequestMapping(value = "/input")
	public String create(ModelMap modelMap, HttpServletRequest request) {
		return "createProfile";
	}
	
	@RequestMapping(value = "/saveMerchantBasicProfile")
	public String register(@ModelAttribute("merchant") com.eros.core.model.Merchant merchant, HttpServletRequest request, final RedirectAttributes redirectAttributes) {
		//TODO : check if merchant exist by email or phone
		try{
			merchantService.registerMerchant(merchant);	
		}catch (Exception e) {
			LOGGER.error(
					"Merchant Deal : Error while registering merchant id: "+merchant.getEmail()
							, e);
			redirectAttributes.addFlashAttribute("error_message",
					"Error:: " + e.getMessage());
			return "redirect:/register/input";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Successfully registered merchant with Id "+merchant.getEmail());
		return "redirect:/merchant/login";
	}
	
	
	}
