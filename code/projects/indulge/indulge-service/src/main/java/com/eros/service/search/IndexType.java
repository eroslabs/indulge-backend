/**
 * indulge-service
 * author vikas created on Apr 16, 2015
 */
package com.eros.service.search;

/**
 * @author vikas
 *
 */
public enum IndexType {
	
	INDULGE("indulge"),MERCHANT("merchant"),DEAL("deal");
	private String text;
	/**
	 * 
	 */
	private IndexType() {
		// TODO Auto-generated constructor stub
	}
	private IndexType(String type) {
		this.text = type;
	}
	public String getText() {
	    return this.text;
	 }
}
