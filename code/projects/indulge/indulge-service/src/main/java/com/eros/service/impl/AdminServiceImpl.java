/**
 * indulge-service
 * author vikas created on Apr 22, 2015
 */
package com.eros.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.common.recycler.Recycler.V;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eros.core.model.Merchant;
import com.eros.core.model.MerchantDeal;
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
			adminDBService.updateMerchantStatus(param);
			if (b) {
				addToCache(id);
			}else{
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
		try{
			if (id != null) {
				merchantRepository.delete(id);
				dealRepository.deleteByMerchantId(id);

			}
			}catch (Exception e) {
				LOG.error("Error in updating cache while enabling a merchant" , e);
			}

	}

	/**
	 * @param id
	 */
	private void addToCache(Integer id) {
		try{
		Merchant merchant = merchantService.getMerchantById(id);
		if (merchant != null && merchant.getId() != null) {
			merchantRepository.save(merchant);
		}
		List<MerchantDeal> deals = merchantService.fetchDealWithMerchant(id);
		if (deals != null && deals.size() > 0) {
			dealRepository.save(deals);
		}}catch (Exception e) {
			LOG.error("Error in updating cache while enabling a merchant" , e);
		}
	}

}
