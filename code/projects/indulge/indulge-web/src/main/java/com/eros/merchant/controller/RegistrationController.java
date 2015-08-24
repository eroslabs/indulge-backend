package com.eros.merchant.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eros.core.BaseController;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantSchedule;
import com.eros.core.model.State;
import com.eros.service.security.UserRole;

/**
 * 
 * @author
 * 
 */
@Controller
@RequestMapping(value = "/register")
public class RegistrationController extends BaseController {

	/**
	 * 
	 */
	private static final String PHONE_REGEX = "^[0-9]+$";

	protected static Log LOGGER = LogFactory
			.getLog(RegistrationController.class);

	/**
	 * Providing list of cities for autocomplete on registration page
	 * 
	 * @param modelMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/input")
	public String create(ModelMap modelMap, HttpServletRequest request) {
		List<State> states = merchantService.fetchStates();
		modelMap.put("states", states);
		return "createProfile";
	}

	/**
	 * Saves the basic profile of merchant
	 * 
	 * @param map
	 * @param request
	 * @param redirectAttributes
	 * @param merchant
	 * @return
	 */
	@RequestMapping(value = "/saveMerchantBasicProfile")
	public String register(ModelMap map, HttpServletRequest request,
			final RedirectAttributes redirectAttributes,
			@ModelAttribute("merchant") Merchant merchant) {
		// TODO : check if merchant exist by email or phone
		try {
			if (merchant == null) {
				throw new Exception("Merchant Info invalid");
			}

			Merchant oldMerchant = merchantService.ifMerchantExist(
					merchant.getEmail(), merchant.getPhone());
			if (oldMerchant != null
					&& !oldMerchant.getRole().equalsIgnoreCase(
							UserRole.ROLE_OWNER.toString())) {
				LOGGER.error("Merchant already exist: " + merchant.getEmail()
						+ merchant.getPhone());
				redirectAttributes
						.addFlashAttribute(ERROR_MESSAGE,
								"Error:: Merchant already exist with entered email/phone");
				redirectAttributes.addFlashAttribute("merchant", merchant);
				return "redirect:/register/input";
			} else if ((oldMerchant != null
					&& oldMerchant.getRole().equalsIgnoreCase(
							UserRole.ROLE_OWNER.toString())) || merchant.getRole().equalsIgnoreCase(
									UserRole.ROLE_OWNER.toString()) ) {
				merchant.setRole(UserRole.ROLE_OWNER.toString());
			} else {
				merchant.setRole(UserRole.ROLE_USER.toString());
			}
			merchantService.registerMerchant(merchant);
			request.getSession().setAttribute(MERCHANT_ATTRIBUTE ,
					merchant);
		} catch (Exception e) {
			LOGGER.error(
					"Merchant Deal : Error while registering merchant id: "
							, e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: Some error occurred while saving information");
			redirectAttributes.addFlashAttribute("merchant", merchant);
			return "redirect:/register/input";
		}
		map.addAttribute(MERCHANT_ID, StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail() : merchant.getPhone());
		redirectAttributes.addFlashAttribute(
				SUCCESS_MESSAGE,
				"Successfully registered merchant with Id "
						+ merchant.getEmail());
		return "redirect:/register/inputLocation";
	}

	/**
	 * Generating location page for merchant
	 * 
	 * @param modelMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/inputLocation")
	public String inputLocation(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = null;
		try {
			merchant = (Merchant) request.getSession().getAttribute(MERCHANT_ATTRIBUTE );
			String id = (String) modelMap.get(MERCHANT_ID);
			if (merchant == null && StringUtils.isNotBlank(id)) {
				merchant = merchantService.getMerchantByEmailOrPhone(id);
				request.getSession().setAttribute(
						MERCHANT_ATTRIBUTE , merchant);
			}
			List<State> states = merchantService.fetchStates();
			modelMap.put("states", states);
			modelMap.put("merchant", merchant);
		} catch (Exception e) {
			LOGGER.error("Error in retrieving merchant", e);
		}
		return "inputLocation";
	}

	/**
	 * Saving Lat/Lng and merchant profile image
	 * 
	 * @param file
	 * @param merchant
	 * @param redirectAttributes
	 * @param session
	 * @param principal
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/saveLocation", method = RequestMethod.POST)
	public String handleSingleFileUpload(
			@RequestParam("file") MultipartFile file,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			Principal principal, ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
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
				redirectAttributes.addFlashAttribute(ERROR_MESSAGE, "Error:: "
						+ e.getMessage());
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

			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: " + e.getMessage());
			return "redirect:/register/inputLocation";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Location Information Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE , contextMerchant);
		modelMap.addAttribute(MERCHANT_ID, StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail() : merchant.getPhone());
		return "redirect:/register/inputAddress";

	}

	/**
	 * Input Page for Complete Address
	 * 
	 * @param modelMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/inputAddress")
	public String inputAddress(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		String id = (String) modelMap.get(MERCHANT_ID);
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmailOrPhone(id);
			request.getSession().setAttribute(MERCHANT_ATTRIBUTE, merchant);
		}
		if (merchant == null) {
			throw new IllegalArgumentException("Invalid session");
		}
		modelMap.put("merchant", merchant);
		return "inputAddress";
	}

	/**
	 * Saving detailed address info
	 * 
	 * @param merchant
	 * @param redirectAttributes
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/saveAddress", method = RequestMethod.POST)
	public String saveAddress(
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
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
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving address information");
			redirectAttributes.addFlashAttribute("merchant", merchant);
			return "redirect:/register/inputAddress";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Address Information Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE , contextMerchant);
		modelMap.addAttribute(MERCHANT_ID, StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail() : merchant.getPhone());
		return "redirect:/register/inputContact";

	}

	/**
	 * Input of merchant phone numbers
	 * 
	 * @param modelMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/inputContact")
	public String inputContact(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		String id = (String) modelMap.get(MERCHANT_ID);
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmailOrPhone(id);
			request.getSession().setAttribute(MERCHANT_ATTRIBUTE ,
					merchant);
		}
		modelMap.put("merchant", merchant);
		return "inputContact";
	}

	/**
	 * Saving merchant contact numbers.
	 * 
	 * @param phone1
	 * @param phone2
	 * @param phone3
	 * @param merchant
	 * @param redirectAttributes
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/saveContact", method = RequestMethod.POST)
	public String saveContact(@RequestParam("phone1") String phone1,
			@RequestParam("phone2") String phone2,
			@RequestParam("phone3") String phone3,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (StringUtils.isBlank(phone1) && StringUtils.isBlank(phone2)
				&& StringUtils.isBlank(phone3)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid phone numbers");
			return "redirect:/register/inputContact";
		}
		if ((StringUtils.isNotBlank(phone1) && !phone1.matches(PHONE_REGEX))
				|| (StringUtils.isNotBlank(phone2) && !phone2
						.matches(PHONE_REGEX))
				|| (StringUtils.isNotBlank(phone3) && !phone3
						.matches(PHONE_REGEX))) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid phone numbers");
			return "redirect:/register/inputContact";
		}
		Boolean clear = true;
		try {
			HashSet<String> phones = new HashSet<String>();
			if (StringUtils.isNotBlank(phone1)) {
				phones.add(phone1);
			}
			if (StringUtils.isNotBlank(phone2)) {
				phones.add(phone2);
			}
			if (StringUtils.isNotBlank(phone3)) {
				phones.add(phone3);
			}
			contextMerchant.setSoftware(merchant.getSoftware());
			clear = merchantService.saveContact(contextMerchant, phones);

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving address data ",
					e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving address information");
			return "redirect:/register/inputContact";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Your Contact Information Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE , contextMerchant);
		modelMap.addAttribute(MERCHANT_ID, StringUtils.isNotBlank(merchant
				.getEmail()) ? merchant.getEmail() : merchant.getPhone());
		return "redirect:/register/inputSchedule";

	}

	/**
	 * Taking schedule from merchant.
	 * 
	 * @param modelMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/inputSchedule")
	public String inputSchedule(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		String id = (String) modelMap.get(MERCHANT_ID);
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmailOrPhone(id);
			request.getSession().setAttribute(MERCHANT_ATTRIBUTE ,
					merchant);
		}
		ScheduleWrapper wrapper = new ScheduleWrapper();
		wrapper.add(new MerchantSchedule());
		wrapper.add(new MerchantSchedule());
		modelMap.put("schedule", wrapper);
		modelMap.put("merchant", merchant);
		return "inputSchedule";
	}

	/**
	 * Saving schedule information
	 * 
	 * @param schedule
	 * @param redirectAttributes
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/saveSchedule", method = RequestMethod.POST)
	public String saveSchedule(
			@ModelAttribute("schedule") ScheduleWrapper schedule,
			final RedirectAttributes redirectAttributes, HttpSession session,
			ModelMap modelMap) {
		if (schedule == null || schedule.getSchedule() == null
				|| schedule.getSchedule().size() <= 0) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Incorrect schedule information");
			return "redirect:/register/inputSchedule";
		}
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		List<MerchantSchedule> merchantSchedule = new ArrayList<MerchantSchedule>();
		try {
			for (MerchantSchedule submittedSchedule : schedule.getSchedule()) {
				if (StringUtils.isNotBlank(submittedSchedule.getWeekSchedule())
						&& StringUtils.isNotBlank(submittedSchedule
								.getOpeningTime())
						&& StringUtils.isNotBlank(submittedSchedule
								.getClosingTime())) {
					submittedSchedule.setMerchantId(contextMerchant.getId());
					merchantSchedule.add(submittedSchedule);
				}

			}
			if (merchantSchedule.size() <= 0) {
				redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
						"Invalid schedule information");
				return "redirect:/register/inputSchedule";
			}
			contextMerchant.setSchedule(merchantSchedule);
			clear = merchantService.saveSchedule(contextMerchant);

		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving Schedule data ",
					e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving schedule information");
			return "redirect:/register/inputSchedule";
		}
		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Your Schedule Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE , contextMerchant);
		return "redirect:/register/inputPhoto";

	}

	/**
	 * Input multiple Photo
	 * 
	 * @param modelMap
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/inputPhoto")
	public String inputPhoto(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session.getAttribute(MERCHANT_ATTRIBUTE);
		String id = (String) modelMap.get(MERCHANT_ID);
		if (merchant == null && StringUtils.isNotBlank(id)) {
			merchant = merchantService.getMerchantByEmailOrPhone(id);
			session.setAttribute(MERCHANT_ATTRIBUTE , merchant);
		}
		modelMap.put("merchant", merchant);
		return "inputPhoto";

	}

	/**
	 * Saving multiple photos of the merchant.
	 * 
	 * @param files
	 * @param merchant
	 * @param redirectAttributes
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/savePhoto", method = RequestMethod.POST)
	public String savePhoto(@RequestParam("files") MultipartFile[] files,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			ModelMap modelMap) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			if (files != null && files.length > 0) {
				for (int i = 0; i < files.length; i++) {

					if (files[i] != null && !files[i].isEmpty()) {
						try {
							byte[] bytes = files[i].getBytes();
							String filePath = merchantService
									.saveMerchantImage(bytes,
											contextMerchant.getId(),
											files[i].getOriginalFilename());
							MerchantImage image = new MerchantImage();
							image.setImage(filePath);
							image.setMerchantId(contextMerchant.getId());
							List<MerchantImage> images = contextMerchant
									.getImages();
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
											+ files[i].getOriginalFilename(), e);
							redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
									"Error:: " + e.getMessage());
							return "redirect:/merchant/home";
						}

					}
				}
			}
		} catch (Throwable e) {
			LOGGER.error("Merchant Address: Error while saving Image data ", e);
			clear = false;
		}

		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving image information");
			return "redirect:/register/inputPhoto";
		}
		redirectAttributes
				.addFlashAttribute(SUCCESS_MESSAGE,
						"Your basic profile & image/s are saved Successfully. Please login.");
		session.setAttribute(MERCHANT_ATTRIBUTE , contextMerchant);
		return "redirect:/merchant/login";

	}

	/**
	 * Forgot Password request
	 * 
	 * @param redirectAttributes
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/inputforgot", method = RequestMethod.GET)
	public String inputForgotRequest(
			final RedirectAttributes redirectAttributes, ModelMap modelMap) {
		return "inputForgot";

	}

	/**
	 * Verifying merchant post registration.
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping(value = "/verifyMerchant", method = RequestMethod.GET)
	public String verifyMerchant(@RequestParam("identifier") String identifier,
			@RequestParam("id") String id,
			final RedirectAttributes redirectAttributes) {
		try {
			if (StringUtils.isBlank(identifier)) {
				redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
						"Invalid Verification request.");
				return "redirect:/merchant/login";
			}
			merchantService.verifyMerchant(identifier, id);

		} catch (Exception e) {
			LOGGER.error("Error in initiating forgot password request for:::"
					+ identifier, e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in verifying merchant.");
			return "redirect:/merchant/login";
		}

		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Merchant Verified Successfully. Please Login.");
		return "redirect:/merchant/login";

	}

	/**
	 * Forgot Request is generated and mail is sent.
	 * 
	 * @param email
	 * @return
	 */
	@RequestMapping(value = "/triggerForgot", method = RequestMethod.GET)
	public String forgotPasword(@RequestParam("email") String email,
			final RedirectAttributes redirectAttributes) {
		try {
			if (StringUtils.isBlank(email)) {
				redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
						"Error in input.");
				return "/triggerForgot";
			}
			merchantService.saveForgotPasswordRequest(email, 0);

		} catch (Exception e) {
			LOGGER.error("Error in initiating forgot password request for:::"
					+ email, e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in sending password change request.");
			return "redirect:/merchant/login";
		}

		redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
				"Forgot password request sent Successfully");
		return "redirect:/merchant/login";

	}

	/**
	 * Taking new password from merchant post email link click.
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/inputPassword", method = RequestMethod.GET)
	public String inputPasword(@RequestParam("identifier") String identifier,
			@RequestParam("requestId") String requestId,
			final RedirectAttributes redirectAttributes, ModelMap modelMap) {
		Boolean error = false;

		if (StringUtils.isBlank(requestId) || StringUtils.isBlank(identifier)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in changing password. Invalid request.");
			return "redirect:/merchant/login";
		}
		modelMap.put("identifier", identifier);
		modelMap.put("requestId", requestId);
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
	public String forgotPasword(@RequestParam("identifier") String identifier,
			@RequestParam("requestId") String requestId,
			@RequestParam("passphrase") String passphrase,
			final RedirectAttributes redirectAttributes) {
		Boolean error = false;
		if (StringUtils.isBlank(requestId) || StringUtils.isBlank(identifier)
				|| StringUtils.isBlank(passphrase)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in changing password. Invalid request.");
			return "redirect:/merchant/login";
		}
		try {
			merchantService.changePassword(identifier, requestId, passphrase);

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

	@ExceptionHandler(Exception.class)
	public ModelAndView handleCustomException(Exception ex) {

		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);

		return model;

	}

}
