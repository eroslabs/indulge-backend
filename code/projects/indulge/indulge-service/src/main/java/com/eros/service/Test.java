/**
 * indulge-service
 * author vikas created on Apr 9, 2015
 */
package com.eros.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Date;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * @author vikas
 *
 */
public class Test {
	
	public static void main(String[] args) {
		
		String  s = "0110.111";
		System.out.println(s.substring(s.indexOf(".")));
		String  key = "1000000";
		
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < s.length(); i++)
		    sb.append((int)(s.charAt(i) ^ key.charAt(i % key.length())));
		String result = sb.toString();
		System.out.println(result);
		System.err.println(new Date(1427719898000L));
//		
//		for (int i = 460; i < 480; i++) {
//			
//		
//
//try {
//
//        URL url = new URL("http://www.spazense.com/spa-map-search.aspx/GetSpaDetails");
//        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//        conn.setDoOutput(true);
//        conn.setRequestMethod("POST");
//        conn.setRequestProperty("Content-Type", "application/json");
//
//        String input = "{id:\""+i+"\"}";
//
//        OutputStream os = conn.getOutputStream();
//        os.write(input.getBytes());
//        os.flush();
//
//        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
//            throw new RuntimeException("Failed : HTTP error code : "
//                + conn.getResponseCode());
//        }
//
//        BufferedReader br = new BufferedReader(new InputStreamReader(
//                (conn.getInputStream())));
//
//        String output;
//        StringBuilder buffer = new StringBuilder();
//        System.out.println("Output from Server .... \n");
//        while ((output = br.readLine()) != null) {
//            buffer.append(output);
//        }
//        JSONObject outputj = (JSONObject)new JSONParser().parse(buffer.toString());
//        File file=new File("c:/eros/JSON.csv");
//        FileUtils.writeStringToFile(file, outputj.toJSONString() ,true);
//        FileUtils.writeStringToFile(file, "\n" ,true);
//        conn.disconnect();
//        try {
//            Thread.sleep(3000);                 //1000 milliseconds is one second.
//        } catch(InterruptedException ex) {
//            Thread.currentThread().interrupt();
//        }
//
//      } catch (MalformedURLException e) {
//
//        e.printStackTrace();
//
//      } catch (Exception e) {
//
//        e.printStackTrace();
//
//     }
//	}
	}
}
