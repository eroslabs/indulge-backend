/**
 * indulge-api
 * author vikas created on Mar 31, 2015
 */
package com.eros.core.model;

import java.util.List;

/**
 * @author vikas
 *
 */
public class DealRequest extends BaseModel{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer userId;
	private String userName;
	private Integer merchantId;;
	private List<DealServiceRequest> services;
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
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @return the services
	 */
	public List<DealServiceRequest> getServices() {
		return services;
	}
	/**
	 * @param services the services to set
	 */
	public void setServices(List<DealServiceRequest> services) {
		this.services = services;
	}
	/**
	 * @return the merchantId
	 */
	public Integer getMerchantId() {
		return merchantId;
	}
	/**
	 * @param merchantId the merchantId to set
	 */
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
		
}
