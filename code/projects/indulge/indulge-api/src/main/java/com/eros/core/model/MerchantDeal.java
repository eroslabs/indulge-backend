/**
 * indulge-api
 * author vikas created on Mar 30, 2015
 */
package com.eros.core.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldIndex;
import org.springframework.data.elasticsearch.annotations.FieldType;
import org.springframework.data.elasticsearch.annotations.GeoPointField;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @author vikas
 * 
 */
@Document(indexName = "indulge", type = "deal", shards = 1, replicas = 0, refreshInterval = "-1")
public class MerchantDeal extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private Integer id;
	private Integer merchantId;
	private String finalWeekSchedule;
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	private Date validFrom;
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	private Date validTill;
	private Integer percentOff;
	private Integer flatOff;
	private String days;
	private Integer redemption;
	private Integer confirmed;
	private Boolean recurring;
	private List<MerchantDealService> services;
	private List<Integer> categoryIds;
	private Boolean status;
	private String name;
	private String city;
	private String pincode;
	private String locality;
	private String landmark;
	@Field(type = FieldType.Float, index = FieldIndex.not_analyzed, store = true)
	private Float rating;
	private List<MerchantSchedule> schedule;
	private List<DigitalMenuImage> menus;
	private Boolean ccAccepted;
	private Boolean acFacility;
	@Field(type = FieldType.Integer, index = FieldIndex.not_analyzed,store=true)
    private Integer luxuryRating;
	@GeoPointField
	private GeoPoint geo;
	@Field(type = FieldType.Boolean, index = FieldIndex.no, store = true)
	private Double lat;
	@Field(type = FieldType.Boolean, index = FieldIndex.no, store = true)
	private Double lng;
	private String country;
	@Field(type = FieldType.Integer, index = FieldIndex.no, store = true)
	private Integer homeService;
	@Field(type = FieldType.String, index = FieldIndex.no, store = true)
	private String phone;
	private Integer genderSupport;
	@Field(type = FieldType.Integer, index = FieldIndex.no, store = true)
	private Integer serviceRadius;
	private List<String> serviceNames;
	
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the merchantId
	 */
	public Integer getMerchantId() {
		return merchantId;
	}

	/**
	 * @param merchantId
	 *            the merchantId to set
	 */
	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}

	/**
	 * @return the description
	 */

	/**
	 * @return the validFrom
	 */
	public Date getValidFrom() {
		return validFrom;
	}

	/**
	 * @param validFrom
	 *            the validFrom to set
	 */
	public void setValidFrom(Date validFrom) {
		this.validFrom = validFrom;
	}

	/**
	 * @return the services
	 */
	public List<MerchantDealService> getServices() {
		return services;
	}

	/**
	 * @param services
	 *            the services to set
	 */
	public void setServices(List<MerchantDealService> services) {
		this.services = services;
	}

	/**
	 * @return the categoryIds
	 */
	public List<Integer> getCategoryIds() {
		if (services != null) {
			Set<Integer> cats = new HashSet<Integer>();
			for (MerchantDealService service : services) {
				cats.add(service.getCategoryId());
			}
			categoryIds = new ArrayList<Integer>();
			categoryIds.addAll(cats);
		}
		return categoryIds;
	}

	/**
	 * @param categoryIds
	 *            the categoryIds to set
	 */
	public void setCategoryIds(List<Integer> categoryIds) {
		this.categoryIds = categoryIds;
	}

	/**
	 * @return the validTill
	 */
	public Date getValidTill() {
		return validTill;
	}

	/**
	 * @param validTill
	 *            the validTill to set
	 */
	public void setValidTill(Date validTill) {
		this.validTill = validTill;
	}

	/**
	 * @return the percentOff
	 */
	public Integer getPercentOff() {
		return percentOff;
	}

	/**
	 * @param percentOff
	 *            the percentOff to set
	 */
	public void setPercentOff(Integer percentOff) {
		this.percentOff = percentOff;
	}

	/**
	 * @return the flatOff
	 */
	public Integer getFlatOff() {
		return flatOff;
	}

	/**
	 * @param flatOff
	 *            the flatOff to set
	 */
	public void setFlatOff(Integer flatOff) {
		this.flatOff = flatOff;
	}

	/**
	 * @return the days
	 */
	public String getDays() {
		return days;
	}

	/**
	 * @param days
	 *            the days to set
	 */
	public void setDays(String days) {
		this.days = days;
	}

	/**
	 * @return the redemption
	 */
	public Integer getRedemption() {
		return redemption;
	}

	/**
	 * @param redemption
	 *            the redemption to set
	 */
	public void setRedemption(Integer redemption) {
		this.redemption = redemption;
	}

	/**
	 * @return the luxuryRating
	 */
	public Integer getLuxuryRating() {
		return luxuryRating;
	}

	/**
	 * @param luxuryRating the luxuryRating to set
	 */
	public void setLuxuryRating(Integer luxuryRating) {
		this.luxuryRating = luxuryRating;
	}

	/**
	 * @return the confirmed
	 */
	public Integer getConfirmed() {
		return confirmed;
	}

	/**
	 * @return the schedule
	 */
	public List<MerchantSchedule> getSchedule() {
		return schedule;
	}

	/**
	 * @param schedule
	 *            the schedule to set
	 */
	public void setSchedule(List<MerchantSchedule> schedule) {
		this.schedule = schedule;
	}

	/**
	 * @return the menus
	 */
	public List<DigitalMenuImage> getMenus() {
		return menus;
	}

	/**
	 * @param menus
	 *            the menus to set
	 */
	public void setMenus(List<DigitalMenuImage> menus) {
		this.menus = menus;
	}

	/**
	 * @return the ccAccepted
	 */
	public Boolean getCcAccepted() {
		return ccAccepted;
	}

	/**
	 * @param ccAccepted
	 *            the ccAccepted to set
	 */
	public void setCcAccepted(Boolean ccAccepted) {
		this.ccAccepted = ccAccepted;
	}

	/**
	 * @return the acFacility
	 */
	public Boolean getAcFacility() {
		return acFacility;
	}

	/**
	 * @param acFacility
	 *            the acFacility to set
	 */
	public void setAcFacility(Boolean acFacility) {
		this.acFacility = acFacility;
	}

	/**
	 * @return the serviceNames
	 */
	public List<String> getServiceNames() {
		if (services != null) {
			Set<String> cats = new HashSet<String>();
			for (MerchantDealService service : services) {
				if (StringUtils.isNotBlank(service.getService())) {
					cats.add(service.getService());
				} else {
					cats.add(service.getName());
				}
			}
			serviceNames = new ArrayList<String>();
			serviceNames.addAll(cats);
		}
		return serviceNames;
	}

	/**
	 * @param serviceNames
	 *            the serviceNames to set
	 */
	public void setServiceNames(List<String> serviceNames) {
		this.serviceNames = serviceNames;
	}

	/**
	 * @param confirmed
	 *            the confirmed to set
	 */
	public void setConfirmed(Integer confirmed) {
		this.confirmed = confirmed;
	}

	/**
	 * @return the recurring
	 */
	public Boolean getRecurring() {
		return recurring;
	}

	/**
	 * @param recurring
	 *            the recurring to set
	 */
	public void setRecurring(Boolean recurring) {
		this.recurring = recurring;
	}

	/**
	 * @return the status
	 */
	public Boolean getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(Boolean status) {
		this.status = status;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * @return the pincode
	 */
	public String getPincode() {
		return pincode;
	}

	/**
	 * @param pincode
	 *            the pincode to set
	 */
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	/**
	 * @return the building
	 */
	public String getLocality() {
		return locality;
	}

	/**
	 * @param building
	 *            the building to set
	 */
	public void setLocality(String building) {
		this.locality = building;
	}

	/**
	 * @return the landmark
	 */
	public String getLandmark() {
		return landmark;
	}

	/**
	 * @param landmark
	 *            the landmark to set
	 */
	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}

	/**
	 * @return the rating
	 */
	public Float getRating() {
		return rating;
	}

	/**
	 * @param rating
	 *            the rating to set
	 */
	public void setRating(Float rating) {
		this.rating = rating;
	}

	/**
	 * @return the geo
	 */
	public GeoPoint getGeo() {
		GeoPoint point = new GeoPoint(lat, lng);
		this.setGeo(point);
		return geo;
	}

	/**
	 * @param geo
	 *            the geo to set
	 */
	public void setGeo(GeoPoint geo) {
		if (geo != null) {
			this.setLat(geo.getLat());
			this.setLng(geo.getLon());
		}
		this.geo = geo;
	}

	/**
	 * @return the lat
	 */
	public Double getLat() {
		return lat;
	}

	/**
	 * @param lat
	 *            the lat to set
	 */
	public void setLat(Double lat) {
		this.lat = lat;
	}

	/**
	 * @return the lng
	 */
	public Double getLng() {
		return lng;
	}

	/**
	 * @param lng
	 *            the lng to set
	 */
	public void setLng(Double lng) {
		this.lng = lng;
	}

	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}

	/**
	 * @param country
	 *            the country to set
	 */
	public void setCountry(String country) {
		this.country = country;
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
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone
	 *            the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
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
	 * @return the serviceRadius
	 */
	public Integer getServiceRadius() {
		return serviceRadius;
	}

	/**
	 * @param serviceRadius
	 *            the serviceRadius to set
	 */
	public void setServiceRadius(Integer serviceRadius) {
		this.serviceRadius = serviceRadius;
	}

	/**
	 * @return the finalWeekSchedule
	 */
	public String getFinalWeekSchedule() {
		if (schedule != null) {
			if (schedule.size() == 2) {
				MerchantSchedule s1 = schedule.get(0);
				MerchantSchedule s2 = schedule.get(1);
				StringBuilder sb = new StringBuilder();
				for (int i = 0; i < s1.getWeekSchedule().length(); i++)
					sb.append((int) (s1.getWeekSchedule().charAt(i) ^ s2
							.getWeekSchedule().charAt(
									i % s2.getWeekSchedule().length())));
				finalWeekSchedule = sb.toString();
			}else if(schedule.size() == 1){
				MerchantSchedule s1 = schedule.get(0);
				return s1.getWeekSchedule();
			}
		}
		return finalWeekSchedule;
	}

	/**
	 * @param finalWeekSchedule
	 *            the finalWeekSchedule to set
	 */
	public void setFinalWeekSchedule(String finalWeekSchedule) {
		this.finalWeekSchedule = finalWeekSchedule;
	}

}
