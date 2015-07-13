/**
 * indulge-service
 * author vikas created on May 27, 2015
 */
package com.eros.service.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

/**
 * @author vikas
 * 
 */
public class TinyUrlUtility {

	private static String T_URL = "http://tinyurl.com/api-create.php?url=";

	public static String getTinyUrl(String longUrl) throws Exception{
		BufferedReader in = null;
		try{
		String tinyUrl = "";
		String urlString = T_URL + longUrl;
		URL url = new URL(urlString);

		in = new BufferedReader(new InputStreamReader(
				url.openStream()));
		String str;

		while ((str = in.readLine()) != null) {
			tinyUrl += str;
			return tinyUrl;
		}
		return tinyUrl;
		}finally{
			if(in != null){
				in.close();
			}
		}

		
	}

}
