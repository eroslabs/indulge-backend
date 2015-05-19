/**
 * indulge-api
 * author vikas created on Apr 23, 2015
 */
package com.eros.core.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author vikas
 *
 */
public class ReportedError implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Boolean wrongPhone;
	private Boolean wrongAddress;
	private Boolean closedClosed;
	private Boolean wrongPricing;
	private String details;
	private Integer userId;
	private Integer merchantId;
	private Date createdDate;

	/**
	 * @return the wrongPhone
	 */
	public Boolean getWrongPhone() {
		return wrongPhone;
	}

	/**
	 * @param wrongPhone the wrongPhone to set
	 */
	public void setWrongPhone(Boolean wrongPhone) {
		this.wrongPhone = wrongPhone;
	}

	/**
	 * @return the wrongAddress
	 */
	public Boolean getWrongAddress() {
		return wrongAddress;
	}

	/**
	 * @param wrongAddress the wrongAddress to set
	 */
	public void setWrongAddress(Boolean wrongAddress) {
		this.wrongAddress = wrongAddress;
	}

	/**
	 * @return the closedClosed
	 */
	public Boolean getClosedClosed() {
		return closedClosed;
	}

	/**
	 * @param closedClosed the closedClosed to set
	 */
	public void setClosedClosed(Boolean closedClosed) {
		this.closedClosed = closedClosed;
	}

	/**
	 * @return the wrongPricing
	 */
	public Boolean getWrongPricing() {
		return wrongPricing;
	}

	/**
	 * @param wrongPricing the wrongPricing to set
	 */
	public void setWrongPricing(Boolean wrongPricing) {
		this.wrongPricing = wrongPricing;
	}

	/**
	 * @return the details
	 */
	public String getDetails() {
		return details;
	}

	/**
	 * @param details the details to set
	 */
	public void setDetails(String details) {
		this.details = details;
	}

	/**
	 * @return the createdDate
	 */
	public Date getCreatedDate() {
		return createdDate;
	}

	/**
	 * @param createdDate the createdDate to set
	 */
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
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
