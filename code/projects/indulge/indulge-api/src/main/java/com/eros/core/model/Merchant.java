package com.eros.core.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.AutoPopulatingList;

/**
 * 
 * @author vikas
 *
 */
public class Merchant extends BaseModel {
	
	

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
    private String name;
    private String email; 	 	
    private String passPhrase; 	
    private String city;	
    private Float lat;	
    private Float lng; 	 	
    private String image;
    private Boolean ccAccepted;	
    private String unitNumber; 	
    private String floor;	 	
    private String building;	
    private String street;
    private String landmark;	
    private String state;	 	
    private String pincode;	
    private String country; 	
    private Boolean status;
    private String software;
    private Float rating;
    private Boolean homeService;
	private String phone;
	private Boolean separateRateCard;
	private Integer serviceRadius;
    private Boolean profileComplete;
    private List<MerchantPhone> phones;
    private List<MerchantImage> images;
    private MerchantSchedule schedule;
    private List<MerchantService> services  ;
    private List<DigitalMenuImage> menus;
    
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
	 * @return the passphrase
	 */
	public String getPassPhrase() {
		return passPhrase;
	}
	/**
	 * @param passphrase the passphrase to set
	 */
	public void setPassPhrase(String passphrase) {
		this.passPhrase = passphrase;
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
	public Float getLat() {
		return lat;
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
	 * @param lat the lat to set
	 */
	public void setLat(Float lat) {
		this.lat = lat;
	}
	/**
	 * @return the lng
	 */
	public Float getLng() {
		return lng;
	}
	/**
	 * @param lng the lng to set
	 */
	public void setLng(Float lng) {
		this.lng = lng;
	}
	/**
	 * @return the ccAccepted
	 */
	public Boolean getCcAccepted() {
		return ccAccepted;
	}
	/**
	 * @param ccAccepted the ccAccepted to set
	 */
	public void setCcAccepted(Boolean ccAccepted) {
		this.ccAccepted = ccAccepted;
	}
	/**
	 * @return the unitNumber
	 */
	public String getUnitNumber() {
		return unitNumber;
	}
	/**
	 * @param unitNumber the unitNumber to set
	 */
	public void setUnitNumber(String unitNumber) {
		this.unitNumber = unitNumber;
	}
	/**
	 * @return the floor
	 */
	public String getFloor() {
		return floor;
	}
	/**
	 * @param floor the floor to set
	 */
	public void setFloor(String floor) {
		this.floor = floor;
	}
	/**
	 * @return the building
	 */
	public String getBuilding() {
		return building;
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
	 * @param building the building to set
	 */
	public void setBuilding(String building) {
		this.building = building;
	}
	/**
	 * @return the street
	 */
	public String getStreet() {
		return street;
	}
	/**
	 * @param street the street to set
	 */
	public void setStreet(String street) {
		this.street = street;
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
	 * @return the review_rating
	 */
	public Float getRating() {
		return rating;
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
	 * @param Rating the review_rating to set
	 */
	public void setRating(Float rating) {
		this.rating = rating;
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
	public MerchantSchedule getSchedule() {
		return schedule;
	}
	/**
	 * @param schedule the schedule to set
	 */
	public void setSchedule(MerchantSchedule schedule) {
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

    
    }
