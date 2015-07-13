package com.eros.search.controller;

import static com.eros.constants.RequestConstants.EMAIL;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.time.StopWatch;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eros.core.BaseController;
import com.eros.core.model.ServiceCategory;
import com.eros.core.model.State;
import com.eros.service.MerchantCustomService;
import com.eros.service.SearchService;
import com.eros.service.search.Filter;
import com.eros.service.search.IndexType;
import com.eros.service.search.SearchResponse;
import com.eros.utils.RequestUtils;

/**
 * indulge-web author vikas created on Apr 3, 2015
 */

@Controller
@RequestMapping("/search")
public class SearchController extends BaseController {

	protected static Log LOGGER = LogFactory.getLog(SearchController.class);

	@RequestMapping(value = "/loadStates", method = RequestMethod.GET)
	public @ResponseBody Map loadStates() {
		Map<String, Object> map = new HashMap<String, Object>();
		Boolean success = true;
		try {

			List<State> states = merchantService.fetchStates();
			if(states != null && !states.isEmpty()){
			map.put(STATUS, success);
			map.put("states", states);
			}

		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in fetching states ::" , e);
		}
		if (!success) {
			map.put(ERROR, "Error in loading states");
		}
		return map;

	}
	@RequestMapping(value = "/loadCategories", method = RequestMethod.GET)
	public @ResponseBody Map loadCategories() {
		Map<String, Object> map = new HashMap<String, Object>();
		Boolean success = true;
		try {

			List<ServiceCategory> services = merchantService.fetchAllServices();
			if(services != null && !services.isEmpty()){
			map.put(STATUS, success);
			map.put("categories", services);
			}

		} catch (Exception e) {
			success = false;
			LOGGER.error("Error in fetching services ::" , e);
		}
		if (!success) {
			map.put(ERROR, "Error in loading services");
		}
		return map;

	}


	/**
	 * 
	 * @param s
	 *            Search text to search in name, building, state, city
	 * @param hs
	 *            if home services are required value 1,0
	 * @param gs
	 *            if home services are required value 1,0
	 * @param services
	 *            Integer array containing services ID
	 * @param pf
	 *            Price From FLoat
	 * @param pt
	 *            Price To FLoat
	 * @param lat
	 *            Latitude
	 * @param lon
	 *            Longitude
	 * @param page
	 *            Page default 0
	 * @param limit
	 *            Limit Page limit
	 * @param sort
	 *            Field on which to be sorted rating,name
	 * @param dir
	 *            Sort direction asc, desc
	 * @return
	 */
	@RequestMapping(value = "/searchMerchant", method = RequestMethod.GET)
	public @ResponseBody
	Map search(
			@RequestParam(value = "s", required = false) String search,
			@RequestParam(value = "hs", required = false) Integer homeService,
			@RequestParam(value = "gs", required = false) Integer genderSupport,
			@RequestParam(value = "services", required = false) Integer[] services,
			@RequestParam(value = "pf", required = false, defaultValue = "0") Float priceFrom,
			@RequestParam(value = "pt", required = false) Float priceTo,
			@RequestParam(value = "lat", required = false) String lat,
			@RequestParam(value = "lon", required = false) String lon,
			@RequestParam(value = "lr", required = false) Integer lr,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "dir", required = false) String direction,
			@RequestParam(value = "dir", required = false) String city) {
		Boolean success = true;
		StopWatch watch = new StopWatch();
		watch.start();
		Filter filter = RequestUtils.generateFilter(search, homeService, genderSupport, services, priceFrom,
				priceTo, lat, lon, page, limit, direction, sort, IndexType.INDULGE,
				IndexType.MERCHANT,false,lr,city);
		Map<String, Object> map = new HashMap<String, Object>();
		SearchResponse response = null;
		try {
			response = searchService.search(filter);
			if(response !=null){
				map.put(RESULT, response.getResponse());
			}else{
				map.put(RESULT, null);
			}
			map.put(STATUS, success);
			
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + filter, e);
			success = false;
		}
		
		if (!success) {
			map.put(ERROR, "Error in search " + filter);
		}
		watch.stop();
		if(filter != null){
			SEARCHLOG.trace(filter.toString() +" Status"+ success +"  Took (ms): "+watch.getTime());
		}
		return map;

	}

	/**
	 * Work on service, location, merchant name 
	 * @param s
	 * @return
	 */
	@RequestMapping(value = "/suggestMerchant", method = RequestMethod.GET)
	public @ResponseBody Map search(
			@RequestParam(value = "s", required = true) String s,
			@RequestParam(value = "c", required = false) String c) {
		Boolean success = true;
		Filter filter = RequestUtils.generateFilter(s,c,IndexType.INDULGE,
				IndexType.MERCHANT,true);
		Map<String, Object> map = new HashMap<String, Object>();
		SearchResponse response = null;
		try {
			response = searchService.search(filter);
			if(response != null){
				map.put(RESULT, response.getResponse());
			}else{
				map.put(RESULT, null);
			}
			map.put(STATUS, success);
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + filter, e);
			success = false;
		}
		
		if (!success) {
			map.put(ERROR, "Error in search " + filter);
		}
		return map;

	}

	/**
	 * 
	 * @param s
	 *            Search text to search in name, building, state, city
	 * @param hs
	 *            if home services are required value 1,0
	 * @param gs
	 *            if home services are required value 1,0
	 * @param services
	 *            Integer array containing services ID
	 * @param pf
	 *            Price From FLoat
	 * @param pt
	 *            Price To FLoat
	 * @param lat
	 *            Latitude
	 * @param lon
	 *            Longitude
	 * @param page
	 *            Page default 0
	 * @param limit
	 *            Limit Page limit
	 * @param sort
	 *            Field on which to be sorted rating,name
	 * @param dir
	 *            Sort direction asc, desc
	 * @return
	 */
	@RequestMapping(value = "/searchDeals", method = RequestMethod.GET)
	public @ResponseBody
	Map searchDeals(@RequestParam(value = "s", required = false) String search,
			@RequestParam(value = "lat", required = false) String lat,
			@RequestParam(value = "lon", required = false) String lon,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "lr", required = false) Integer luxuryRating,
			@RequestParam(value = "services", required = false) Integer[] services,
			@RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "dir", required = false) String dir,
			@RequestParam(value = "c", required = false) String city) {
		Boolean success = true;
		StopWatch watch = new StopWatch();
		watch.start();
		Filter filter = RequestUtils.generateFilter(search, lat, lon, page, limit,
				dir, sort, IndexType.INDULGE, IndexType.DEAL,false,luxuryRating,services,city);
		Map<String, Object> map = new HashMap<String, Object>();
		SearchResponse response = null;
		try {
			response = searchService.search(filter);
			if(response !=null){
				map.put(RESULT, response.getResponse());
			}else{
				map.put(RESULT, response);
			}
		
			map.put(STATUS, success);	
		} catch (Exception e) {
			LOGGER.error("Error in search ::" + filter, e);
			success = false;
		}
		
		if (!success) {
			map.put(ERROR, "Error in search " + filter);
		}
		watch.stop();
		if(filter != null){
			SEARCHLOG.trace(filter.toString() +" Status"+ success +"  Took (ms): "+watch.getTime());
		}

		return map;

	}

	@ExceptionHandler(Exception.class)
	public @ResponseBody Map handleCustomException(Exception ex) {

		Map returnMap = new HashMap<String, Object>();
		returnMap.put(ERROR, ex.getMessage());
		returnMap.put(STATUS, false);
		return returnMap;

	}
}
