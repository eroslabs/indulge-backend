/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */
package com.eros.core.model;

import java.util.List;

/**
 * @author vikas
 *
 */
public class Service extends BaseModel{

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
    private Boolean status;
    private List<ServiceType> serviceTypes;
    /**
	 * 
	 */
	public Service() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 */
	public Service(Integer id) {
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
	 * @return the serviceTypes
	 */
	public List<ServiceType> getServiceTypes() {
		return serviceTypes;
	}

	/**
	 * @param serviceTypes the serviceTypes to set
	 */
	public void setServiceTypes(List<ServiceType> serviceTypes) {
		this.serviceTypes = serviceTypes;
	}
    
    
}
