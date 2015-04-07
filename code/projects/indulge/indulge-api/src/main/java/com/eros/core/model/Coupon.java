/**
 * indulge-api
 * author vikas created on Apr 6, 2015
 */
package com.eros.core.model;

/**
 * @author vikas
 *
 */
public class Coupon extends BaseModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer merchantId;
	private String couponCode;
	private Integer dealId;
	private Integer status;
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
	/**
	 * @return the couponCode
	 */
	public String getCouponCode() {
		return couponCode;
	}
	/**
	 * @param couponCode the couponCode to set
	 */
	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}
	/**
	 * @return the dealId
	 */
	public Integer getDealId() {
		return dealId;
	}
	/**
	 * @param dealId the dealId to set
	 */
	public void setDealId(Integer dealId) {
		this.dealId = dealId;
	}
	/**
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}

}
