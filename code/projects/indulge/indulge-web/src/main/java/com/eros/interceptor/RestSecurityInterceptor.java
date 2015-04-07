/**
 * indulge-web
 * author vikas created on Apr 3, 2015
 */
package com.eros.interceptor;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.eros.service.util.EncryptionUtils;

/**
 * @author vikas
 *
 */
public class RestSecurityInterceptor extends HandlerInterceptorAdapter{
	
	/**
	 * 
	 */
	private static final String TOKEN2 = "token";
	/**
	 * 
	 */
	private static final String AUTH2 = "auth";
	protected static Log LOGGER = LogFactory
			.getLog(RestSecurityInterceptor.class);
	      
	 	    public boolean preHandle(HttpServletRequest request,
	      HttpServletResponse response, Object handler)
	         throws Exception {
	 	    	try{
 	 	    	String auth = request.getHeader(AUTH2);
	 	    	String token = request.getParameter(TOKEN2);
	 	    	if(StringUtils.isEmpty(auth) || StringUtils.isEmpty(token)){
	 	    		throw new IllegalAccessException("Incorrect headers either auth or token null");
	 	    	}
	 	    	String unencryptedStr = EncryptionUtils.decrypt(auth);
	 	    	if(unencryptedStr == null || unencryptedStr.indexOf(token) ==-1)
	 	    	{
	 	    		LOGGER.error("Auth unsuccessfull in User API call "+unencryptedStr);
	 	    		throw new IllegalAccessException("Auth failed");
	 	    	}
	 	    	String email = unencryptedStr.replaceAll(token,"");
	 	    	if(!isValidEmailAddress(email)){
	 	    		throw new IllegalAccessException("Invalid email "+email);
	 	    	}
	 	    	ServletContext context = request.getSession().getServletContext();
	 	    	context.setAttribute("USER_LOGGED_IN_EMAIL", email);
	 	    	}catch (Exception e) {
					e.printStackTrace();
				}
	 	        return true;
	 	    }
	 	     
	 	   public static boolean isValidEmailAddress(String email) {
	 		   boolean result = true;
	 		   try {
	 		      InternetAddress emailAddr = new InternetAddress(email);
	 		      emailAddr.validate();
	 		   } catch (AddressException ex) {
	 		      result = false;
	 		   }
	 		   return result;
	 		}  

}
