/**
 * indulge-web
 * author vikas created on Apr 14, 2015
 */
package com.eros.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

import com.eros.service.search.Filter;
import com.eros.service.search.IndexType;

/**
 * @author vikas
 *
 */
public class RequestUtils {

	/**
	 * 
	 */
	private static final String DESC = "desc";
	/**
	 * 
	 */
	private static final String RATING = "rating";
	/**
	 * 
	 */
	private static final String ASC = "asc";
	protected static Log LOGGER = LogFactory
			.getLog(RequestUtils.class);
	private static Integer size = new Integer(20);
	private static List<String> sortDirection = new ArrayList<String>(2); 
	static{
		sortDirection.add(ASC);
		sortDirection.add(DESC);
		
	}
	/**
	 * @param s
	 * @param hs
	 * @param gs
	 * @param services
	 * @param pf
	 * @param pt
	 * @param point
	 * @param page
	 * @param merchant 
	 * @param indulge 
	 * @return
	 */
	public static Filter generateFilter(String s, Boolean hs, Boolean gs,
			Integer[] services, Float pf, Float pt, String lat, String lon,
			Integer page, Integer limit, String dir,String sort, IndexType index,
			IndexType type) {
		if(index == null || type == null){
			throw new IllegalArgumentException("Index/type cannot be null");
		}
		Filter filter = new Filter();
		filter.setIndex(index.getText());
		filter.setType(type.getText());
		filter.setPage(page == null ? 0 : page);
		filter.setLimit((limit == null ? size : limit));
		filter.setSortField(StringUtils.isNotBlank(sort) ? sort : RATING );
		filter.setDirection(StringUtils.isNotBlank(dir)&& sortDirection.contains(dir) ? dir : DESC );
		filter.setGenderSupport(gs);
		filter.setHomeService(hs);
		filter.setPriceFrom(pf);
		filter.setServices(services);
		filter.setPriceTo(pt);
		filter.setSearch(s);
		if(lat !=null && lon!= null){
			try{
			filter.setPoint(new GeoPoint(Double.parseDouble(lat),Double.parseDouble(lon)));
			}catch (Exception e) {
				LOGGER.error("Invalid lat Long information in request : " + lat+" : "+lon);
				throw new IllegalArgumentException("Invalid lat Long information");
			}
		}
		return filter;
	}
	/**
	 * @param s
	 * @param lat
	 * @param lon
	 * @param page
	 * @param limit
	 * @param dir
	 * @param sort
	 * @param indulge
	 * @param deal
	 * @return
	 */
	public static Filter generateFilter(String s, String lat, String lon,
			Integer page, Integer limit, String dir, String sort,
			IndexType index, IndexType type) {
		
		return generateFilter(s, null, null, null, null, null, lat, lon, page, limit, dir, sort, index, type);
	}

	
	
	
	
	

}
