/**
 * indulge-web
 * author vikas created on Apr 14, 2015
 */
package com.eros.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.solr.common.util.Base64;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

import com.eros.core.model.ReportedError;
import com.eros.core.model.UserReview;
import com.eros.core.model.user.User;
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
	
	private static final SimpleDateFormat formatter = new SimpleDateFormat("dd/mm/yyyy");
	protected static Log LOGGER = LogFactory
			.getLog(RequestUtils.class);
	
	
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
	public static Filter generateFilter(String s, Integer hs, Integer gs,
			Integer[] services, Float pf, Float pt, String lat, String lon,
			Integer page, Integer limit, String dir,String sort, IndexType index,
			IndexType type,Boolean autoSuggest,Integer lr) {
		if(index == null || type == null){
			throw new IllegalArgumentException("Index/type cannot be null");
		}
		Filter filter = new Filter();
		filter.setAutoSuggest(autoSuggest);
		filter.setIndex(index.getText());
		filter.setType(type.getText());
		filter.setPage(page == null ? 0 : page);
		filter.setLimit(limit);
		filter.setSortField(sort);
		filter.setDirection(dir);
		filter.setGenderSupport(gs);
		filter.setHomeService(hs);
		filter.setPriceFrom(pf);
		filter.setServices(services);
		filter.setPriceTo(pt);
		filter.setSearch(s);
		filter.setLuxury(lr);
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
			IndexType index, IndexType type, Boolean autoSuggest, Integer lr) {
		
		return generateFilter(s, null, null, null, null, null, lat, lon, page, limit, dir, sort, index, type,autoSuggest,lr);
	}
	/**
	 * @param s
	 * @param indulge
	 * @param merchant
	 * @param b
	 * @return
	 */
	public static Filter generateFilter(String s, IndexType index,
			IndexType type, boolean autoSuggest) {
		return generateFilter(s, null, null, null, null, null, null, null, null, null, null, null, index, type,autoSuggest,null);
	}
	/**
	 * @param user
	 * @param userMap
	 */
	public static User populateUserObject( Map userMap) throws Exception{
		User user = new User();
		if(userMap == null || userMap.size() <=0 ){
			throw new Exception("Invalid parameter");
		}else{
			user.setFacebook(userMap.get("facebook") != null ?userMap.get("facebook").toString():null);
			user.setGender(userMap.get("gender") != null ? userMap.get("gender").toString() : null);
			user.setName(userMap.get("name").toString());
			if(userMap.get("image") != null){
				user.setImage(Base64.base64ToByteArray(userMap.get("image").toString()));
			}
			user.setGoogle(userMap.get("google") != null ?userMap.get("google").toString():null);
			user.setMail(userMap.get("mail") != null ? userMap.get("mail").toString(): null);
			user.setMobile(userMap.get("mobile") != null ? userMap.get("mobile").toString() : null);
			user.setPassphrase(userMap.get("passphrase") != null ? userMap.get("passphrase").toString() :null);
			try{
				Date dob = formatter.parse(userMap.get("dob") != null ? userMap.get("dob").toString() : null);
				user.setDob(dob);
				return user;
			}catch (Exception e) {
				LOGGER.error("error in parsing DOB " , e);
			}
			return null;
		}
		
	}
	/**
	 * @param reviewMap
	 * @return
	 */
	public static UserReview populateReview(Map reviewMap) throws Exception{
		UserReview review = new UserReview();
		if(reviewMap == null || reviewMap.size() <=0 ){
			throw new Exception("Invalid parameter");
		}else{
			review.setCleanlinessRating(reviewMap.get("cleanlinessRating") != null ? Float.parseFloat(reviewMap.get("cleanlinessRating").toString()) : null );
			review.setText(reviewMap.get("text") != null ? reviewMap.get("text").toString() : null );
			review.setUser(reviewMap.get("user") != null ? reviewMap.get("user").toString() : null );
//			Intentionally left.
			review.setMerchantId( Integer.parseInt(reviewMap.get("merchantId").toString()) );
			review.setUserId(Integer.parseInt(reviewMap.get("userId").toString()) );
			review.setServiceRating(reviewMap.get("serviceRating") != null ? Float.parseFloat(reviewMap.get("serviceRating").toString()) : null );
			review.setRating(reviewMap.get("rating") != null ? Float.parseFloat(reviewMap.get("rating").toString()) : null);
			return review;
		}
	}
	/**
	 * @param errorObj
	 * @return
	 */
	public static ReportedError fillError(Map<String, Object> errorObj) throws Exception{
		ReportedError error = new ReportedError();
		if(errorObj == null || errorObj.size() <=0 ){
			throw new Exception("Invalid parameter");
		}else{
			error.setDetails(errorObj.get("details") != null ? errorObj.get("details").toString() : null );
			error.setWrongAddress(errorObj.get("wrongAddress") != null ? (Boolean)errorObj.get("wrongAddress") : false );
			error.setWrongPricing(errorObj.get("wrongPricing") != null ? (Boolean)errorObj.get("wrongPricing") : false );
			error.setWrongPhone(errorObj.get("wrongPhone") != null ? (Boolean)errorObj.get("wrongPhone") : false );
			error.setMerchantId( Integer.parseInt(errorObj.get("merchantId").toString()) );
			error.setUserId(Integer.parseInt(errorObj.get("userId").toString()) );
			
			return error;
		}
	}

	
	
	
	
	

}
