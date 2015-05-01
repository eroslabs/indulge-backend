package com.eros.merchant.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.constants.WebConstants;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantSchedule;
import com.eros.core.model.State;
import com.eros.service.MerchantCustomService;

/**
 * 
 * @author
 * 
 */
@Controller
@RequestMapping(value = "/register")
public class RegistrationController {

	protected static Log LOGGER = LogFactory
			.getLog(RegistrationController.class);

	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;

	@RequestMapping(value = "/input")
	public String create(ModelMap modelMap, HttpServletRequest request) {
		List<State> states = merchantService.fetchStates();
		modelMap.put("states", states);
		return "createProfile";
	}

	@RequestMapping(value = "/saveMerchantBasicProfile")
	public String register(ModelMap map, HttpServletRequest request,
			final RedirectAttributes redirectAttributes,@ModelAttribute("merchant") Merchant merchant) {
		// TODO : check if merchant exist by email or phone
		try {
			if (merchant == null) {
				throw new Exception("Merchant Info invalid");
			}
			
			Merchant merchantOld = merchantService.getMerchantByEmail(StringUtils.isNotBlank(merchant
					.getEmail()) ? merchant.getEmail():merchant.getPhone());
			if(merchantOld != null){
				throw new Exception("Merchant Already Exist With Entered Email/phone");
			}
			merchantService.registerMerchant(merchant);
			merchant = merchantService.getMerchantByEmail(StringUtils.isNotBlank(merchant
					.getEmail()) ? merchant.getEmail():merchant.getPhone());
			request.getSession().setAttribute("com.eros.core.model.merchant",merchant);
		} catch (Exception e) {
			LOGGER.error(
					"Merchant Deal : Error while registering merchant id: "
							+ merchant.getEmail(), e);
			redirectAttributes.addFlashAttribute("error_message", "Error:: "
					+ e.getMessage());
			return "redirect:/register/input";
		}
		map.addAttribute("merchantId", StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail():merchant.getPhone());
		redirectAttributes.addFlashAttribute(
				"success_message",
				"Successfully registered merchant with Id "
						+ merchant.getEmail());
		return "redirect:/register/inputLocation";
	}

	@RequestMapping(value = "/inputLocation")
	public String inputLocation(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = null;
		try {
			merchant = (Merchant)request.getSession().getAttribute("com.eros.core.model.merchant");
			String id = (String)modelMap.get("merchantId");
			if (merchant == null && StringUtils.isNotBlank(id)) {
				merchant = merchantService.getMerchantByEmail(merchant
						.getEmail());
				request.getSession().setAttribute(
						"com.eros.core.model.merchant", merchant);
			}
				List<State> states = merchantService.fetchStates();
				modelMap.put("states", states);
				modelMap.put("merchant", merchant);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving merchant", e);
		}
		return "inputLocation";
	}

	@RequestMapping(value = "/saveLocation", method = RequestMethod.POST)
	public String handleSingleFileUpload(
			@RequestParam("file") MultipartFile file,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			Principal principal, ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		if (file != null && !file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				String filePath = merchantService.saveMerchantImage(bytes,
						contextMerchant.getId(), file.getOriginalFilename());
				contextMerchant.setImage(filePath);

			} catch (Exception e) {
				LOGGER.error(
						"Merchant Location : Error while saving uploaded file "
								+ file.getOriginalFilename(), e);
				redirectAttributes.addFlashAttribute("error_message",
						"Error:: " + e.getMessage());
				return "redirect:/register/inputLocation";
			}

		}
		try {
			contextMerchant.setCertification(merchant.getCertification());
			contextMerchant.setExperience(merchant.getExperience());
			contextMerchant.setLat(merchant.getLat());
			contextMerchant.setLng(merchant.getLng());
			merchantService.saveLocation(contextMerchant);

		} catch (Throwable e) {
			LOGGER.error("Merchant location: Error while saving location data "
					+ file.getOriginalFilename(), e);

			redirectAttributes.addFlashAttribute("error_message", "Error:: "
					+ e.getMessage());
			return "redirect:/register/inputLocation";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Location Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		modelMap.addAttribute("merchantId", StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail():merchant.getPhone());
		return "redirect:/register/inputAddress";

	}

	@RequestMapping(value = "/inputAddress")
	public String inputAddress(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		String id = (String)modelMap.get("merchantId");
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmail(merchant
					.getEmail());
			request.getSession().setAttribute(
					"com.eros.core.model.merchant", merchant);
		}
		modelMap.put("merchant", merchant);
		return "inputAddress";
	}

	@RequestMapping(value = "/saveAddress", method = RequestMethod.POST)
	public String saveAddress(
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			contextMerchant.setAddress(merchant.getAddress());
			contextMerchant.setLocality(merchant.getLocality());
			contextMerchant.setEstablishment(merchant.getEstablishment());
			contextMerchant.setCity(merchant.getCity());
			contextMerchant.setPincode(merchant.getPincode());
			contextMerchant.setCountry(merchant.getCountry());
			contextMerchant.setLandmark(merchant.getLandmark());
			contextMerchant.setCcAccepted(merchant.getCcAccepted());
			contextMerchant.setAcFacility(merchant.getAcFacility());
			clear = merchantService.saveAddress(contextMerchant);

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving address data ",
					e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving address information");
			return "redirect:/register/inputAddress";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Address Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		modelMap.addAttribute("merchantId", StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail():merchant.getPhone());
		return "redirect:/register/inputContact";

	}

	@RequestMapping(value = "/inputContact")
	public String inputContact(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		String id = (String)modelMap.get("merchantId");
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmail(merchant
					.getEmail());
			request.getSession().setAttribute(
					"com.eros.core.model.merchant", merchant);
		}
		modelMap.put("merchant", merchant);
		return "inputContact";
	}

	@RequestMapping(value = "/saveContact", method = RequestMethod.POST)
	public String saveContact(@RequestParam("phone1") String phone1,
			@RequestParam("phone2") String phone2,
			@RequestParam("phone3") String phone3,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session, ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			contextMerchant.setSoftware(merchant.getSoftware());
			clear = merchantService.saveContact(contextMerchant, phone1,
					phone1, phone3);

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving address data ",
					e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving address information");
			return "redirect:/register/inputContact";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Contact Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		modelMap.addAttribute("merchantId", StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail():merchant.getPhone());
		return "redirect:/register/inputSchedule";

	}

	@RequestMapping(value = "/inputSchedule")
	public String inputSchedule(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		String id = (String)modelMap.get("merchantId");
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmail(merchant
					.getEmail());
			request.getSession().setAttribute(
					"com.eros.core.model.merchant", merchant);
		}
		MerchantSchedule schedule = merchant.getSchedule();
		if (schedule == null) {
			schedule = new MerchantSchedule();
		}
		modelMap.put("schedule", schedule);
		return "inputSchedule";
	}

	@RequestMapping(value = "/saveSchedule", method = RequestMethod.POST)
	public String saveSchedule(
			@ModelAttribute("schedule") com.eros.core.model.MerchantSchedule merchantSchedule,
			final RedirectAttributes redirectAttributes, HttpSession session, ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			merchantSchedule.setMerchantId(contextMerchant.getId());
			contextMerchant.setSchedule(merchantSchedule);
			clear = merchantService.saveSchedule(contextMerchant);

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving Schedule data ",
					e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving schedule information");
			return "redirect:/register/inputSchedule";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Schedule Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/register/inputPhoto";

	}

	@RequestMapping(value = "/inputPhoto")
	public String inputPhoto(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		String id = (String)modelMap.get("merchantId");
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmail(merchant
					.getEmail());
			session.setAttribute(
					"com.eros.core.model.merchant", merchant);
		}
		modelMap.put("merchant", merchant);
		return "inputPhoto";

	}

	@RequestMapping(value = "/savePhoto", method = RequestMethod.POST)
	public String savePhoto(@RequestParam("file") MultipartFile file,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			if (file != null && !file.isEmpty()) {
				try {
					byte[] bytes = file.getBytes();
					String filePath = merchantService
							.saveMerchantImage(bytes, contextMerchant.getId(),
									file.getOriginalFilename());
					MerchantImage image = new MerchantImage();
					image.setImage(filePath);
					image.setMerchantId(contextMerchant.getId());
					List<MerchantImage> images = contextMerchant.getImages();
					if (images == null) {
						images = new ArrayList<MerchantImage>();
					}
					images.add(image);
					contextMerchant.setImages(images);
					clear = merchantService.savePhoto(image);
					merchantService.completeProfile(merchant);
					
				} catch (Exception e) {
					LOGGER.error(
							"Merchant Location : Error while saving uploaded file "
									+ file.getOriginalFilename(), e);
					redirectAttributes.addFlashAttribute("error_message",
							"Error:: " + e.getMessage());
					return "redirect:/register/inputPhoto";
				}

			}

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving image information");

		}
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Image Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/register/inputPhoto";

	}

	/**
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping(value = "/triggerForgot", method = RequestMethod.GET)
	public String forgotPasword(@RequestParam("email") String email,final RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			merchantService.saveForgotPasswordRequest(email);
			

		} catch (Exception e) {
			LOGGER.error("Error in initiating forgot password request for:::"
					+ email,e);
			redirectAttributes.addFlashAttribute("error_message",
					"Error in sending password change request.");
			return "/merchant/login";
		}

		redirectAttributes.addFlashAttribute("success_message",
				"Forgot password request sent Successfully");
		return "/merchant/login";

	}

	/**
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public String forgotPasword(@RequestParam("email") String email,
			@RequestParam("requestId") String requestId,
			@RequestParam("passphrase") String passphrase,final RedirectAttributes redirectAttributes) {
		Boolean error = false;
		try {
			merchantService.changePassword(email, requestId, passphrase);

		} catch (Exception e) {
			error = true;
			LOGGER.error("Error in changing password for:::" + email);
		}
		if (error) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in changing password");

		}
		redirectAttributes.addFlashAttribute("success_message",
				"Password changed successfully");

		return "redirect:/merchant/login";

	}

	@ExceptionHandler(Exception.class)
	public ModelAndView handleCustomException(Exception ex) {

		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);

		return model;

	}

}
