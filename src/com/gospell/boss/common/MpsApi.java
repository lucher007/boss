package com.gospell.boss.common;

import java.util.Map;

import javax.ws.rs.core.MediaType;

import com.googlecode.jsonplugin.JSONException;
import com.googlecode.jsonplugin.JSONUtil;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.multipart.FormDataBodyPart;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.impl.MultiPartWriter;



public class MpsApi {

    //工具
    public static String pushProductToMps(Map<String, Object> dataMap, String apiUrl) throws JSONException {
 	    FormDataMultiPart part = new FormDataMultiPart();
 	    String jsonStr = "";
 		jsonStr = JSONUtil.serialize(dataMap);
     	System.out.println(jsonStr);
    
     	part.bodyPart(new FormDataBodyPart("json", jsonStr));
     
     	ClientConfig cc = new DefaultClientConfig();
 	    cc.getClasses().add(MultiPartWriter.class);
 	    Client writerClient = Client.create(cc);
 	    writerClient.setConnectTimeout(new Integer(3000));
 	    writerClient.setReadTimeout(new Integer(3000));
 	    try {
 	        WebResource resource = writerClient.resource(apiUrl);
 	        String response = resource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(String.class, part);
 	        System.out.println("response:" + response);
 	    	return response;
 	    } finally {
 	        writerClient.destroy();
 	    }
    }

 

}
