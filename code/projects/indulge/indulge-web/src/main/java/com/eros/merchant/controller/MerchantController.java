package com.eros.merchant.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.eros.constants.WebConstants;
import com.eros.core.model.DealRequest;
import com.eros.core.model.DealService;
import com.eros.core.model.DigitalMenuImage;
import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.MerchantImage;
import com.eros.core.model.MerchantSchedule;
import com.eros.core.model.MerchantService;
import com.eros.core.model.Reviews;
import com.eros.core.model.ServiceCategory;
import com.eros.filter.ISecurityContextAccessor;
import com.eros.service.MerchantCustomService;

/**
 * 
 * @author
 * 
 */
@Controller
@RequestMapping(value = "/merchant")
public class MerchantController {

	protected static Log MERCHANT_LOGGER = LogFactory
			.getLog(MerchantController.class);

	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;

	@Autowired
	ISecurityContextAccessor securityContextAccessor;

	@RequestMapping(value = "/login")
	public String login() {
		if (securityContextAccessor != null
				&& !securityContextAccessor.isAnonymous()) {
			return "redirect:/merchant/home";

		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/home")
	public String home(ModelMap modelMap, Principal principle,
			HttpServletRequest request) {
		Merchant merchant = null;
		try {
			merchant = merchantService.getMerchantByEmail(principle.getName());
			request.getSession().setAttribute("com.eros.core.model.merchant",
					merchant);
			modelMap.put("merchant", merchant);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (merchant == null) {
			return "redirect:/merchant/createProfile";
		}
		return "merchantHome";
	}

	@RequestMapping(value = "/inputLocation")
	public String create(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		modelMap.put("merchant", merchant);
		return "inputLocation";
	}

	@RequestMapping(value = "/saveLocation", method = RequestMethod.POST)
	public String handleSingleFileUpload(
			@RequestParam("file") MultipartFile file,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session,
			Principal principal) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		if (file != null && !file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				String filePath = merchantService.saveMerchantImage(bytes,
						contextMerchant.getId(), file.getOriginalFilename());
				contextMerchant.setImage(filePath);

			} catch (Exception e) {
				MERCHANT_LOGGER.error(
						"Merchant Location : Error while saving uploaded file "
								+ file.getOriginalFilename(), e);
				redirectAttributes.addFlashAttribute("error_message",
						"Error:: " + e.getMessage());
				return "redirect:/merchant/inputLocation";
			}

		}
		try {
			contextMerchant.setName(merchant.getName());
			contextMerchant.setLat(merchant.getLat());
			contextMerchant.setLng(merchant.getLng());
			merchantService.saveLocation(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant location: Error while saving location data "
							+ file.getOriginalFilename(), e);
			
			redirectAttributes.addFlashAttribute("error_message", "Error:: "
					+ e.getMessage());
			return "redirect:/merchant/inputLocation";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Location Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputAddress";

	}

	@RequestMapping(value = "/inputAddress")
	public String inputAddress(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		modelMap.put("merchant", merchant);
		return "inputAddress";
	}

	@RequestMapping(value = "/saveAddress", method = RequestMethod.POST)
	public String saveAddress(
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			contextMerchant.setUnitNumber(merchant.getName());
			contextMerchant.setBuilding(merchant.getBuilding());
			contextMerchant.setFloor(merchant.getFloor());
			contextMerchant.setCity(merchant.getCity());
			contextMerchant.setStreet(merchant.getStreet());
			contextMerchant.setPincode(merchant.getPincode());
			contextMerchant.setCountry(merchant.getCountry());
			contextMerchant.setLandmark(merchant.getLandmark());
			clear = merchantService.saveAddress(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving address data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving address information");
			return "redirect:/merchant/inputAddress";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Address Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputContact";

	}

	@RequestMapping(value = "/inputContact")
	public String inputContact(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
		modelMap.put("merchant", merchant);
		return "inputContact";
	}

	@RequestMapping(value = "/saveContact", method = RequestMethod.POST)
	public String saveContact(@RequestParam("phone1") String phone1,
			@RequestParam("phone2") String phone2,
			@RequestParam("phone3") String phone3,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			contextMerchant.setSoftware(merchant.getSoftware());
			clear = merchantService.saveContact(contextMerchant, phone1,
					phone1, phone3);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving address data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving address information");
			return "redirect:/merchant/inputContact";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Contact Information Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputSchedule";

	}

	@RequestMapping(value = "/inputSchedule")
	public String inputSchedule(ModelMap modelMap, HttpServletRequest request) {
		Merchant merchant = (Merchant) request.getSession().getAttribute(
				WebConstants.MERCHANT_ATTRIBUTE);
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
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		try {
			merchantSchedule.setMerchantId(contextMerchant.getId());
			contextMerchant.setSchedule(merchantSchedule);
			clear = merchantService.saveSchedule(contextMerchant);

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Schedule data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving schedule information");
			return "redirect:/merchant/inputSchedule";
		}
		redirectAttributes.addFlashAttribute("success_message",
				"Your Schedule Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputPhoto";

	}

	@RequestMapping(value = "/inputPhoto")
	public String inputPhoto(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		modelMap.put("merchant", merchant);
		return "inputPhoto";

	}

	@RequestMapping(value = "/savePhoto", method = RequestMethod.POST)
	public String savePhoto(@RequestParam("file") MultipartFile file,
			@ModelAttribute("merchant") com.eros.core.model.Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
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
					MERCHANT_LOGGER.error(
							"Merchant Location : Error while saving uploaded file "
									+ file.getOriginalFilename(), e);
					redirectAttributes.addFlashAttribute("error_message",
							"Error:: " + e.getMessage());
					return "redirect:/merchant/inputLocation";
				}

			}

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving image information");

		} 
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Image Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputPhoto";

	}
	
	
	@RequestMapping(value = "/inputDigitalMenu")
	public String inputDigitalMenu(ModelMap modelMap, HttpSession session) {
		Merchant merchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		modelMap.put("merchant", merchant);
		return "inputDigitalMenu";

	}
	
	@RequestMapping(value = "/saveDigitalMenu", method = RequestMethod.POST)
	public String saveDigitalMenu(@RequestParam("file") List<MultipartFile> file,@ModelAttribute("merchant") Merchant merchant,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		contextMerchant.setSeparateRateCard(merchant.getSeparateRateCard());
		contextMerchant.setServiceRadius(merchant.getServiceRadius());
		contextMerchant.setHomeService(merchant.getHomeService());
		Boolean clear = true;
		try {
			if (file != null && !file.isEmpty()) {
				List<DigitalMenuImage> filePaths = new ArrayList<DigitalMenuImage>();
				
				try {
					for (MultipartFile multipartFile : file) {
						
					byte[] bytes = multipartFile.getBytes();
					if(bytes != null && bytes.length > 0){
					String filePath = merchantService
							.saveMerchantImage(bytes, contextMerchant.getId(),
									multipartFile.getOriginalFilename());
					DigitalMenuImage image = new DigitalMenuImage();
					image.setMerchantId(contextMerchant.getId());
					image.setImage(filePath);
					filePaths.add(image);
					}
				}

					contextMerchant.setMenus(filePaths);
					clear = merchantService.saveDigitalMenus(contextMerchant);

				} catch (Exception e) {
					MERCHANT_LOGGER.error(
							"Merchant Location : Error while saving uploaded Menus "
									+ file, e);
					redirectAttributes.addFlashAttribute("error_message",
							"Error:: " + e.getMessage());
					return "redirect:/merchant/inputLocation";
				}

			}

		} catch (Throwable e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving image information");

		} 
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Digital Menu Saved Successfully");
		session.setAttribute("com.eros.core.model.merchant", contextMerchant);
		return "redirect:/merchant/inputPhoto";

	}

	@RequestMapping(value = "/reviews")
	public String reviews(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", defaultValue = "0") int start,
			@RequestParam(value = "rows", defaultValue = "10") int rows) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Reviews reviews = merchantService.fetchReviews(contextMerchant.getId(),
				start, rows);
		modelMap.put("reviews", reviews);
		return "reviews";

	}
	
	@RequestMapping(value = "/listDeals")
	public String listDeals(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", defaultValue = "0") int start,
			@RequestParam(value = "rows", defaultValue = "10") int rows) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		List<MerchantDeal> deals = merchantService.fetchDeals(contextMerchant.getId(),
				start, rows);
		modelMap.put("deals", deals);
		return "listDeals";

	}
	
	@RequestMapping(value = "/listDealRequests")
	public String listDealRequests(ModelMap modelMap, HttpSession session,
			@RequestParam(value = "start", defaultValue = "0") int start,
			@RequestParam(value = "rows", defaultValue = "10") int rows) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		List<DealRequest> dealRequests = merchantService.fetchDealRequest(contextMerchant.getId());
		modelMap.put("requests", dealRequests);
		return "listRequests";

	}

	@RequestMapping(value = "/inputDeal")
	public String inputDeal(ModelMap modelMap, HttpSession session) {
		List<ServiceCategory> categories = merchantService.fetchAllServices();
		modelMap.put("categories", categories);
		MerchantDeal deal = new MerchantDeal();
		modelMap.put("deal", deal);
		return "createDeal";

	}

	@RequestMapping(value = "/saveDeal", method = RequestMethod.POST)
	public String saveDeal(@RequestParam("selection") Integer[] selection,
			@ModelAttribute MerchantDeal deal,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		if (selection == null || selection.length <= 0) {
			redirectAttributes.addFlashAttribute("error_message",
					"No services Selected for this deal");
			return "redirect:/merchant/inputDeal";
		}
		List<DealService> services = new ArrayList<DealService>();
		for (int i = 0; i < selection.length; i++) {
			Integer id = selection[i];
			DealService service = new DealService(id);
			services.add(service);
		}
		if (services.size() > 0) {
			deal.setServices(services);
		}
		deal.setMerchantId(contextMerchant.getId());
		Boolean saved = true;
		try{
		saved = merchantService.saveDeal(deal);
		}catch (Exception e) {
			MERCHANT_LOGGER.error(
					"Merchant Deal : Error while saving deal "
							, e);
			redirectAttributes.addFlashAttribute("error_message",
					"Error:: " + e.getMessage());
			return "redirect:/merchant/listDeals";
		}
		if (!saved) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving Deal");

		} 
		redirectAttributes.addFlashAttribute("success_message",
				"Your deal is saved successfully");
		return "redirect:/merchant/listDeals";

	}
	
	@RequestMapping(value = "/inputServices")
	public String inputServices(ModelMap modelMap, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		List<ServiceCategory> categories = merchantService.fetchAllServices();
		modelMap.put("categories", categories);
		modelMap.put("merchant", contextMerchant);
		return "createMerchantServices";

	}
	
	@RequestMapping(value = "/saveMerchantServices", method = RequestMethod.POST)
	public String saveDeal(@RequestParam("selectedId") String[] selectedId,@RequestParam("selectedPrice") String[] selectedPrice,
			final RedirectAttributes redirectAttributes, HttpSession session) {
		Merchant contextMerchant = (Merchant) session
				.getAttribute(WebConstants.MERCHANT_ATTRIBUTE);
		Boolean clear = true;
		List<MerchantService> services = new ArrayList<MerchantService>();
		try{
		for (int i = 0; i < selectedPrice.length; i++) {
			MerchantService merchantService = new MerchantService();
			merchantService.setServiceId(Integer.parseInt(selectedId[i]));
			merchantService.setPrice(Float.parseFloat(selectedPrice[i]));
			merchantService.setMerchantId(contextMerchant.getId());
			services.add(merchantService);
		}
		contextMerchant.setServices(services);
		clear  = merchantService.saveServices(contextMerchant);
		}catch (Exception e) {
			MERCHANT_LOGGER.error(
					"Merchant Address: Error while saving Image data ", e);
			clear = false;
		}
		if (!clear) {
			redirectAttributes.addFlashAttribute("error_message",
					"Error'in saving image information");

		}
		redirectAttributes.addFlashAttribute("success_message",
				"Merchant Services Saved Successfully");
		return "redirect:/merchant/listDeals";

	}
	
	
	@ExceptionHandler(Exception.class)
	public ModelAndView handleCustomException(Exception ex) {
 
		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);
 
		return model;
 
	}
}
