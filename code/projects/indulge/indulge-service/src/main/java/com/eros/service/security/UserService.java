/**
 * indulge-service
 * author vikas created on Apr 20, 2015
 */
package com.eros.service.security;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.eros.core.model.security.Role;
import com.eros.core.model.security.SecurityUser;
import com.eros.service.db.MerchantDBService;
 

 
@Service
public class UserService implements UserDetailsService {
 
	@Autowired
	protected MerchantDBService merchantDBService;

 
    public UserDetails loadUserByUsername(final String username, String password) throws UsernameNotFoundException {
    	Map<String, String> param = new HashMap<String, String>(2);
    	param.put("user", username);
    	param.put("passphrase", password);
    	Map<String , String> user = merchantDBService.loadMerchantByUsernameOrPhone(param);
    	if (user == null) {
            throw new BadCredentialsException("Invalid Credentials");
        }else{
        	
        }
       
        List<Role> authorities = new ArrayList< Role>();
        authorities.add(new Role(user.get("role")));
    	SecurityUser userDetails = new SecurityUser(user.get("email"), user.get("passphrase"), user.get("phone"), authorities);
        return userDetails;
    }


	/* (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
	 */
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		 
		return loadUserByUsername(username, null);
	}
}