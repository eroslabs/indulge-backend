package com.eros.merchant.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
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
import com.eros.core.model.DealRequest;
import com.eros.core.model.DigitalMenuImage;
import com.eros.core.model.Issue;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantSchedule;
import com.eros.core.model.MerchantService;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.security.SecurityUser;
import com.eros.service.security.UserRole;

/**
 * 
 * @author
 * 
 */
@Controller
@RequestMapping(value = "/merchant")
public class MerchantController extends BaseController {

	private static final String PHONE_REGEX = "^[0-9]+$";

	protected static Log MERCHANT_LOGGER = LogFactory
			.getLog(MerchantController.class);

	@RequestMapping(value = "/login")
	public String login() {
		return "login";
	}

	/**
	 * Redirects to Super admin Home if Super admin logs in else merchant home
	 * 
	 * @param modelMap
	 * @param principle
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/home")
	public String home(ModelMap modelMap, Principal principle,
			HttpServletRequest request) {
		Merchant merchant = null;
		String merchantEmail = ((SecurityUser) ((UsernamePasswordAuthenticationToken) principle)
				.getPrincipal()).getEmail();
		String merchantPhone = ((SecurityUser) ((UsernamePasswordAuthenticationToken) principle)
				.getPrincipal()).getPhone();
		String merchantIdentifier = StringUtils.isNotBlank(merchantEmail) ? merchantEmail
				: merchantPhone;
		if(request.getSession().getAttribute(MERCHANT_CHAIN_ATTRIBUTE) != null){
			merchant = (Merchant) request.getSession()
					.getAttribute(MERCHANT_ATTRIBUTE);
			if(merchant != null){
				modelMap.put(MERCHANT, merchant);
				return "merchantHome";	
			}
		}
		boolean fAdmin = request.isUserInRole(UserRole.ROLE_ADMIN.toString());
		if (fAdmin) {
			return "redirect:/admin/home";
		}

		try {
//			Handling for chains
			boolean chainOwner = request.isUserInRole(UserRole.ROLE_OWNER.toString());
			List<Merchant> chainList = null;
			if(chainOwner){
			chainList = merchantService
					.getChainInfo(merchantIdentifier);
			}
			if (chainList == null || chainList.size() <= 1) {
				merchant = merchantService
						.getMerchantByEmailOrPhone(merchantIdentifier);
				request.getSession().setAttribute(
						MERCHANT_ATTRIBUTE, merchant);
				modelMap.put(MERCHANT, merchant);
			}else{
				modelMap.put(MERCHANT_CHAIN, chainList);
				request.getSession().setAttribute(
						MERCHANT_CHAIN_ATTRIBUTE, true);
				return "selectMerchant";
			}
			
		} catch (Exception e) {
			MERCHANT_LOGGER.error("Error in loading merchant : principle"
					+ principle.getName(), e);

		}
		if (merchant == null) {
			return "redirect:/merchant/createProfile";
		}
		return "merchantHome";
	}



	/**
	 * This is for super admin/chain owner to visit merchant profile
	 * 
	 * @param modelMap
	 * @param principle
	 * @param request
	 * @param merchantIdentifier
	 * @return
	 */
	@RequestMapping(value = "/homeFromAdmin")
	public String homeAdmin(
			ModelMap modelMap,
			Principal principle,
			HttpServletRequest request,
			@RequestParam(value = "id", required = true) Integer merchantIdentifier) {
		Merchant merchant = null;
		try {
			merchant = merchantService.getMerchantById(merchantIdentifier);
			request.getSession().setAttribute(MERCHANT_ATTRIBUTE,
					merchant);
			modelMap.put(MERCHANT, merchant);
		} catch (Exception e) {
			MERCHANT_LOGGER.error("Error in loading merchant : principle"
					+ principle.getName(), e);

		}
		if (merchant == null) {
			return "redirect:/merchant/login";
		}
		return "merchantHome";
	}

	@RequestMapping(value = "/inputLocation")
	public String create(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		return "inputLocation";
	}

	@RequestMapping(value = "/saveLocation", method = RequestMethod.POST)
	public String handleSingleFileUpload(
			@RequestParam("file") MultipartFile file,
			@ModelAttribute(MERCHANT) com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			Principal principal) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (file != null && !file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				String filePath = merchantService.saveMerchantImage(bytes,
						contextMerchant.getId(), file.getOriginalFilename());
				contextMerchant.setImage(filePath);

			} catch (Exception e) {
				MERCHANT_LOGGER.error(
						"Merchant Profile image : Error while saving uploaded file "
								+ file.getOriginalFilename(), e);
				redirectAttributes.addFlashAttribute(ERROR_MESSAGE, "Error:: "
						+ e.getMessage());
				return "redirect:/merchant/inputLocation";
			}

		}
		try {
			contextMerchant.setCertification(merchant.getCertification());
			contextMerchant.setExperience(merchant.getExperience());
			contextMerchant.setLat(merchant.getLat());
			contextMerchant.setLng(merchant.getLng());
			merchantService.saveLocation(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant location: Error while saving location data "
							+ file.getOriginalFilename(), e);

			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: " + e.getMessage());
			return "redirect:/merchant/inputLocation";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Profile image saved successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputAddress")
	public String inputAddress(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		return "inputAddress";
	}

	@RequestMapping(value = "/saveAddress", method = RequestMethod.POST)
	public String saveAddress(
			@ModelAttribute(MERCHANT) com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
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
			contextMerchant.setGenderSupport(merchant.getGenderSupport());
			contextMerchant.setHomeService(merchant.getHomeService());
			clear = merchantService.saveAddress(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving address data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving address information");
			return "redirect:/merchant/inputAddress";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Address Information Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputContact")
	public String inputContact(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		return "inputContact";
	}

	@RequestMapping(value = "/saveContact", method = RequestMethod.POST)
	public String saveContact(@RequestParam("phone1") String phone1,
			@RequestParam(value = "phone2", required = false) String phone2,
			@RequestParam(value = "phone3", required = false) String phone3,
			@ModelAttribute(MERCHANT) com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (StringUtils.isBlank(phone1) && StringUtils.isBlank(phone2)
				&& StringUtils.isBlank(phone3)) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid phone numbers");
			return "redirect:/merchant/home";
		}
		if ((StringUtils.isNotBlank(phone1) && !phone1.matches(PHONE_REGEX))
				|| (StringUtils.isNotBlank(phone2) && !phone2
						.matches(PHONE_REGEX))
				|| (StringUtils.isNotBlank(phone3) && !phone3
						.matches(PHONE_REGEX))) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid phone numbers");
			return "redirect:/merchant/home";
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
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving address data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving address information");
			return "redirect:/merchant/home";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Contact Information Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputSchedule")
	public String inputSchedule(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		List<MerchantSchedule> schedule = merchant.getSchedule();
		if (schedule == null) {
			schedule = Collections.singletonList(new MerchantSchedule());
			merchant.setSchedule(schedule);
		}
		modelMap.put("merchant", merchant);
		return "inputSchedule";
	}

	@RequestMapping(value = "/saveSchedule", method = RequestMethod.POST)
	public String saveSchedule(@ModelAttribute("merchant") Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (merchant == null || merchant.getSchedule() == null
				|| merchant.getSchedule().size() <= 0) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid schedule information");
			return "redirect:/merchant/home";
		}

		List<MerchantSchedule> merchantSchedule = merchant.getSchedule();
		Boolean clear = true;
		try {
			for (MerchantSchedule merchantSchedule2 : merchantSchedule) {
				merchantSchedule2.setMerchantId(contextMerchant.getId());
			}
			contextMerchant.setSchedule(merchantSchedule);
			clear = merchantService.saveSchedule(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Schedule data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in saving schedule information");
			return "redirect:/merchant/home";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Schedule Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputIssue")
	public String inputIssue(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		modelMap.put("issue", new Issue());
		return "inputIssue";
	}

	@RequestMapping(value = "/saveIssue", method = RequestMethod.POST)
	public String saveIssue(@ModelAttribute("issue") Issue issue,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (issue == null || StringUtils.isBlank(issue.getSubject())) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Invalid error reported");
			return "redirect:/merchant/inputIssue";
		}
		Boolean clear = true;
		try {
			clear = merchantService.saveIssue(issue);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error("Error while saving the reported issue ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in saving reported error information");
			return "redirect:/merchant/inputIssue";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your problem is reported successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputPhoto")
	public String inputPhoto(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		return "inputPhoto";

	}

	/**
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/deleteImage", method = RequestMethod.GET)
	public void deleteImage(@RequestParam("imageId") Integer id,
			HttpSession session, HttpServletResponse response) {
		String responseStr = ERROR;
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		try {
			if (id == null || contextMerchant == null) {
				throw new Exception("Invalid parameters for change password");
			}
			merchantService.deleteImage(id, contextMerchant.getId());
			responseStr = "success";
		} catch (Exception e) {
			MERCHANT_LOGGER.error("Error in deleting image :::" + id, e);
		}
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.println(responseStr);

		} catch (IOException ex) {
			MERCHANT_LOGGER.error("error in writing deleimage response");
		} finally {
			out.close();
		}

	}

	/**
	 * 
	 * @param email
	 * @param requestId
	 * @param passphrase
	 * @return
	 */
	@RequestMapping(value = "/deleteMenuImage", method = RequestMethod.GET)
	public void deleteMenuImage(@RequestParam("imageId") Integer id,
			HttpSession session, HttpServletResponse response) {
		String responseStr = ERROR;
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		try {
			if (id == null || contextMerchant == null) {
				throw new Exception("Invalid parameters for delete image");
			}
			merchantService.deleteMenuImage(id, contextMerchant.getId());
			responseStr = "success";
		} catch (Exception e) {
			MERCHANT_LOGGER.error("Error in deleting image :::" + id, e);
		}
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.println(responseStr);

		} catch (IOException ex) {
			MERCHANT_LOGGER.error("error in writing delete image response");
		} finally {
			out.close();
		}

	}

	@RequestMapping(value = "/savePhoto", method = RequestMethod.POST)
	public String savePhoto(@RequestParam("files") MultipartFile[] files,
			@ModelAttribute(MERCHANT) com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			if (files != null && files.length > 0) {
				for (int i = 0; i < files.length; i++) {

					if (files[i] != null && !files[i].isEmpty()) {
						try {
							if (files[i].getSize() <= 0) {
								continue;
							}
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
							// merchantService.completeProfile(merchant);

						} catch (Exception e) {
							MERCHANT_LOGGER
									.error("Merchant Location : Error while saving uploaded file "
											+ files[i].getOriginalFilename(), e);
							redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
									"Error:: " + e.getMessage());
							return "redirect:/merchant/home";
						}

					}
				}
			}
		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving image information");

		}
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Image Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/inputDigitalMenu")
	public String inputDigitalMenu(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		modelMap.put(MERCHANT, merchant);
		return "inputDigitalMenu";

	}

	@RequestMapping(value = "/saveDigitalMenu", method = RequestMethod.POST)
	public String saveDigitalMenu(
			@RequestParam("file") List<MultipartFile> file,
			@ModelAttribute(MERCHANT) Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		contextMerchant.setSeparateRateCard(merchant.getSeparateRateCard());
		contextMerchant.setServiceRadius(merchant.getServiceRadius());
		contextMerchant.setHomeService(merchant.getHomeService());
		Boolean clear = true;
		try {
			if (file != null && !file.isEmpty()) {
				List<DigitalMenuImage> filePaths = new ArrayList<DigitalMenuImage>();

				try {
					for (MultipartFile multipartFile : file) {
						if (multipartFile.getSize() <= 0) {
							continue;
						}
						byte[] bytes = multipartFile.getBytes();
						if (bytes != null && bytes.length > 0) {
							String filePath = merchantService
									.saveMerchantImage(bytes,
											contextMerchant.getId(),
											multipartFile.getOriginalFilename());
							DigitalMenuImage image = new DigitalMenuImage();
							image.setMerchantId(contextMerchant.getId());
							image.setImage(filePath);
							filePaths.add(image);
						}
					}
					if (filePaths != null && filePaths.size() > 0) {
						contextMerchant.setMenus(filePaths);
						merchant.setMenus(filePaths);
					}
					merchant.setId(contextMerchant.getId());
					clear = merchantService.saveDigitalMenus(merchant);
				} catch (Exception e) {
					MERCHANT_LOGGER.error(
							"Merchant Location : Error while saving uploaded Menus "
									+ file, e);
					redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
							"Error:: " + e.getMessage());
					return "redirect:/merchant/inputDigitalMenu";
				}

			}

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving image information");

		}
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Digital Menu Saved Successfully");
		session.setAttribute(MERCHANT_ATTRIBUTE, contextMerchant);
		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/reviews")
	public String reviews(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", defaultValue = "0") int start,
			@RequestParam(value = "rows", defaultValue = "10") int rows) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		Reviews reviews = null;
		if (contextMerchant != null) {
			reviews = merchantService.fetchReviews(contextMerchant.getId(),
					start, rows);
		}
		modelMap.put("merchant", contextMerchant);
		modelMap.put("reviews", reviews);
		return "reviews";

	}

	@RequestMapping(value = "/listDeals")
	public String listDeals(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", required = false) Integer start,
			@RequestParam(value = "rows", required = false) Integer rows,
			@RequestParam(value = "coupon", required = false) String coupon) {

		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		List<MerchantDeal> deals = merchantService.fetchDeals(
				contextMerchant.getId(), coupon, start, rows);
		List<ServiceCategory> categories = merchantService.fetchAllServices();
		modelMap.put("categories", categories);
		modelMap.put("deals", deals);
		return "listDeals";

	}

	@RequestMapping(value = "/killDeal")
	public String killDeals(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "dealId") Integer dealId) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		merchantService.killDeal(contextMerchant.getId(), dealId);
		return "redirect:/merchant/listDeals";

	}

	@RequestMapping(value = "/listDealRequests")
	public String listDealRequests(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", defaultValue = "0") int start,
			@RequestParam(value = "rows", defaultValue = "10") int rows) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		List<DealRequest> dealRequests = merchantService
				.fetchDealRequest(contextMerchant);
		modelMap.put("requests", dealRequests);
		modelMap.put("merchant", contextMerchant);
		return "listRequests";

	}

	@RequestMapping(value = "/inputDeal")
	public String inputDeal(ModelMap modelMap, HttpSession session) {
		List<ServiceCategory> categories = merchantService.fetchAllServices();
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		List<MerchantService> services = merchantService
				.fetchMerchantServices(contextMerchant.getId());
		if (services != null && services.size() > 0) {
			Set<Integer> uniqueCategories = new HashSet<Integer>();

			Set<Integer> uniqueService = new HashSet<Integer>();
			for (MerchantService service : services) {
				if (service.getCategoryId() != null) {
					uniqueCategories.add(service.getCategoryId());
				}
				if (service.getServiceId() != null) {
					uniqueService.add(service.getServiceId());
				}
			}
			modelMap.put("uniqueCategory", uniqueCategories);
			modelMap.put("uniqueService", uniqueService);
		}
		modelMap.put("categories", categories);
		MerchantDeal deal = new MerchantDeal();
		modelMap.put("deal", deal);
		modelMap.put("services", services);
		return "createDeal";

	}

	@RequestMapping(value = "/saveDeal", method = RequestMethod.POST)
	public String saveDeal(
			@RequestParam(value = "categoryId", required = false) List<Integer> categoryIds,
			@RequestParam(value = "serviceId", required = false) List<Integer> serviceIds,
			@RequestParam(value = "serviceTypeId", required = false) List<Integer> serviceTypeIds,
			@ModelAttribute MerchantDeal deal,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (categoryIds == null && serviceIds == null && serviceTypeIds == null) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"No services Selected for this deal");
			return "redirect:/merchant/inputDeal";
		}
		if (categoryIds != null) {
			categoryIds.removeAll(Collections.singleton(null));
			// bad hack but validation more tricky on UI
			if (categoryIds.size() > 0) {
				serviceIds = null;
				serviceTypeIds = null;
			}
			deal.setCategoryBased(true);
		}
		if (serviceIds != null) {
			serviceIds.removeAll(Collections.singleton(null));
		}
		if (serviceTypeIds != null) {
			serviceTypeIds.removeAll(Collections.singleton(null));
		}
		deal.setMerchantId(contextMerchant.getId());

		Boolean saved = true;
		try {
			saved = merchantService.saveDeal(deal, categoryIds, serviceIds,
					serviceTypeIds);
		} catch (Exception e) {
			MERCHANT_LOGGER
					.error("Merchant Deal : Error while saving deal ", e);
			saved = false;
		}
		if (!saved) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving Deal");
			return "redirect:/merchant/inputDeal";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your deal is saved successfully");
		return "redirect:/merchant/listDeals";

	}

	@RequestMapping(value = "/inputServices")
	public String inputServices(ModelMap modelMap, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		List<ServiceCategory> categories = merchantService.fetchAllServices();
		modelMap.put("categories", categories);
		modelMap.put(MERCHANT, contextMerchant);
		return "createMerchantServices";

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
	public String changePasword(
			@RequestParam("oldPassphrase") String oldPassphrase,
			@RequestParam("passphrase") String passphrase,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			if (StringUtils.isBlank(oldPassphrase)
					|| StringUtils.isBlank(passphrase)) {
				throw new Exception("Invalid parameters for change password");
			}
			if (!oldPassphrase.equals(passphrase)) {
				merchantService
						.updatePassword(StringUtils.isBlank(contextMerchant
								.getEmail()) ? contextMerchant.getPhone()
								: contextMerchant.getEmail(), oldPassphrase,
								passphrase );
				redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
						"Password updated successfully");
			} else {
				redirectAttributes.addFlashAttribute(SUCCESS_MESSAGE,
						"Both old/new passwords are same");
			}

		} catch (Exception e) {
			MERCHANT_LOGGER.error(
					"Error while resetting new password for merchant ", e);
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error:: " + e.getMessage());
			return "redirect:/merchant/home";
		}

		return "redirect:/merchant/home";

	}

	@RequestMapping(value = "/saveMerchantServices", method = RequestMethod.POST)
	public String saveMerchantServices(
			@RequestParam("categoryId") String[] categoryId,
			@RequestParam("selectedId") String[] selectedId,
			@RequestParam("selectedType") String[] selectedType,
			@RequestParam("selectedGender") String[] selectedGender,
			@RequestParam("selectedHomeService") String[] selectedHomeService,
			@RequestParam("selectedPrice") String[] selectedPrice,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(MERCHANT_ATTRIBUTE);
		if (selectedType == null || selectedPrice == null || selectedId == null) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error in saving service information, Invalid selection.");
			return "redirect:/merchant/inputServices";
		}
		Boolean clear = true;
		List<MerchantService> services = new ArrayList<MerchantService>();
		try {
			for (int i = 0; i < selectedPrice.length; i++) {
				MerchantService merchantService = new MerchantService();
				try {
					merchantService.setCategoryId(Integer
							.parseInt(categoryId[i]));
					merchantService.setServiceId(Integer
							.parseInt(selectedId[i]));
					merchantService.setServiceTypeId(Integer
							.parseInt(selectedType[i]));
					merchantService
							.setPrice(Float.parseFloat(selectedPrice[i]));
					merchantService.setGender(Integer
							.parseInt(selectedGender[i]));
					merchantService.setHomeService(Integer
							.parseInt(selectedHomeService[i]));
					merchantService.setMerchantId(contextMerchant.getId());
					services.add(merchantService);
				} catch (Exception e) {
					// ignore extra input boxes
				}

			}
			contextMerchant.setServices(services);
			clear = merchantService.saveServices(contextMerchant);
		} catch (Exception e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Service data ", e);
			return "redirect:/merchant/inputServices";
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute(ERROR_MESSAGE,
					"Error'in saving service information");
			return "redirect:/merchant/inputServices";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Services Saved Successfully");
		return "redirect:/merchant/home";

	}

	@ExceptionHandler(Exception.class)
	public ModelAndView handleCustomException(Exception ex) {

		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);

		return model;

	}
}
