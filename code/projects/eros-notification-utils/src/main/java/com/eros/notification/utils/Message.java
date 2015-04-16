/**
 * eros-notification-utils
 * author vikas created on Apr 7, 2015
 */
package com.eros.notification.utils;

import java.io.Serializable;
import java.util.Map;

/**
 * @author vikas
 *
 */
public class Message implements Serializable {
	public Message(){
		super();
	}
	public Message(NotificationType type){
		this.type = type;
	}
	private String[] toEmails;
	private String[] ccEmails;
	private String[] bccEmails;
	private String message;
	private String subject;
	private String messageTemplate;
	private String[] phoneNumbers;
	private Map<String,Object> dataMap;
	public NotificationType type;
	/**
	 * @return the toEmails
	 */
	public String[] getToEmails() {
		return toEmails;
	}
	/**
	 * @param toEmails the toEmails to set
	 */
	public void setToEmails(String[] toEmails) {
		this.toEmails = toEmails;
	}
	/**
	 * @return the ccEmails
	 */
	public String[] getCcEmails() {
		return ccEmails;
	}
	/**
	 * @param ccEmails the ccEmails to set
	 */
	public void setCcEmails(String[] ccEmails) {
		this.ccEmails = ccEmails;
	}
	/**
	 * @return the bccEmails
	 */
	public String[] getBccEmails() {
		return bccEmails;
	}
	/**
	 * @param bccEmails the bccEmails to set
	 */
	public void setBccEmails(String[] bccEmails) {
		this.bccEmails = bccEmails;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the messageTemplate
	 */
	public String getMessageTemplate() {
		return messageTemplate;
	}
	/**
	 * @param messageTemplate the messageTemplate to set
	 */
	public void setMessageTemplate(String messageTemplate) {
		this.messageTemplate = messageTemplate;
	}
	/**
	 * @return the phoneNumbers
	 */
	public String[] getPhoneNumbers() {
		return phoneNumbers;
	}
	/**
	 * @param phoneNumbers the phoneNumbers to set
	 */
	public void setPhoneNumbers(String[] phoneNumbers) {
		this.phoneNumbers = phoneNumbers;
	}
	/**
	 * @return the dataMap
	 */
	public Map<String, Object> getDataMap() {
		return dataMap;
	}
	/**
	 * @param dataMap the dataMap to set
	 */
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	/**
	 * @return the type
	 */
	public NotificationType getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(NotificationType type) {
		this.type = type;
	}
	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
}
