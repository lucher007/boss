package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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


import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.CasEmmDao;
import com.gospell.boss.cas.ConditionAddr;
import com.gospell.boss.cas.EmailOrOsdMsg;
import com.gospell.boss.cas.Forcedrestart;
import com.gospell.boss.cas.PvrAuthEmm;
import com.gospell.boss.cas.Researchprogram;
import com.gospell.boss.cas.Stbdefaultmsg;
import com.gospell.boss.common.Tools;

import com.gospell.boss.dao.IAuthorizeDao;
import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.dao.ICaspnblackcardDao;
import com.gospell.boss.dao.ICaspnblackstbDao;
import com.gospell.boss.dao.ICaspnforcedccDao;
import com.gospell.boss.dao.ICaspnforcedosdDao;
import com.gospell.boss.dao.ICaspnnewemailDao;
import com.gospell.boss.dao.ICaspnnewfingerDao;
import com.gospell.boss.dao.ICaspnproductplayDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IServiceDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;

import com.gospell.boss.po.Authorize;
import com.gospell.boss.po.AuthorizeParamForPages;
import com.gospell.boss.po.Batchcmd;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Caspnblackcard;
import com.gospell.boss.po.Caspnblackstb;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Caspnproductplay;
import com.gospell.boss.po.Constant;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Service;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IAuthorizeService;
import com.gospell.boss.service.IBatchcmdService;
import com.sun.org.apache.bcel.internal.generic.I2F;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/cascommand")
@Transactional
public class CascommandController extends BaseController {

	@Autowired
	private ICaspnforcedosdDao caspnforcedosdDao;
	@Autowired
	private ICaspnnewfingerDao caspnnewfingerDao;
	@Autowired
	private ICaspnnewemailDao caspnnewemailDao;
	@Autowired
	private ICaspnblackcardDao caspnblackcardDao;
	@Autowired
	private ICaspnblackstbDao caspnblackstbDao;
	@Autowired
	private ICaspnforcedccDao caspnforcedccDao;
	@Autowired
	private IUsercardDao usercardDao;
	@Autowired
	private IUserstbDao userstbDao;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IAuthorizeDao authorizeDao;
	@Autowired
	private IAuthorizeService authorizeService;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private IServiceDao serviceDao;
	@Autowired
	private INetworkDao networkDao;	
	@Autowired
	private ICardDao cardDao;	
	@Autowired
	private IStbDao stbDao;	
	@Autowired
	private IServerDao serverDao;	
	@Autowired
	private IUserproductDao userproductDao; 
	@Autowired
	private ICaspnproductplayDao caspnproductplayDao; 
	@Autowired
	private IBatchcmdService batchcmdService;

	/**
	 * 批量预授权指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/add_batchpreauthorize_Init")
	public String add_batchpreauthorize_Init(AuthorizeParamForPages pageParam,Product query_product) {
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		query_product.setNetworkmap(map);
		//pageParam.setProduct(query_product);
		return "cascommand/add_batchpreauthorize";
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryProducts")
	public Map<String, Object> queryProducts(Product form,int rows,int page) {
		form.setQuerystate("1");
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = productDao.findByCount(form);
		List<Product> products = productDao.findByList(form);
		Map<String, Object> json = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> productList = new ArrayList<HashMap<String, Object>>();
		for (Product product : products) {
			HashMap<String, Object> productMap = new HashMap<String, Object>();
			productMap.put("id", product.getId());
			Network network = networkDao.findById(product.getNetid());
			productMap.put("netname", network!=null ? network.getNetname() : "");
			productMap.put("productid", product.getProductid());  
			productMap.put("productname", product.getProductname());
			productMap.put("state", product.getState());
			productList.add(productMap);
		}
		json.put("total", total);
		json.put("rows", productList);
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryTerminalList")
	public Map<String, Object> queryTerminalList(Stb form,int rows,int page) {
		
		//返回给页面的json数据
		Map<String, Object> json = new HashMap<String, Object>(); 
		int total = 0;//默认查询总数为0
		List<HashMap<String, Object>> terminalList = new ArrayList<HashMap<String, Object>>();
		String queryversiontype = form.getQueryversiontype();
		if("gos_pn".equals(queryversiontype)){//普安服务器，查询智能卡
			Card cardform = new Card();
			cardform.setQuerynetid(form.getQuerynetid());
			cardform.setQueryversiontype(form.getQueryversiontype());
			cardform.setQuerystate(form.getQuerystate());
			cardform.setPager_offset(rows*(page-1));
			cardform.setPager_openset(rows);
			total = cardDao.findByCount(cardform);
			List<Card> cardlist = cardDao.findByList(cardform);
			for (Card card : cardlist) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				objectMap.put("id", card.getCardid());
				Network network = networkDao.findById(card.getNetid());
				objectMap.put("netname", network!=null ? network.getNetname() : "");
				objectMap.put("terminalid", card.getCardid());  
				objectMap.put("terminaltype", "1");  
				terminalList.add(objectMap);
			}
			
		}else if("gos_gn".equals(queryversiontype)){//高安服务器，查询机顶盒
			Stb stbform = new Stb();
			stbform.setQuerynetid(form.getQuerynetid());
			stbform.setQueryversiontype(form.getQueryversiontype());
			stbform.setQuerystate(form.getState());
			stbform.setPager_offset(rows*(page-1));
			stbform.setPager_openset(rows);
			total =stbDao.findByCount(stbform);
			List<Stb> stblist = stbDao.findByList(stbform);
			for (Stb stb : stblist) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				objectMap.put("id", stb.getStbno());
				Network network = networkDao.findById(stb.getNetid());
				objectMap.put("netname", network!=null ? network.getNetname() : "");
				objectMap.put("terminalid", stb.getStbno());  
				objectMap.put("terminaltype", "0");  
				terminalList.add(objectMap);
			}
		}
		json.put("total", total);
		json.put("rows", terminalList);
		return json;
	}
	
	/**
	 * 批量预授权
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/send_batchpreauthorize")
	public String send_batchpreauthorize(AuthorizeParamForPages pageParam, HttpServletRequest request ,Product query_product, @RequestParam("uploadfile") MultipartFile file) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		//caCommandParam.setVersiontype("gos_pn");
		//caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		String starttime = pageParam.getStarttime() + " 00:00:00";
		String endtime = pageParam.getEndtime() + " 23:59:59";
		
		/***************************** 封装userproduct ****************************/
		List<Userproduct> userproductList = new ArrayList<Userproduct>();
		String[] idArray = request.getParameter("ids").split(",");
		if (idArray == null || idArray.length < 1) {
			pageParam.setReturninfo(getMessage("page.select.empty"));
			return add_batchpreauthorize_Init(pageParam,query_product);
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Userproduct userproduct = new Userproduct();
				userproduct.setProductid(productDao.findById(Integer.parseInt(idArray[i])).getProductid());
				userproduct.setType("1");//（1-产品；2-业务；3-事件）
				userproduct.setStarttime(starttime);
				userproduct.setEndtime(endtime);
				userproductList.add(userproduct);
			}
		}
		caCommandParam.setUserproductlist(userproductList);
		caCommandParam.setAddressingmode(addressing_mode);
		caCommandParam.setNetid(Integer.valueOf(query_product.getQuerynetid()));
		caCommandParam.setVersiontype(pageParam.getVersiontype());

		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String cardid = pageParam.getCardid();
				caCommandParam.setCardid(cardid);
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String stbno = pageParam.getStbno();
				caCommandParam.setStbno(stbno);
			}
			//发送授权指令
			authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
			
		} else if (addressing_mode.equals("1")) {

			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String startcardid = pageParam.getStartcardid();
				String endcardid = pageParam.getEndcardid();
				long min = Long.valueOf(startcardid);
				long max = Long.valueOf(endcardid);
				for (long index = min; index <= max; index++) {
					String cardid = String.valueOf(index);
				    caCommandParam.setCardid(cardid);
				    //发送授权指令
					authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
				}
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String startstbno = pageParam.getStartstbno();
				String endstbno = pageParam.getEndstbno();
				long min = Long.parseLong(startstbno, 16);//16进制机顶盒号转换成long
				long max = Long.parseLong(endstbno, 16);//16进制机顶盒号转换成long
				for (long index = min; index <= max; index++) {
					String stbno = Long.toHexString(index);//long转换成16进制机顶盒号
				    caCommandParam.setStbno(stbno);
				    //发送授权指令
					authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
				}
			}
		} else if (addressing_mode.equals("2")) {//文件导入
			// 得到页面上传的临时文件
			// XML上传服务器流文件
			String filename = file.getOriginalFilename();
			if (filename == null || "".equals(filename)) {
				pageParam.setReturninfo(getMessage("uploadify.filename.null"));
				return add_batchpreauthorize_Init(pageParam,query_product);
			}
			// 文件类型
			String[] strArray = filename.split("[.]");
			String type = strArray[strArray.length - 1];
			if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
				pageParam.setReturninfo(getMessage("uploadify.filetype.error"));
				return add_batchpreauthorize_Init(pageParam,query_product);
			}
			
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
			File tmpFile = new File(fullpath);
			try {
				file.transferTo(tmpFile);
				FileInputStream fis = new FileInputStream(tmpFile);
				if("xls".equals(type)||"XLS".equals(type)){//xls文件处理
					HSSFWorkbook excel = new HSSFWorkbook(fis);
					HSSFSheet sheet0 = excel.getSheetAt(0);
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    caCommandParam.setCardid(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    caCommandParam.setStbno(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							}
						}
					}
				}else{//xlsx文件处理
					XSSFWorkbook excel = new XSSFWorkbook(fis);
					XSSFSheet sheet0 = excel.getSheetAt(0);
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    caCommandParam.setCardid(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    caCommandParam.setStbno(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							}
						}
					}
				}
				
				/*HSSFSheet sheet0 = excel.getSheetAt(0);
				
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					
					//获取机顶盒号
					Cell cell0 = row.getCell(0);
					String terminalid_val = this.cellValue(cell0);
					if (StringUtils.isNotEmpty(terminalid_val)) {
						//普安服务器
						if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						    caCommandParam.setCardid(terminalid_val);
						    //发送授权指令
							authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
						//高安服务器
						}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						    caCommandParam.setStbno(terminalid_val);
						    //发送授权指令
							authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
						}
					}
				}*/	
			} catch (IllegalStateException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchpreauthorize_Init(pageParam,query_product);
			} catch (IOException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchpreauthorize_Init(pageParam,query_product);
			}
			
		} else if (addressing_mode.equals("3")) { //表格选择
			
			String[] terminalidArray = request.getParameter("terminalids").split(",");
			if (terminalidArray == null || terminalidArray.length < 1) {
				pageParam.setReturninfo(getMessage("user.terminalid.empty"));
				return add_batchpreauthorize_Init(pageParam,query_product);
			} else {
				for (int i = 0; i < terminalidArray.length; i++) {
					//普安服务器
					if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						caCommandParam.setCardid(terminalidArray[i]);
					//高安服务器
					}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						caCommandParam.setStbno(terminalidArray[i]);
					}
					//发送授权指令
					authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
				}
			}
			
		}
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return add_batchpreauthorize_Init(pageParam,query_product);
	}
	
	/**
	 * 新邮件指令
	 * @param Caspnnewemail
	 * @return
	 */
	@RequestMapping(value = "/find_newemail_List")
	public String find_newemail_List(Caspnnewemail form) {
		caspnnewemailDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnnewemailDao.findByCount(form));
		form.setCasemaillist(caspnnewemailDao.findByList(form));
		return "cascommand/find_newemail_List";
	}

	@RequestMapping(value = "/add_newemail_Init")
	public String add_newemail_Init(Caspnnewemail form) {
		return "cascommand/add_newemail_Init";
	}
	
	@RequestMapping(value = "/add_newemail_Info")
	public String add_newemail_Info(Caspnnewemail form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_newemail_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_newemail_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_newemail")
	public String send_newemail(Caspnnewemail form, HttpServletRequest request) {
		// 先把new mail存入数据库，获得其递增的emailid
		form.setEmailoper("0");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}
		caspnnewemailDao.save(form);
		System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_newemail(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_newemail_Info(form);
	}

	@RequestMapping(value = "/send_cancel_newemail")
	public String send_cancel_newemail(Caspnnewemail form) {
		Caspnnewemail cancelCaspnnewemail = caspnnewemailDao.findById(form.getId());
		cancelCaspnnewemail.setEmailoper("1"); //    0:添加 1：删除
		//发送授权指令
		authorizeService.saveAuthorize_newemail(cancelCaspnnewemail);
		caspnnewemailDao.delete(form.getId());

		form.setReturninfo(getMessage("page.execution.success"));
		return find_newemail_List(form);
	}

	@RequestMapping(value = "/delete_newemail")
	public String delete_newemail(Caspnnewemail form) {
		caspnnewemailDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_newemail_List(form);
	}
	
	
	
	/**
	 * 强制OSD
	 * @param Caspnforcedosd
	 * @return
	 */
	@RequestMapping(value = "/find_forcedosd_List")
	public String find_forcedosd_List(Caspnforcedosd form) {
		caspnforcedosdDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnforcedosdDao.findByCount(form));
		form.setCaspnforcedosdlist(caspnforcedosdDao.findByList(form));
		return "cascommand/find_forcedosd_List";
	}

	@RequestMapping(value = "/add_forcedosd_Init")
	public String add_forcedosd_Init(Caspnforcedosd form) {
		return "cascommand/add_forcedosd_Init";
	}
	
	@RequestMapping(value = "/add_forcedosd_Info")
	public String add_forcedosd_Info(Caspnforcedosd form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_forcedosd_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_forcedosd_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_forcedosd")
	public String send_forcedosd(Caspnforcedosd form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			String stylevalue =  "";
			if("0".equals(form.getStyle())){
				stylevalue = form.getScroll_direction();
			}else{
				stylevalue = form.getScalerelativetoscreen();
			}
			form.setStylevalue(stylevalue); 
		}
		
		caspnforcedosdDao.save(form);
		System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_forcedosd(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_forcedosd_Info(form);
	}

	@RequestMapping(value = "/send_cancel_forcedosd")
	public String send_cancel_forcedosd(Caspnforcedosd form) {
		Caspnforcedosd cancelCaspnforcedosd = caspnforcedosdDao.findById(form.getId());
		cancelCaspnforcedosd.setIscontrol("0"); //   1：启动，0：取消
		
		//发送授权指令
		authorizeService.saveAuthorize_forcedosd(cancelCaspnforcedosd);
		caspnforcedosdDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_forcedosd_List(form);
	}

	@RequestMapping(value = "/delete_forcedosd")
	public String delete_forcedosd(Caspnforcedosd form) {
		caspnforcedosdDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_forcedosd_List(form);
	}
	
	/**
	 * 新版指纹显示
	 * @param Caspnnewfinger
	 * @return
	 */
	@RequestMapping(value = "/find_newfinger_List")
	public String find_newfinger_List(Caspnnewfinger form) {
		caspnnewfingerDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnnewfingerDao.findByCount(form));
		form.setCaspnnewfingerlist(caspnnewfingerDao.findByList(form));
		return "cascommand/find_newfinger_List";
	}

	@RequestMapping(value = "/add_newfinger_Init")
	public String add_newfinger_Init(Caspnnewfinger form) {
		return "cascommand/add_newfinger_Init";
	}
	
	@RequestMapping(value = "/add_newfinger_Info")
	public String add_newfinger_Info(Caspnnewfinger form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_newfinger_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_newfinger_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_newfinger")
	public String send_newfinger(Caspnnewfinger form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		caspnnewfingerDao.save(form);
	//	System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_newfinger(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_newfinger_Info(form);
	}

	@RequestMapping(value = "/send_cancel_newfinger")
	public String send_cancel_newfinger(Caspnnewfinger form) {
		Caspnnewfinger cancelCaspnnewfinger = caspnnewfingerDao.findById(form.getId());
		cancelCaspnnewfinger.setIscontrol("0"); //   1：启动，0：取消
		
		//发送授权指令
		authorizeService.saveAuthorize_newfinger(cancelCaspnnewfinger);
		caspnnewfingerDao.delete(form.getId());

		form.setReturninfo(getMessage("page.execution.success"));
		return find_newfinger_List(form);
	}

	@RequestMapping(value = "/delete_newfinger")
	public String delete_newfinger(Caspnnewfinger form) {
		caspnnewfingerDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_newfinger_List(form);
	}
	
	
	/**
	 * 强制换台
	 * @param Caspnforcedcc
	 * @return
	 */
	@RequestMapping(value = "/find_forcedcc_List")
	public String find_forcedcc_List(Caspnforcedcc form) {
		caspnforcedccDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnforcedccDao.findByCount(form));
		form.setCaspnforcedcclist(caspnforcedccDao.findByList(form));
		return "cascommand/find_forcedcc_List";
	}

	@RequestMapping(value = "/add_forcedcc_Init")
	public String add_forcedcc_Init(Caspnforcedcc form) {
		return "cascommand/add_forcedcc_Init";
	}
	
	@RequestMapping(value = "/add_forcedcc_Info")
	public String add_forcedcc_Info(Caspnforcedcc form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_forcedcc_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_forcedcc_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_forcedcc")
	public String send_forcedcc(Caspnforcedcc form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			//cardid随意填写，但必须填
			form.setCardid("00000000"); 
			//封装流信息
			String[] componentArray = request.getParameterValues("streamcontent");
			ArrayList<HashMap <String,Object>> programComponentInfo =  new ArrayList<HashMap<String,Object>>();
			if (componentArray != null) {
				for (int i = 0; i < componentArray.length; i++) {
					HashMap<String, Object> component = new HashMap<String, Object>();
					component.put("StreamContent", componentArray[i]);
					component.put("CompType", request.getParameterValues("comptype")[i]);
					component.put("CompPID", request.getParameterValues("compid")[i]);
					component.put("ECMPID", request.getParameterValues("ecmpid")[i]);
					programComponentInfo.add(component);
				}
				form.setProgramComponentInfo(programComponentInfo);
			}
			
			//封装DVB_Info
			HashMap <String,Object> DVBInfo =new HashMap<String, Object>();
			if("00".equals(form.getStbtype())){
				//dvbc
				DVBInfo.put("Frequency", request.getParameter("frequency_c"));
				DVBInfo.put("FEC_outer", request.getParameter("fecouter_c"));
				DVBInfo.put("Modulation", request.getParameter("modulation_c"));
				DVBInfo.put("symbol_rate", request.getParameter("symbolrate_c"));
				DVBInfo.put("FEC_inner", request.getParameter("fecinner_c"));
			}else if("01".equals(form.getStbtype())){
				//dvbs
				DVBInfo.put("Frequency", request.getParameter("frequency_s"));
				DVBInfo.put("orbital_position", request.getParameter("orbital_position"));
				DVBInfo.put("west_east_flag", request.getParameter("west_east_flag"));
				DVBInfo.put("polarization", request.getParameter("polarization"));
				DVBInfo.put("modulation", request.getParameter("modulation_s"));
				DVBInfo.put("symbol_rate", request.getParameter("symbolrate_s"));
				DVBInfo.put("FEC_inner", request.getParameter("fecinner_s"));
			}
			form.setDVBInfo(DVBInfo);
		}
		
		caspnforcedccDao.save(form);
		
		System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_forcedcc(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_forcedcc_Info(form);
	}

	@RequestMapping(value = "/send_cancel_forcedcc")
	public String send_cancel_forcedcc(Caspnforcedcc form) {
		Caspnforcedcc cancelCaspnforcedcc = caspnforcedccDao.findById(form.getId());
		cancelCaspnforcedcc.setIscontrol("0"); //   1：启动，0：取消
		//发送授权指令
		authorizeService.saveAuthorize_forcedcc(cancelCaspnforcedcc);
		caspnforcedccDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_forcedcc_List(form);
	}

	@RequestMapping(value = "/delete_forcedcc")
	public String delete_forcedcc(Caspnforcedcc form) {
		caspnforcedccDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_forcedcc_List(form);
	}
	
	/**
	 * 指定机顶盒默认开机节目
	 * @param Stbdefaultmsg
	 * @return
	 */

	@RequestMapping(value = "/add_stbdefaultmsg_Init")
	public String add_stbdefaultmsg_Init(Stbdefaultmsg form) {
		return "cascommand/add_stbdefaultmsg_Init";
	}
	
	@RequestMapping(value = "/add_stbdefaultmsg_Info")
	public String add_stbdefaultmsg_Info(Stbdefaultmsg form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_stbdefaultmsg_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_stbdefaultmsg_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_stbdefaultmsg")
	public String send_stbdefaultmsg(Stbdefaultmsg form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			String[] componentArray = request.getParameterValues("streamcontent");
			ArrayList<HashMap <String,Object>> programComponentInfo =  new ArrayList<HashMap<String,Object>>();
			if (componentArray != null) {
				for (int i = 0; i < componentArray.length; i++) {
					HashMap<String, Object> component = new HashMap<String, Object>();
					component.put("StreamContent", componentArray[i]);
					component.put("CompType", request.getParameterValues("comptype")[i]);
					component.put("CompPID", request.getParameterValues("compid")[i]);
					component.put("ECMPID", request.getParameterValues("ecmpid")[i]);
					programComponentInfo.add(component);
				}
				form.setProgramComponentInfo(programComponentInfo);
			}
			
			HashMap <String,Object> DVBInfo =new HashMap<String, Object>();
			if("00".equals(form.getStbtype())){
				//dvbc
				DVBInfo.put("Frequency", request.getParameter("frequency_c"));
				DVBInfo.put("FEC_outer", request.getParameter("fecouter_c"));
				DVBInfo.put("Modulation", request.getParameter("modulation_c"));
				DVBInfo.put("symbol_rate", request.getParameter("symbolrate_c"));
				DVBInfo.put("FEC_inner", request.getParameter("fecinner_c"));
			}else if("01".equals(form.getStbtype())){
				//dvbs
				DVBInfo.put("Frequency", request.getParameter("frequency_s"));
		//		System.out.println("***************frequencys:" + DVBInfo.get("frequency_s"));
				DVBInfo.put("orbital_position", request.getParameter("orbital_position"));
				DVBInfo.put("west_east_flag", request.getParameter("west_east_flag"));
				DVBInfo.put("polarization", request.getParameter("polarization"));
				DVBInfo.put("modulation", request.getParameter("modulation_s"));
				DVBInfo.put("symbol_rate", request.getParameter("symbolrate_s"));
				DVBInfo.put("FEC_inner", request.getParameter("fecinner_s"));
			}
			form.setDVBInfo(DVBInfo);
		}
		//caspnstbdefaultmsgDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_stbdefaultmsg(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_stbdefaultmsg_Info(form);
	}
	
	/**
	 * 强制重启
	 * @param Forcedrestart
	 * @return
	 */

	@RequestMapping(value = "/add_forcedrestart_Init")
	public String add_forcedrestart_Init(Forcedrestart form) {
		return "cascommand/add_forcedrestart_Init";
	}
	
	@RequestMapping(value = "/add_forcedrestart_Info")
	public String add_forcedrestart_Info(Forcedrestart form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_forcedrestart_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_forcedrestart_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_forcedrestart")
	public String send_forcedrestart(Forcedrestart form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspnforcedrestartDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_forcedrestart(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_forcedrestart_Info(form);
	}
	
	/**
	 * 重新搜索节目
	 * @param Researchprogram
	 * @return
	 */

	@RequestMapping(value = "/add_researchprogram_Init")
	public String add_researchprogram_Init(Researchprogram form) {
		return "cascommand/add_researchprogram_Init";
	}
	
	@RequestMapping(value = "/add_researchprogram_Info")
	public String add_researchprogram_Info(Researchprogram form) {
		// 构建网络Map对象
				List<Network> list = networkDao.queryByList(new Network());
				Map<Integer, String> map = new HashMap<Integer, String>();
				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					Network network = (Network) iterator.next();
					map.put(network.getId(), network.getNetname());
				}
				form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_researchprogram_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_researchprogram_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_researchprogram")
	public String send_researchprogram(Researchprogram form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspnresearchprogramDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_researchprogram(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_researchprogram_Info(form);
	}
	
	/**
	 * PVA再授权
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_pvrauthemm_Init")
	public String add_pvrauthemm_Init(CaCommandParam form) {
		return "cascommand/add_pvrauthemm_Init";
	}
	
	@RequestMapping(value = "/add_pvrauthemm_Info")
	public String add_pvrauthemm_Info(PvrAuthEmm form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_pvrauthemm_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_pvrauthemm_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_pvrauthemm")
	public String send_pvrauthemm(PvrAuthEmm form) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("0");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspnpvrauthemmDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_pvrauthemm(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_pvrauthemm_Info(form);
	}
	
	/**
	 * 机顶盒黑名单
	 * @param Caspnforcedcc
	 * @return
	 */
	@RequestMapping(value = "/find_blackstb_List")
	public String find_blackstb_List(Caspnblackstb form) {
		caspnblackstbDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnblackstbDao.findByCount(form));
		form.setCaspnblackstblist(caspnblackstbDao.findByList(form));
		return "cascommand/find_blackstb_List";
	}

	@RequestMapping(value = "/add_blackstb_Init")
	public String add_blackstb_Init(Caspnblackstb form) {
		return "cascommand/add_blackstb_Init";
	}
	
	@RequestMapping(value = "/add_blackstb_Info")
	public String add_blackstb_Info(Caspnblackstb form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_blackstb_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_blackstb_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_blackstb")
	public String send_blackstb(Caspnblackstb form) {
		
		// 先存入数据库，获得其递增的id
		form.setOperatorType("0");   // 添加删除（0：添加，2：删除）
		form.setAddtime(Tools.getCurrentTime());
		
		//保存机顶盒黑名单
		caspnblackstbDao.save(form);
		
		//保存智能卡黑名单
		String cardids = form.getCardids();
		String[] array = cardids.split(",");
		List<String> cardidList = new ArrayList<String>(Arrays.asList(array));
		//初始化机顶盒黑名单智能卡号
		form.setBlackStbCardidList(cardidList);
		
		for(String save_black_cardid :  cardidList){
			Caspnblackcard black_card = new Caspnblackcard();
			black_card.setCardid(save_black_cardid);
			black_card.setRemark(String.valueOf(form.getId()));
			black_card.setNetid(form.getNetid());
			black_card.setVersiontype(form.getVersiontype());
			black_card.setAddtime(Tools.getCurrentTime());
			black_card.setStbno(form.getStbno());
			System.out.println("*********************remark" +black_card.getRemark());
			caspnblackcardDao.save(black_card);
		}
		
		// 解绑未选中的智能卡
		String unselectedcardids = form.getUnselectedcardids();
		if(unselectedcardids != null && !("".equals(unselectedcardids))){
			String[] unselected = unselectedcardids.split(",");
			for(String card_to_cancel : unselected){
				System.out.println("here to delete cardid:" +  card_to_cancel);
				Usercard cancelusercard = usercardDao.findByCardidStr(card_to_cancel);		
				if(cancelusercard!=null && "0".equals(cancelusercard.getIncardflag())){
					cancelusercard.setStbno("");//外置卡解除机卡绑定关系
					usercardDao.updateStbno(cancelusercard);
				}
			}
		}
		
		System.out.println("**************id**************: " + form.getId());
		
		//发送机顶盒黑名单指令
		authorizeService.saveAuthorize_blackstb(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_blackstb_Info(form);
	}

	@RequestMapping(value = "/send_cancel_blackstb")
	public String send_cancel_blackstb(Caspnblackstb form) {
		//查询出该机顶盒黑名单信息
		Caspnblackstb cancelCaspnblackstb = caspnblackstbDao.findById(form.getId());
		cancelCaspnblackstb.setOperatorType("2");   // 添加删除（0：添加，2：删除）
		
		//删除机顶盒黑名单
		caspnblackstbDao.delete(form.getId());
		
		//发送黑名单取消指令
		authorizeService.saveAuthorize_blackstb(cancelCaspnblackstb);
		
		//删除绑定的智能卡黑名单
		String[] cardidarray = cancelCaspnblackstb.getCardids().split(",");
		List<String> cardidList = new ArrayList<String>(Arrays.asList(cardidarray));
		cancelCaspnblackstb.setBlackStbCardidList(cardidList);
		for(String cardid : cardidList){
			Caspnblackcard blackcard_finder = new Caspnblackcard();
			blackcard_finder.setCardid(cardid);
			caspnblackcardDao.deleteByCardid(blackcard_finder);
			
			//发送开卡指令
			Usercard usercard = usercardDao.findByCardidStr(cardid);
			if(usercard != null){
				authorizeService.saveAuthorize_stopAndOnCard(usercard,"1");
			}
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return find_blackstb_List(form);
	}

	@RequestMapping(value = "/delete_blackstb")
	public String delete_blackstb(Caspnblackstb form) {
		caspnblackstbDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_blackstb_List(form);
	}
	
	
	/**
	 * 智能卡黑名单
	 * @param Caspnblackcard
	 * @return
	 */
	@RequestMapping(value = "/find_blackcard_List")
	public String find_blackcard_List(Caspnblackcard form) {
		caspnblackcardDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnblackcardDao.findByCount(form));
		form.setCaspnblackcardlist(caspnblackcardDao.findByList(form));
		return "cascommand/find_blackcard_List";
	}

	@RequestMapping(value = "/add_blackcard_Init")
	public String add_blackcard_Init(Caspnblackcard form) {
		return "cascommand/add_blackcard_Init";
	}
	
	@RequestMapping(value = "/add_blackcard_Info")
	public String add_blackcard_Info(Caspnblackcard form) {
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_blackcard_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_blackcard_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_blackcard")
	public String send_blackcard(Caspnblackcard form) {
		
		// 先存入数据库，获得其递增的id
		form.setOperatorType("0");   // 添加删除（0：添加，2：删除）
		form.setAddtime(Tools.getCurrentTime());
		
		//保存机顶盒黑名单
		caspnblackcardDao.save(form);
		
		System.out.println("**************id**************: " + form.getId());
		
		//发送智能卡黑名单指令
		authorizeService.saveAuthorize_blackcard(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_blackcard_Info(form);
	}

	@RequestMapping(value = "/send_cancel_blackcard")
	public String send_cancel_blackcard(Caspnblackcard form) {
		//查询出该机顶盒黑名单信息
		Caspnblackcard cancelCaspnblackcard = caspnblackcardDao.findById(form.getId());
		cancelCaspnblackcard.setOperatorType("2");   // 添加删除（0：添加，2：删除）
		
		//删除智能卡黑名单
		caspnblackcardDao.delete(form.getId());
				
		//发送智能卡黑名单取消指令
		authorizeService.saveAuthorize_blackcard(cancelCaspnblackcard);
		
		//发送开卡指令
		Usercard usercard = usercardDao.findByCardidStr(cancelCaspnblackcard.getCardid());
		if(usercard != null){
			authorizeService.saveAuthorize_stopAndOnCard(usercard,"1");
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return find_blackcard_List(form);
	}

	@RequestMapping(value = "/delete_blackcard")
	public String delete_blackcard(Caspnblackcard form) {
		caspnblackcardDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_blackcard_List(form);
	}
	
	
	/**
	 * 重置Pin码
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_resetpincode_Init")
	public String add_resetpincode_Init(CaCommandParam form) {
		return "cascommand/add_resetpincode_Init";
	}
	
	@RequestMapping(value = "/add_resetpincode_Info")
	public String add_resetpincode_Info(CaCommandParam form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_resetpincode_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_resetpincode_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_resetpincode")
	public String send_resetpincode(CaCommandParam form) {
		// 先存入数据库，获得其递增的id
		//form.setIscontrol("1");   // 0:添加 1：删除
		//form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("0");//高安是单播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspnresetpincodeDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_resetpincode(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_resetpincode_Info(form);
	}
	
	
	/**
	 * 清除Pin码
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_cleanpincode_Init")
	public String add_cleanpincode_Init(CaCommandParam form) {
		return "cascommand/add_cleanpincode_Init";
	}
	
	@RequestMapping(value = "/add_cleanpincode_Info")
	public String add_cleanpincode_Info(CaCommandParam form) {
		// 构建网络Map对象
				List<Network> list = networkDao.queryByList(new Network());
				Map<Integer, String> map = new HashMap<Integer, String>();
				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					Network network = (Network) iterator.next();
					map.put(network.getId(), network.getNetname());
				}
				form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_cleanpincode_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_cleanpincode_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_cleanpincode")
	public String send_cleanpincode(CaCommandParam form) {
		// 先存入数据库，获得其递增的id
		//form.setIscontrol("1");   // 0:添加 1：删除
		//form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("0");//高安是单播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspncleanpincodeDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_cleanpincode(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_cleanpincode_Info(form);
	}
	
	/**
	 * 删除错误发卡指令
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_deleteerrcard_Init")
	public String add_deleteerrcard_Init(CaCommandParam form) {
		return "cascommand/add_deleteerrcard_Init";
	}
	
	@RequestMapping(value = "/add_deleteerrcard_Info")
	public String add_deleteerrcard_Info(CaCommandParam form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_deleteerrcard_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_deleteerrcard_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_deleteerrcard")
	public String send_deleteerrcard(CaCommandParam form) {
		// 先存入数据库，获得其递增的id
		//form.setIscontrol("1");   // 0:添加 1：删除
		//form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("0");//高安是单播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspndeleteerrcardDao.save(form);
		
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_deleteerrcard(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_deleteerrcard_Info(form);
	}
	
	/**
	 * 批量授权指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/add_batchauthorize_Init")
	public String add_batchauthorize_Init(AuthorizeParamForPages pageParam,Product query_product) {
		// 构建上级网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		query_product.setNetworklist(networklist);
		//pageParam.setProduct(query_product);
		return "cascommand/add_batchauthorize";
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryUserterminalList")
	public Map<String, Object> queryUserterminalList(Stb form,int rows,int page) {
		
		//返回给页面的json数据
		Map<String, Object> json = new HashMap<String, Object>(); 
		int total = 0;//默认查询总数为0
		List<HashMap<String, Object>> terminalList = new ArrayList<HashMap<String, Object>>();
		String queryversiontype = form.getQueryversiontype();
		
		//查询网络信息
		Network network = networkDao.findById(Integer.valueOf(form.getQuerynetid()));
		//查询服务器信息
		Server serverform = new Server();
		serverform.setServertype("cas");
		serverform.setNetid(Integer.valueOf(form.getQuerynetid()));
		serverform.setVersiontype(queryversiontype);
		serverform = serverDao.findByServertypeAndVersiontype(serverform);
		if(serverform == null){
			serverform = new Server();
		}
		
		if("gos_pn".equals(queryversiontype)){//普安服务器，查询智能卡
			Usercard usercardForm = new Usercard();
			usercardForm.setQuerynetid(form.getQuerynetid());
			usercardForm.setQueryserverid(String.valueOf(serverform.getId()));
			usercardForm.setPager_offset(rows*(page-1));
			usercardForm.setPager_openset(rows);
			
			total = usercardDao.findByCount(usercardForm);
			List<Usercard> usercardlist = usercardDao.findByList(usercardForm);
			for (Usercard usercard : usercardlist) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				objectMap.put("id", usercard.getCardid());
				objectMap.put("netname", network!=null ? network.getNetname() : "");
				objectMap.put("terminalid", usercard.getCardid());  
				objectMap.put("terminaltype", "1");  
				terminalList.add(objectMap);
			}
		}else if("gos_gn".equals(queryversiontype)){//高安服务器，查询机顶盒
			Userstb userstbform = new Userstb();
			userstbform.setQuerynetid(form.getQuerynetid());
			userstbform.setQueryserverid(String.valueOf(serverform.getId()));
			userstbform.setPager_offset(rows*(page-1));
			userstbform.setPager_openset(rows);
			total =userstbDao.findByCount(userstbform);
			List<Userstb> userstblist = userstbDao.findByList(userstbform);
			for (Userstb userstb : userstblist) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				objectMap.put("id", userstb.getStbno());
				objectMap.put("netname", network!=null ? network.getNetname() : "");
				objectMap.put("terminalid", userstb.getStbno());  
				objectMap.put("terminaltype", "0");  
				terminalList.add(objectMap);
			}
		}
		json.put("total", total);
		json.put("rows", terminalList);
		return json;
	}
	
	
	/**
	 * 保存批量授权指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/send_batchauthorize")
	public String send_batchauthorize(AuthorizeParamForPages pageParam, HttpServletRequest request ,Product query_product, @RequestParam("uploadfile") MultipartFile file) {
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		
		List<Usercard> usercardlist = new ArrayList<Usercard>();
		List<Userstb> userstblist = new ArrayList<Userstb>();
		
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		//caCommandParam.setVersiontype("gos_pn");
		//caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		String starttime = pageParam.getStarttime() + " 00:00:00";
		String endtime = pageParam.getEndtime() + " 23:59:59";
		
		/***************************** 封装userproduct ****************************/
		List<Userproduct> userproductList = new ArrayList<Userproduct>();
		String[] idArray = request.getParameter("ids").split(",");
		if (idArray == null || idArray.length < 1) {
			pageParam.setReturninfo(getMessage("page.select.empty"));
			return add_batchauthorize_Init(pageParam,query_product);
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Userproduct userproduct = new Userproduct();
				Product product = productDao.findById(Integer.parseInt(idArray[i]));
				userproduct.setProductid(product.getProductid());
				userproduct.setProductname(product.getProductname());
				userproduct.setType("1");//（1-产品；2-业务；3-事件）
				userproduct.setStarttime(starttime);
				userproduct.setEndtime(endtime);
				userproductList.add(userproduct);
			}
		}
		caCommandParam.setUserproductlist(userproductList);
		caCommandParam.setAddressingmode(addressing_mode);
		caCommandParam.setNetid(Integer.valueOf(query_product.getQuerynetid()));
		caCommandParam.setVersiontype(pageParam.getVersiontype()); 
		
		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String cardid = pageParam.getCardid();
				//查询该智能卡购买信息
				Usercard usercard = usercardDao.findByCardidStr(cardid);
				if(usercard ==null){//智能卡还未出售
					pageParam.setReturninfo(getMessage("authorize.batchsendcard.cardnosell"));
					return add_batchauthorize_Init(pageParam,query_product);
				}
				caCommandParam.setCardid(cardid);
				//发送授权指令
				authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
				
				//封装订户智能卡
				usercardlist.add(usercard);
				
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String stbno = pageParam.getStbno();
				//查询该机顶盒购买信息
				Userstb userstb = userstbDao.findByStbnoStr(stbno);
				if(userstb ==null){//机顶盒还未出售
					pageParam.setReturninfo(getMessage("authorize.batchsendcard.cardnosell"));
					return add_batchauthorize_Init(pageParam,query_product);
				}
				caCommandParam.setStbno(stbno);
				
				//发送授权指令
				authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
				
				//封装订户机顶盒
				userstblist.add(userstb);
				
			}
			
			
		} else if (addressing_mode.equals("1")) {//卡号段

			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String startcardid = pageParam.getStartcardid();
				String endcardid = pageParam.getEndcardid();
				long min = Integer.valueOf(startcardid);
				long max = Integer.valueOf(endcardid);
				for (long index = min; index <= max; index++) {
					String cardid = String.valueOf(index);
					
					//查询该智能卡购买信息
					Usercard usercard = usercardDao.findByCardidStr(cardid);
					if(usercard ==null){//智能卡还未出售
						continue;
					}
					
				    caCommandParam.setCardid(cardid);
				    //发送授权指令
					authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
					
					//封装订户智能卡
					usercardlist.add(usercard);
					
				}
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String startstbno = pageParam.getStartstbno();
				String endstbno = pageParam.getEndstbno();
				long min = Long.parseLong(startstbno, 16);//16进制机顶盒号转换成long
				long max = Long.parseLong(endstbno, 16);//16进制机顶盒号转换成long
				for (long index = min; index <= max; index++) {
					String stbno = Long.toHexString(index);//long转换成16进制机顶盒号
					
					//查询该机顶盒购买信息
					Userstb userstb = userstbDao.findByStbnoStr(stbno);
					if(userstb ==null){//机顶盒还未出售
						continue;
					}
					
				    caCommandParam.setStbno(stbno);
				    //发送授权指令
					authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
					
					//封装订户机顶盒
					userstblist.add(userstb);
					
				}
			}
		} else if (addressing_mode.equals("2")) {//文件导入
			// 得到页面上传的临时文件
			// XML上传服务器流文件
			String filename = file.getOriginalFilename();
			if (filename == null || "".equals(filename)) {
				pageParam.setReturninfo(getMessage("uploadify.filename.null"));
				return add_batchauthorize_Init(pageParam,query_product);
			}
			// 文件类型
			String[] strArray = filename.split("[.]");
			String type = strArray[strArray.length - 1];
			if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
				pageParam.setReturninfo(getMessage("uploadify.filetype.error"));
				return add_batchauthorize_Init(pageParam,query_product);
			}
			
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
			File tmpFile = new File(fullpath);
			try {
				file.transferTo(tmpFile);
				FileInputStream fis = new FileInputStream(tmpFile);
				if("xls".equals(type) || "XLS".equals(type)){
					HSSFWorkbook excel = new HSSFWorkbook(fis);
					HSSFSheet sheet0 = excel.getSheetAt(0);
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
								
								caCommandParam.setCardid(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
								caCommandParam.setStbno(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}	
				}else{
					XSSFWorkbook excel = new XSSFWorkbook(fis);
					XSSFSheet sheet0 = excel.getSheetAt(0);
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
								
								caCommandParam.setCardid(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
								caCommandParam.setStbno(terminalid_val);
							    //发送授权指令
								authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}	
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchauthorize_Init(pageParam,query_product);
			} catch (IOException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchauthorize_Init(pageParam,query_product);
			}
			
		} else if (addressing_mode.equals("3")) { //表格选择
			
			String[] terminalidArray = request.getParameter("terminalids").split(",");
			if (terminalidArray == null || terminalidArray.length < 1) {
				pageParam.setReturninfo(getMessage("user.terminalid.empty"));
				return add_batchauthorize_Init(pageParam,query_product);
			} else {
				for (int i = 0; i < terminalidArray.length; i++) {
					//普安服务器
					if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						
						//查询该智能卡购买信息
						Usercard usercard = usercardDao.findByCardidStr(terminalidArray[i]);
						if(usercard ==null){//智能卡还未出售
							continue;
						}
						
						caCommandParam.setCardid(terminalidArray[i]);
						//发送授权指令
						authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
						
						//封装订户智能卡
						usercardlist.add(usercard);
						
					//高安服务器
					}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						
						//查询该机顶盒购买信息
						Userstb userstb = userstbDao.findByStbnoStr(terminalidArray[i]);
						if(userstb ==null){//机顶盒还未出售
							continue;
						}
						
						caCommandParam.setStbno(terminalidArray[i]);
						//发送授权指令
						authorizeService.saveAuthorize_batchpreauthorize(caCommandParam);
						
						//封装订户机顶盒
						userstblist.add(userstb);
						
					}
					
				}
			}
			
		}
		
		//保存产品、业务信息的参数
		Batchcmd batchcmd = new Batchcmd();
		batchcmd.setOperator(operator);//封装操作员信息
		batchcmd.setUserproductList(userproductList);
		batchcmd.setVersiontype(pageParam.getVersiontype());
		batchcmd.setUsercardlist(usercardlist);
		batchcmd.setUserstblist(userstblist);
		batchcmd.setBusinesstypekey("buyproduct");
		batchcmd.setBusinesstypename(getMessage("business.type.buyproduct"));
		batchcmdService.saveBatchcmd_authorize(batchcmd);
		
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return add_batchauthorize_Init(pageParam,query_product);
	}
	
	
	/**
	 * 批量关停指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/add_batchstop_Init")
	public String add_batchstop_Init(AuthorizeParamForPages pageParam,Product query_product) {
		// 构建上级网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		query_product.setNetworklist(networklist);
		//pageParam.setProduct(query_product);
		return "cascommand/add_batchstop";
	}
	
	
	/**
	 * 保存批量关停指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/send_batchstop")
	public String send_batchstop(AuthorizeParamForPages pageParam, HttpServletRequest request ,Product query_product, @RequestParam("uploadfile") MultipartFile file) {
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		
		List<Usercard> usercardlist = new ArrayList<Usercard>();
		List<Userstb> userstblist = new ArrayList<Userstb>();
		
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		//caCommandParam.setVersiontype("gos_pn");
		//caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		
		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String cardid = pageParam.getCardid();
				//查询该智能卡购买信息
				Usercard usercard = usercardDao.findByCardidStr(cardid);
				if(usercard ==null){//智能卡还未出售
					pageParam.setReturninfo(getMessage("page.execution.failure"));
					return add_batchstop_Init(pageParam,query_product);
				}
				//封装订户智能卡
				usercardlist.add(usercard);
				
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String stbno = pageParam.getStbno();
				//查询该机顶盒购买信息
				Userstb userstb = userstbDao.findByStbnoStr(stbno);
				if(userstb ==null){//机顶盒还未出售
					pageParam.setReturninfo(getMessage("page.execution.failure"));
					return add_batchstop_Init(pageParam,query_product);
				}
				
				//封装订户机顶盒
				userstblist.add(userstb);
				
			}
			
			
		} else if (addressing_mode.equals("1")) {//卡号段

			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String startcardid = pageParam.getStartcardid();
				String endcardid = pageParam.getEndcardid();
				long min = Integer.valueOf(startcardid);
				long max = Integer.valueOf(endcardid);
				for (long index = min; index <= max; index++) {
					String cardid = String.valueOf(index);
					
					//查询该智能卡购买信息
					Usercard usercard = usercardDao.findByCardidStr(cardid);
					if(usercard ==null){//智能卡还未出售
						continue;
					}
					
					//封装订户智能卡
					usercardlist.add(usercard);
					
				}
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String startstbno = pageParam.getStartstbno();
				String endstbno = pageParam.getEndstbno();
				long min = Long.parseLong(startstbno, 16);//16进制机顶盒号转换成long
				long max = Long.parseLong(endstbno, 16);//16进制机顶盒号转换成long
				for (long index = min; index <= max; index++) {
					String stbno = Long.toHexString(index);//long转换成16进制机顶盒号
					
					//查询该机顶盒购买信息
					Userstb userstb = userstbDao.findByStbnoStr(stbno);
					if(userstb ==null){//机顶盒还未出售
						continue;
					}
					//封装订户机顶盒
					userstblist.add(userstb);
					
				}
			}
		} else if (addressing_mode.equals("2")) {//文件导入
			// 得到页面上传的临时文件
			// XML上传服务器流文件
			String filename = file.getOriginalFilename();
			if (filename == null || "".equals(filename)) {
				pageParam.setReturninfo(getMessage("uploadify.filename.null"));
				return add_batchstop_Init(pageParam,query_product);
			}
			// 文件类型
			String[] strArray = filename.split("[.]");
			String type = strArray[strArray.length - 1];
			if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
				pageParam.setReturninfo(getMessage("uploadify.filetype.error"));
				return add_batchstop_Init(pageParam,query_product);
			}
			
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
			File tmpFile = new File(fullpath);
			try {
				file.transferTo(tmpFile);
				FileInputStream fis = new FileInputStream(tmpFile);
				if("xls".equals(type) || "XLS".equals(type)){
					HSSFWorkbook excel = new HSSFWorkbook(fis);
					HSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}
				}else{
					XSSFWorkbook excel = new XSSFWorkbook(fis);
					XSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}
				}
					
			} catch (IllegalStateException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchstop_Init(pageParam,query_product);
			} catch (IOException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchstop_Init(pageParam,query_product);
			}
			
		} else if (addressing_mode.equals("3")) { //表格选择
			
			String[] terminalidArray = request.getParameter("terminalids").split(",");
			if (terminalidArray == null || terminalidArray.length < 1) {
				pageParam.setReturninfo(getMessage("user.terminalid.empty"));
				return add_batchstop_Init(pageParam,query_product);
			} else {
				for (int i = 0; i < terminalidArray.length; i++) {
					//普安服务器
					if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						
						//查询该智能卡购买信息
						Usercard usercard = usercardDao.findByCardidStr(terminalidArray[i]);
						if(usercard ==null){//智能卡还未出售
							continue;
						}
						
						//封装订户智能卡
						usercardlist.add(usercard);
						
					//高安服务器
					}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						
						//查询该机顶盒购买信息
						Userstb userstb = userstbDao.findByStbnoStr(terminalidArray[i]);
						if(userstb ==null){//机顶盒还未出售
							continue;
						}
						
						//封装订户机顶盒
						userstblist.add(userstb);
						
					}
					
				}
			}
			
		}
		
		//保存产品、业务信息的参数
		Batchcmd batchcmd = new Batchcmd();
		batchcmd.setOperator(operator);//封装操作员信息
		batchcmd.setVersiontype(pageParam.getVersiontype());
		batchcmd.setUsercardlist(usercardlist);
		batchcmd.setUserstblist(userstblist);
		batchcmd.setBusinesstypekey("pausecard");
		batchcmd.setBusinesstypename(getMessage("business.type.pausecard"));
		batchcmd.setContent(getMessage("business.type.pausecard"));
		batchcmdService.saveBatchcmd_stop(batchcmd);
		
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return add_batchstop_Init(pageParam,query_product);
	}
	
	/**
	 * 批量授权刷新指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/add_batchauthorizerefresh_Init")
	public String add_batchauthorizerefresh_Init(AuthorizeParamForPages pageParam,Product query_product) {
		// 构建上级网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		query_product.setNetworklist(networklist);
		//pageParam.setProduct(query_product);
		return "cascommand/add_batchauthorizerefresh";
	}
	
	
	/**
	 * 保存批量授权刷新指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/send_batchauthorizerefresh")
	public String send_batchauthorizerefresh(AuthorizeParamForPages pageParam, HttpServletRequest request ,Product query_product, @RequestParam("uploadfile") MultipartFile file) {
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		
		List<Usercard> usercardlist = new ArrayList<Usercard>();
		List<Userstb> userstblist = new ArrayList<Userstb>();
		
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		//caCommandParam.setVersiontype("gos_pn");
		//caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		
		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String cardid = pageParam.getCardid();
				//查询该智能卡购买信息
				Usercard usercard = usercardDao.findByCardidStr(cardid);
				if(usercard ==null){//智能卡还未出售
					pageParam.setReturninfo(getMessage("page.execution.failure"));
					return add_batchauthorizerefresh_Init(pageParam,query_product);
				}
				//封装订户智能卡
				usercardlist.add(usercard);
				
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String stbno = pageParam.getStbno();
				//查询该机顶盒购买信息
				Userstb userstb = userstbDao.findByStbnoStr(stbno);
				if(userstb ==null){//机顶盒还未出售
					pageParam.setReturninfo(getMessage("page.execution.failure"));
					return add_batchauthorizerefresh_Init(pageParam,query_product);
				}
				
				//封装订户机顶盒
				userstblist.add(userstb);
				
			}
			
			
		} else if (addressing_mode.equals("1")) {//卡号段

			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String startcardid = pageParam.getStartcardid();
				String endcardid = pageParam.getEndcardid();
				long min = Integer.valueOf(startcardid);
				long max = Integer.valueOf(endcardid);
				for (long index = min; index <= max; index++) {
					String cardid = String.valueOf(index);
					
					//查询该智能卡购买信息
					Usercard usercard = usercardDao.findByCardidStr(cardid);
					if(usercard ==null){//智能卡还未出售
						continue;
					}
					
					//封装订户智能卡
					usercardlist.add(usercard);
					
				}
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String startstbno = pageParam.getStartstbno();
				String endstbno = pageParam.getEndstbno();
				long min = Long.parseLong(startstbno, 16);//16进制机顶盒号转换成long
				long max = Long.parseLong(endstbno, 16);//16进制机顶盒号转换成long
				for (long index = min; index <= max; index++) {
					String stbno = Long.toHexString(index);//long转换成16进制机顶盒号
					
					//查询该机顶盒购买信息
					Userstb userstb = userstbDao.findByStbnoStr(stbno);
					if(userstb ==null){//机顶盒还未出售
						continue;
					}
					//封装订户机顶盒
					userstblist.add(userstb);
					
				}
			}
		} else if (addressing_mode.equals("2")) {//文件导入
			// 得到页面上传的临时文件
			// XML上传服务器流文件
			String filename = file.getOriginalFilename();
			if (filename == null || "".equals(filename)) {
				pageParam.setReturninfo(getMessage("uploadify.filename.null"));
				return add_batchauthorizerefresh_Init(pageParam,query_product);
			}
			// 文件类型
			String[] strArray = filename.split("[.]");
			String type = strArray[strArray.length - 1];
			if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
				pageParam.setReturninfo(getMessage("uploadify.filetype.error"));
				return add_batchauthorizerefresh_Init(pageParam,query_product);
			}
			
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
			File tmpFile = new File(fullpath);
			try {
				file.transferTo(tmpFile);
				FileInputStream fis = new FileInputStream(tmpFile);
				if("xls".equals(type) || "XLS".equals(type)){
					HSSFWorkbook excel = new HSSFWorkbook(fis);
					HSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}
				}else{
					XSSFWorkbook excel = new XSSFWorkbook(fis);
					XSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Usercard usercard = usercardDao.findByCardidStr(terminalid_val);
								if(usercard ==null){//智能卡还未出售
									continue;
								}
							    
								//封装订户智能卡
								usercardlist.add(usercard);
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Userstb userstb = userstbDao.findByStbnoStr(terminalid_val);
								if(userstb ==null){//机顶盒还未出售
									continue;
								}
								
							    //封装订户机顶盒
								userstblist.add(userstb);
								
							}
						}
					}
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchauthorizerefresh_Init(pageParam,query_product);
			} catch (IOException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchauthorizerefresh_Init(pageParam,query_product);
			}
			
		} else if (addressing_mode.equals("3")) { //表格选择
			
			String[] terminalidArray = request.getParameter("terminalids").split(",");
			if (terminalidArray == null || terminalidArray.length < 1) {
				pageParam.setReturninfo(getMessage("user.terminalid.empty"));
				return add_batchauthorizerefresh_Init(pageParam,query_product);
			} else {
				for (int i = 0; i < terminalidArray.length; i++) {
					//普安服务器
					if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						
						//查询该智能卡购买信息
						Usercard usercard = usercardDao.findByCardidStr(terminalidArray[i]);
						if(usercard ==null){//智能卡还未出售
							continue;
						}
						
						//封装订户智能卡
						usercardlist.add(usercard);
						
					//高安服务器
					}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						
						//查询该机顶盒购买信息
						Userstb userstb = userstbDao.findByStbnoStr(terminalidArray[i]);
						if(userstb ==null){//机顶盒还未出售
							continue;
						}
						
						//封装订户机顶盒
						userstblist.add(userstb);
						
					}
					
				}
			}
			
		}
		
		//保存产品、业务信息的参数
		Batchcmd batchcmd = new Batchcmd();
		batchcmd.setOperator(operator);//封装操作员信息
		batchcmd.setVersiontype(pageParam.getVersiontype());
		batchcmd.setUsercardlist(usercardlist);
		batchcmd.setUserstblist(userstblist);
		batchcmd.setBusinesstypekey("pausecard");
		batchcmd.setBusinesstypename(getMessage("business.type.pausecard"));
		batchcmd.setContent(getMessage("business.type.pausecard"));
		batchcmdService.saveBatchcmd_batchauthorizerefresh(batchcmd);
		
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return add_batchauthorizerefresh_Init(pageParam,query_product);
	}
	
	
	/**
	 * 批量发卡指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/add_batchsendcard_Init")
	public String add_batchsendcard_Init(AuthorizeParamForPages pageParam,Product query_product) {
		// 构建上级网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		query_product.setNetworklist(networklist);
		//pageParam.setProduct(query_product);
		return "cascommand/add_batchsendcard";
	}
	
	
	/**
	 * 保存批量发卡指令
	 * @param AuthorizeParamForPages
	 * @return
	 */
	@RequestMapping(value = "/send_batchsendcard")
	public String send_batchsendcard(AuthorizeParamForPages pageParam, HttpServletRequest request ,Product query_product, @RequestParam("uploadfile") MultipartFile file) {
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		
		List<Card> cardlist = new ArrayList<Card>();
		List<Stb> stblist = new ArrayList<Stb>();
		
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		//caCommandParam.setVersiontype("gos_pn");
		//caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		String userareacode = request.getParameter("queryareacode");
		if(StringUtils.isEmpty(userareacode)){
			pageParam.setReturninfo(getMessage("area.areacode.empty"));
			return add_batchsendcard_Init(pageParam,query_product);
		}
		
		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String cardid = pageParam.getCardid();
				//查询该智能卡购买信息
				Card card = cardDao.findByCardidStr(cardid);
				if(card == null){//智能卡库存
					pageParam.setReturninfo(getMessage("authorize.batchsendcard.cardnoin"));
					return add_batchsendcard_Init(pageParam,query_product);
				}
				//封装订户智能卡
				cardlist.add(card);
				
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String stbno = pageParam.getStbno();
				//查询该机顶盒购买信息
				Stb stb = stbDao.findByStbnoStr(stbno);
				if(stb == null){//机顶盒库存
					pageParam.setReturninfo(getMessage("authorize.batchsendcard.cardnoin"));
					return add_batchsendcard_Init(pageParam,query_product);
				}
				
				//封装订户机顶盒
				stblist.add(stb);
				
			}
			
			
		} else if (addressing_mode.equals("1")) {//卡号段

			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
				String startcardid = pageParam.getStartcardid();
				String endcardid = pageParam.getEndcardid();
				long min = Integer.valueOf(startcardid);
				long max = Integer.valueOf(endcardid);
				for (long index = min; index <= max; index++) {
					String cardid = String.valueOf(index);
					
					//查询该智能卡购买信息
					Card card = cardDao.findByCardidStr(cardid);
					if(card != null ){//智能卡库存
						//封装订户智能卡
						cardlist.add(card);
					}
					
				}
			//高安服务器
			}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
				String startstbno = pageParam.getStartstbno();
				String endstbno = pageParam.getEndstbno();
				long min = Long.parseLong(startstbno, 16);//16进制机顶盒号转换成long
				long max = Long.parseLong(endstbno, 16);//16进制机顶盒号转换成long
				for (long index = min; index <= max; index++) {
					String stbno = Long.toHexString(index);//long转换成16进制机顶盒号
					
					//查询该机顶盒购买信息
					Stb stb = stbDao.findByStbnoStr(stbno);
					if(stb != null ){//机顶盒已经出售
						//封装订户机顶盒
						stblist.add(stb);
					}
				}
			}
		} else if (addressing_mode.equals("2")) {//文件导入
			// 得到页面上传的临时文件
			// XML上传服务器流文件
			String filename = file.getOriginalFilename();
			if (filename == null || "".equals(filename)) {
				pageParam.setReturninfo(getMessage("uploadify.filename.null"));
				return add_batchsendcard_Init(pageParam,query_product);
			}
			// 文件类型
			String[] strArray = filename.split("[.]");
			String type = strArray[strArray.length - 1];
			if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
				pageParam.setReturninfo(getMessage("uploadify.filetype.error"));
				return add_batchsendcard_Init(pageParam,query_product);
			}
			
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
			File tmpFile = new File(fullpath);
			try {
				file.transferTo(tmpFile);
				FileInputStream fis = new FileInputStream(tmpFile);
				if("xls".equals(type) || "XLS".equals(type)){
					HSSFWorkbook excel = new HSSFWorkbook(fis);
					HSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Card card = cardDao.findByCardidStr(terminalid_val);
								if(card != null ){//智能卡库存
									//封装订户智能卡
									cardlist.add(card);
								}
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Stb stb = stbDao.findByStbnoStr(terminalid_val);
								if(stb != null){//机顶盒已经出售
									//封装订户机顶盒
									stblist.add(stb);
								}
								
							}
						}
					}	
				}else{
					XSSFWorkbook excel = new XSSFWorkbook(fis);
					XSSFSheet sheet0 = excel.getSheetAt(0);
					
					for (Row row : sheet0) {
						if (row.getRowNum() == 0) {
							continue; // 第一排表头跳过不读
						}
						
						//获取机顶盒号
						Cell cell0 = row.getCell(0);
						String terminalid_val = this.cellValue(cell0);
						if (StringUtils.isNotEmpty(terminalid_val)) {
							//普安服务器
							if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
							    
								//查询该智能卡购买信息
								Card card = cardDao.findByCardidStr(terminalid_val);
								if(card != null ){//智能卡库存
									//封装订户智能卡
									cardlist.add(card);
								}
								
								//高安服务器
							}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
							    
								//查询该机顶盒购买信息
								Stb stb = stbDao.findByStbnoStr(terminalid_val);
								if(stb != null){//机顶盒已经出售
									//封装订户机顶盒
									stblist.add(stb);
								}
								
							}
						}
					}	
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchsendcard_Init(pageParam,query_product);
			} catch (IOException e) {
				e.printStackTrace();
				pageParam.setReturninfo(getMessage("page.execution.failure"));
				return add_batchsendcard_Init(pageParam,query_product);
			}
			
		} else if (addressing_mode.equals("3")) { //表格选择
			
			String[] terminalidArray = request.getParameter("terminalids").split(",");
			if (terminalidArray == null || terminalidArray.length < 1) {
				pageParam.setReturninfo(getMessage("user.terminalid.empty"));
				return add_batchsendcard_Init(pageParam,query_product);
			} else {
				for (int i = 0; i < terminalidArray.length; i++) {
					//普安服务器
					if(Constant.SERVER_GOS_PN.equals(pageParam.getVersiontype())){
						
						//查询该智能卡购买信息
						Card card = cardDao.findByCardidStr(terminalidArray[i]);
						if(card != null ){//智能卡库存
							//封装订户智能卡
							cardlist.add(card);
						}
						
					//高安服务器
					}else if(Constant.SERVER_GOS_GN.equals(pageParam.getVersiontype())){
						
						//查询该机顶盒购买信息
						Stb stb = stbDao.findByStbnoStr(terminalidArray[i]);
						if(stb != null){//机顶盒已经出售
							//封装订户机顶盒
							stblist.add(stb);
						}
						
					}
					
				}
			}
			
		}
		
		//保存产品、业务信息的参数
		Batchcmd batchcmd = new Batchcmd();
		batchcmd.setUserareacode(userareacode);
		batchcmd.setOperator(operator);//封装操作员信息
		batchcmd.setVersiontype(pageParam.getVersiontype());
		batchcmd.setCardlist(cardlist);
		batchcmd.setStblist(stblist);
		batchcmd.setBusinesstypekey("pausecard");
		batchcmd.setBusinesstypename(getMessage("business.type.pausecard"));
		batchcmd.setContent(getMessage("business.type.pausecard"));
		batchcmdService.saveBatchcmd_batchsendcard(batchcmd);
		
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return add_batchsendcard_Init(pageParam,query_product);
	}
	
	@RequestMapping(value="/findServiceListForDialog")
	public String findServiceListForDialog(Service form) {
		form.setQuerystate("1");
		form.setPager_openset(5);
		form.setPager_count(serviceDao.findByCount(form));
		List<Service> services = serviceDao.findByList(form);
		for (Service service : services) {
			service.setNetwork(networkDao.findById(service.getNetid()));
		}
		form.setServicelist(services);
		return "authorize/findServiceListForDialog";
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
	 * 下载导入模板
	 */
	@RequestMapping(value = "/downloadTerminalTemplate")
	public String downloadTerminalTemplate(AuthorizeParamForPages pageParam, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "terminalid_template.xls";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("terminalid_template.xls", "UTF-8"));
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
	 * OSD
	 * @param Caspnforcedosd
	 * @return
	 */
	@RequestMapping(value = "/find_osd_List")
	public String find_osd_List(EmailOrOsdMsg form) {
		/*caspnforcedosdDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnforcedosdDao.findByCount(form));
		form.setCaspnforcedosdlist(caspnforcedosdDao.findByList(form));*/
		return "cascommand/find_osd_List";
	}
	
	@RequestMapping(value = "/add_osd_Init")
	public String add_osd_Init(EmailOrOsdMsg form) {
		return "cascommand/add_osd_Init";
	}
	
	@RequestMapping(value = "/add_osd_Info")
	public String add_osd_Info(EmailOrOsdMsg form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_osd_gos_pn";
		}/*else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_forcedosd_gos_gn";
		}*/else{
			return null;
		}
	}
	
	@RequestMapping(value = "/send_osd")
	public String send_osd(EmailOrOsdMsg form, HttpServletRequest request) {
		// 先存入数据库，获得其递增的id
		form.setIscontrol("1");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){//高安
			form.setAddressingmode("1");//高安是多播
		} else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){//普安
			
		}
		
		//caspnforcedosdDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		
		//发送授权指令
		authorizeService.saveAuthorize_osd(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return add_osd_Info(form);
	}
	
	/**
	 * 邮件指令
	 * @param Caspnnewemail
	 * @return
	 */
	@RequestMapping(value = "/find_email_List")
	public String find_email_List(EmailOrOsdMsg form) {
//		caspnnewemailDao.findByList(form);
//		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
//		form.setPager_count(caspnnewemailDao.findByCount(form));
//		form.setCasemaillist(caspnnewemailDao.findByList(form));
		return "cascommand/find_email_List";
	}

	@RequestMapping(value = "/add_email_Init")
	public String add_email_Init(EmailOrOsdMsg form) {
		return "cascommand/add_email_Init";
	}
	
	@RequestMapping(value = "/add_email_Info")
	public String add_email_Info(EmailOrOsdMsg form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_email_gos_pn";
		}/*else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_newemail_gos_gn";
		}*/else{
			return null;
		}
	}

	@RequestMapping(value = "/send_email")
	public String send_email(EmailOrOsdMsg form, HttpServletRequest request) {
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}
		//caspnnewemailDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_email(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_email_Info(form);
	}
	
	/**
	 * 指纹指令
	 * @param Caspnnewemail
	 * @return
	 */
	@RequestMapping(value = "/find_finger_List")
	public String find_finger_List(EmailOrOsdMsg form) {
//		caspnnewfingerDao.findByList(form);
//		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
//		form.setPager_count(caspnnewfingerDao.findByCount(form));
//		form.setCasfingerlist(caspnnewfingerDao.findByList(form));
		return "cascommand/find_finger_List";
	}

	@RequestMapping(value = "/add_finger_Init")
	public String add_finger_Init(EmailOrOsdMsg form) {
		return "cascommand/add_finger_Init";
	}
	
	@RequestMapping(value = "/add_finger_Info")
	public String add_finger_Info(EmailOrOsdMsg form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_finger_gos_pn";
		}/*else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_newfinger_gos_gn";
		}*/else{
			return null;
		}
	}

	@RequestMapping(value = "/send_finger")
	public String send_finger(EmailOrOsdMsg form, HttpServletRequest request) {
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}
		//caspnnewfingerDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_finger(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_finger_Info(form);
	}
	
	/**
	 * 产品限播指令
	 * @param Caspnproductplay
	 * @return
	 */
	@RequestMapping(value = "/find_productplaylimit_List")
	public String find_productplaylimit_List(Caspnproductplay form) {
//		caspnnewfingerDao.findByList(form);
//		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
//		form.setPager_count(caspnnewfingerDao.findByCount(form));
//		form.setCasfingerlist(caspnnewfingerDao.findByList(form));
		return "cascommand/find_productplaylimit_List";
	}

	@RequestMapping(value = "/add_productplaylimit_Init")
	public String add_productplaylimit_Init(Caspnproductplay form) {
		return "cascommand/add_productplaylimit_Init";
	}
	
	@RequestMapping(value = "/add_productplaylimit_Info")
	public String add_productplaylimit_Info(Caspnproductplay form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_productplaylimit_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_productplaylimit_gos_gn";
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "/send_productplaylimit")
	public String send_productplaylimit(Caspnproductplay form, HttpServletRequest request) {
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){
			//caspnproductplayDao.save(form);
		}
		//caspnnewproductplaylimitDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_productplaylimit(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_productplaylimit_Info(form);
	}
	
	/**
	 * 产品准播指令
	 * @param Caspnproductplay
	 * @return
	 */
	@RequestMapping(value = "/find_productplayallow_List")
	public String find_productplayallow_List(Caspnproductplay form) {
		caspnproductplayDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnproductplayDao.findByCount(form));
		form.setCaspnproductplaylist(caspnproductplayDao.findByList(form));
		return "cascommand/find_productplayallow_List";
	}

	@RequestMapping(value = "/add_productplayallow_Init")
	public String add_productplayallow_Init(Caspnproductplay form) {
		return "cascommand/add_productplayallow_Init";
	}
	
	@RequestMapping(value = "/add_productplayallow_Info")
	public String add_productplayallow_Info(Caspnproductplay form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_productplayallow_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_productplayallow_gos_gn";
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/send_productplayallow")
	public String send_productplayallow(Caspnproductplay form, HttpServletRequest request) {
		form.setAddtime(Tools.getCurrentTime());
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){
			form.setIsControl("1");  //    1:添加 0：删除
			caspnproductplayDao.save(form);
		}
		//caspnnewproductplayallowDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_productplayallow(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_productplayallow_Info(form);
	}
	
	@RequestMapping(value = "/send_cancel_productplayallow")
	public String send_cancel_productplayallow(Caspnproductplay form) {
		Caspnproductplay caspnproductplay = caspnproductplayDao.findById(form.getId());
		caspnproductplay.setIsControl("0"); //    1:添加 0：删除
		//发送授权指令
		authorizeService.saveAuthorize_productplayallow(caspnproductplay);
		caspnproductplayDao.delete(form.getId());

		form.setReturninfo(getMessage("page.execution.success"));
		return find_productplayallow_List(form);
	}
	
	/**
	 * pvr功能控制
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_pvrcontrol_Init")
	public String add_pvrfunctionControl_Init(CaCommandParam form) {
		return "cascommand/add_pvrfunctionControl_Init";
	}
	
	@RequestMapping(value = "/add_pvrfunctionControl_Info")
	public String add_pvrfunctionControl_Info(CaCommandParam form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_pvrfunctionControl_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_pvrfunctionControl_gos_gn";
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "/send_pvrfunctionControl")
	public String send_pvrfunctionControl(CaCommandParam form, HttpServletRequest request) {
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("1");//高安是多播
		}else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){
			//caspnproductplayDao.save(form);
		}
		//caspnnewproductplaylimitDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_pvrfunctionControl(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_pvrfunctionControl_Info(form);
	}
	
	/**
	 * 父母锁密码复位
	 * @param CaCommandParam
	 * @return
	 */

	@RequestMapping(value = "/add_parentlock_Init")
	public String add_parentlock_Init(CaCommandParam form) {
		return "cascommand/add_parentlock_Init";
	}
	
	@RequestMapping(value = "/add_parentlock_Info")
	public String add_parentlock_Info(CaCommandParam form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		if("gos_pn".equals(form.getVersiontype())){
			return "cascommand/add_parentlock_gos_pn";
		}else if("gos_gn".equals(form.getVersiontype())){
			return "cascommand/add_parentlock_gos_gn";
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "/send_parentlock")
	public String send_parentlock(CaCommandParam form, HttpServletRequest request) {
		if(Constant.SERVER_GOS_GN.equals(form.getVersiontype())){
			form.setAddressingmode("0");//高安是单播
		}else if(Constant.SERVER_GOS_PN.equals(form.getVersiontype())){
			//caspnproductplayDao.save(form);
		}
		//caspnnewproductplaylimitDao.save(form);
		//System.out.println("**************id**************: " + form.getId());
		//发送授权指令
		authorizeService.saveAuthorize_parentlock(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_parentlock_Info(form);
	}
	
	
}
