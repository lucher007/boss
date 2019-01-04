package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.From;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.googlecode.jsonplugin.JSONException;
import com.gospell.boss.common.MpsApi;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IActivityinfopicDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IActivityinfoDao;
import com.gospell.boss.dao.IPromotioninfoDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IServiceDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Activityinfopic;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Activityinfo;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productextend;
import com.gospell.boss.po.User;
import com.gospell.boss.service.IAuthorizeService;
import com.sun.jersey.multipart.FormDataBodyPart;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/activityinfo")
@Transactional
public class ActivityinfoController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IActivityinfoDao activityinfoDao;
	@Autowired
	private IActivityinfopicDao activityinfopicDao;
	@Autowired
	private ISystemparaDao systemparaDao;
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Activityinfo form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(activityinfoDao.findByCount(form));
		List<Activityinfo> activityinfolist = activityinfoDao.findByList(form);
		form.setActivityinfolist(activityinfolist);
		return "activityinfo/findActivityinfoList";
	}

	/**
	 * 添加用户信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Activityinfo form) {
		return "activityinfo/addActivityinfo";
	}
    
	
	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Activityinfo form) {
		Activityinfo activityinfo = activityinfoDao.findByStr(form.getTitle());
		if(!"".equals(activityinfo) && activityinfo != null){
			form.setReturninfo(getMessage("activityinfo.existed"));
			return addInit(form);
		}
		//state默认设为1-有效
		form.setState("1");
		//type默认为图片
		form.setType("1");
		Integer activityinfoid = activityinfoDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Activityinfo form) {

		form.setActivityinfo(activityinfoDao.findById(form.getId()));
				
		return "activityinfo/updateActivityinfo";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Activityinfo form) {

		if ("".equals(form.getTitle())) {
			form.setReturninfo(getMessage("activityinfo.title.empty"));
			return updateInit(form);
		} 

		//修改之后 state默认设为0-无效，必须重新激活
		form.setType("1");
		
		// 修改网络信息
		activityinfoDao.update(form);
		

		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Activityinfo form) {
		
        Activityinfo activityinfo =  activityinfoDao.findById(form.getId());
		
		if(activityinfo == null){
			return null;
		}
		
		List<Activityinfopic> activityinfopiclist = activityinfopicDao.findPicListByActivityinfoid(form.getId());
		if(activityinfopiclist != null && activityinfopiclist.size() > 0){
			for (Activityinfopic activityinfopic : activityinfopiclist) {
				//删除服务器上的文件
				if(StringUtils.isNotEmpty(activityinfopic.getPreserveurl())){
					 //删除服务器所在文件
					File tmpFile = new File(activityinfopic.getPreserveurl());
					tmpFile.delete();
				}
				//删除图片信息
				activityinfopicDao.delete(activityinfopic.getId());
			}
		}
       
		// 删除activityinfo
		activityinfoDao.delete(form.getId());
				
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
    
	
	/**
	 * 查看图片列表信息
	 */
	@RequestMapping(value = "/queryActivityinfopic")
	public String queryActivityinfopic(Activityinfo form) {
		Activityinfo activityinfo = activityinfoDao.findById(form.getId());
		if (activityinfo != null) {
			form.setActivityinfo(activityinfo);
			form.setActivityinfopiclist(activityinfopicDao.findPicListByActivityinfoid(activityinfo.getId()));
		}
		return "activityinfo/findActivityinfopicList";
	}
	
	
	/**
	 * 查看图片
	 */
	@RequestMapping(value = "/getExtendFileStream")
	public String getExtendFileStream(Activityinfopic form,HttpServletResponse response){
		Activityinfopic activityinfopic =  activityinfopicDao.findById(form.getId());
        
        try {
        	if(StringUtils.isNotEmpty(activityinfopic.getPreserveurl())){
        		File excelTemplate = new File(activityinfopic.getPreserveurl());
    			response.reset();
    			
    			//图片文件，直接在页面显示图片
    			if (Tools.isImage(excelTemplate)) {  
    				response.setHeader("Accept-Ranges", "bytes");  
    	            response.setHeader("Pragma", "no-cache");  
    	            response.setHeader("Cache-Control", "no-cache");  
    	            response.setDateHeader("Expires", 0);  
    			}else{//非图片文件，先下载
    				response.setContentType("application/octet-stream");
    				response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
    				response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(activityinfopic.getFilename(), "UTF-8"));
    			}
    			
    			FileInputStream fis = new FileInputStream(excelTemplate);
    			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
    			byte[] buffer = new byte[1024 * 1024];
    			while (fis.read(buffer) > 0) {
    				toClient.write(buffer);
    			}
    			fis.close();
    			toClient.flush();
    			toClient.close();
        	}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
    }
	
	@RequestMapping(value = "/deleteActivityinfopic")
	public String deleteActivityinfopic(Activityinfo form){
		Activityinfopic activityinfopic =  activityinfopicDao.findById(form.getId());
		
		if(activityinfopic != null){
			if(StringUtils.isNotEmpty(activityinfopic.getPreserveurl())){
				//删除服务器所在文件
				File tmpFile = new File(activityinfopic.getPreserveurl());
				tmpFile.delete();
			}
			//删除推广信息
			activityinfopicDao.delete(form.getId());
		}
		
		return queryActivityinfopic(form);
    }
	
	/**
	 * 上传图片初始化
	 */
	@RequestMapping(value = "/addActivityinfopicInit")
	public String addActivityinfopicInit(Activityinfo form) {
		Activityinfo activityinfo = activityinfoDao.findById(form.getId());
		if (activityinfo != null) {
			form.setActivityinfo(activityinfo);
			//查询活动的图片信息
			form.setActivityinfopiccount(activityinfopicDao.findActivityinfopicCount(form.getId()));
		}
		return "activityinfo/addActivityinfopic";
	}
	
	/**
	 * 上传图片-保存活动
	 */
	@ResponseBody
	@RequestMapping(value = "/saveActivityinfopic")
	public Map<String, Object> saveActivityinfopic(@RequestParam("uploadfile") MultipartFile file, Activityinfopic form) throws IllegalStateException, IOException {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		try {
			
			if (!file.isEmpty()) {
				
				String filename = file.getOriginalFilename();
				String[] strArray = filename.split("[.]");
				String filetype = strArray[strArray.length - 1];
				String upload_extend_path = systemparaDao.findByCodeStr("upload_file_path").getValue();
				String folderpath = upload_extend_path + File.separatorChar + "activityinfo" + File.separatorChar + form.getTitle() +"_" + form.getActivityinfoid();
				File folder = new File(folderpath);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String preservefilename = Tools.getNowRandom() + "_" + filename;
				String preservepath = folderpath + File.separatorChar + preservefilename;
				File savefile = new File(preservepath);
				file.transferTo(savefile);
				form.setFilename(filename);
				form.setPreservefilename(preservefilename);
				form.setPreserveurl(preservepath);
				activityinfopicDao.save(form);
			}
		} catch (Exception e) {
			// TODO: handle exception
			responseMap.put("result", getMessage("page.execution.failure") + "(" + e + ")");
			return responseMap;
		}
		responseMap.put("result", getMessage("page.execution.success"));
		return responseMap;
	}

}
