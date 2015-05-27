/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import java.io.IOException;

import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;

/**
 * @author vikas
 *
 */
public class SmsNotifier implements Runnable{

	private Message message;
	private Configuration fmConfig;
	/**
	 * 
	 */
	public SmsNotifier() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * @param message
	 * @param fmConfig 
	 */
	public SmsNotifier(Message message, Configuration fmConfig) {
		this.message = message;
		this.fmConfig = fmConfig;
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		try {
			String text = FreeMarkerTemplateUtils
			.processTemplateIntoString(
					fmConfig.getTemplate(message.getMessageTemplate()
							+ "_SMS.ftl"), message.getDataMap());
			System.out.println("-----------------------------"+ message.getDataMap().toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}

}
