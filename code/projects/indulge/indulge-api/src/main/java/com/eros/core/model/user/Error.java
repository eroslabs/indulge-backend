/**
 * indulge-api
 * author vikas created on Apr 3, 2015
 */
package com.eros.core.model.user;

/**
 * @author vikas
 *
 */
public class Error {
	
	private String code;
	private String message;
	
	/**
	 * 
	 */
	public Error() {
		// TODO Auto-generated constructor stub
	}
	public Error(String code, String message) {
		this.code = code;
		this.message = message;
	}
	
	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}
	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

}
