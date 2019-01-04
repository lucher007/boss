package com.gospell.boss.common;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.MediaType;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.springframework.beans.factory.annotation.Autowired;

import net.sf.json.JSONArray;

import com.googlecode.jsonplugin.JSONException;
import com.googlecode.jsonplugin.JSONUtil;
import com.gospell.boss.controller.HttpForMpsController;
import com.gospell.boss.dao.IDispatchDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IProblemcomplaintDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IServiceDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserbusinessDao;
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Service;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.multipart.FormDataBodyPart;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.file.FileDataBodyPart;
import com.sun.jersey.multipart.impl.MultiPartWriter;
import com.sun.mail.handlers.multipart_mixed;

public class JerseyClient {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws JSONException 
	 */

	@Autowired
	private IProductDao productDao;
	@Autowired
	private IServiceDao serviceDao;
	
	public static void main(String[] args) throws IOException, JSONException {
		//file.createNewFile();
	   // System.out.println(file.exists());
	    FormDataMultiPart part = new FormDataMultiPart();

//	    part.bodyPart(new FileDataBodyPart("file", file));
//	    part.bodyPart(new FileDataBodyPart("file", file));
	    part.bodyPart(new FormDataBodyPart("json", "18988886666"));
	    part.bodyPart(new FormDataBodyPart("password", "123456"));


	    //装json信息
		
		

	   String jsonStr = "{'messagertype':'1','messagerid':'00000030','dispatchid':'2','content':'家庭住址在哪儿呢','addtime':'2017-05-18 14:38:20'}";
	   //String jsonStr1 = "{'totalMoney':'20','payMoney':'20','terminalid':'1234565796','terminaltype':'1','billDetail':[{'id':'1','type':'1','buytype':'buyproduct','totalmoney':'20.00','starttime':'2017-01-19','endtime':'2017-02-19'}]}";
	    
		//Map<String, Object> responseMap = new HashMap<String, Object>();
	    //jsonStr = JSONUtil.serialize(responseMap);
    	part.bodyPart(new FormDataBodyPart("messageInfo", jsonStr));
    	ClientConfig cc = new DefaultClientConfig();
	    cc.getClasses().add(MultiPartWriter.class);
	    Client writerClient = Client.create(cc);
	    // 处理文件将超时设置为10S
	    writerClient.setConnectTimeout(new Integer(3000));
	    writerClient.setReadTimeout(new Integer(3000));
	    try {
	        WebResource resource = writerClient.resource("http://192.168.3.167:8080/boss/httpForMps/saveMessage");
	        String response = resource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(String.class, part);
	        System.out.println(response);
	    } finally {
	        writerClient.destroy();
	    }
	}
	
	
	
	
}
