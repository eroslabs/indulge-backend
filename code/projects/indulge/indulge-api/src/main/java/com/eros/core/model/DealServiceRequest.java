/**
 * indulge-api
 * author vikas created on Mar 31, 2015
 */
package com.eros.core.model;

/**
 * @author vikas
 *
 */
public class DealServiceRequest {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String image;
	private Integer serviceId;
	/**
	 * @return the image
	 */
	public String getImage() {
		return image;
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}
	
	
	/**
	 * @return the serviceId
	 */
	public Integer getServiceId() {
		return serviceId;
	}
	/**
	 * @param serviceId the serviceId to set
	 */
	public void setServiceId(Integer serviceId) {
		this.serviceId = serviceId;
	}
	
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the dealId
	 */
	public Integer getDealId() {
		return serviceId;
	}
	/**
	 * @param dealId the dealId to set
	 */
	public void setDealId(Integer dealId) {
		this.serviceId = dealId;
	}

}
