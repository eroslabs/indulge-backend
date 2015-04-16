/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;

/**
 * @author vikas
 * 
 */
public class MailNotifier implements Runnable {
	private Message message;

	/**
	 * @param message
	 */
	public MailNotifier(Message message) {
		this.message = message;
	}

	@Autowired
	private Configuration fmConfig;
	
	@Autowired
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
									+ "_SUBJECT.tpl"), message.getDataMap()));
			message.setMessage(FreeMarkerTemplateUtils
					.processTemplateIntoString(
							fmConfig.getTemplate(message.getMessageTemplate()
									+ "_BODY.tpl"), message.getDataMap()));
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
