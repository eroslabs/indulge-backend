
package com.eros.core.model;

import org.springframework.data.elasticsearch.annotations.Document;

/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */

public class MerchantPhone extends BaseModel{
	
	private static final long serialVersionUID = 1L;
	private Integer merchantId;
	/**
	 * @return the merchantId
	 */
	public Integer getMerchantId() {
		return merchantId;
	}

	/**
	 * @param merchantId the merchantId to set
	 */
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	private Integer id;
    private String phone;
    private char type; 	 	
    private Boolean status;
    
    /**
	 * 
	 */
	public MerchantPhone() {
		// TODO Auto-generated constructor stub
	}
	
	public MerchantPhone(String phone, Integer merInteger){
		super();
		this.phone=phone;
		this.type='O';
		this.merchantId = merInteger;
	}
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @return the type
	 */
	public char getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(char type) {
		this.type = type;
	}
	/**
	 * @return the status
	 */
	public Boolean getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Boolean status) {
		this.status = status;
	}

}
