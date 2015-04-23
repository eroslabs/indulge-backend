/**
 * indulge-web
 * author vikas created on Apr 16, 2015
 */
package com.eros.core;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

	protected static final String SEARCH = "SEARCH_LOG";
	protected static final Logger SEARCHLOG = LoggerFactory
			.getLogger(SEARCH);
}
