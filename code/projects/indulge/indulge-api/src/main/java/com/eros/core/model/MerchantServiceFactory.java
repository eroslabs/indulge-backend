/**
 * indulge-api
 * author vikas created on Apr 1, 2015
 */
package com.eros.core.model;

import org.springframework.util.AutoPopulatingList;

/**
 * @author vikas
 *
 */
public class MerchantServiceFactory implements AutoPopulatingList.ElementFactory<MerchantService> {

    public MerchantService createElement(int index) {
        MerchantService subDivision = new MerchantService();
        return subDivision;
    }
}
