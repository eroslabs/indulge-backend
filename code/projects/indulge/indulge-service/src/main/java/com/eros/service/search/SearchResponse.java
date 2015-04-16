/**
 * indulge-service
 * author vikas created on Apr 14, 2015
 */
package com.eros.service.search;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.PageRequest;

import com.eros.core.model.Merchant;

/**
 * @author vikas
 *
 */
public class SearchResponse implements Serializable{
	
	List<?> response = null;
	Long total = 0L;
	PageRequest page = null;
	
	/**
	 * 
	 */
	public SearchResponse() {
		// TODO Auto-generated constructor stub
	}
	
	
	public SearchResponse(List<?> response, Long count , PageRequest page) {
		super();
		this.response = response;
		this.total = count;
		this.page = page;
	}
	
	/**
	 * @return the response
	 */
	public List<?> getResponse() {
		return response;
	}
	/**
	 * @param response the response to set
	 */
	public void setResponse(List<?> response) {
		this.response = response;
	}
	/**
	 * @return the total
	 */
	public Long getTotal() {
		return total;
	}
	/**
	 * @param total the total to set
	 */
	public void setTotal(Long total) {
		this.total = total;
	}
	/**
	 * @return the page
	 */
	public PageRequest getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(PageRequest page) {
		this.page = page;
	}

}
