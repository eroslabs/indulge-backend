/**
 * indulge-service
 * author vikas created on Apr 13, 2015
 */
package com.eros.service.search;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.search.sort.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

import com.eros.service.impl.QueryUtils;
import com.eros.service.impl.SearchConstants;
import com.eros.service.impl.SearchServiceImpl;

/**
 * @author vikas
 * 
 */
public class Filter implements Serializable {
	private static final Logger LOGGER = LoggerFactory.getLogger(Filter.class);
	private static Integer DEFAULT_SIZE = new Integer(20);
	private String index;
	private String type;
	private Integer homeService;
	private Integer genderSupport;
	private Float priceFrom;
	private Float priceTo;
	private Integer[] services;
	private GeoPoint point;
	private Integer page;
	private Integer limit;
	private String search;
	private String sortField;
	private SortOrder direction;
	private static List<String> sortFields = new ArrayList<String>(2);
	private Boolean autoSuggest;
	private Integer luxury;
	static {
		sortFields.add(SearchConstants.RATING_FIELD);
		sortFields.add(SearchConstants.DISTANCE_PARAMETER);
		sortFields.add(SearchConstants.POPULARITY_PARAMETER);
		sortFields.add(SearchConstants.PRICE_PARAMETER);
	}

	public Filter() {
	}

	/**
	 * 
	 */
	public Filter(IndexType index, IndexType type) {
		super();
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
	public Integer getHomeService() {
		return homeService;
	}

	/**
	 * @param homeService
	 *            the homeService to set
	 */
	public void setHomeService(Integer homeService) {
		this.homeService = homeService;
	}

	/**
	 * @return the genderSupport
	 */
	public Integer getGenderSupport() {
		return genderSupport;
	}

	/**
	 * @param genderSupport
	 *            the genderSupport to set
	 */
	public void setGenderSupport(Integer genderSupport) {
		this.genderSupport = genderSupport;
	}

	/**
	 * @return the priceFrom
	 */
	public Float getPriceFrom() {
		return priceFrom;
	}

	/**
	 * @param priceFrom
	 *            the priceFrom to set
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
	 * @param priceTo
	 *            the priceTo to set
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
	 * @param services
	 *            the services to set
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
	 * @param point
	 *            the point to set
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
	 * @param page
	 *            the page to set
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
	 * @param limit
	 *            the limit to set
	 */
	public void setLimit(Integer limit) {
		if (limit == null || limit == 0) {
			this.limit = DEFAULT_SIZE;
		} else {
			this.limit = limit;
		}
	}

	/**
	 * @return the search
	 */
	public String getSearch() {
		return search;
	}

	/**
	 * @param search
	 *            the search to set
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
	 * @param sortField
	 *            the sortField to set
	 */
	public void setSortField(String sortField) {
		if (StringUtils.isNotBlank(sortField) && sortFields.contains(sortField)) {
			this.sortField = sortField;
		} else if (StringUtils.isBlank(sortField)) {
			this.sortField = QueryUtils.RATING_FIELD;
		} else {
			LOGGER.error("**************************Invalid Sort field being passed Please check urgently : "
					+ sortField);
			this.sortField = sortFields.get(0);
		}
	}

	/**
	 * @return the direction
	 */
	public SortOrder getDirection() {
		return direction;
	}

	/**
	 * @param direction
	 *            the direction to set
	 */
	public void setDirection(String direction) {
		if (StringUtils.isNotBlank(direction)
				&& direction.equalsIgnoreCase("asc")) {
			this.direction = SortOrder.ASC;
		} else {
			this.direction = SortOrder.DESC;
		}
	}

	/**
	 * @return the index
	 */
	public String getIndex() {
		return index;
	}

	/**
	 * @param index
	 *            the index to set
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
	 * @param type
	 *            the type to set
	 */
	/**
	 * @return the autoSuggest
	 */
	public Boolean getAutoSuggest() {
		return autoSuggest;
	}

	/**
	 * @param autoSuggest
	 *            the autoSuggest to set
	 */
	public void setAutoSuggest(Boolean autoSuggest) {
		this.autoSuggest = autoSuggest;
	}
	
	/**
	 * @param lr
	 */
	public void setLuxury(Integer lr) {
	 this.luxury = lr;
		
	}
	
	/**
	 * 
	 */
	public Integer getLuxury() {
	 return luxury;
		
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		if (StringUtils.isNotBlank(search)) {
			buffer.append("Search :");
			buffer.append(search);

		}
		if (StringUtils.isNotBlank(type)) {
			buffer.append(" + type :");
			buffer.append(type);
		}
		if (homeService != null) {
			buffer.append(" + Home Service :");
			buffer.append(homeService);
		}
		if (genderSupport != null) {
			buffer.append(" + genderSupport :");
			buffer.append(genderSupport);
		}
		if (priceFrom != null) {
			buffer.append(" + priceFrom :");
			buffer.append(priceFrom);
		}
		if (services != null) {
			buffer.append(" + services :");
			buffer.append(services);
		}
		if (point != null) {
			buffer.append(" + Geo point :");
			buffer.append(point);
		}
		if (page != null) {
			buffer.append(" + page :");
			buffer.append(page);
		}
		if (StringUtils.isNotBlank(sortField)) {
			buffer.append("sortField :");
			buffer.append(sortField);
		}

		if (StringUtils.isNotBlank(index)) {
			buffer.append("index :");
			buffer.append(index);
		}
		return buffer.toString();
	}

	
}
