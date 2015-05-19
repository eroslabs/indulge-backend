/**
 * indulge-web
 * author vikas created on Apr 22, 2015
 */
package com.eros.admin.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.core.BaseController;
import com.eros.service.AdminService;
import com.eros.service.MerchantCustomService;
import com.eros.service.search.SearchResponse;

/**
 * @author vikas
 *
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController extends BaseController{
	private static final String MERCHANT_STATS = "merchant_stats";
	protected static Log LOGGER = LogFactory
			.getLog(AdminController.class);
	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;
	
	@Resource(name = "adminService")
	protected AdminService adminService;
	
	@RequestMapping(value = "/home")
	public String home(ModelMap modelMap, Principal principle,
			HttpServletRequest request) {
		List<HashMap<String, String>> merchantsStats = null;
		try {
			merchantsStats = adminService.getMerchantsSummary();
			modelMap.put(MERCHANT_STATS, merchantsStats);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}
		
		return "admin/adminHome";
	}

	@RequestMapping(value = "/listDeactiveMerchants", method = RequestMethod.GET)
	public String searchDeals(ModelMap map,final RedirectAttributes redirectAttributes,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.fetchDeactiveMerchant( page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search of deactive merchants::" , e);
			success = false;
		}
		map.put(RESULT, response.getResponse());
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error:: in fetching deactive merchant : ");
			return "redirect:/admin/home";
		}
		return "admin/adminMerchantListing";

	}
	@RequestMapping(value = "/searchMerchant", method = RequestMethod.GET)
	public String searchDeals(ModelMap map,final RedirectAttributes redirectAttributes,@RequestParam(value = "s", required = true) String s,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.searchMerchant(s , page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + s, e);
			success = false;
		}
		map.put(RESULT, response.getResponse());
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error:: in fetching merchant : "+s);
			return "redirect:/admin/home";
		}
		return "admin/adminMerchantListing";

	}

	@RequestMapping(value = "/setLuxuryRating")
	public String changeLuxuryRating(ModelMap modelMap,@RequestParam(value = "id", required = true) Integer id,@RequestParam(value = "rating", required = true) Integer rating, Principal principle,
			HttpServletRequest request) {
		try {
			adminService.setMerchantLuxuryRating(id,rating);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}
		
		return "admin/thanks";
	}
	@RequestMapping(value = "/activateMerchant/{id}")
	public String activate(ModelMap modelMap,@PathVariable("id") Integer id, Principal principle,
			HttpServletRequest request) {
		try {
			adminService.changeMerchantStatus(id,true);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}
		
		return "admin/thanks";
	}
	@RequestMapping(value = "/refreshMerchant/{id}")
	public String refresh(ModelMap modelMap,@PathVariable(value="id") Integer id, Principal principle,
			HttpServletRequest request) {
		try {
			if(id != null)
				adminService.addToCache(id);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}
		
		return "admin/thanks";
	}
	@RequestMapping(value = "/deactivateMerchant/{id}")
	public String deactivate(ModelMap modelMap,@PathVariable("id") Integer id, Principal principle,
			HttpServletRequest request) {
		try {
			adminService.changeMerchantStatus(id,false);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}
		
		return "admin/thanks";
	}
	
	@RequestMapping(value = "/refresh")
	public String uploadAll(Principal principle,final RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		List<HashMap<String, String>> merchantsStats = null;
		try {
			adminService.uploadAllActiveMerchants();
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
			redirectAttributes.addFlashAttribute("error_message",
					"Error:: in loading all merchants  ");
			return "redirect:/admin/home";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Loading all merchants : Will take some time ");
		return "redirect:/admin/home";
	}
	
	@RequestMapping(value = "/fetchLatLong")
	public String fetchLatLong(ModelMap modelMap,@RequestParam(value = "id", required = true) List<Integer> id,final RedirectAttributes redirectAttributes, Principal principle,
			HttpServletRequest request) {
		try {
			adminService.fetchAndUpdateLatLng(id);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving lat Long", e);
			redirectAttributes.addFlashAttribute("error_message",
					" Some error occured while updating Lat/Lng");
			return "redirect:/admin/home";
		}
		redirectAttributes.addFlashAttribute("success_message",
				" Lat Longs updated for all the ids  " + id.toString());
		return "redirect:/admin/home";
	}
	
	
}
