/**
 * indulge-web
 * author vikas created on May 13, 2015
 */
package com.eros.merchant.controller;

import java.util.ArrayList;
import java.util.List;

import com.eros.core.model.MerchantSchedule;

/**
 * @author vikas
 *
 */
public class ScheduleWrapper {
	private List<MerchantSchedule> schedule;
	/**
	 * 
	 */
	public ScheduleWrapper() {
		schedule = new ArrayList<MerchantSchedule>();
	}
	/**
	 * @return the schedule
	 */
	public List<MerchantSchedule> getSchedule() {
		return schedule;
	}
	/**
	 * @param schedule the schedule to set
	 */
	public void setSchedule(List<MerchantSchedule> schedule) {
		this.schedule = schedule;
	}
	
	public void add(MerchantSchedule scheduleObj){
		schedule.add(scheduleObj);
	}
}
