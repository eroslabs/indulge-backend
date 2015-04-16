/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

/**
 * @author vikas
 *
 */
public class SmsNotifier implements Runnable{

	private Message message;
	/**
	 * @param message
	 */
	public SmsNotifier(Message message) {
		this.message = message;
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		System.err.println("Tto be implemented");
		
	}

}
