/**
 * indulge-api
 * author vikas created on Mar 26, 2015
 */
package com.eros.core.model;

/**
 * @author vikas
 *
 */
public class Service extends BaseModel{

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String image;
	private String description;
    private Boolean status;
    /**
	 * 
	 */
	public Service() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 */
	public Service(Integer id) {
		super();
		this.id = id;
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
	 * @return the image
	 */
	public String getImage() {
		return image;
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
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
