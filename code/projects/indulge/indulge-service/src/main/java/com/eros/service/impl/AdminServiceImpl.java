/**
 * indulge-service
 * author vikas created on Apr 22, 2015
 */
package com.eros.service.impl;

import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.StopWatch;
import org.elasticsearch.common.geo.GeoPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
import com.eros.core.model.ReportedError;
import com.eros.service.AdminService;
import com.eros.service.MerchantCustomService;
import com.eros.service.db.AdminDBService;
import com.eros.service.elasticsearch.MerchantDealRepository;
import com.eros.service.elasticsearch.MerchantRepository;
import com.eros.service.search.SearchResponse;

/**
 * @author vikas
 * 
 */

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	private static final Logger LOG = LoggerFactory
			.getLogger(AdminServiceImpl.class);
	
	@Value("${google.api.key}")
	private String GOOGLE_KEY;
	
	@Value("${google.geo.url}")
	private String GOOGLE_URL;
	
	@Autowired
	protected AdminDBService adminDBService;

	@Autowired
	protected MerchantRepository merchantRepository;

	@Resource(name = "merchantService")
	protected MerchantCustomService merchantService;

	@Autowired
	private MerchantDealRepository dealRepository;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.AdminService#getMerchantsSummary()
	 */
	@Override
	public List<HashMap<String, String>> getMerchantsSummary() throws Exception {
		List<HashMap<String, String>> stats = adminDBService
				.fetchMerchantsStatus();
		return stats;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.AdminService#getMerchantsSummary()
	 */
	@Override
	public List<HashMap<String, String>> getRedemptionReport() throws Exception {
		List<HashMap<String, String>> stats = adminDBService
				.fetchRedemptionReport();
		return stats;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.AdminService#searchMerchant(java.lang.String,
	 * java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public SearchResponse searchMerchant(String s, Integer page, Integer limit) {
		if (StringUtils.isBlank(s) || s.length() < 3) {
			return null;
		}
		if (page == null) {
			page = 0;
		}
		if (limit == null) {
			limit = 50;
		}
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("s", s);
		param.put("page", page);
		param.put("limit", limit);
		List<Merchant> merchants = adminDBService.listMerchant(param);
		Integer total = adminDBService.countMerchant(s);
		SearchResponse res = new SearchResponse();
		res.setTotal(total.longValue());
		res.setResponse(merchants);

		return res;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.AdminService#changeMerchantStatus(boolean)
	 */
	@Override
	public void changeMerchantStatus(Integer id, boolean b) {
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("merchantId", id);
			param.put("status", b);
			Integer rows = adminDBService.updateMerchantStatus(param);
			if (b && rows >0) {
				addToCache(id);
			} else {
				removeFromCache(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * @param id
	 */
	private void removeFromCache(Integer id) {
		try {
			if (id != null) {
				merchantRepository.delete(id);
				dealRepository.deleteByMerchantId(id);

			}
		} catch (Exception e) {
			LOG.error("Error in updating cache while enabling a merchant", e);
		}

	}

	/**
	 * @param id
	 */
	public void addToCache(Integer id) {
		try {
			Merchant merchant = merchantService.getMerchantById(id);
			if (merchant != null && merchant.getId() != null) {
				merchantRepository.index(merchant);
			}
			List<MerchantDeal> deals = merchantService
					.fetchDealWithMerchant(id);
			if (deals != null && deals.size() > 0) { 
				for (MerchantDeal merchantDeal : deals) {
					dealRepository.index(merchantDeal);	
				}
				
			}
		} catch (Exception e) {
			LOG.error("Error in updating cache while enabling a merchant", e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.eros.service.AdminService#uploadAllActiveMerchants()
	 */
	@Override
	public void uploadAllActiveMerchants() {
		LOG.info("Starting loading of all merchant");
		StopWatch watch = new StopWatch();
		watch.start();
		List<Integer> activeIds = adminDBService.getAllActiveMerchantsId();
		for (Integer integer : activeIds) {
			try {
				Merchant merchant = merchantService.getMerchantById(integer);
				if (merchant != null) {
					if(merchant.getLat() == null || merchant.getLat() <= 0){
						try{
							updateLatLng(merchant);
						}catch (Exception e) {
							LOG.error("error in fetching Lat Long for merchant" + e.getMessage());
						}
					}
					merchantRepository.index(merchant);
					try {
					    Thread.sleep(1000);                 //1000 milliseconds is one second.
					} catch(InterruptedException ex) {
					    Thread.currentThread().interrupt();
					}
					List<MerchantDeal> deals = merchantService
							.fetchDealWithMerchant(merchant.getId());
					if (deals != null && deals.size() > 0) {
						for (MerchantDeal merchantDeal : deals) {
							try {
							    Thread.sleep(1000);                 //1000 milliseconds is one second.
							} catch(InterruptedException ex) {
							    Thread.currentThread().interrupt();
							}
							dealRepository.index(merchantDeal);
						}
						
					}
				}
			} catch (Exception e) {
				LOG.error("Error in loading merchant with id " + integer ,e);
			}
		}
		watch.stop();
		LOG.error("**************************** Total Time taken to load all Merchants " + watch.getTime());
	}

	/* (non-Javadoc)
	 * @see com.eros.service.AdminService#fetchDeactiveMerchant(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public SearchResponse fetchDeactiveMerchant(Integer page, Integer limit) {
			if (page == null) {
				page = 0;
			}
			if (limit == null) {
				limit = 50;
			}
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("status", 0);
			param.put("page", page);
			param.put("limit", limit);
			List<Merchant> merchants = adminDBService.listMerchant(param);
			SearchResponse res = new SearchResponse();
			res.setResponse(merchants);

			return res;
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.AdminService#fetchAndUpdateLatLng(java.lang.Integer)
	 */
	@Override
	public void fetchAndUpdateLatLng(List<Integer> id) throws Exception{
		for (Integer integer : id) {
			Merchant merchant = merchantService.getMerchantById(integer);
			
			updateLatLng(merchant);
			
			//for google API
			try {
			    Thread.sleep(1000);
			} catch(InterruptedException ex) {
			    Thread.currentThread().interrupt();
			}
		}
		
	}

	/**
	 * @param merchant
	 */
	private void updateLatLng(Merchant merchant) {
		if(merchant != null && StringUtils.isNotBlank(merchant.getAddress()) ){
			GeoPoint point = connectGoogleAPI(merchant.getAddress());
			if(point != null){
				merchant.setLat(point.getLat());
				merchant.setLng(point.getLon());
				adminDBService.saveLatLng(merchant);
			}
		}
		
	}

	/**
	 * @param address
	 * @return
	 */
	private GeoPoint connectGoogleAPI(String address) {
		HttpsURLConnection con = null;
		try{
		String url = GOOGLE_URL+"?address="+URLEncoder.encode(address,"utf-8")+"&key="+GOOGLE_KEY;
		URL obj = new URL(url);
		con = (HttpsURLConnection) obj.openConnection();
		GeoPoint point = null;
		con.setRequestMethod("GET");
		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		int responseCode = con.getResponseCode();
		if(responseCode != 200){
			throw new Exception("Error response code ::" +responseCode);
		}
		Double lat=null,lng = null;
		 Document doc = parseXML(con.getInputStream());
	        NodeList locNodes = doc.getElementsByTagName("location");

	        for(int i=0; i<locNodes.getLength();i++)
	        {
	        	if(locNodes.item(i).hasChildNodes()){
	        		NodeList childList = locNodes.item(i).getChildNodes();
	    	        for(int j=0; j<childList.getLength();j++)
	    	        {
	    	        	if(childList.item(j) != null && childList.item(j).getNodeName() != null){
	    	        	if(childList.item(j).getNodeName().equalsIgnoreCase("lat")){
	    	        		lat=Double.valueOf(childList.item(j).getTextContent());
	    	        		continue;
	    	        	}else if(childList.item(j).getNodeName().equalsIgnoreCase("lng")){
	    	        		lng=Double.valueOf(childList.item(j).getTextContent());
	    	        	}
	    	        	}
	    	        }
	        	}
	        }
	      if(lat != null && lng!=null){
	    	  point = new GeoPoint(lat, lng);
	      }
	      
		return point;
		}catch (Exception e) {
			LOG.error("Error in extracking lat/long from google API " +GOOGLE_KEY ,e);
		}finally{
			if(con != null){
				con.disconnect();
			}
		}
		return null;
	}
	
	private Document parseXML(InputStream stream)
		    throws Exception
		    {
		        DocumentBuilderFactory objDocumentBuilderFactory = null;
		        DocumentBuilder objDocumentBuilder = null;
		        Document doc = null;
		        try
		        {
		            objDocumentBuilderFactory = DocumentBuilderFactory.newInstance();
		            objDocumentBuilder = objDocumentBuilderFactory.newDocumentBuilder();

		            doc = objDocumentBuilder.parse(stream);
		        }
		        catch(Exception ex)
		        {
		            throw ex;
		        }       

		        return doc;
		    }

	/* (non-Javadoc)
	 * @see com.eros.service.AdminService#setMerchantLuxuryRating(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public void setMerchantLuxuryRating(Integer id, Integer rating) {
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("merchantId", id);
			param.put("luxury", rating);
			Integer rows = adminDBService.updateMerchantLuxuryRating(param);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/* (non-Javadoc)
	 * @see com.eros.service.AdminService#fetchDeals(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public SearchResponse fetchDeals(Integer page, Integer limit) {
		Map<String, Object> param = new HashMap<String, Object>();
		if(page == null) {
			page=0;
		}
		if(limit == null) {
			limit=50;
		}
		param.put("page", page);
		param.put("limit", limit);
		List<HashMap<String, String>> deals = adminDBService
				.fetchDeals(param);
		SearchResponse res = new SearchResponse();
		res.setResponse(deals);
		return res;
	}

	/* (non-Javadoc)
	 * @see com.eros.service.AdminService#fetchErrors(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public SearchResponse fetchErrors(Integer page, Integer limit) {
		Map<String, Object> param = new HashMap<String, Object>();
		if(page == null) {
			page=0;
		}
		if(limit == null) {
			limit=50;
		}
		param.put("page", page);
		param.put("limit", limit);
		List<ReportedError> deals = adminDBService
				.fetchErrors(param);
		SearchResponse res = new SearchResponse();
		res.setResponse(deals);
		return res;
	}
}
