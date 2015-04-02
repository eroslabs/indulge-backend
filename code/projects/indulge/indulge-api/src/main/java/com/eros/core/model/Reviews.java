/**
 * indulge-api
 * author vikas created on Mar 30, 2015
 */
package com.eros.core.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author vikas
 *
 */
public class Reviews implements Serializable{

	private List<UserReview> userReviews;
	private Integer count;
	
	/**
	 * 
	 */
	public Reviews() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 */
	public Reviews(Integer count) {
		this.count = count;
	}
	

	/**
	 * @return the count
	 */
	public Integer getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(Integer count) {
		this.count = count;
	}

	/**
	 * @return the userReviews
	 */
	public List<UserReview> getUserReviews() {
		return userReviews;
	}

	/**
	 * @param userReviews the userReviews to set
	 */
	public void setUserReviews(List<UserReview> userReviews) {
		this.userReviews = userReviews;
	} 
}
