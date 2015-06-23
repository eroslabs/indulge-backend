package com.eros.core.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldIndex;
import org.springframework.data.elasticsearch.annotations.FieldType;
import org.springframework.data.elasticsearch.annotations.GeoPointField;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

/**
 * 
 * @author vikas
 *
 */
@Document(indexName = "indulge",type = "merchant" , shards = 1, replicas = 0, refreshInterval = "-1")
public class Merchant extends BaseModel {
	
	

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	@Field(type = FieldType.String, index = FieldIndex.analyzed,store=true,indexAnalyzer="simple")
	private String name;
    private String email; 	 	
    private String passPhrase; 	
    private String city;	
    @Field(type = FieldType.Double, index = FieldIndex.not_analyzed,store=true)
    private Double lat;	
    @Field(type = FieldType.Double, index = FieldIndex.not_analyzed,store=true)
    private Double lng;
    @Field(type = FieldType.String, index = FieldIndex.not_analyzed,store=true)
    private String image;
    private Boolean ccAccepted;	
    private String address; 	
    private String establishment;	 	
    private String locality;	
    private String landmark;	
    private String state;	 	
    private String pincode;	
    private String country; 
    private String experience;
    private String certification;
    private Boolean acFacility;
    private Integer merchantType;
    @Field(type = FieldType.Boolean, index = FieldIndex.not_analyzed,store=true)
    private Boolean status;
    private String software;
    @Field(type = FieldType.Float, index = FieldIndex.not_analyzed,store=true)
    private Float rating;
    private Boolean homeService;
    @Field(type = FieldType.String, index = FieldIndex.not_analyzed,store=true)
	private String phone;
	private Integer genderSupport;
	private Boolean separateRateCard;
	@Field(type = FieldType.Integer, index = FieldIndex.not_analyzed,store=true)
	private Integer serviceRadius;
	@Field(type = FieldType.Boolean, index = FieldIndex.not_analyzed,store=true)
    private Boolean profileComplete;
    @GeoPointField
    private GeoPoint geo;
    private List<MerchantPhone> phones;
    private List<MerchantImage> images;
	private List<MerchantSchedule> schedule;
    private List<MerchantService> services  ;
    private List<DigitalMenuImage> menus;
    @Field(type = FieldType.String, index = FieldIndex.not_analyzed,store=true)
	private String recommended;
    private Integer totalReviews;
    private List<MerchantDeal> deals;
    private List<UserReview> reviews;
    @Field(type = FieldType.Integer, index = FieldIndex.not_analyzed,store=true)
    private Integer luxuryRating;
    private String finalWeekSchedule;
    private String refer;
    private String role;
    private List<Integer> categoryIds;
    
	/**
	 * @return the deals
	 */
	public List<MerchantDeal> getDeals() {
		return deals;
	}
	/**
	 * @param deals the deals to set
	 */
	public void setDeals(List<MerchantDeal> deals) {
		this.deals = deals;
	}
	/**
	 * @return the totalReviews
	 */
	public Integer getTotalReviews() {
		return totalReviews;
	}
	/**
	 * @param totalReviews the totalReviews to set
	 */
	public void setTotalReviews(Integer totalReviews) {
		this.totalReviews = totalReviews;
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
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the passPhrase
	 */
	public String getPassPhrase() {
		return passPhrase;
	}
	/**
	 * @param passPhrase the passPhrase to set
	 */
	public void setPassPhrase(String passPhrase) {
		this.passPhrase = passPhrase;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the lat
	 */
	public Double getLat() {
		return lat;
	}
	/**
	 * @param lat the lat to set
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
	 * @return the acFacility
	 */
	public Boolean getAcFacility() {
		return acFacility;
	}
	/**
	 * @param acFacility the acFacility to set
	 */
	public void setAcFacility(Boolean acFacility) {
		this.acFacility = acFacility;
	}
	/**
	 * @param lng the lng to set
	 */
	public void setLng(Double lng) {
		this.lng = lng;
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
	 * @return the ccAccepted
	 */
	public Boolean getCcAccepted() {
		return ccAccepted;
	}
	/**
	 * @return the recommended
	 */
	public String getRecommended() {
		return recommended;
	}
	/**
	 * @param recommended the recommended to set
	 */
	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}
	/**
	 * @param ccAccepted the ccAccepted to set
	 */
	public void setCcAccepted(Boolean ccAccepted) {
		this.ccAccepted = ccAccepted;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the role
	 */
	public String getRole() {
		return role;
	}
	/**
	 * @param role the role to set
	 */
	public void setRole(String role) {
		this.role = role;
	}
	/**
	 * @return the refer
	 */
	public String getRefer() {
		return refer;
	}
	/**
	 * @param refer the refer to set
	 */
	public void setRefer(String refer) {
		this.refer = refer;
	}
	/**
	 * @return the establishment
	 */
	public String getEstablishment() {
		return establishment;
	}
	/**
	 * @param establishment the establishment to set
	 */
	public void setEstablishment(String establishment) {
		this.establishment = establishment;
	}
	/**
	 * @return the locality
	 */
	public String getLocality() {
		return locality;
	}
	/**
	 * @return the categoryIds
	 */
	public List<Integer> getCategoryIds() {
		if (services != null) {
			Set<Integer> cats = new HashSet<Integer>();
			for (MerchantService service : services) {
				cats.add(service.getCategoryId());
			}
			categoryIds = new ArrayList<Integer>();
			categoryIds.addAll(cats);
		}
		return categoryIds;
	}
	/**
	 * @param categoryIds the categoryIds to set
	 */
	public void setCategoryIds(List<Integer> categoryIds) {
		this.categoryIds = categoryIds;
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
	 * @return the reviews
	 */
	public List<UserReview> getReviews() {
		return reviews;
	}
	/**
	 * @param reviews the reviews to set
	 */
	public void setReviews(List<UserReview> reviews) {
		this.reviews = reviews;
	}
	/**
	 * @param locality the locality to set
	 */
	public void setLocality(String locality) {
		this.locality = locality;
	}
	/**
	 * @return the landmark
	 */
	public String getLandmark() {
		return landmark;
	}
	/**
	 * @param landmark the landmark to set
	 */
	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * @return the pincode
	 */
	public String getPincode() {
		return pincode;
	}
	/**
	 * @param pincode the pincode to set
	 */
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}
	/**
	 * @param country the country to set
	 */
	public void setCountry(String country) {
		this.country = country;
	}
	/**
	 * @return the experience
	 */
	public String getExperience() {
		return experience;
	}
	/**
	 * @param experience the experience to set
	 */
	public void setExperience(String experience) {
		this.experience = experience;
	}
	/**
	 * @return the certification
	 */
	public String getCertification() {
		return certification;
	}
	/**
	 * @param certification the certification to set
	 */
	public void setCertification(String certification) {
		this.certification = certification;
	}
	/**
	 * @return the merchantType
	 */
	public Integer getMerchantType() {
		return merchantType;
	}
	/**
	 * @param merchantType the merchantType to set
	 */
	public void setMerchantType(Integer merchantType) {
		this.merchantType = merchantType;
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
	 * @return the software
	 */
	public String getSoftware() {
		return software;
	}
	/**
	 * @param software the software to set
	 */
	public void setSoftware(String software) {
		this.software = software;
	}
	/**
	 * @return the rating
	 */
	public Float getRating() {
		return rating;
	}
	/**
	 * @param rating the rating to set
	 */
	public void setRating(Float rating) {
		this.rating = rating;
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
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone the phone to set
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
	 * @param genderSupport the genderSupport to set
	 */
	public void setGenderSupport(Integer genderSupport) {
		this.genderSupport = genderSupport;
	}
	/**
	 * @return the separateRateCard
	 */
	public Boolean getSeparateRateCard() {
		return separateRateCard;
	}
	/**
	 * @param separateRateCard the separateRateCard to set
	 */
	public void setSeparateRateCard(Boolean separateRateCard) {
		this.separateRateCard = separateRateCard;
	}
	/**
	 * @return the serviceRadius
	 */
	public Integer getServiceRadius() {
		return serviceRadius;
	}
	/**
	 * @param serviceRadius the serviceRadius to set
	 */
	public void setServiceRadius(Integer serviceRadius) {
		this.serviceRadius = serviceRadius;
	}
	/**
	 * @return the profileComplete
	 */
	public Boolean getProfileComplete() {
		return profileComplete;
	}
	/**
	 * @param profileComplete the profileComplete to set
	 */
	public void setProfileComplete(Boolean profileComplete) {
		this.profileComplete = profileComplete;
	}
	/**
	 * @return the phones
	 */
	public List<MerchantPhone> getPhones() {
		return phones;
	}
	/**
	 * @param phones the phones to set
	 */
	public void setPhones(List<MerchantPhone> phones) {
		this.phones = phones;
	}
	/**
	 * @return the images
	 */
	public List<MerchantImage> getImages() {
		return images;
	}
	/**
	 * @param images the images to set
	 */
	public void setImages(List<MerchantImage> images) {
		this.images = images;
	}
	/**
	 * @return the schedule
	 */
	public List<MerchantSchedule> getSchedule() {
		return schedule;
	}
	/**
	 * @param schedule the schedule to set
	 */
	public void setSchedule(List<MerchantSchedule> schedule) {
		this.schedule = schedule;
	}
	/**
	 * @return the services
	 */
	public List<MerchantService> getServices() {
		return services;
	}
	/**
	 * @param services the services to set
	 */
	public void setServices(List<MerchantService> services) {
		this.services = services;
	}
	/**
	 * @return the menus
	 */
	public List<DigitalMenuImage> getMenus() {
		return menus;
	}
	/**
	 * @param menus the menus to set
	 */
	public void setMenus(List<DigitalMenuImage> menus) {
		this.menus = menus;
	}
	/**
	 * @return the geo
	 */
	public GeoPoint getGeo() {
		GeoPoint point = new GeoPoint(lat,lng);
		this.setGeo(point);
		return geo;
	}
	/**
	 * @param geo the geo to set
	 */
	public void setGeo(GeoPoint geo) {
		if(geo != null){
			this.setLat(geo.getLat());
			this.setLng(geo.getLon());
		}
		this.geo = geo;
	}
	/**
	 * @return the finalWeekSchedule
	 */
	public String getFinalWeekSchedule() {
		if(schedule != null){
		if(schedule.size() ==2){
		MerchantSchedule s1 = schedule.get(0);
		MerchantSchedule s2 = schedule.get(1);
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < s1.getWeekSchedule().length(); i++)
		    sb.append((int)(s1.getWeekSchedule().charAt(i) ^ s2.getWeekSchedule().charAt(i % s2.getWeekSchedule().length())));
		finalWeekSchedule = sb.toString();
		}else if(schedule.size() ==1){
			MerchantSchedule s1 = schedule.get(0);
			finalWeekSchedule = s1.getWeekSchedule();
		}
		}
		return finalWeekSchedule;
	}
	/**
	 * @param finalWeekSchedule the finalWeekSchedule to set
	 */
	public void setFinalWeekSchedule(String finalWeekSchedule) {
		this.finalWeekSchedule = finalWeekSchedule;
	}
	
}