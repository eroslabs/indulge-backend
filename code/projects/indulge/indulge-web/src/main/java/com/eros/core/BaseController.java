/**
 * indulge-web
 * author vikas created on Apr 16, 2015
 */
package com.eros.core;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.eros.service.AdminService;
import com.eros.service.MerchantCustomService;
import com.eros.service.SearchService;
import com.eros.service.UserService;

/**
 * @author vikas
 * 
 */
public class BaseController {

	/**
	 * 
	 */
	public BaseController() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 */
	protected static final String RESULT = "result";

	/**
	 * 
	 */
	protected static final String ERROR = "error";

	/**
	 * 
	 */
	protected static final String STATUS = "status";
	
	protected static final String USER = "user";

	protected static final String SEARCH = "SEARCH_LOG";
	
	/**
	 * 
	 */
	protected static final String REQUEST_ID = "requestId";

	/**
	 * 
	 */
	protected static final String IDENTIFIER = "identifier";

	protected static final String MERCHANT = "merchant";
	/**
	 * 
	 */
	protected static final String SUCCESS_MESSAGE = "success_message";

	/**
	 * 
	 */
	protected static final String ERROR_MESSAGE = "error_message";
	protected static final String MERCHANT_ID = "merchantId";

	protected static final Logger SEARCHLOG = LoggerFactory
			.getLogger(SEARCH);
	
	@Resource(name = "userServiceImpl")
	protected UserService userService;


	@Resource(name = "searchService")
	protected SearchService searchService;

	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;
	
	@Resource(name = "adminService")
	protected AdminService adminService;
	
}
