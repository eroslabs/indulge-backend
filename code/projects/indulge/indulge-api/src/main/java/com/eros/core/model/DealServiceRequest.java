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
	private String serviceName;
	private Integer serviceId;
	private String category;
	private String categoryId;
	private String serviceType;
	private String serviceTypeId;
	
	
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
	public String getServiceName() {
		return serviceName;
	}
	/**
	 * @param name the name to set
	 */
	public void setServiceName(String name) {
		this.serviceName = name;
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
	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return the categoryId
	 */
	public String getCategoryId() {
		return categoryId;
	}
	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	/**
	 * @return the serviceType
	 */
	public String getServiceType() {
		return serviceType;
	}
	/**
	 * @param serviceType the serviceType to set
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	/**
	 * @return the serviceTypeId
	 */
	public String getServiceTypeId() {
		return serviceTypeId;
	}
	/**
	 * @param serviceTypeId the serviceTypeId to set
	 */
	public void setServiceTypeId(String serviceTypeId) {
		this.serviceTypeId = serviceTypeId;
	}

}
