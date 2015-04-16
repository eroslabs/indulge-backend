/**
 * indulge-service
 * author vikas created on Apr 13, 2015
 */
package com.eros.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.elasticsearch.core.query.Criteria;

/**
 * @author vikas
 *
 */
public class QueryCriteriaUtils {

	/**
	 * @param search
	 * @param criteria 
	 * @return
	 */
	public static Criteria createTextCriteria(String search, Criteria criteria) {
		if(StringUtils.isBlank(search)){
			return criteria;
		}
		Criteria name =  new Criteria("name");
		name.boost(1F);
		Criteria building =  new Criteria("building");
		building.boost(.6F);
		Criteria landmark =  new Criteria("landmark");
		landmark.boost(.8F);
		Criteria state =  new Criteria("state");
		state.boost(1F);
		
			 criteria.and(name.contains(search)).or(building.contains(search)).or(landmark.contains(search).or(state.contains(search)));
			 return criteria;
	}

}
