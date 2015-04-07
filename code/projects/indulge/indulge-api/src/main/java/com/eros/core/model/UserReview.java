
package com.eros.core.model;
/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */
public class UserReview extends BaseModel{
	
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer merchantId;
	private String text;
	private String user;
	private String userId;
	private Float rating;
	private Float cleanlinessRating;
	private Float serviceRating;
    private Boolean status;
	
    /**
	 * @return the text
	 */
	public String getText() {
		return text;
	}
	/**
	 * @param text the text to set
	 */
	public void setText(String text) {
		this.text = text;
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
	 * @return the user
	 */
	public String getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(String user) {
		this.user = user;
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
	/**
	 * @return the cleanlinessRating
	 */
	public Float getCleanlinessRating() {
		return cleanlinessRating;
	}
	/**
	 * @param cleanlinessRating the cleanlinessRating to set
	 */
	public void setCleanlinessRating(Float cleanlinessRating) {
		this.cleanlinessRating = cleanlinessRating;
	}
	/**
	 * @return the serviceRating
	 */
	public Float getServiceRating() {
		return serviceRating;
	}
	/**
	 * @param serviceRating the serviceRating to set
	 */
	public void setServiceRating(Float serviceRating) {
		this.serviceRating = serviceRating;
	}
	/**
	 * @return the rating
	 */
	public Float getRating() {
		return rating;
	}
	/**
	 * @param merchantId the merchantId to set
	 */
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	/**
	 * @param rating the rating to set
	 */
	public void setRating(Float rating) {
		this.rating = rating;
	}
	/**
	 * @return the merchantId
	 */
	public Integer getMerchantId() {
		return merchantId;
	}

}
