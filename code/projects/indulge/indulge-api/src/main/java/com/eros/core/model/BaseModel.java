package com.eros.core.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @author vikas
 *
 */

public class BaseModel implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date createdDate;
    private Date updatedDate;

    public Date getCreatedDate() {
	return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
	this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
	return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
	this.updatedDate = updatedDate;
    }

}
