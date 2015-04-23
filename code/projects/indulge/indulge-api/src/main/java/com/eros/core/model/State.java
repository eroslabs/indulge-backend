/**
 * indulge-api
 * author vikas created on Apr 20, 2015
 */
package com.eros.core.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author vikas
 *
 */
public class State implements Serializable{

	private Integer id;
	private String stateName;
	private List<City> cities;
	private Boolean status ;
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
	 * @return the stateName
	 */
	public String getStateName() {
		return stateName;
	}
	/**
	 * @param stateName the stateName to set
	 */
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	/**
	 * @return the cities
	 */
	public List<City> getCities() {
		return cities;
	}
	/**
	 * @param cities the cities to set
	 */
	public void setCities(List<City> cities) {
		this.cities = cities;
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
	
}
