/**
 * indulge-web
 * author vikas created on Jun 3, 2015
 */
package com.eros.utils;

import java.text.ParseException;
import java.util.Collection;
import java.util.Collections;
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
	
	
	public static String getWeekDays(String str){
		if(StringUtils.isNotBlank(str)){
			String[] days = str.split("(?<=.)");
			StringBuffer returnStr = new StringBuffer();
			for (int i = 0; i < days.length; i++) {
				if(StringUtils.isNotBlank(days[i]) && days[i].equals("1")){
					returnStr.append(weekDays[i]);
				}
			}
			return returnStr.toString();
		} return null;
	}
	
	
	public static Integer getSize(Collection<?> list){
		if(list == null || list.isEmpty()){
			
			return 0;
		}else{ return list.size();}
	}
}
