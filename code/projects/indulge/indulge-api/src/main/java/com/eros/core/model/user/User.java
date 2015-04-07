/**
 * indulge-api
 * author vikas created on Apr 3, 2015
 */
package com.eros.core.model.user;

import java.util.Date;

import com.eros.core.model.BaseModel;

/**
 * @author vikas
 *
 */
public class User extends BaseModel{
	 private Integer id;
	 private String name;
	 private String mail;
	 private Date dob;
	 private String gender;
	 private String mobile;
	 private String passphrase;
	 private String facebook;
	 private String profilePhoto;
	 private Boolean status;
	 private String refCode;
	 private String imagePath;
	 private byte[] image;
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
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the dob
	 */
	public Date getDob() {
		return dob;
	}
	/**
	 * @param dob the dob to set
	 */
	public void setDob(Date dob) {
		this.dob = dob;
	}
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
	 * @return the mobile
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * @param mobile the mobile to set
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * @return the passphrase
	 */
	public String getPassphrase() {
		return passphrase;
	}
	/**
	 * @param passphrase the passphrase to set
	 */
	public void setPassphrase(String passphrase) {
		this.passphrase = passphrase;
	}
	/**
	 * @return the facebook
	 */
	public String getFacebook() {
		return facebook;
	}
	/**
	 * @param facebook the facebook to set
	 */
	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}
	/**
	 * @return the profilePhoto
	 */
	public String getProfilePhoto() {
		return profilePhoto;
	}
	/**
	 * @param profilePhoto the profilePhoto to set
	 */
	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
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
	 * @return the ref_code
	 */
	public String getRefCode() {
		return refCode;
	}
	/**
	 * @param ref_code the ref_code to set
	 */
	public void setRefCode(String ref_code) {
		this.refCode = ref_code;
	}
	/**
	 * @return the mail
	 */
	public String getMail() {
		return mail;
	}
	/**
	 * @param mail the mail to set
	 */
	public void setMail(String mail) {
		this.mail = mail;
	}
	/**
	 * @return the imagePath
	 */
	public String getImagePath() {
		return imagePath;
	}
	/**
	 * @param imagePath the imagePath to set
	 */
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	/**
	 * @return the image
	 */
	public byte[] getImage() {
		return image;
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(byte[] image) {
		this.image = image;
	}
	
}
