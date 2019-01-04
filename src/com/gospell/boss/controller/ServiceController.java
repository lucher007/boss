package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductservicerefDao;
import com.gospell.boss.dao.IPromotioninfoDao;
import com.gospell.boss.dao.IServiceDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productextend;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Service;
import com.gospell.boss.po.Serviceextend;
import com.gospell.boss.po.Stb;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/service")
@Transactional
public class ServiceController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IServiceDao serviceDao; 
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IPromotioninfoDao promotioninfoDao; 
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IProductservicerefDao productservicerefDao;
	
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Service form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(serviceDao.findByCount(form));
		List<Service> servicelist = serviceDao.findByList(form);
		for (Service service : servicelist) {
			service.setNetwork(networkDao.findById(service.getNetid()));
		}
		form.setServicelist(servicelist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "service/findServiceList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Service form) {
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "service/addService";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Service form){
		if ("".equals(form.getServiceid())) {
			form.setReturninfo(getMessage("service.serviceid.empty"));
			return addInit(form);
		} else {
			Service oldService = serviceDao.findByServiceid(form);
			if (oldService != null) {
				form.setReturninfo(getMessage("service.serviceid.existed"));
				return addInit(form);
			}
		}
		//判断是否能单独购买
		if("1".equals(form.getChargetype())){
			if(form.getPricepermonth() == null){
				form.setReturninfo(getMessage("service.pricepermonth.empty"));
				return addInit(form);
			}
		}else{
			form.setPricepermonth(null);
		}
		//state默认设为0-无效
		form.setState("0");
		serviceDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Service form){
		
		Service service = serviceDao.findById(form.getId());
		
		form.setService(service);
		
		Network networkform = networkDao.findById(service.getNetid());
		
		form.setNetwork(networkform);
		
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "service/updateService";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Service form){
		if ("".equals(form.getServiceid())) {
			form.setReturninfo(getMessage("service.serviceid.empty"));
			return updateInit(form);
		} 
		Service oldService = serviceDao.findByServiceid(form);
		if (oldService != null && !oldService.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("service.serviceid.existed"));
			return updateInit(form);
		}
		//判断是否能单独购买
		if("1".equals(form.getChargetype())){
			if(form.getPricepermonth() == null){
				form.setReturninfo(getMessage("service.pricepermonth.empty"));
				return updateInit(form);
			}
		}else{
			form.setPricepermonth(null);
		}
		//修改就变成未激活，state默认设为0-无效，需要重新激活
		form.setState("0");
		
        oldService = serviceDao.findById(form.getId());
        //如果业务ID改变了，需要判断是否已经关联产品
        if(!oldService.getServiceid().equals(form.getServiceid())){
        	//此业务ID已经打包成产品了，不能修改业务ID
    		Productserviceref productserviceref = new Productserviceref();
    		productserviceref.setNetid(oldService.getNetid());
    		productserviceref.setServiceid(oldService.getServiceid());
    		List<Productserviceref> productservicereflist = productservicerefDao.findByServiceid(productserviceref);
    		if(productservicereflist !=null && productservicereflist.size() > 0){
    			form.setReturninfo(getMessage("service.serviceid.packaged"));
				return updateInit(form);
    		}
        }
        
        //修改网络信息
		Integer id = serviceDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Service form) {
		
		Service service = serviceDao.findById(form.getId());
		
		//此业务ID已经打包成产品了，不能修改业务ID
		Productserviceref productserviceref = new Productserviceref();
		productserviceref.setNetid(service.getNetid());
		productserviceref.setServiceid(service.getServiceid());
		List<Productserviceref> productservicereflist = productservicerefDao.findByServiceid(productserviceref);
		if(productservicereflist !=null && productservicereflist.size() > 0){
			form.setReturninfo(getMessage("service.serviceid.packaged"));
			return findByList(form);
		}
		
		//删除原来关联的产品业务表数据
		serviceDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
	 * 批量激活
	 */
	@RequestMapping(value="/active")
	public String activeService(Service form,HttpServletRequest request)  {
		String[] idArray = request.getParameterValues("ids");
		if(idArray ==null || idArray.length < 1){
			form.setReturninfo(getMessage("page.select.empty"));
		}else{
			for (int i=0;i<idArray.length;i++) {
				Service service = new Service();
				service.setId(Integer.parseInt(idArray[i]));
				service.setState("1");//激活
				Integer deleteflag = serviceDao.activeService(service);
			}
			form.setReturninfo(getMessage("page.execution.success"));
		}
		return findByList(form);
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/servicePromotion")
	public String servicePromotion(Service form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(serviceDao.findByCount(form));
		List<Service> servicelist = serviceDao.findByList(form);
		for (Service service : servicelist) {
			service.setNetwork(networkDao.findById(service.getNetid()));
		}
		form.setServicelist(servicelist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "service/servicePromotion";
	}
	
	@RequestMapping(value = "/queryExtendInfo")
	public String queryExtendInfo(Service form) {
		Service service = serviceDao.findById(form.getId());
		if (service != null) {
			form.setNetid(service.getNetid());
			form.setServiceid(service.getServiceid());
			form.setServicename(service.getServicename());
			form.setNetwork(networkDao.findById(service.getNetid()));
			form.setService(service);
			//业务推广信息
			Serviceextend serviceextend =  new Serviceextend();
			serviceextend.setNetid(service.getNetid());
			serviceextend.setServiceid(service.getServiceid());
			form.setServiceextendlist(promotioninfoDao.findByService(serviceextend));
		}
		return "service/findServicePromotionList";
	}
	
	@RequestMapping(value = "/getExtendFileStream")
	public String getExtendFileStream(Serviceextend form,HttpServletResponse response){
		Serviceextend serviceextend =  promotioninfoDao.findServiceextendById(form.getId());
        try {
			File excelTemplate = new File(serviceextend.getPreserveurl());
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
				response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(serviceextend.getFilename(), "UTF-8"));
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
		} catch (Exception ex){
			ex.printStackTrace();
		}
		return null;
    }
	
	@RequestMapping(value = "/deleteExtendInfo")
	public String deleteExtendInfo(Service form){
		Serviceextend serviceextend =  promotioninfoDao.findServiceextendById(form.getServiceetendid());
		if(serviceextend == null){
			return null;
		}
        //删除服务器所在文件
		File tmpFile = new File(serviceextend.getPreserveurl());
		tmpFile.delete();
		//删除推广信息
		promotioninfoDao.deleteServiceextend(serviceextend.getId());
		return queryExtendInfo(form);
    }
	
	@RequestMapping(value = "/saveExtendInfoInit")
	public String saveExtendInfoInit(Service form) {
		Service service = serviceDao.findById(form.getId());
		if (service != null) {
			Network network = networkDao.findById(service.getNetid());
			form.setNetwork(network !=  null ? network : new Network());
			form.setServiceid(service.getServiceid());
			form.setNetid(service.getNetid());
			form.setServicename(service.getServicename());
			form.setExtendinfocount(promotioninfoDao.findServiceextendCount(form));
			System.out.println("************" + form.getExtendinfocount());
			
		}
		return "service/addExtendInfo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveExtendInfo")
	public Map<String, Object> saveExtendInfo(@RequestParam("uploadfile") MultipartFile file, Serviceextend form) throws IllegalStateException, IOException {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		try {
			if (!file.isEmpty()) {
				
				Network network = networkDao.findById(form.getNetid());
				
				String filename = file.getOriginalFilename();
				String[] strArray = filename.split("[.]");
				String filetype = strArray[strArray.length - 1];
				String upload_extend_path = systemparaDao.findByCodeStr("upload_file_path").getValue();
				String folderpath = upload_extend_path + File.separatorChar + "service"+ File.separatorChar + "netid_" + network.getNetid() + File.separatorChar + "sericeid_" + form.getServiceid();
				File folder = new File(folderpath);
				if (!folder.exists()){
					folder.mkdirs();
				}
				String preservefilename = Tools.getNowRandom() + "_" + filename;
				String preservepath = folderpath + File.separatorChar + preservefilename;
				File savefile = new File(preservepath);
				file.transferTo(savefile);
				form.setFilename(filename);
				form.setPreservefilename(preservefilename);
				form.setPreserveurl(preservepath);
				promotioninfoDao.saveServiceextend(form);
			}
		} catch (Exception e) {
			responseMap.put("result", getMessage("page.execution.failure")+ "("+e+")");
			return responseMap;
		}
		responseMap.put("result", getMessage("page.execution.success"));
		return responseMap;
	}
	
	/**
	 * 文件导入添加初始页面
	 */
	@RequestMapping(value = "/addByImportFileInit")
	public String addByImportFileInit(Service form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "service/addByImportFile";
	}
	
	/**
	 * 导入文件信息
	 */
	@RequestMapping(value = "/saveByImportFile")
	public String saveByImportFile(Service form, @RequestParam("uploadfile") MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		if (filename == null || "".equals(filename)) {
			form.setReturninfo(getMessage("uploadify.filename.null"));
			return addByImportFileInit(form);
		}
		// 文件类型
		String[] strArray = filename.split("[.]");
		String type = strArray[strArray.length - 1].toLowerCase();
		if (!"xls".equals(type) && !"xlsx".equals(type)) {
			form.setReturninfo(getMessage("uploadify.filetype.error"));
			return addByImportFileInit(form);
		}
		String import_template_path = servletContext.getInitParameter("import_template_path");
		String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
		File tmpFile = new File(fullpath);
		file.transferTo(tmpFile);
		try {
			FileInputStream fis = new FileInputStream(tmpFile);
			ArrayList<Service> serviceList = new ArrayList<Service>();
			if("xls".equals(type)){
				HSSFWorkbook excel = new HSSFWorkbook(fis);
				HSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Service serviceRow = fillServiceData(row);
					/*** 提示用户读取出错地点 ***/
					String returnInfo = serviceRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						serviceRow.setNetid(form.getNetid());
						serviceRow.setState("0");
						serviceRow.setPriceperday(new BigDecimal(0));
						serviceRow.setPricepermonth(new BigDecimal(0));
						serviceRow.setChargetype("1");  //可以单独购买
						serviceList.add(serviceRow);
					}
				}
			}else if("xlsx".equals(type)){
				XSSFWorkbook excel = new XSSFWorkbook(fis);
				XSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Service serviceRow = fillServiceData(row);
					/*** 提示用户读取出错地点 ***/
					String returnInfo = serviceRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						serviceRow.setNetid(form.getNetid());
						serviceRow.setState("0");
						serviceRow.setPriceperday(new BigDecimal(0));
						serviceRow.setPricepermonth(new BigDecimal(0));
						serviceRow.setChargetype("1");  //可以单独购买
						serviceList.add(serviceRow);
					}
				}
			}
			
			//先删除该网络下的业务ID
			//serviceDao.emptyTable();
			serviceDao.deleteByNetid(form.getNetid());
			serviceDao.saveBatch(serviceList);
			form.setReturninfo(getMessage("page.execution.success"));
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
			tmpFile.delete();
			return addByImportFileInit(form);
		}
		tmpFile.delete();
		return addByImportFileInit(form);
	}
	
	/**
	 * 下载导入模板
	 */
	@RequestMapping(value = "/downloadTemplate")
	public String downloadTemplate(Service form, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "service_list_template.xls";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("service_list_template.xls", "UTF-8"));
			FileInputStream fis = new FileInputStream(excelTemplate);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer);
			}
			fis.close();
			toClient.flush();
			toClient.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	/**
	 * 读取EXCEL单元值
	 */
	private String cellValue(Cell cell) {
		String cellValue = "";
		if (cell != null) {
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_NUMERIC:
				double temp = cell.getNumericCellValue();
				cellValue = temp == (int) temp ? String.valueOf((int) temp) : String.valueOf(temp);
				break;
			case HSSFCell.CELL_TYPE_STRING:
				cellValue = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				cellValue = String.valueOf(cell.getBooleanCellValue());
				break;
			}
		}
		return cellValue;
	}

	/**
	 * 封装EXCEL中的Service信息
	 */
	private Service fillServiceData(Row row) {
		Service service = new Service();
		//获取service id
		Cell cell1 = row.getCell(0);   //第二列
		String serviceid = this.cellValue(cell1);
		if (serviceid == "" || serviceid == null) {
			service.setReturninfo(getMessage("service.serviceid.empty"));
			return service;
		}else{
			service.setServiceid(serviceid);
		}
		//获取service name
		Cell cell2 = row.getCell(1);
		String servicename = this.cellValue(cell2);
		service.setServicename(servicename);
		return service;
	}
	
	
	
}
