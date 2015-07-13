/**
 * indulge-web
 * author vikas created on Jun 3, 2015
 */
package com.eros.utils;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.StringUtils;

/**
 * @author vikas
 *
 */
public class CalculationUtils {
	private static final String[] weekDays = {" Sun", " Mon", " Tue"," Wed", " Thu", " Fri", " Sat"};
	
	public static Long getDateDiff(Date date){
		try {
		    long diff = date.getTime() - new Date().getTime();
		    return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return null;
	}
	
	
	public static String getWeekDays(String str , Date from, Date to){
		StringBuffer returnStr = new StringBuffer();
		if(StringUtils.isBlank(str)){
			str = calculateWeekdays(from,to);
		}
		if(StringUtils.isBlank(str)){
			return null;
		}
		String[] days = str.split("(?<=.)");
		for (int i = 0; i < days.length; i++) {
			if(StringUtils.isNotBlank(days[i]) && days[i].equals("1")){
				returnStr.append(weekDays[i]);
			}
		}
		return returnStr.toString();
	}
	
	
	/**
	 * @param from
	 * @param to
	 * @return
	 */
	private static String calculateWeekdays(Date from, Date to) {
		if(from == null || to == null){
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(from);
		int w1 = c.get(Calendar.DAY_OF_WEEK);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(to);
		int w2 = c2.get(Calendar.DAY_OF_WEEK);
		long days = (c2.getTimeInMillis()-c.getTimeInMillis())/(1000*60*60*24);
		StringBuffer str = new StringBuffer("");
		if((w1==w2 && days > 6) || days > 6){
			str.append("1111111");
		}else if(w2 > w1){
			for (int i = 1; i <= 7; i++) {
				if(i <= w2 && i >= w1){
					str.append("1"); 
				}else{
					str.append("0");
				}
			}
		}else{
			for (int i = 1; i <= 7; i++) {
				if((w2 == w1 && w1==i) || (w2 != w1 && ( i <= w2 || i >= w1))){
					str.append("1"); 
				}else{
					str.append("0");
				}
			}
		}
		return str.toString();
	}


	public static Integer getSize(Collection<?> list){
		if(list == null || list.isEmpty()){
			return 0;
		}else{ return list.size();}
	}
}
