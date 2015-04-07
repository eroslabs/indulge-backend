
package com.eros.core.model;

import java.util.HashMap;
import java.util.Map;

/**
 * indulge-api
 * author vikas created on Apr 3, 2015
 */
public class JsonReturnObject {
	private Map<String, Object> response = new HashMap<String, Object>();
	

	/**
	 * @return the response
	 */
	public Map<String, Object> getResponse() {
		return response;
	}

	/**
	 * @param response the response to set
	 */
	public void setResponse(Map<String, Object> response) {
		this.response = response;
	}
	
}
