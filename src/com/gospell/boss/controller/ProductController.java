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
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IProductservicerefDao;
import com.gospell.boss.dao.IPromotioninfoDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IServiceDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productextend;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Service;
import com.gospell.boss.po.Serviceextend;
import com.gospell.boss.po.User;
import com.gospell.boss.service.IAuthorizeService;
import com.sun.jersey.multipart.FormDataBodyPart;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/product")
@Transactional
public class ProductController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IServiceDao serviceDao;
	@Autowired
	private IProductservicerefDao productservicerefDao;
	@Autowired
	private IPromotioninfoDao promotioninfoDao;
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IServerDao serverDao;
	@Autowired
	private IAuthorizeService authorizeService;

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Product form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(productDao.findByCount(form));
		List<Product> productlist = productDao.findByList(form);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
		}
		form.setProductlist(productlist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "product/findProductList";
	}

	/**
	 * 添加用户信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Product form) {
		// 构建上级网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
		
		return "product/addProduct";
	}
    
	/**
	 * 初始化网络下的service
	 * @return
	 */
	@RequestMapping(value="/refServiceInfo")
	public String refServiceInfo(Product form) {
		// 封装产品已经包含的业务
		Productserviceref ref = new Productserviceref();
		ref.setNetid(form.getNetid());
		ref.setProductid(form.getProductid());
		List<Productserviceref> existedServices = productservicerefDao.findByProductid(ref);
		List<String> existedServiceId = new ArrayList<String>();
		for (Productserviceref existedService : existedServices) {
			existedServiceId.add(existedService.getServiceid());
		}
		
		Service service = new Service();
		// 初始化页面，网络默认选择为页面List中第一个
		service.setQuerynetid(String.valueOf(form.getNetid()));
		List<Service> serviceList = serviceDao.queryByList(service);
		for (Service service1 : serviceList) {
			/* 属于该产品的业务，将belongproduct置为true */
			if (existedServiceId.contains(service1.getServiceid())) {
				service1.setBelongproduct(true);
			}
		}
		form.setServicelist(serviceList);
		return "product/refServiceInfo";
	}
	
	
	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Product form) {
		if ("".equals(form.getProductid())) {
			form.setReturninfo(getMessage("product.productid.empty"));
			return addInit(form);
		} else {
			Product oldProduct = productDao.findByProductid(form);
			if (oldProduct != null) {
				form.setReturninfo(getMessage("product.productid.existed"));
				return addInit(form);
			}
		}
		// 如果价格为空，默认为0；
		if (form.getPricepermonth() == null) {
			form.setPricepermonth(new BigDecimal(0));
		}
		if (form.getPriceperday() == null) {
			form.setPriceperday(new BigDecimal(0));
		}
		if (form.getSubpricepermonth() == null) {
			form.setSubpricepermonth(new BigDecimal(0));
		}
		if (form.getSubpriceperday() == null) {
			form.setSubpriceperday(new BigDecimal(0));
		}
		// state默认设为0-无效
		form.setState("0");
		Integer productid = productDao.save(form);
		
		String[] idArray = getRequest().getParameterValues("ids");
//		if (idArray == null || idArray.length == 0) {
//			form.setReturninfo(getMessage("product.service.empty"));
//			return addInit(form);
//		}
		/* 添加业务信束关联 */
		if(idArray != null && idArray.length > 0){
			for (String id : idArray) {
				Productserviceref productserviceref = new Productserviceref();
				productserviceref.setProductid(form.getProductid());
				productserviceref.setNetid(form.getNetid());
				productserviceref.setServiceid(id);
				productservicerefDao.save(productserviceref);
			}
		}
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Product form) {

		form.setProduct(productDao.findById(form.getId()));

		// 构建上级网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
				
		return "product/updateProduct";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Product form) {

		if ("".equals(form.getProductid())) {
			form.setReturninfo(getMessage("product.productid.empty"));
			return updateInit(form);
		} else {
			Product oldProduct = productDao.findByProductid(form);
			if (oldProduct != null && !oldProduct.getId().equals(form.getId())) {
				form.setReturninfo(getMessage("product.productid.existed"));
				return updateInit(form);
			}
		}

		// 如果价格为空，默认为0；
		if (form.getPricepermonth() == null) {
			form.setPricepermonth(new BigDecimal(0));
		}
		if (form.getPriceperday() == null) {
			form.setPriceperday(new BigDecimal(0));
		}
		if (form.getSubpricepermonth() == null) {
			form.setSubpricepermonth(new BigDecimal(0));
		}
		if (form.getSubpriceperday() == null) {
			form.setSubpriceperday(new BigDecimal(0));
		}
		//修改之后 state默认设为0-无效，必须重新激活
		form.setState("0");
		
		// 修改网络信息
		productDao.update(form);
		// 删除原来关联的servcie
		Productserviceref productserviceref = new Productserviceref();
		productserviceref.setNetid(form.getNetid());
		productserviceref.setProductid(form.getProductid());
		productservicerefDao.deleteByProductid(productserviceref);
		
		String[] idArray = getRequest().getParameterValues("ids");
//		if (idArray == null || idArray.length == 0) {
//			form.setReturninfo(getMessage("product.service.empty"));
//			return updateInit(form);
//		}
		// 添加新关联的servcie
		if(idArray != null && idArray.length > 0){
			for (String id : idArray) {
				productserviceref.setServiceid(id);
				productservicerefDao.save(productserviceref);
			}
		}
		

		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Product form) {
		
		Product product = productDao.findById(form.getId());
		
		// 删除原来关联的servcie
		Productserviceref productserviceref = new Productserviceref();
		productserviceref.setNetid(product.getNetid());
		productserviceref.setProductid(product.getProductid());
		productservicerefDao.deleteByProductid(productserviceref);
        
		// 删除product
		productDao.delete(form.getId());
				
		//同步产品信息给CAS
		//authorizeService.saveAuthorize_pushproductinfo();
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}

	/**
	 * 批量激活
	 */
	@RequestMapping(value = "/active")
	public String activeProduct(Product form, HttpServletRequest request) {
		String[] idArray = request.getParameterValues("ids");
		if (idArray == null || idArray.length < 1) {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Product product = new Product();
				product.setId(Integer.parseInt(idArray[i]));
				product.setState("1");// 激活
				Integer deleteflag = productDao.activeProduct(product);
			}
			
		
			
//			//每次激活之后，自动同步下MPS
//			//获取MPS服务器信息
//			String mpsIp = "127.0.0.1:8080";
//			Server serverForm = new Server();
//			serverForm.setQueryservertype("mps");
//			List<Server> serverlist = serverDao.queryByList(serverForm);
//			if(serverlist != null && serverlist.size()>0){
//				Server server = serverlist.get(0);
//				mpsIp = server.getIp() + ":" + server.getPort();
//			}
//			String apiUrl = "http://" + mpsIp + "/mps/rs/push/pushProduct";
//			try {
//				Map<String, Object> dataMap = new HashMap<String, Object>();
//				dataMap = this.productInfoPackage(dataMap);
//				MpsApi.pushProductToMps(/*files, */dataMap, apiUrl);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
			 
		
			//同步产品信息给CAS
			//authorizeService.saveAuthorize_pushproductinfo();
			
			form.setReturninfo(getMessage("page.execution.success"));
		}
		
		return findByList(form);
	}
    
	/**
	 * 上传图片初始化
	 */
	@RequestMapping(value = "/saveExtendInfoInit")
	public String saveExtendInfoInit(Product form) {
		Product product = productDao.findById(form.getId());
		if (product != null) {
			//form.setNetid(product.getNetid());
			form.setNetwork(networkDao.findById(product.getNetid()));
			form.setProductid(product.getProductid());
			form.setProductname(product.getProductname());
			form.setNetid(product.getNetid());
			form.setExtendinfocount(promotioninfoDao.findProductextendCount(form));
		}
		return "product/addExtendInfo";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/productPromotion")
	public String productPromotion(Product form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(productDao.findByCount(form));
		List<Product> productlist = productDao.findByList(form);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
		}
		form.setProductlist(productlist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		form.setRemark(systemparaDao.findByCodeStr("mps_extend_flag").getValue());
		return "product/productPromotion";
	}
	
	
	@RequestMapping(value = "/queryExtendInfo")
	public String queryExtendInfo(Product form) {
		Product product =productDao.findById(form.getId());
		if (product != null) {
			
			form.setNetid(product.getNetid());
			form.setProductid(product.getProductid());
			form.setProductname(product.getProductname());
			
			form.setNetwork(networkDao.findById(product.getNetid()));
			form.setProduct(product);
			//业务推广信息
			Productextend productextend =  new Productextend();
			productextend.setNetid(product.getNetid());
			productextend.setProductid(product.getProductid());
			
			form.setProductextendlist(promotioninfoDao.findByProduct(productextend));
		}
		return "product/findProductPromotionList";
	}
	
	@RequestMapping(value = "/getExtendFileStream")
	public String getExtendFileStream(Productextend form,HttpServletResponse response){
		Productextend productextend =  promotioninfoDao.findProductextendById(form.getId());
        
        try {
			File excelTemplate = new File(productextend.getPreserveurl());
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
				response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(productextend.getFilename(), "UTF-8"));
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
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
    }
	
	@RequestMapping(value = "/deleteExtendInfo")
	public String deleteExtendInfo(Product form){
		Productextend productextend =  promotioninfoDao.findProductextendById(form.getProductetendid());
		
		if(productextend == null){
			return null;
		}
		
        //删除服务器所在文件
		File tmpFile = new File(productextend.getPreserveurl());
		tmpFile.delete();
		//删除推广信息
		promotioninfoDao.deleteProductextend(productextend.getId());
       
		return queryExtendInfo(form);
    }
	
	
	@RequestMapping(value = "/pushAllProductToMps")
	public String pushAllProductToMps(Product form) {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap = this.productInfoPackage(dataMap);
		
		//获取MPS服务器信息
		String mpsIp = "127.0.0.1:8080";
		Server serverForm = new Server();
		serverForm.setQueryservertype("mps");
		List<Server> serverlist = serverDao.queryByList(serverForm);
		if(serverlist != null && serverlist.size()>0){
			Server server = serverlist.get(0);
			mpsIp = server.getIp() + ":" + server.getPort();
		}
		
		String apiUrl = "http://" + mpsIp + "/mps/rs/push/pushProduct";

		try {
			MpsApi.pushProductToMps(/*files, */dataMap, apiUrl);
			
			form.setReturninfo(getMessage("page.execution.success"));
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
		}
		
		return productPromotion(form);
	}
	
	@RequestMapping(value = "/savePushAllProductToCas")
	public String savePushAllProductToCas(Product form) {
		
		//同步产品信息给CAS
		authorizeService.saveAuthorize_pushproductinfo();
		
		form.setReturninfo(getMessage("page.execution.success"));
		
		return productPromotion(form);
	}
	
	private Map<String, Object> productInfoPackage(Map<String, Object> responseMap) {
		// 产品信息
		List<HashMap<String, Object>> productlist = new ArrayList<HashMap<String, Object>>();
		Product findProduct = new Product();
		findProduct.setQuerystate("1");//只推送激活的产品
		List<Product> products = productDao.findByList(findProduct);
		for (Product product : products) {
			HashMap<String, Object> productMap = new HashMap<String, Object>();
			productMap.put("netid", product.getNetid());
			String netname = "";
			if(networkDao.findById(product.getNetid()) !=null){
			netname = 	networkDao.findById(product.getNetid()).getNetname();
			}
			productMap.put("netname", netname);
			productMap.put("productid", product.getProductid());
			productMap.put("productname", product.getProductname());
			productMap.put("producttype", product.getProducttype());
			productMap.put("pricepermonth", product.getPricepermonth());
			productMap.put("priceperday", product.getPriceperday());
			productMap.put("subpricepermonth", product.getSubpricepermonth());
			productMap.put("subpriceperday", product.getSubpriceperday());
			productMap.put("extendflag", product.getExtendflag());
			productMap.put("state", product.getState());
			// extend info
			Productextend findProductExtend = new Productextend();
			findProductExtend.setNetid(product.getNetid());
			findProductExtend.setProductid(product.getProductid());
			List<Productextend> productextends = promotioninfoDao.findByProduct(findProductExtend);
			List<HashMap<String, Object>> productextendsList = new ArrayList<HashMap<String, Object>>();
			for(Productextend productextend : productextends){
				HashMap<String, Object> productextendMap = new HashMap<String, Object>();
				productextendMap.put("webflag", productextend.getWebflag());
				productextendMap.put("rank", productextend.getRank());
				productextendMap.put("description", productextend.getDescription());
				productextendMap.put("type", productextend.getType());
				productextendMap.put("filename", productextend.getFilename());
				productextendMap.put("preservefilename", productextend.getPreservefilename());
				productextendMap.put("fullpath", productextend.getPreserveurl());
				productextendsList.add(productextendMap);
			}
			productMap.put("productextend",productextendsList);
			// product包含的servicelist
			Productserviceref findProductserviceref = new Productserviceref();
			findProductserviceref.setNetid(product.getNetid());
			findProductserviceref.setProductid(product.getProductid());
			List<Productserviceref> productservicerefs = productservicerefDao.findByProductid(findProductserviceref);
			List<HashMap<String, Object>> serviceIncludedlist = new ArrayList<HashMap<String, Object>>();
			for (Productserviceref productserviceref : productservicerefs) {
				HashMap<String, Object> serviceIncluded = new HashMap<String, Object>();
				//Service service  = serviceDao.findById(productserviceref.getServiceid());
				//serviceIncluded.put("serviceid", service != null ? service.getServiceid() : "");
				serviceIncluded.put("serviceid", productserviceref.getServiceid());
				serviceIncludedlist.add(serviceIncluded);
			}
			productMap.put("serviceIncluded", serviceIncludedlist);
			productlist.add(productMap);
		}
		responseMap.put("productForMPS", productlist);
		
		// service信息
		List<HashMap<String, Object>> serviceList = new ArrayList<HashMap<String, Object>>();
		Service findService = new Service();
		findService.setQuerystate("1");//只推送激活的业务
		List<Service> services = serviceDao.findByList(findService);
		for (Service service : services) {
			HashMap<String, Object> serviceMap = new HashMap<String, Object>();
			serviceMap.put("netid", service.getNetid());
			String netname = "";
			if(networkDao.findById(service.getNetid()) !=null){
			netname = 	networkDao.findById(service.getNetid()).getNetname();
			}
			serviceMap.put("netname", netname);
			serviceMap.put("serviceid", service.getServiceid());
			serviceMap.put("servicename", service.getServicename());
			serviceMap.put("servicetype", service.getServicetype());
			serviceMap.put("chargetype", service.getChargetype());
			serviceMap.put("pricepermonth", service.getPricepermonth());
			serviceMap.put("priceperday", service.getPriceperday());
			serviceMap.put("subpricepermonth", service.getSubpricepermonth());
			serviceMap.put("subpriceperday", service.getSubpriceperday());
			serviceMap.put("unit", service.getUnit());
			serviceMap.put("extendflag", service.getExtendflag());
			serviceMap.put("state", service.getState());
			// extend info
			Serviceextend findServiceextend = new Serviceextend();
			findServiceextend.setServiceid(service.getServiceid());
			findServiceextend.setNetid(service.getNetid());
			List<Serviceextend> serviceextends = promotioninfoDao.findByService(findServiceextend);
			List<HashMap<String, Object>> serviceextendList = new ArrayList<HashMap<String, Object>>();
			for(Serviceextend serviceextend : serviceextends){
				HashMap<String, Object> serviceextendMap = new HashMap<String, Object>();
				serviceextendMap.put("webflag", serviceextend.getWebflag());
				serviceextendMap.put("rank", serviceextend.getRank());
				serviceextendMap.put("description", serviceextend.getDescription() );
				serviceextendMap.put("type", serviceextend.getType());
				serviceextendMap.put("filename", serviceextend.getFilename());
				serviceextendMap.put("preservefilename", serviceextend.getPreservefilename());
				serviceextendMap.put("fullpath", serviceextend.getPreserveurl());
				serviceextendList.add(serviceextendMap);
			}
			serviceMap.put("serviceextend", serviceextendList);
			serviceList.add(serviceMap);
		}
		responseMap.put("serviceForMPS", serviceList);
		return responseMap;
	}

	/**
	 * 上传图片-产品推广
	 */
	@ResponseBody
	@RequestMapping(value = "/saveExtendInfo")
	public Map<String, Object> saveExtendInfo(@RequestParam("uploadfile") MultipartFile file, Productextend form) throws IllegalStateException, IOException {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		try {
			if (!file.isEmpty()) {
				
				Network network = networkDao.findById(form.getNetid());
				
				String filename = file.getOriginalFilename();
				String[] strArray = filename.split("[.]");
				String filetype = strArray[strArray.length - 1];
				String upload_extend_path = systemparaDao.findByCodeStr("upload_file_path").getValue();
				String folderpath = upload_extend_path + File.separatorChar + "product" + File.separatorChar + "netid_" + network.getNetid()+ File.separatorChar + "productid_" + form.getProductid();
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
				promotioninfoDao.saveProductextend(form);
			}
		} catch (Exception e) {
			// TODO: handle exception
			responseMap.put("result", getMessage("page.execution.failure") + "(" + e + ")");
			return responseMap;
		}
		responseMap.put("result", getMessage("page.execution.success"));
		return responseMap;
	}


	/**
	 * 文件导入添加初始页面
	 */
	@RequestMapping(value = "/addByImportFileInit")
	public String addByImportFileInit(Product form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "product/addByImportFile";
	}
	
	/**
	 * 导入文件信息
	 */
	@RequestMapping(value = "/saveByImportFile")
	public String saveByImportFile(Product form, @RequestParam("uploadfile") MultipartFile file) throws IOException {
		// XML上传服务器流文件
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
		
		HashMap<String,Product> productMp = new HashMap<String,Product>();
		
		try {
			FileInputStream fis = new FileInputStream(tmpFile);
			ArrayList<Product> productlist = new ArrayList<Product>();
			if("xls".equals(type)){
				HSSFWorkbook excel = new HSSFWorkbook(fis);
				HSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Product productRow = fillProductData(row,form.getNetid());
					/*** 提示用户读取出错地点 ***/
					String returnInfo = productRow.getReturninfo();
					
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						
						productRow.setNetid(form.getNetid());
						productRow.setPricepermonth(new BigDecimal(0));
						productRow.setPriceperday(new BigDecimal(0));
						productRow.setSubpricepermonth(new BigDecimal(0));
						productRow.setSubpriceperday(new BigDecimal(0));
						productRow.setState("0");
						
						//如果MAP没有该产品ID
						if(!productMp.containsKey(productRow.getProductid())){
							productMp.put(productRow.getProductid(), productRow);
							productlist.add(productRow);
						}
					}
				}
			}else if("xlsx".equals(type)){
				XSSFWorkbook excel = new XSSFWorkbook(fis);
				XSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Product productRow = fillProductData(row,form.getNetid());
					/*** 提示用户读取出错地点 ***/
					String returnInfo = productRow.getReturninfo();
					
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						
						productRow.setNetid(form.getNetid());
						productRow.setPricepermonth(new BigDecimal(0));
						productRow.setPriceperday(new BigDecimal(0));
						productRow.setSubpricepermonth(new BigDecimal(0));
						productRow.setSubpriceperday(new BigDecimal(0));
						productRow.setState("0");
						
						//如果MAP没有该产品ID
						if(!productMp.containsKey(productRow.getProductid())){
							productMp.put(productRow.getProductid(), productRow);
							productlist.add(productRow);
						}
					}
				}
			}
			
			//删除产品关联的业务
			productservicerefDao.deleteByNetid(form.getNetid());
			// 删除product
			productDao.deleteByNetid(form.getNetid());
			
			//批量插入产品业务关系表
			for (Product product : productlist) {
				List<Productserviceref> reflist = product.getReflist();
				if(reflist !=null){
					productservicerefDao.saveBatch(reflist);
				}
			}
			//批量保存产品信息
			productDao.saveBatch(productlist);
			
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
	public String downloadTemplate(Product form, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "product_list_template.xls";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("product_list_template.xls", "UTF-8"));
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
	 * 封装EXCEL中的Product信息
	 */
	private Product fillProductData(Row row,Integer netid) {
		Product product = new Product();
		//获取product id
		Cell cell0 = row.getCell(0);
		String productid = this.cellValue(cell0);
		if (productid == "" || productid == null) {
			product.setReturninfo(getMessage("product.productid.empty"));
			return product;
		}else{
			product.setProductid(productid);
		}
		//获取product name
		Cell cell1 = row.getCell(1);
		String productname = this.cellValue(cell1);
		product.setProductname(productname);
		
		//获取对应service列表
		Cell cell2 = row.getCell(2);
		String servicesString = this.cellValue(cell2);
		if (servicesString == "" || servicesString == null) {
			//product.setReturninfo(getMessage("stb.cardid.empty"));
			//没有对应的绑定serivce结束读取
		}else{
			servicesString.replaceAll("，", ",");   //所有全角转半角
			String[] serviceids = servicesString.split("[,]");
			ArrayList<Productserviceref> reflist = new ArrayList<Productserviceref>();
			for(String serviceid : serviceids){
				Productserviceref ref = new Productserviceref();
				ref.setNetid(netid);
				ref.setProductid(product.getProductid());  // ref.setProductid(form.get)
				ref.setServiceid(serviceid);   //ref.setServiceid(serviceid)
				reflist.add(ref);
			}
			product.setReflist(reflist);
		}
		return product;
	}
	
}
