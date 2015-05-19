/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */
package com.eros.core.model;


/**
 * @author vikas
 *
 */
public class ServiceType extends BaseModel{

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private Integer serviceId;
    private Boolean status;
    /**
	 * 
	 */
	public ServiceType() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 */
	public ServiceType(Integer id) {
		super();
		this.id = id;
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
	 * @return the status
	 */
	public Boolean getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Boolean status) {
		this.status = status;
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

	    
    
}
