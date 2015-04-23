/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.stereotype.Service;

import freemarker.template.Configuration;

/**
 * @author vikas
 *
 */
@Service("notificationService")
public class NotificationServiceImpl implements NotificationService{
	@Autowired
	private Configuration fmConfig;
	
	@Autowired
    private MailSender mailSender;

	/* (non-Javadoc)
	 * @see com.eros.notification.utils.Notifier#sendNotification(com.eros.notification.utils.Message)
	 */
	@Override
	public void sendNotification(Message message) throws Exception {
		if(message == null){
			throw new IllegalArgumentException("Message Null");
		}
		if(message.getType() == null)
		{
			throw new IllegalArgumentException("Message Type Null");
		}
		 processMessage(message);
		
	}

	/**
	 * @param message
	 */
	private void processMessage(Message message) {
		ExecutorService executor = Executors.newFixedThreadPool(2);
		executor.execute(new MailNotifier(message,fmConfig,mailSender));
		executor.execute(new SmsNotifier(message));
		executor.shutdown();
		
		
	}
	
	

}
