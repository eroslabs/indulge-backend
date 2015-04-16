package com.eros.search.controller;

import static com.eros.constants.RequestConstants.DEAL_ID_PARAM;
import static com.eros.constants.RequestConstants.EMAIL;
import static com.eros.constants.RequestConstants.EMAIL_PARAM;
import static com.eros.constants.RequestConstants.PASS_PHRASE;
import static com.eros.constants.RequestConstants.REVIEW_PARAM;
import static com.eros.constants.RequestConstants.USER_PARAM;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eros.core.BaseController;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
import com.eros.service.SearchService;
import com.eros.service.UserService;
import com.eros.service.search.Filter;
import com.eros.service.search.IndexType;
import com.eros.service.search.SearchResponse;
import com.eros.utils.RequestUtils;
/**
 * indulge-web author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/search")
public class SearchController extends BaseController{

	

	

	protected static Log LOGGER = LogFactory
			.getLog(SearchController.class);

	@Resource(name = "searchService")
	protected SearchService searchService;

	
	/**
	 * `
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	@RequestMapping(value = "/loadMerchant", method = RequestMethod.GET)
	public @ResponseBody Map load(@RequestParam(EMAIL) String email) {
		Boolean success = true;
		try {
			searchService.loadMerchant(email);
		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in uploading merchant ::" + email , e);
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
	 * @param userEmail
	 * @param dealId
	 * @return
	 */
	@RequestMapping(value = "/loadDeal", method = RequestMethod.GET)
	public @ResponseBody Map load(@RequestParam("id") Integer id) {
		Boolean success = true;
		try {
			searchService.loadDeal(id);
		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in uploading deal::" + id , e);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in loading Merchant");
		}
		return map;

	}
	/**
	 * 
	 * @param s Search text to search in name, building, state, city
	 * @param hs if home services are required value 1,0
	 * @param gs if home services are required value 1,0
	 * @param services Integer array containing services ID
	 * @param pf Price From FLoat
	 * @param pt Price To FLoat
	 * @param lat Latitude
	 * @param lon Longitude
	 * @param page Page default 0
	 * @param limit Limit Page limit
	 * @param sort Field on which to be sorted rating,name
	 * @param dir Sort direction asc, desc
	 * @return
	 */
	@RequestMapping(value = "/searchMerchant", method = RequestMethod.GET)
	public @ResponseBody
	Map search(
			@RequestParam(value = "s", required = false) String s,
			@RequestParam(value = "hs", required = false) Boolean hs,
			@RequestParam(value = "gs", required = false) Boolean gs,
			@RequestParam(value = "services", required = false) Integer[] services,
			@RequestParam(value = "pf", required = false ,defaultValue = "0") Float pf,
			@RequestParam(value = "pt", required = false) Float pt,
			@RequestParam(value = "lat", required = false) String lat,
			@RequestParam(value = "lon", required = false) String lon,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "dir", required = false) String dir) {
		Boolean success = true;
		Filter filter = RequestUtils.generateFilter(s,hs,gs,services,pf,pt,lat,lon,page,limit,dir,sort,IndexType.INDULGE,IndexType.MERCHANT);
		SearchResponse response = null;
		try {
			response  = searchService.search(filter);
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + filter, e);
			success = false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(RESULT, response.getResponse());
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in search " + filter);
		}
		return map;

	}
	
	
	/**
	 * 
	 * @param s Search text to search in name, building, state, city
	 * @param hs if home services are required value 1,0
	 * @param gs if home services are required value 1,0
	 * @param services Integer array containing services ID
	 * @param pf Price From FLoat
	 * @param pt Price To FLoat
	 * @param lat Latitude
	 * @param lon Longitude
	 * @param page Page default 0
	 * @param limit Limit Page limit
	 * @param sort Field on which to be sorted rating,name
	 * @param dir Sort direction asc, desc
	 * @return
	 */
	@RequestMapping(value = "/searchDeals", method = RequestMethod.GET)
	public @ResponseBody
	Map searchDeals(
			@RequestParam(value = "s", required = false) String s,
			@RequestParam(value = "lat", required = false) String lat,
			@RequestParam(value = "lon", required = false) String lon,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "dir", required = false) String dir) {
		Boolean success = true;
		Filter filter = RequestUtils.generateFilter(s,lat,lon,page,limit,dir,sort,IndexType.INDULGE,IndexType.DEAL);
		SearchResponse response = null;
		try {
			response  = searchService.search(filter);
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + filter, e);
			success = false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(RESULT, response.getResponse());
		map.put(STATUS, success);
		if (!success) {
			map.put(ERROR, "Error in search " + filter);
		}
		return map;

	}

	@ExceptionHandler(Exception.class)
	public @ResponseBody Map handleCustomException(Exception ex) {
 
		Map returnMap = new HashMap<String, Object>();
		returnMap.put(ERROR, ex);
		returnMap.put(STATUS, false);
		return returnMap;
 
	}
}
