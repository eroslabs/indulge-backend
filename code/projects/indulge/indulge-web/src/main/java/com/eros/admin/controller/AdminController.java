/**
 * indulge-web
 * author vikas created on Apr 22, 2015
 */
package com.eros.admin.controller;

import static com.eros.constants.RequestConstants.EMAIL;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.core.BaseController;
import com.eros.core.model.DealRequest;
import com.eros.service.search.SearchResponse;

/**
 * @author vikas
 * 
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController extends BaseController {
	private static final String MERCHANT_STATS = "merchant_stats";
	protected static Log LOGGER = LogFactory.getLog(AdminController.class);

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

	@RequestMapping(value = "/redemption")
	public String redeemReport(ModelMap modelMap, Principal principle,
			HttpServletRequest request) {
		List<HashMap<String, String>> redemptionStats = null;
		try {
			redemptionStats = adminService.getRedemptionReport();
			modelMap.put(MERCHANT_STATS, redemptionStats);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving redemption Stats", e);
		}

		return "admin/adminRedemptionReport";
	}
	@RequestMapping(value = "/listDeactiveMerchants", method = RequestMethod.GET)
	public String searchMerchants(ModelMap map,
			final RedirectAttributes redirectAttributes,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.fetchDeactiveMerchant(page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search of deactive merchants::", e);
			success = false;
		}
		map.put(RESULT, response);
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in fetching deactive merchant : ");
			return "redirect:/admin/home";
		}
		return "admin/adminMerchantListing";

	}

	@RequestMapping(value = "/listRequests", method = RequestMethod.GET)
	public String searchDealRequests(ModelMap map,
			final RedirectAttributes redirectAttributes,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		List<DealRequest> response = null;
		try {
			response = merchantService.fetchDealRequest(null);
		} catch (Exception e) {
			LOGGER.error("Error in search of deals::", e);
			success = false;
		}
		map.put(RESULT, response);
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in fetching deal requests : ");
			return "redirect:/admin/home";
		}
		return "admin/adminDealRequestListing";

	}

	@RequestMapping(value = "/listDeals", method = RequestMethod.GET)
	public String searchDeals(ModelMap map,
			final RedirectAttributes redirectAttributes,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.fetchDeals(page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search of deals::", e);
			success = false;
		}
		map.put(RESULT, response);
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in fetching deals : ");
			return "redirect:/admin/home";
		}
		return "admin/adminDealListing";

	}

	@RequestMapping(value = "/listErrors", method = RequestMethod.GET)
	public String listErrors(ModelMap map,
			final RedirectAttributes redirectAttributes,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.fetchErrors(page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search of deals::", e);
			success = false;
		}
		map.put(RESULT, response);
		map.put(STATUS, success);
		if (!success) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in fetching deals : ");
			return "redirect:/admin/home";
		}
		return "admin/adminErrorListing";

	}


	@RequestMapping(value = "/searchMerchant", method = RequestMethod.GET)
	public String searchMerchant(ModelMap map,
			final RedirectAttributes redirectAttributes,
			@RequestParam(value = "s", required = true) String s,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) {
		Boolean success = true;
		SearchResponse response = null;
		try {
			response = adminService.searchMerchant(s, page, limit);
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + s, e);
			success = false;
		}
		map.put(RESULT, response);
		if (!success) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in fetching merchant : " + s);
			return "redirect:/admin/home";
		}
		return "admin/adminMerchantListing";
	}

	
	
	@RequestMapping(value = "/setLuxuryRating")
	public String changeLuxuryRating(ModelMap modelMap,
			@RequestParam(value = "id", required = true) List<Integer> id,
			@RequestParam(value = "rating", required = true) Integer rating,
			Principal principle, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
		
		boolean success = false;
		try {
			for (Integer idInt : id) {
				adminService.setMerchantLuxuryRating(idInt, rating);
			}
			success=true;

		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in updating luxury rating : " + e.getMessage());
		}
		if (success) {
			redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
					"Merchants Luxury rating successfully updated");
			
		}
		return "redirect:/admin/home";
		

	}

	@RequestMapping(value = "/activateMerchant")
	public String activate(ModelMap modelMap, @RequestParam(value="id") List<Integer> id,
			Principal principle, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
		boolean success = false;
		try {
			for (Integer idInt : id) {
				adminService.changeMerchantStatus(idInt, true);	
			}
			success=true;
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
			
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in activating merchant : " + e.getMessage());
		}
		if (success) {
			redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
					"Merchant activated successfully");
			
		}
		if(id.size() > 1){
			return "redirect:/admin/home";
		}
		return "admin/thanks";
	}

	@RequestMapping(value = "/refreshMerchant/{id}")
	public String refresh(ModelMap modelMap,
			@PathVariable(value = "id") Integer id, Principal principle,
			HttpServletRequest request) {
		try {
			if (id != null)
				adminService.addToCache(id);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
		}

		return "admin/thanks";
	}

	@RequestMapping(value = "/deactivateMerchant")
	public String deactivate(ModelMap modelMap, @RequestParam("id") List<Integer> id,
			Principal principle, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
		boolean success = false;
		try {
			for (Integer idInt : id) {
			adminService.changeMerchantStatus(idInt, false);
			}
			success=true;

		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in deactivating merchant : " + e.getMessage());
		}
		if (success) {
			redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
					"Merchants deactivated successfully");
			
		}
		if(id.size() > 1){
			return "redirect:/admin/home";
		}
		return "admin/thanks";
	}

	@RequestMapping(value = "/loadMeta")
	public String uploadAll(Principal principle,
			final RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		List<HashMap<String, String>> merchantsStats = null;
		try {
			adminService.uploadAllActiveMerchants();
		} catch (Exception e) {
			LOGGER.error("Error in retrieving Stats", e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: in loading all merchants  ");
			return "redirect:/admin/home";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Loading all merchants : Will take some time ");
		return "redirect:/admin/home";
	}

	@RequestMapping(value = "/fetchLatLong")
	public String fetchLatLong(ModelMap modelMap,
			@RequestParam(value = "id", required = true) List<Integer> id,
			final RedirectAttributes redirectAttributes, Principal principle,
			HttpServletRequest request) {
		try {
			adminService.fetchAndUpdateLatLng(id);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving lat Long", e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					" Some error occured while updating Lat/Lng");
			return "redirect:/admin/home";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				" Lat Longs updated for all the ids  " + id.toString());
		return "redirect:/admin/home";
	}

	/**
	 * `
	 * 
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	@RequestMapping(value = "/loadMerchant", method = RequestMethod.GET)
	public @ResponseBody
	Map load(@RequestParam(EMAIL) String email) {
		Boolean success = true;
		try {
			searchService.loadMerchant(email);
		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in uploading merchant ::" + email, e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in loading Merchant");
		}
		return map;

	}

	/**
	 * `
	 * 
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	@RequestMapping(value = "/loadDeal", method = RequestMethod.GET)
	public @ResponseBody
	Map load(@RequestParam("id") Integer id) {
		Boolean success = true;
		try {
			searchService.loadDeal(id);
		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in uploading deal::" + id, e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in loading Merchant");
		}

		return map;

	}
}
