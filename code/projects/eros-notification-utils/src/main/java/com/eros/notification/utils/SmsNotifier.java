/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;

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
			if(message == null || message.getPhoneNumbers() == null || message.getPhoneNumbers().length <=0){
				return;
			}
			String mobile = null;
			if(message.getPhoneNumbers().length > 0 ){
				mobile = message.getPhoneNumbers()[0];
				if(mobile.length() > 11){
					mobile = mobile.substring(1);
				}
			}
			String text = FreeMarkerTemplateUtils
			.processTemplateIntoString(
					fmConfig.getTemplate(message.getMessageTemplate()
							+ "_SMS.ftl"), message.getDataMap());
			
			HttpURLConnection huc = null;
			try{
				
				text =URLEncoder.encode(text,"UTF-8");
				URL url = new URL( "http://bulksms.mysmsmantra.com:8080/WebSMS/SMSAPI.jsp?username=NDULGE&password=1959800412&sendername=NDULGE&mobileno=91"+message.getPhoneNumbers()[0]+"&message="+text);
				huc = (HttpURLConnection) url.openConnection();
				huc.setConnectTimeout(5000);
				 huc.setRequestMethod("GET");
				 InputStream response = huc.getInputStream();
				 int k;
			     StringBuffer sb=new StringBuffer();
			     while((k=response.read())!=-1)
			     {
			     sb.append((char)k);
			     }
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				try{
					huc.disconnect();
					}catch (Exception e) {
						// TODO: handle exception
					}
				}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}


}
