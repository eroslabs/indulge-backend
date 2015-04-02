/**
 * indulge-api
 * author vikas created on Mar 30, 2015
 */
package com.eros.core.model;

import java.util.Date;
import java.util.List;

/**
 * @author vikas
 *
 */
public class MerchantDeal extends BaseModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer merchantId;
	private String description;
	private Date validFrom;
	private Date validTill;
	private Integer percentOff;
	private Integer flatOff;
	private String days;
	private Integer redemption;
	private Integer confirmed;
	private Boolean recurring;
	private List<DealService> services;
	
	/**
	 * @return the services
	 */
	public List<DealService> getServices() {
		return services;
	}
	/**
	 * @param services the services to set
	 */
	public void setServices(List<DealService> services) {
		this.services = services;
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
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the validFrom
	 */
	public Date getValidFrom() {
		return validFrom;
	}
	/**
	 * @param validFrom the validFrom to set
	 */
	public void setValidFrom(Date validFrom) {
		this.validFrom = validFrom;
	}
	/**
	 * @return the validTill
	 */
	public Date getValidTill() {
		return validTill;
	}
	/**
	 * @param validTill the validTill to set
	 */
	public void setValidTill(Date validTill) {
		this.validTill = validTill;
	}
	/**
	 * @return the percentOff
	 */
	public Integer getPercentOff() {
		return percentOff;
	}
	/**
	 * @param percentOff the percentOff to set
	 */
	public void setPercentOff(Integer percentOff) {
		this.percentOff = percentOff;
	}
	/**
	 * @return the flatOff
	 */
	public Integer getFlatOff() {
		return flatOff;
	}
	/**
	 * @param flatOff the flatOff to set
	 */
	public void setFlatOff(Integer flatOff) {
		this.flatOff = flatOff;
	}
	/**
	 * @return the days
	 */
	public String getDays() {
		return days;
	}
	/**
	 * @param days the days to set
	 */
	public void setDays(String days) {
		this.days = days;
	}
	/**
	 * @return the redemption
	 */
	public Integer getRedemption() {
		return redemption;
	}
	/**
	 * @param redemption the redemption to set
	 */
	public void setRedemption(Integer redemption) {
		this.redemption = redemption;
	}
	/**
	 * @return the confirmed
	 */
	public Integer getConfirmed() {
		return confirmed;
	}
	/**
	 * @param confirmed the confirmed to set
	 */
	public void setConfirmed(Integer confirmed) {
		this.confirmed = confirmed;
	}
	/**
	 * @return the recurring
	 */
	public Boolean getRecurring() {
		return recurring;
	}
	/**
	 * @param recurring the recurring to set
	 */
	public void setRecurring(Boolean recurring) {
		this.recurring = recurring;
	}
	
	

}
