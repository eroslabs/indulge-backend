/**
 * indulge-service
 * author vikas created on Apr 13, 2015
 */
package com.eros.service.search;

import java.io.Serializable;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

/**
 * @author vikas
 *
 */
public class Filter implements Serializable {
	
	 private String index;
	 private String type;
	 private Boolean homeService;
	 private Boolean genderSupport;
	 private Float priceFrom;
	 private Float priceTo;
	 private Integer[] services;
	 private GeoPoint point;
	 private Integer page;
	 private Integer limit;
	 private String search;
	 private String sortField;
	 private String direction;
	
	 public Filter() {
		}
	 /**
	 * 
	 */
	public Filter(IndexType index , IndexType type) {
		this.index = index.getText();
		this.type = type.getText();
	}
	 /**
	  * 
	  * @param type
	  */
	 public void setType(String type) {
			this.type = type;
		}
		 
	/**
	 * @return the homeService
	 */
	public Boolean getHomeService() {
		return homeService;
	}
	/**
	 * @param homeService the homeService to set
	 */
	public void setHomeService(Boolean homeService) {
		this.homeService = homeService;
	}
	/**
	 * @return the genderSupport
	 */
	public Boolean getGenderSupport() {
		return genderSupport;
	}
	/**
	 * @param genderSupport the genderSupport to set
	 */
	public void setGenderSupport(Boolean genderSupport) {
		this.genderSupport = genderSupport;
	}
	/**
	 * @return the priceFrom
	 */
	public Float getPriceFrom() {
		return priceFrom;
	}
	/**
	 * @param priceFrom the priceFrom to set
	 */
	public void setPriceFrom(Float priceFrom) {
		this.priceFrom = priceFrom;
	}
	/**
	 * @return the priceTo
	 */
	public Float getPriceTo() {
		return priceTo;
	}
	/**
	 * @param priceTo the priceTo to set
	 */
	public void setPriceTo(Float priceTo) {
		this.priceTo = priceTo;
	}
	/**
	 * @return the services
	 */
	public Integer[] getServices() {
		return services;
	}
	/**
	 * @param services the services to set
	 */
	public void setServices(Integer[] services) {
		this.services = services;
	}
	/**
	 * @return the point
	 */
	public GeoPoint getPoint() {
		return point;
	}
	/**
	 * @param point the point to set
	 */
	public void setPoint(GeoPoint point) {
		this.point = point;
	}
	
	/**
	 * @return the page
	 */
	public Integer getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(Integer page) {
		this.page = page;
	}
	/**
	 * @return the limit
	 */
	public Integer getLimit() {
		return limit;
	}
	/**
	 * @param limit the limit to set
	 */
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	/**
	 * @return the search
	 */
	public String getSearch() {
		return search;
	}
	/**
	 * @param search the search to set
	 */
	public void setSearch(String search) {
		this.search = search;
	}
	/**
	 * @return the sortField
	 */
	public String getSortField() {
		return sortField;
	}
	/**
	 * @param sortField the sortField to set
	 */
	public void setSortField(String sortField) {
		this.sortField = sortField;
	}
	/**
	 * @return the direction
	 */
	public String getDirection() {
		return direction;
	}
	/**
	 * @param direction the direction to set
	 */
	public void setDirection(String direction) {
		this.direction = direction;
	}
	/**
	 * @return the index
	 */
	public String getIndex() {
		return index;
	}
	/**
	 * @param index the index to set
	 */
	public void setIndex(String index) {
		this.index = index;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
}
