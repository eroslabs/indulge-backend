
package com.eros.core.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */
public class MerchantSchedule extends BaseModel{
		
	private static final long serialVersionUID = 1L;
	private static final String[] weekDays = {" Sun", " Mon", " Tue"," Wed", " Thur", " Fri", " Sat"};
	private Integer id;
	private Integer merchantId;
    private String openingTime;
    private String closingTime;
    private String weekSchedule; 	 
	private Boolean status;
	private String weekStr;
	
	/**
	 * 
	 */
	public MerchantSchedule() {
		super();
	}
	public MerchantSchedule(String opString,String clString, String weekString) {
		super();
		this.openingTime = opString;
		this.closingTime = clString;
		this.weekSchedule = weekString;
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
	 * @return the openingTime
	 */
	public String getOpeningTime() {
		return openingTime;
	}
	/**
	 * @param openingTime the openingTime to set
	 */
	public void setOpeningTime(String openingTime) {
		this.openingTime = openingTime;
	}
	/**
	 * @return the closingTime
	 */
	public String getClosingTime() {
		return closingTime;
	}
	/**
	 * @param closingTime the closingTime to set
	 */
	public void setClosingTime(String closingTime) {
		this.closingTime = closingTime;
	}
	/**
	 * @return the weekSchedule
	 */
	public String getWeekSchedule() {
		return weekSchedule;
	}
	/**
	 * @param weekSchedule the weekSchedule to set
	 */
	public void setWeekSchedule(String weekSchedule) {
		this.weekSchedule = weekSchedule;
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
	 * @return the weekStr
	 */
	public String getWeekStr() {
		if(StringUtils.isNotBlank(weekSchedule)){
			String[] days = weekSchedule.split("(?<=.)");
			StringBuffer returnStr = new StringBuffer();
			for (int i = 0; i < days.length; i++) {
				if(StringUtils.isNotBlank(days[i]) && days[i].equals("1")){
					returnStr.append(weekDays[i]);
				}
			}
			this.weekStr = returnStr.toString();
		}
		return weekStr;
	}
	/**
	 * @param weekStr the weekStr to set
	 */
	public void setWeekStr(String weekStr) {
		this.weekStr = weekStr;
	}
	}
