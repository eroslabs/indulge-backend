/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;

/**
 * @author vikas
 * 
 */
@Scope("prototype")
public class MailNotifier implements Runnable {
	/**
	 * 
	 */
	public MailNotifier() {
		// TODO Auto-generated constructor stub
	}
	private Message message;

	/**
	 * @param message
	 * @param mailSender2 
	 * @param fmConfig2 
	 */
	public MailNotifier(Message message, Configuration fmConfig2, MailSender mailSender2) {
		this.message = message;
		this.fmConfig = fmConfig2;
		this.mailSender = mailSender2;
	}

	private Configuration fmConfig;
	
    private MailSender mailSender;

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		try{
		if (StringUtils.isBlank(message.getMessage())) {
			if (StringUtils.isBlank(message.getMessageTemplate())) {
				throw new Exception("no mail template found");
			}
			message.setSubject(FreeMarkerTemplateUtils
					.processTemplateIntoString(
							fmConfig.getTemplate(message.getMessageTemplate()
									+ "_SUBJECT.ftl"), message.getDataMap()));
			message.setMessage(FreeMarkerTemplateUtils
					.processTemplateIntoString(
							fmConfig.getTemplate(message.getMessageTemplate()
									+ "_BODY.ftl"), message.getDataMap()));
			SimpleMailMessage mailMessage = new SimpleMailMessage();
			mailMessage.setTo(message.getToEmails());
			mailMessage.setBcc(message.getBccEmails());
			mailMessage.setCc(message.getBccEmails());
			mailMessage.setSubject(message.getSubject());
			mailMessage.setText(message.getMessage());
	        mailSender.send(mailMessage);
			
		}}catch (Exception e) {
			e.printStackTrace();
		}

	}

}
