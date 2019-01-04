package com.gospell.boss.controller;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gospell.boss.common.ExportExcel;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IBusinesstypeDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IStatisticDao;
import com.gospell.boss.dao.IStatreportDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserlevelDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Businesstype;
import com.gospell.boss.po.Giftcard;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Statreport;
import com.gospell.boss.po.Store;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userlevel;
import com.gospell.boss.po.Userstb;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/statreport")
@Transactional
public class StatreportController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private IStatreportDao statreportDao;
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IUserDao userDao; 
	@Autowired
	private IStoreDao storeDao;
	@Autowired
	private IOperatorDao operatorDao;
	@Autowired
	private IBusinesstypeDao businesstypeDao;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private IStatisticDao statisticDao;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IUserlevelDao userlevelDao;
	
	/**
	 * 操作员业务统计信息
	 */
	@RequestMapping(value = "/operatorBusinessStat")
	public String operatorBusinessStat(Statreport form) {
		return "statreport/operatorBusinessStat";
	}
	
	/**
	 * 操作员业务统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/operatorBusinessStatJson")
	public Map<String, Object> operatorBusinessStatJson(Statreport form) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		//easyui footer数据
		List<HashMap<String, Object>> footertlist = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> footerMap = new HashMap<String, Object>();
		Integer addcount = 0;//总数
		BigDecimal addprice = new BigDecimal(0);//总金
		
		List<Statreport> list = statreportDao.operatorBusinessStat(form);
		
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			if(!"transferusered".equals(statreport.getBusinesstypekey())){
				objectMap.put("businesstypekey", statreport.getBusinesstypekey());
				Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
				if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
					objectMap.put("businesstypename", businesstype.getTypename());
				}else{
					objectMap.put("businesstypename", getMessage("business.type."+statreport.getBusinesstypekey()));
				}
				objectMap.put("count", statreport.getCount());
				objectMap.put("totalprice", statreport.getTotalprice());
				
				addcount = addcount + statreport.getCount();
				addprice = addprice.add(statreport.getTotalprice());
				
				objectlist.add(objectMap);
			}
		}
		
		//footerMap.put("businesstypename", "count");
		footerMap.put("count", getMessage("statistic.totalprice"));
		footerMap.put("totalprice", addprice);
		footertlist.add(footerMap);
		
		//result.put("total", total);//页面总数
		result.put("rows", objectlist);
		result.put("footer", footertlist);
		return result;
	}
	
	/**
	 * 导出操作员业务报表excel
	 */
	@RequestMapping(value = "/exportBusinessExcel")
	public String exportBusinessExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.operatorBusinessStat(form);
		if (list != null) {
			form.setStatreportList(list);
			BigDecimal addprice = new BigDecimal(0);//总金
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
				if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
					excelmap.put(getMessage("business.type"), businesstype.getTypename());
				}else{
					excelmap.put(getMessage("business.type"), getMessage("business.type." + statreport.getBusinesstypekey()));
				}
				excelmap.put(getMessage("statistic.count"), statreport.getCount().toString());
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalprice().toString());
				addprice = addprice.add(statreport.getTotalprice());
				statreport.setExcelMap(excelmap);
			}
			Map<String, String> excelmap = new HashMap<String, String>();
			Statreport statreport = new Statreport();
			excelmap.put(getMessage("statistic.count"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), addprice.toString());
			statreport.setExcelMap(excelmap);
			list.add(statreport);
			form.setExporttype("NORMAL");
			//查询条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getSource()) && null != form.getSource()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("userbusiness.source"));
				conditionmap.put("content", getMessage("userbusiness.source." + form.getSource()));
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getNetid()) && null != form.getNetid()){
				Network network = new Network();
				network.setNetid(form.getNetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getStoreid()) && null != form.getStoreid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("store.storename"));
				Store store = storeDao.findById(Integer.valueOf(form.getStoreid()));
				conditionmap.put("content", store.getStorename());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getOperatorid()) && null != form.getOperatorid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("operator.operatorname"));
				Operator operator = operatorDao.findById(Integer.valueOf(form.getOperatorid()));
				conditionmap.put("content", operator.getOperatorname());
				conditionlist.add(conditionmap);
			}
			//表头
			String[] columntitle = {getMessage("business.type"),getMessage("statistic.count")
					,getMessage("statreport.business.price")
					};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "OperatorReport_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}

	/**
	 * 操作员业务统计详情
	 */
	@RequestMapping(value = "/operatorBusinessStatdetail")
	public String operatorBusinessStatdetail(Statreport form) {
		return "statreport/operatorBusinessStatdetail";
	}
	
	/**
     * 业务明细导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportBusinessdetailExcelFlag")
    public Map<String,Object> exportBusinessdetailExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.operatorBusinessStatCount(form);	
		
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 导出业务明细报表excel
	 */
	@RequestMapping(value = "/exportBusinessdetailExcel")
	public String exportBusinessdetailExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportBusinessdetail(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("problemcomplaint.content"), statreport.getContent());
				if("1".equals(statreport.getDefinedflag())){
					excelmap.put(getMessage("service.servicetype"), statreport.getBusinesstypename());
				}else{
					excelmap.put(getMessage("service.servicetype"), getMessage("business.type."+statreport.getBusinesstypekey()));
				}
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalmoney().toString());
				excelmap.put(getMessage("statreport.business.addtime"), statreport.getAddtime().substring(0, 19));
				excelmap.put(getMessage("operator.operatorname"), statreport.getOperatorname());
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				statreport.setExcelMap(excelmap);
			}
			//总金
			BigDecimal totalprice = statreportDao.operatorBusinessPayment(form);
			if("".equals(totalprice) || totalprice == null){
				totalprice = new BigDecimal(0);
			}
			Map<String, String> excelmap = new HashMap<String, String>();
			Statreport statreport = new Statreport();
			excelmap.put(getMessage("service.servicetype"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), totalprice.toString());
			statreport.setExcelMap(excelmap);
			list.add(statreport);
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getBusinesstypes()) && null != form.getBusinesstypes()){
				String[] strs = form.getBusinesstypes();
				String str = "";
				for(int i = 0; i < strs.length; i++){
					Businesstype businesstype = businesstypeDao.findByTypekeyStr(strs[i]);
					if("1".equals(businesstype.getDefinedflag())){
						str = str + businesstype.getTypename() + " ";
					}else{
						str = str + getMessage("business.type." + strs[i]) + " ";
					}
				}
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("service.servicetype"));
				conditionmap.put("content", str);
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getNetid()) && null != form.getNetid()){
				Network network = new Network();
				network.setNetid(form.getNetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getStoreid()) && null != form.getStoreid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("store.storename"));
				Store store = storeDao.findById(Integer.valueOf(form.getStoreid()));
				conditionmap.put("content", store.getStorename());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getOperatorid()) && null != form.getOperatorid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("operator.operatorname"));
				Operator operator = operatorDao.findById(Integer.valueOf(form.getOperatorid()));
				conditionmap.put("content", operator.getOperatorname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getSource()) && null != form.getSource()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("userbusiness.source"));
				conditionmap.put("content", getMessage("userbusiness.source." + form.getSource()));
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.usercode"),getMessage("user.username"),getMessage("service.servicetype")
					,getMessage("problemcomplaint.content")
					,getMessage("statreport.business.price"),getMessage("statreport.business.addtime")
					,getMessage("operator.operatorname"),getMessage("area.areacode")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "OperatorReport_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}
	
	/**
	 * 业务统计明细Json
	 */
	@ResponseBody
	@RequestMapping(value = "/businessStatdetailJson")
	public Map<String, Object> businessStatdetailJson(int rows,int page,Statreport form, HttpServletRequest request) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> footerlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		
		if(!"".equals(form.getBusinesstype())){
			form.setBusinesstypes(form.getBusinesstype().split(","));
		}
		
		Integer total = statreportDao.operatorBusinessStatCount(form);
		
		List<Statreport> list = statreportDao.operatorBusinessStatdetail(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			if(!"transferusered".equals(statreport.getBusinesstypekey())){
				//产品出入库信息
				objectMap.put("usercode", statreport.getUsercode());
				objectMap.put("content", statreport.getContent());
				objectMap.put("businesstypekey", statreport.getBusinesstypekey());
				Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
				if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
					objectMap.put("businesstypename", businesstype.getTypename());
				}else{
					objectMap.put("businesstypename", getMessage("business.type."+statreport.getBusinesstypekey()));
				}
				objectMap.put("price", statreport.getTotalmoney());
				objectMap.put("addtime", statreport.getAddtime());
				objectMap.put("areacode", statreport.getAreacode());
				
				String username = statreportDao.findUsername(statreport);
				objectMap.put("username", username);
				objectMap.put("operatorname", statreport.getOperatorname());
				
				objectlist.add(objectMap);
			}
		}
		//交费总金额
		BigDecimal totalprice = statreportDao.operatorBusinessPayment(form);
		if("".equals(totalprice) || totalprice == null){
			totalprice = new BigDecimal(0);
		}
		HashMap<String, Object> footerMap = new HashMap<String, Object>();
		footerMap.put("businesstypename", getMessage("statistic.totalprice"));
		footerMap.put("price", totalprice);
		footerlist.add(footerMap);
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		result.put("footer", footerlist);
		return result;
	}
	
	/**
     * 订户查询-获取网络的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initNetworkJson")
    public List<HashMap<String, Object>> initNetworkJson(Network form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> networksJSON = new ArrayList<HashMap<String, Object>>();
		
		Operator operator = (Operator)getSession().getAttribute("Operator");
		String operatortype = operator.getOperatortype();
		if("0".equals(operatortype) || "3".equals(operatortype)){//系统级别操作员
			
			String operatorlevel = operator.getOperatorlevel();
			if("0".equals(operatorlevel)){//系统级别操作员
				//封装默认的请选择行数据()
				HashMap<String,Object> selectednetworkMap = new HashMap<String, Object>();
				selectednetworkMap.put("id", "");
				selectednetworkMap.put("netid", "");
				selectednetworkMap.put("netname", getMessage("page.select"));
				networksJSON.add(selectednetworkMap);
				
		    	List<Network> networkList = networkDao.queryByList(form);
		 		for (Network network : networkList) {
		 			HashMap<String,Object> networkMap = new HashMap<String, Object>();
		 			networkMap.put("id", network.getId());
		 			networkMap.put("netid", network.getNetid());
		 			networkMap.put("netname", network.getNetname());
		 			networksJSON.add(networkMap);
		        }
			} else {//不是系统级别的操作员，只能查询操作员所在的网络订户
				Network network = networkDao.findById(operator.getNetid());
				if(network == null){
					network = new Network();
				}
				HashMap<String,Object> networkMap = new HashMap<String, Object>();
				networkMap.put("id", network.getId());
	 			networkMap.put("netid", network.getNetid());
	 			networkMap.put("netname", network.getNetname());
	 			networksJSON.add(networkMap);
			}
		} else {//不是系统级别的操作员，只能查询操作员所在的网络订户
			Network network = networkDao.findById(operator.getNetid());
			if(network == null){
				network = new Network();
			}
			HashMap<String,Object> networkMap = new HashMap<String, Object>();
			networkMap.put("id", network.getId());
 			networkMap.put("netid", network.getNetid());
 			networkMap.put("netname", network.getNetname());
 			networksJSON.add(networkMap);
		}
	    
 		return networksJSON;
	}
	
	/**
     * 获取营业厅下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getStoreJson")
    public List<HashMap<String, Object>> getStoreJson(Store form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> storesJSON = new ArrayList<HashMap<String, Object>>();
		
		Operator operator = (Operator)getSession().getAttribute("Operator");
		String operatortype = operator.getOperatortype();
		
		if("0".equals(operatortype) || "3".equals(operatortype)){//不是超级管理员和普通管理员
			
			if(operator.getStoreid() == null){//系统级别操作员
				//封装默认的请选择行数据()
				HashMap<String,Object> selectedstoreMap = new HashMap<String, Object>();
				selectedstoreMap.put("id", "");
				selectedstoreMap.put("netid", "");
				selectedstoreMap.put("storename", getMessage("page.select"));
				storesJSON.add(selectedstoreMap);
				
				//先判断网络有没有选择
			    if(StringUtils.isNotEmpty(form.getQuerynetid())){
			    	List<Store> stores = storeDao.queryByList(form);
			 		for (Store store : stores) {
			 			HashMap<String,Object> storeMap = new HashMap<String, Object>();
			 			storeMap.put("id", store.getId());
			 			storeMap.put("netid", store.getNetid());
			 			storeMap.put("storename", store.getStorename());
			 			storesJSON.add(storeMap);
			        }
			    }
			  }else {//不是系统级别的操作员，只能查询操作员所在的网络订户
				  Store store = storeDao.findById(operator.getStoreid());
					if(store == null){
						store = new Store();
					}
					HashMap<String,Object> storeMap = new HashMap<String, Object>();
		 			storeMap.put("id", store.getId());
		 			storeMap.put("netid", store.getNetid());
		 			storeMap.put("storename", store.getStorename());
		 			storesJSON.add(storeMap);
				} 
		}else{//查询所有的区域
			Store store = storeDao.findById(operator.getStoreid());
			if(store == null){
				store = new Store();
			}
			HashMap<String,Object> storeMap = new HashMap<String, Object>();
 			storeMap.put("id", store.getId());
 			storeMap.put("netid", store.getNetid());
 			storeMap.put("storename", store.getStorename());
 			storesJSON.add(storeMap);
		}
 		return storesJSON;
	}
	
	/**
     * 获取操作员的下拉列表框值JSON
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getOperatorJson")
    public List<HashMap<String, Object>> getOperatorJson(Operator form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> operatorJSON = new ArrayList<HashMap<String, Object>>();
		
		Operator operator = (Operator)getSession().getAttribute("Operator");
		String operatortype = operator.getOperatortype();
		
		if("0".equals(operatortype) || "3".equals(operatortype)){//不是超级管理员和普通管理员
			//封装默认的请选择行数据()
			HashMap<String,Object> selectedoperatorMap = new HashMap<String, Object>();
			selectedoperatorMap.put("id", "");
			selectedoperatorMap.put("netid", "");
			selectedoperatorMap.put("operatorname", getMessage("page.select"));
			operatorJSON.add(selectedoperatorMap);
		    
	    	List<Operator> operators = operatorDao.queryByList(form);
	 		for (Operator operatorObject : operators) {
	 			HashMap<String,Object> operatorMap = new HashMap<String, Object>();
	 			operatorMap.put("id", operatorObject.getId());
	 			operatorMap.put("netid", operatorObject.getNetid());
	 			operatorMap.put("operatorname", operatorObject.getOperatorname());
	 			operatorMap.put("operatorcode", operatorObject.getOperatorcode());
	 			operatorJSON.add(operatorMap);
	        }
		}else{//查询所有的区域
			HashMap<String,Object> operatorMap = new HashMap<String, Object>();
 			operatorMap.put("id", operator.getId());
 			operatorMap.put("netid", operator.getNetid());
 			operatorMap.put("operatorname", operator.getOperatorname());
 			operatorMap.put("operatorcode", operator.getOperatorcode());
 			operatorJSON.add(operatorMap);
		}
		
 		return operatorJSON;
	}
	
	/**
     * 获取业务类型的下拉列表框值JSON
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getBusinesstypeJson")
    public List<HashMap<String, Object>> getBusinesstypeJson(Businesstype form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> operatorJSON = new ArrayList<HashMap<String, Object>>();
		
		HashMap<String,Object> selectedbusinesstypeMap = new HashMap<String, Object>();
		operatorJSON.add(selectedbusinesstypeMap);
		
		form.setQuerystate("1");//查询有效
		List<Businesstype> businesstypelist = businesstypeDao.queryByList(form);
		for (Businesstype businesstype : businesstypelist) {
			if(!"transferusered".equals(businesstype.getTypekey())){//不是受理过户业务
				HashMap<String,Object> businesstypeMap = new HashMap<String, Object>();
				businesstypeMap.put("id", businesstype.getTypekey());
				businesstypeMap.put("typekey", businesstype.getTypekey());
				if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
					businesstypeMap.put("typename", businesstype.getTypename());
				}else{
					businesstypeMap.put("typename", getMessage("business.type." + businesstype.getTypekey()));
				}
				operatorJSON.add(businesstypeMap);
			}
		}
		
 		return operatorJSON;
	}
	
	/**
	 * 订户收费记录
	 */
	@RequestMapping(value = "/userChargeRecord")
	public String userChargeRecord(Statreport form) {
		return "statreport/userChargeRecord";
	}
	
	/**
     * 订户收费记录导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportChargeRecordExcelFlag")
    public Map<String,Object> exportChargeRecordExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.userChargeRecordCount(form);	
		
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 订户收费记录Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userChargeRecordJson")
	public Map<String, Object> userChargeRecordJson(int rows,int page,Statreport form, HttpServletRequest request) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = statreportDao.userChargeRecordCount(form);
		
		List<Statreport> list = statreportDao.userChargeRecord(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			//产品出入库信息
			objectMap.put("userid", statreport.getUserid());
			objectMap.put("content", statreport.getContent());
			objectMap.put("price", statreport.getTotalmoney());
			objectMap.put("addtime", statreport.getAddtime());
			objectMap.put("areacode", statreport.getAreacode());
			
			User user = userDao.findById(statreport.getUserid());
			if(user == null){
				user = new User();
			}
			objectMap.put("username", user.getUsername());
			objectMap.put("usercode", user.getUsercode());
			String operatorname = statreportDao.findOperatorname(statreport);
			
			objectMap.put("operatorname", operatorname);
			
			objectlist.add(objectMap);
		}
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 订户收费记录导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportChargeRecordExcel")
    public String exportChargeRecordExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportUserChargeRecord(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("problemcomplaint.content"), statreport.getContent());
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalmoney().toString());
				excelmap.put(getMessage("statreport.business.addtime"), statreport.getAddtime().substring(0, 19));
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				
				User user = userDao.findById(statreport.getUserid());
				if(user == null){
					user = new User();
				}
				excelmap.put(getMessage("user.username"), user.getUsername());
				excelmap.put(getMessage("user.usercode"), user.getUsercode());
				String operatorname = statreportDao.findOperatorname(statreport);
				
				excelmap.put(getMessage("operator.operatorname"), operatorname);
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryusername()) && null != form.getQueryusername()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("user.username"));
				conditionmap.put("content", form.getQueryusername());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.usercode"),getMessage("user.username"),getMessage("problemcomplaint.content")
					,getMessage("statreport.business.price"),getMessage("statreport.business.addtime"),getMessage("operator.operatorname")
					,getMessage("area.areacode")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userChargeRecord_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 查询机顶盒信息
	 */
	@RequestMapping(value="/selectUserListForDialog")
	public String selectUserListForDialog(User form) {
		return "user/selectUserListForDialog";
	}
	
	
	/**
	 * 订户终端状态统计
	 */
	@RequestMapping(value = "/userTerminalStateStat")
	public String userTerminalStateStat(Statreport form) {
		return "statreport/userterminalstateStat";
	}
	
	/**
     * 终端状态导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserTerminalstateStatExcelFlag")
    public Map<String,Object> exportUserTerminalstateStatExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = null;
		if("gos_pn".equals(form.getQueryversiontype())){
			total = statreportDao.userterminalstatestatCount_pn(form);
		}	else{//高安
			total = statreportDao.userterminalstatestatCount(form);
		}	
		
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
     * 终端状态导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserTerminalstateStatExcel")
    public String exportUserTerminalstateStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = new ArrayList<Statreport>();
		if("gos_pn".equals(form.getQueryversiontype())){//普安
			list = statreportDao.exportUserTerminalstateStat_pn(form);
		}else{
			list = statreportDao.exportUserTerminalstateStat(form);
		}
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.terminalid"), statreport.getTerminalid());
				excelmap.put(getMessage("user.terminalstate"), getMessage("user.terminalstate." + statreport.getState()));
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				excelmap.put(getMessage("user.address"), statreport.getAddress());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQueryversiontype()) && null != form.getQueryversiontype()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("server.versiontype"));
				conditionmap.put("content", getMessage("server.versiontype." + form.getQueryversiontype()));
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystate()) && null != form.getQuerystate()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("user.terminalstate"));
				conditionmap.put("content", getMessage("userstb.state." + form.getQuerystate()));
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.terminalid"),getMessage("user.usercode"),getMessage("user.username")
					,getMessage("area.areacode"),getMessage("user.address"),getMessage("user.terminalstate")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "UserDeterminalStateReport_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}
	
	/**
	 * 订户终端状态Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userTerminalstateStatJson")
	public Map<String, Object> userTerminalstateStatJson(int rows,int page,Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		
		//普安
		if("gos_pn".equals(form.getQueryversiontype())){
			Integer total = statreportDao.userterminalstatestatCount_pn(form);
			List<Statreport> list = statreportDao.userterminalstatestat_pn(form);
			for (Statreport statreport : list) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				//产品出入库信息
				objectMap.put("terminalid", statreport.getTerminalid());
				objectMap.put("state", getMessage("user.terminalstate." + statreport.getState()));
				objectMap.put("areacode", statreport.getAreacode());
				User user = userDao.findById(statreport.getUserid());
				objectMap.put("usercode", user.getUsercode());
				objectMap.put("username", user.getUsername());
				objectMap.put("address", user.getAddress());
				
				objectlist.add(objectMap);
			}
			
			result.put("total", total);//页面总数
			result.put("rows", objectlist);
			return result;
			
		}else{//高安
			Integer total = statreportDao.userterminalstatestatCount(form);
			List<Statreport> list = statreportDao.userterminalstatestat(form);
			
			for (Statreport statreport : list) {
				HashMap<String, Object> objectMap = new HashMap<String, Object>();
				//产品出入库信息
				objectMap.put("terminalid", statreport.getTerminalid());
				objectMap.put("state", getMessage("user.terminalstate." + statreport.getState()));
				User user = userDao.findById(statreport.getUserid());
				objectMap.put("usercode", user.getUsercode());
				objectMap.put("username", user.getUsername());
				objectMap.put("areacode", user.getAreacode());
				objectMap.put("address", user.getAddress());
				
				objectlist.add(objectMap);
			}
			
			result.put("total", total);//页面总数
			result.put("rows", objectlist);
			return result;
		}
	}
	
	/**
	 * 订户产品到期统计
	 */
	@RequestMapping(value = "/userProductExpiredStat")
	public String userProductExpiredStat(Statreport form, HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getDateMonthDayStrTwo();
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getSpecifiedDayAfter(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductExpiredStat";
	}
	
	/**
     * 产品到期导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductExpiredStatExcelFlag")
    public Map<String,Object> exportUserProductExpiredStatExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.userproductExpiredStatCount(form);
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 订户产品到期统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductExpiredStatJson")
	public Map<String, Object> userProductExpiredStatJson(int rows,int page,Statreport form) {
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = statreportDao.userproductExpiredStatCount(form);
		List<Statreport> list = statreportDao.userproductExpiredStat(form);
		
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			//产品出入库信息
			objectMap.put("terminalid", statreport.getTerminalid());
			objectMap.put("terminaltype", getMessage("user.terminaltype." + statreport.getTerminaltype()));
			objectMap.put("productid", statreport.getProductid());
			objectMap.put("productname", statreport.getProductname());
			objectMap.put("starttime", statreport.getStarttime().substring(0, 19));
			objectMap.put("endtime", statreport.getEndtime().substring(0, 19));
			User user = userDao.findById(statreport.getUserid());
			objectMap.put("username", user.getUsername());
			objectMap.put("usercode", user.getUsercode());
			
			objectlist.add(objectMap);
		}
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 订户产品到期统计导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductExpiredStatExcel")
    public String exportUserProductExpiredStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportUserProductExpiredStat(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.terminalid"), statreport.getTerminalid());
				excelmap.put(getMessage("user.terminaltype"), getMessage("user.terminaltype." + statreport.getTerminaltype()));
				excelmap.put(getMessage("statreport.userproductid"), statreport.getProductid());
				excelmap.put(getMessage("statreport.userproductname"), statreport.getProductname());
				excelmap.put(getMessage("userproduct.starttime"), statreport.getStarttime().substring(0, 19));
				excelmap.put(getMessage("userproduct.endtime"), statreport.getEndtime().substring(0, 19));
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryproductid()) && null != form.getQueryproductid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("product.productid"));
				conditionmap.put("content", form.getQueryproductid());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.terminalid"),getMessage("user.terminaltype"),getMessage("statreport.userproductid")
					,getMessage("statreport.userproductname"),getMessage("userproduct.starttime"),getMessage("userproduct.endtime")
					,getMessage("user.username"),getMessage("user.usercode")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userProductExpiredStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 订户产品收视统计
	 */
	@RequestMapping(value = "/userProductAudienceStat")
	public String userProductAudienceStat(Statreport form, HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductAudienceStat";
	}
	
	/**
	 * 订户产品收视统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductAudienceStatJson")
	public Map<String, Object> userProductAudienceStatJson(Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		List<Statreport> list = statreportDao.userProductAudienceStat(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			//产品出入库信息
			objectMap.put("productid", statreport.getProductid());
			Product productForm = new Product();
			productForm.setNetid(Integer.parseInt(statreport.getNetid()));
			productForm.setProductid(statreport.getProductid());
			productForm = productDao.findByProductid(productForm);
			if(productForm ==null){
				productForm = new Product();
			}
			objectMap.put("productname", productForm.getProductname());
			objectMap.put("count", statreport.getCount());
			objectMap.put("usercount", statreport.getUsercount());
			Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
			objectMap.put("netname", network.getNetname());
			objectMap.put("netid", statreport.getNetid());
			
			objectlist.add(objectMap);
		}
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 订户产品收视导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductAudienceStatExcel")
    public String exportUserProductAudienceStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.userProductAudienceStat(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
				excelmap.put(getMessage("network.netname"), network.getNetname());
				excelmap.put(getMessage("statreport.userproductid"), statreport.getProductid());
				Product productForm = new Product();
				productForm.setNetid(Integer.parseInt(statreport.getNetid()));
				productForm.setProductid(statreport.getProductid());
				productForm = productDao.findByProductid(productForm);
				if(productForm ==null){
					productForm = new Product();
				}
				excelmap.put(getMessage("statreport.userproductname"), productForm.getProductname());
				excelmap.put(getMessage("statreport.terminal.count"), statreport.getCount().toString());
				excelmap.put(getMessage("statreport.user.count"), statreport.getUsercount().toString());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			//表头
			String[] columntitle = {getMessage("network.netname"),getMessage("statreport.userproductid"),getMessage("statreport.userproductname")
					,getMessage("statreport.terminal.count"),getMessage("statreport.user.count")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "productAudienceStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 订户产品收视统计详细
	 */
	@RequestMapping(value = "/userProductAudienceStatDialog")
	public String userProductAudienceStatDialog(Statreport form ,HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductAudienceStatDialog";
	}
	
	/**
     * 产品收视详情导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductAudienceDetailStatExcelFlag")
    public Map<String,Object> exportUserProductAudienceDetailStatExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.userProductAudienceDetailStatCount(form);
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 订户产品收视统计弹窗详细Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductAudienceStatDialogJson")
	public Map<String, Object> userProductAudienceStatDialogJson(int rows,int page,Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = statreportDao.userProductAudienceDetailStatCount(form);
		List<Statreport> list = statreportDao.userProductAudienceDetailStat(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("terminalid", statreport.getTerminalid());
			User user = userDao.findById(statreport.getUserid());
			objectMap.put("usercode", user.getUsercode());
			objectMap.put("username", user.getUsername());
			objectMap.put("areacode", user.getAreacode());
			objectMap.put("address", user.getAddress());
			objectMap.put("telephone", user.getTelephone());
			
			objectlist.add(objectMap);
		}
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 订户产品收视详细导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductAudienceDetailStatExcel")
    public String exportUserProductAudienceDetailStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportUserProductAudienceDetailStat(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.terminalid"), statreport.getTerminalid());
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				excelmap.put(getMessage("user.address"), statreport.getAddress());
				excelmap.put(getMessage("user.telephone"), statreport.getTelephone());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryproductid()) && null != form.getQueryproductid()){
				Product product = new Product();
				product.setProductid(form.getQueryproductid());
				product.setNetid(Integer.valueOf(form.getQuerynetid()));
				product = productDao.findByProductid(product);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statreport.userproductname"));
				conditionmap.put("content", product.getProductname());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.terminalid"),getMessage("user.usercode"),getMessage("user.username")
					,getMessage("area.areacode"),getMessage("user.address"),getMessage("user.telephone")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "productAudienceDetailStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 订户产品欠费统计详细
	 */
	@RequestMapping(value = "/userProductArrearsStat")
	public String userProductArrearsStat(Statreport form ,HttpServletRequest request) {
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductArrearsStat";
	}
	
	/**
     * 产品欠费导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductArrearsStatExcelFlag")
    public Map<String,Object> exportUserProductArrearsStatExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.userProductArrearsStatCount(form);
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 订户产品欠费统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductArrearsStatJson")
	public Map<String, Object> userProductArrearsStatJson(int rows,int page,Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = statreportDao.userProductArrearsStatCount(form);
		List<Statreport> list = statreportDao.userProductArrearsStat(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("terminalid", statreport.getTerminalid());
			objectMap.put("terminaltype", getMessage("user.terminaltype." + statreport.getTerminaltype()));
			objectMap.put("productid", statreport.getProductid());
			objectMap.put("productname", statreport.getProductname());
			objectMap.put("starttime", statreport.getStarttime().substring(0, 19));
			objectMap.put("endtime", statreport.getEndtime().substring(0, 19));
			User user = userDao.findById(statreport.getUserid());
			objectMap.put("username", user.getUsername());
			objectMap.put("usercode", user.getUsercode());
			
			objectlist.add(objectMap);
		}
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 订户产品欠费统计导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductArrearsStatExcel")
    public String exportUserProductArrearsStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportUserProductArrearsStat(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.terminalid"), statreport.getTerminalid());
				excelmap.put(getMessage("user.terminaltype"), getMessage("user.terminaltype." + statreport.getTerminaltype()));
				excelmap.put(getMessage("statreport.userproductid"), statreport.getProductid());
				excelmap.put(getMessage("statreport.userproductname"), statreport.getProductname());
				excelmap.put(getMessage("userproduct.starttime"), statreport.getStarttime().substring(0, 19));
				excelmap.put(getMessage("userproduct.endtime"), statreport.getEndtime().substring(0, 19));
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryproductid()) && null != form.getQueryproductid()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("product.productid"));
				conditionmap.put("content", form.getQueryproductid());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("user.terminalid"),getMessage("user.terminaltype"),getMessage("statreport.userproductid")
					,getMessage("statreport.userproductname"),getMessage("userproduct.starttime"),getMessage("userproduct.endtime")
					,getMessage("user.usercode"),getMessage("user.username")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userProductArrearsStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 产品购买统计
	 */
	@RequestMapping(value = "/userProductPurchasedStat")
	public String userProductPurchasedStat(Statreport form ,HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductPurchasedStat";
	}
	
	/**
	 * 产品购买统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductPurchasedStatJson")
	public Map<String, Object> userProductPurchasedStatJson(int rows,int page,Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		Product productform = new Product();
		if(form.getQuerynetid() != "" && form.getQuerynetid() != null){
			productform.setQuerynetid(form.getQuerynetid());
		}
		if(form.getQueryproductname() != "" && form.getQueryproductname() != null){
			productform.setQueryproductname(form.getQueryproductname());
		}
		if(form.getQuerystate() != "" && form.getQuerystate() != null){
			productform.setQuerystate(form.getQuerystate());
		}
		productform.setPager_offset(rows*(page-1));
		productform.setPager_openset(rows);
		Integer total = productDao.findByCount(productform);
		List<Product> productlist = productDao.findByList(productform);
		for (Product product : productlist) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			BusinessReport businessReport = new BusinessReport();
			businessReport.setProductid(product.getProductid());
			businessReport.setQuerystarttime(form.getQuerystarttime());
			businessReport.setQueryendtime(form.getQueryendtime());
			if(form.getQueryareacode() != "" && form.getQueryareacode() != null){
				businessReport.setQueryareacodevalid(form.getQueryareacodevalid());
			}
			product.setNetwork(networkDao.findById(product.getNetid()));
			objectMap.put("netname", product.getNetwork().getNetname());
			objectMap.put("productname", product.getProductname());
			objectMap.put("state", getMessage("product.state." + product.getState()));
			objectMap.put("openbalance", statisticDao.findOpeningBalance(businessReport));
			objectMap.put("closingbalance", statisticDao.findClosingBalance(businessReport));
			objectMap.put("entitlementadded", statisticDao.findEntitlementAdded(businessReport));
			objectMap.put("entitlementremoved", statisticDao.findEntitlementRemoved(businessReport));
			objectMap.put("entitlementexpired", statisticDao.findEntitlementExpired(businessReport));
			objectMap.put("timeperiod", getMessage("statistic.userproduct.from") + form.getQuerystarttime() + getMessage("statistic.userproduct.to") + form.getQueryendtime());
			
			objectlist.add(objectMap);
		}
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 产品购买统计导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductPurchasedStatExcel")
    public String exportUserProductPurchasedStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		Product productform = new Product();
		if(form.getQuerynetid() != "" && form.getQuerynetid() != null){
			productform.setQuerynetid(form.getQuerynetid());
		}
		if(form.getQueryproductname() != "" && form.getQueryproductname() != null){
			productform.setQueryproductname(form.getQueryproductname());
		}
		if(form.getQuerystate() != "" && form.getQuerystate() != null){
			productform.setQuerystate(form.getQuerystate());
		}
		List<Product> productlist = productDao.findByList(productform);
		List<Statreport> statreportlist = new ArrayList<Statreport>();
		if (productlist != null) {
			form.setStatreportList(statreportlist);
			for (Product product : productlist) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				BusinessReport businessReport = new BusinessReport();
				businessReport.setProductid(product.getProductid());
				businessReport.setQuerystarttime(form.getQuerystarttime());
				businessReport.setQueryendtime(form.getQueryendtime());
				if(form.getQueryareacode() != "" && form.getQueryareacode() != null){
					businessReport.setQueryareacodevalid(form.getQueryareacodevalid());
				}
				product.setNetwork(networkDao.findById(product.getNetid()));
				excelmap.put(getMessage("network.netname"), product.getNetwork().getNetname());
				excelmap.put(getMessage("product.productname"), product.getProductname());
				excelmap.put(getMessage("product.state"), getMessage("product.state." + product.getState()));
				excelmap.put(getMessage("statistic.userproduct.openbalance"), statisticDao.findOpeningBalance(businessReport).toString());
				excelmap.put(getMessage("statistic.userproduct.closingbalance"), statisticDao.findClosingBalance(businessReport).toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementadded"), statisticDao.findEntitlementAdded(businessReport).toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementremoved"), statisticDao.findEntitlementRemoved(businessReport).toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementexpired"), statisticDao.findEntitlementExpired(businessReport).toString());
				excelmap.put(getMessage("statistic.userproduct.timeperiod"), getMessage("statistic.userproduct.from") + form.getQuerystarttime() + getMessage("statistic.userproduct.to") + form.getQueryendtime());
				
				Statreport statreport = new Statreport();
				statreport.setExcelMap(excelmap);
				statreportlist.add(statreport);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystate()) && null != form.getQuerystate()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("product.state"));
				conditionmap.put("content", getMessage("product.state." + form.getQuerystate()));
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryproductname()) && null != form.getQueryproductname()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statreport.userproductname"));
				conditionmap.put("content", form.getQueryproductname());
				conditionlist.add(conditionmap);
			}
			String[] columntitle = {getMessage("network.netname"),getMessage("product.productname"),getMessage("product.state")
					,getMessage("statistic.userproduct.openbalance"),getMessage("statistic.userproduct.closingbalance"),getMessage("statistic.userproduct.entitlementadded")
					,getMessage("statistic.userproduct.entitlementremoved"),getMessage("statistic.userproduct.entitlementexpired")
					,getMessage("statistic.userproduct.timeperiod")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userProductPurchasedStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 产品购买收费统计
	 */
	@RequestMapping(value = "/userProductChargeStat")
	public String userProductChargeStat(Statreport form, HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userproductChargeStat";
	}
	
	/**
	 * 产品购买收费Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userProductChargeStatJson")
	public Map<String, Object> userProductChargeStatJson(Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		List<Statreport> statreportlist = statreportDao.userProductChargeStat(form);
		BigDecimal addprice = new BigDecimal(0);//总金
		for (Statreport statreport : statreportlist) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
			objectMap.put("netname", network.getNetname());
			objectMap.put("productid", statreport.getProductid());
			objectMap.put("productname", statreport.getProductname());
			objectMap.put("count", statreport.getCount());
			objectMap.put("totalprice", statreport.getTotalprice());
			objectlist.add(objectMap);
			addprice = addprice.add(statreport.getTotalprice());
		}
		
		List<HashMap<String, Object>> footertlist = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> footerMap = new HashMap<String, Object>();
		footerMap.put("count", getMessage("statistic.totalprice"));
		footerMap.put("totalprice", addprice);
		footertlist.add(footerMap);
		
		result.put("rows", objectlist);
		result.put("footer", footertlist);
		return result;
	}
	
	/**
     * 产品购买收费导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserProductChargeStatExcel")
    public String exportUserProductChargeStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.userProductChargeStat(form);
		if (list != null) {
			form.setStatreportList(list);
			BigDecimal addprice = new BigDecimal(0);//总金
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
				excelmap.put(getMessage("network.netname"), network.getNetname());
				excelmap.put(getMessage("product.productid"), statreport.getProductid());
				excelmap.put(getMessage("product.productname"), statreport.getProductname());
				excelmap.put(getMessage("statistic.count"), statreport.getCount().toString());
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalprice().toString());
				statreport.setExcelMap(excelmap);
				addprice = addprice.add(statreport.getTotalprice());
			}
			Statreport statreport = new Statreport();
			Map<String, String> excelmap = new HashMap<String, String>();
			excelmap.put(getMessage("statistic.count"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), addprice.toString());
			statreport.setExcelMap(excelmap);
			form.getStatreportList().add(statreport);
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getSource()) && null != form.getSource()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("userbusiness.source"));
				conditionmap.put("content", getMessage("userbusiness.source." + form.getSource()));
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			//表头
			String[] columntitle = {getMessage("network.netname"),getMessage("product.productid"),getMessage("product.productname"),
					getMessage("statistic.count"),getMessage("statreport.business.price")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "productChargeStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 移动端业务统计
	 */
	@RequestMapping(value = "/mobileBusinessStat")
	public String mobileBusinessStat(Statreport form) {
		return "statreport/mobileBusinessStat";
	}
	
	/**
	 * 移动端业务统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/mobileBusinessStatJson")
	public Map<String, Object> mobileBusinessStatJson(Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		List<Statreport> statreportlist = statreportDao.mobileBusinessStat(form);
		Integer addcount = 0;//总数
		BigDecimal addprice = new BigDecimal(0);//总金
		for (Statreport statreport : statreportlist) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("businesstypekey", statreport.getBusinesstypekey());
			Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
			if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
				objectMap.put("businesstypename", businesstype.getTypename());
			}else{
				objectMap.put("businesstypename", getMessage("business.type."+statreport.getBusinesstypekey()));
			}
			objectMap.put("count", statreport.getCount());
			objectMap.put("totalprice", statreport.getTotalprice());
			
			addcount = addcount + statreport.getCount();
			addprice = addprice.add(statreport.getTotalprice());
			objectlist.add(objectMap);
		}
		
		List<HashMap<String, Object>> footertlist = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> footerMap = new HashMap<String, Object>();
		footerMap.put("count", getMessage("statistic.totalprice"));
		footerMap.put("totalprice", addprice);
		footertlist.add(footerMap);
		
		result.put("rows", objectlist);
		result.put("footer", footertlist);
		return result;
	}
	
	/**
     * 移动端业务统计导出EXCEL
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportMobileBusinessExcel")
    public String exportMobileBusinessExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.mobileBusinessStat(form);
		if (list != null) {
			form.setStatreportList(list);
			BigDecimal addprice = new BigDecimal(0);//总金
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
				if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
					excelmap.put(getMessage("business.type"), businesstype.getTypename());
				}else{
					excelmap.put(getMessage("business.type"), getMessage("business.type."+statreport.getBusinesstypekey()));
				}
				excelmap.put(getMessage("statistic.count"), statreport.getCount().toString());
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalprice().toString());
				statreport.setExcelMap(excelmap);
				addprice = addprice.add(statreport.getTotalprice());
			}
			Statreport statreport = new Statreport();
			Map<String, String> excelmap = new HashMap<String, String>();
			excelmap.put(getMessage("statistic.count"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), addprice.toString());
			statreport.setExcelMap(excelmap);
			form.getStatreportList().add(statreport);
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			//表头
			String[] columntitle = {getMessage("business.type"),
					getMessage("statistic.count"),getMessage("statreport.business.price")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "mobileBusinessStat_OperitorId" + operator.getOperatorname(), response));
		}
		return null;
	}
	
	/**
	 * 移动端业务明细统计
	 */
	@RequestMapping(value = "/mobileBusinessStatdetail")
	public String mobileBusinessStatdetail(Statreport form) {
		return "statreport/mobileBusinessStatdetail";
	}
	
	/**
     * 移动端业务明细导出验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportMobileBusinessdetailExcelFlag")
    public Map<String,Object> exportMobileBusinessdetailExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.mobileBusinessStatCount(form);	
		
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 移动端业务统计明细Json
	 */
	@ResponseBody
	@RequestMapping(value = "/mobileBusinessStatdetailJson")
	public Map<String, Object> mobileBusinessStatdetailJson(int rows,int page,Statreport form, HttpServletRequest request) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> footerlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		
		if(!"".equals(form.getBusinesstype())){
			form.setBusinesstypes(form.getBusinesstype().split(","));
		}
		
		Integer total = statreportDao.mobileBusinessStatCount(form);
		
		List<Statreport> list = statreportDao.mobileBusinessStatdetail(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("usercode", statreport.getUsercode());
			objectMap.put("content", statreport.getContent());
			objectMap.put("businesstypekey", statreport.getBusinesstypekey());
			Businesstype businesstype = businesstypeDao.findByTypekeyStr(statreport.getBusinesstypekey());
			if("1".equals(businesstype.getDefinedflag())){//自定义业务类型
				objectMap.put("businesstypename", businesstype.getTypename());
			}else{
				objectMap.put("businesstypename", getMessage("business.type."+statreport.getBusinesstypekey()));
			}
			objectMap.put("price", statreport.getTotalmoney());
			objectMap.put("addtime", statreport.getAddtime());
			objectMap.put("areacode", statreport.getAreacode());
			
			String username = statreportDao.findUsername(statreport);
			objectMap.put("username", username);
			//objectMap.put("operatorname", statreport.getOperatorname());
			
			objectlist.add(objectMap);
		}
		//交费总金额
		BigDecimal totalprice = statreportDao.mobileBusinessPayment(form);
		if("".equals(totalprice) || totalprice == null){
			totalprice = new BigDecimal(0);
		}
		HashMap<String, Object> footerMap = new HashMap<String, Object>();
		footerMap.put("businesstypename", getMessage("statistic.totalprice"));
		footerMap.put("price", totalprice);
		footerlist.add(footerMap);
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		result.put("footer", footerlist);
		return result;
	}
	
	/**
	 * 导出移动端业务明细报表excel
	 */
	@RequestMapping(value = "/exportMoblieBusinessdetailExcel")
	public String exportMoblieBusinessdetailExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportmobileBusinessdetail(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				//businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("problemcomplaint.content"), statreport.getContent());
				if("1".equals(statreport.getDefinedflag())){
					excelmap.put(getMessage("service.servicetype"), statreport.getBusinesstypename());
				}else{
					excelmap.put(getMessage("service.servicetype"), getMessage("business.type."+statreport.getBusinesstypekey()));
				}
				excelmap.put(getMessage("statreport.business.price"), statreport.getTotalmoney().toString());
				excelmap.put(getMessage("statreport.business.addtime"), statreport.getAddtime().substring(0, 19));
				//excelmap.put(getMessage("operator.operatorname"), statreport.getOperatorname());
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				statreport.setExcelMap(excelmap);
			}
			//总金
			BigDecimal totalprice = statreportDao.mobileBusinessPayment(form);
			if("".equals(totalprice) || totalprice == null){
				totalprice = new BigDecimal(0);
			}
			Map<String, String> excelmap = new HashMap<String, String>();
			Statreport statreport = new Statreport();
			excelmap.put(getMessage("service.servicetype"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), totalprice.toString());
			statreport.setExcelMap(excelmap);
			list.add(statreport);
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getBusinesstypes()) && null != form.getBusinesstypes()){
				String[] strs = form.getBusinesstypes();
				String str = "";
				for(int i = 0; i < strs.length; i++){
					Businesstype businesstype = businesstypeDao.findByTypekeyStr(strs[i]);
					if("1".equals(businesstype.getDefinedflag())){
						str = str + businesstype.getTypename() + " ";
					}else{
						str = str + getMessage("business.type." + strs[i]) + " ";
					}
				}
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("service.servicetype"));
				conditionmap.put("content", str);
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			//表头s
			String[] columntitle = {getMessage("user.usercode"),getMessage("user.username"),getMessage("service.servicetype")
					,getMessage("problemcomplaint.content")
					,getMessage("statreport.business.price"),getMessage("statreport.business.addtime")
					,getMessage("area.areacode")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "mobileReport_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}
	
	/**
	 * 离线用户统计
	 */
	@RequestMapping(value = "/userOfflineStat")
	public String userOfflineStat(Statreport form, HttpServletRequest request) {
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		return "statreport/userOfflineStat";
	}
	
	/**
	 * 离线用户统计Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userOfflineStatJson")
	public Map<String, Object> userOfflineStatJson(Statreport form) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		List<Statreport> list = statreportDao.userOfflineStat(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("netid", statreport.getNetid());
			Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
			objectMap.put("netname", network.getNetname());
			objectMap.put("productid", statreport.getProductid());
			objectMap.put("productname", statreport.getProductname());
			objectMap.put("count", statreport.getCount());
			objectMap.put("usercount", statreport.getUsercount());
			objectlist.add(objectMap);
		}
		result.put("rows", objectlist);
		return result;
	}
	
	/**
	 * 导出离线用户统计报表excel
	 */
	@RequestMapping(value = "/exportUserOfflineStatExcel")
	public String exportUserOfflineStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.userOfflineStat(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				Network network = networkDao.findById(Integer.valueOf(statreport.getNetid()));
				excelmap.put(getMessage("network.netname"), network.getNetname());
				excelmap.put(getMessage("statreport.userproductid"), statreport.getProductid());
				excelmap.put(getMessage("statreport.userproductname"), statreport.getProductname());
				excelmap.put(getMessage("statreport.terminal.count"), statreport.getCount().toString());
				excelmap.put(getMessage("statreport.user.count"), statreport.getUsercount().toString());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			//表头s
			String[] columntitle = {getMessage("network.netname"),getMessage("statreport.userproductid")
					,getMessage("statreport.userproductname")
					,getMessage("statreport.terminal.count")
					,getMessage("statreport.user.count")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userOffline_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}
	
	/**
	 * 离线用户统计详情
	 */
	@RequestMapping(value = "/userOfflineStatdetail")
	public String userOfflineStatdetail(Statreport form) {
		return "statreport/userOfflineStatDialog";
	}
	
	/**
	 * 离线用户统计详情Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userOfflineStatDialogJson")
	public Map<String, Object> userOfflineStatDialogJson(int rows,int page,Statreport form) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		
		Integer total = statreportDao.userOfflineStatdetailCount(form);
		List<Statreport> list = statreportDao.userOfflineStatdetail(form);
		for (Statreport statreport : list) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("terminalid", statreport.getTerminalid());
			User user = userDao.findById(statreport.getUserid());
			objectMap.put("usercode", user.getUsercode());
			objectMap.put("username", user.getUsername());
			objectMap.put("areacode", user.getAreacode());
			objectMap.put("telephone", user.getTelephone());
			objectMap.put("address", user.getAddress());
			
			objectlist.add(objectMap);
		}
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 导出离线用户统计详情验证
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/exportUserOfflineDetailStatExcelFlag")
    public Map<String,Object> exportUserOfflineDetailStatExcelFlag(Statreport form){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Integer total = statreportDao.userOfflineStatdetailCount(form);	
		
		if(total == null){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.empty"));
		}else if(total >= 20000){
			responseJson.put("flag", "0");
			responseJson.put("error", getMessage("statreport.error.maxdatanum"));
		}else{
			responseJson.put("flag", "1");
		}
		return responseJson;
	}
	
	/**
	 * 导出离线用户统计报表excel
	 */
	@RequestMapping(value = "/exportUserOfflineDetailStatExcel")
	public String exportUserOfflineDetailStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> list = statreportDao.exportuserOfflineStatdetail(form);
		if (list != null) {
			form.setStatreportList(list);
			for (Statreport statreport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("user.terminalid"), statreport.getTerminalid());
				excelmap.put(getMessage("user.usercode"), statreport.getUsercode());
				excelmap.put(getMessage("user.username"), statreport.getUsername());
				excelmap.put(getMessage("area.areacode"), statreport.getAreacode());
				excelmap.put(getMessage("user.telephone"), statreport.getTelephone());
				excelmap.put(getMessage("user.address"), statreport.getAddress());
				statreport.setExcelMap(excelmap);
			}
			form.setExporttype("NORMAL");
			//条件
			List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
			if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
				Network network = new Network();
				network.setNetid(form.getQuerynetid());
				network = networkDao.findByNetid(network);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("network.netname"));
				conditionmap.put("content", network.getNetname());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
				Area area = new Area();
				area.setNetid(Integer.valueOf(form.getQuerynetid()));
				area.setAreacode(form.getQueryareacode());
				area = areaDao.findByAreacode(area);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("area.areacode"));
				conditionmap.put("content", area.getAreaname() + form.getQueryareacode());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQuerystarttime()) && null != form.getQuerystarttime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.querystarttime"));
				conditionmap.put("content", form.getQuerystarttime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryendtime()) && null != form.getQueryendtime()){
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statistic.userproduct.queryendtime"));
				conditionmap.put("content", form.getQueryendtime());
				conditionlist.add(conditionmap);
			}
			if(!"".equals(form.getQueryproductid()) && null != form.getQueryproductid()){
				Product product = new Product();
				product.setProductid(form.getQueryproductid());
				product.setNetid(Integer.valueOf(form.getQuerynetid()));
				product = productDao.findByProductid(product);
				HashMap<String, String> conditionmap = new HashMap<String, String>();
				conditionmap.put("title", getMessage("statreport.userproductname"));
				conditionmap.put("content", product.getProductname());
				conditionlist.add(conditionmap);
			}
			//表头
			String[] columntitle = {getMessage("user.terminalid"),getMessage("user.usercode")
					,getMessage("user.username")
					,getMessage("area.areacode")
					,getMessage("user.telephone"),getMessage("user.address")};
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "userfflineDetail_Operatorid" + operator.getOperatorname(), response));
		}
		
		return null;
	}
	
	/**
	 * 前端用户明细报表
	 */
	@RequestMapping(value = "/userdetailStat")
	public String userdetailStat(Statreport form) {
		return "statreport/userdetailStat";
	}
	
	/**
	 * 前端用户明细报表Json
	 */
	@ResponseBody
	@RequestMapping(value = "/userdetailStatJson")
	public Map<String, Object> userdetailStatJson(Statreport form) {
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		HashMap<String, Object> userMap = new HashMap<String, Object>();
		Integer num = statreportDao.userdetailStat_user(form);
		userMap.put("type1", "总用户数");
		userMap.put("type2", "总用户数");
		userMap.put("num", num);
		objectlist.add(userMap);
		
		//根据订户类型统计
		List<Userlevel> userlevellist = userlevelDao.queryByList(new Userlevel());
		for(Userlevel userlevel : userlevellist){
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			objectMap.put("type1", "用户类型");
			objectMap.put("type2", userlevel.getLevelname() + "数");
			form.setUserlevel(userlevel.getId());
			num = statreportDao.userdetailStat_user(form);
			objectMap.put("num", num);
			objectlist.add(objectMap);
		}
		
		result.put("rows", objectlist);
		return result;
	}
	
	/**
     * 前端用户明细导出EXCEL
     */
	@ResponseBody 
	@RequestMapping(value="/exportUserdetailStatExcel")
    public String exportUserdetailStatExcel(Statreport form, HttpServletResponse response) throws Exception {
		List<Statreport> objectlist = new ArrayList<Statreport>();
		
		Statreport userstatreport = new Statreport();
		Map<String, String> userexcelmap = new HashMap<String, String>();
		form.setQuerystate(null);
		Integer num = statreportDao.userdetailStat_user(form);
		userexcelmap.put("type1", "总用户数");
		userexcelmap.put("type2", "总用户数");
		userexcelmap.put("num", num.toString());
		userstatreport.setExcelMap(userexcelmap);
		objectlist.add(userstatreport);
		
		//根据订户类型统计
		List<Userlevel> userlevellist = userlevelDao.queryByList(new Userlevel());
		for(Userlevel userlevel : userlevellist){
			Statreport statreport = new Statreport();
			HashMap<String, String> excelmap = new HashMap<String, String>();
			excelmap.put("type1", "用户类型");
			excelmap.put("type2", userlevel.getLevelname() + "数");
			form.setUserlevel(userlevel.getId());
			num = statreportDao.userdetailStat_user(form);
			excelmap.put("num", num.toString());
			statreport.setExcelMap(excelmap);
			objectlist.add(statreport);
		}
		
		form.setStatreportList(objectlist);
		
		form.setExporttype("USERDETAILSTAT");
		
		//条件
		List<HashMap<String, String>> conditionlist = new ArrayList<HashMap<String,String>>();
		if(!"".equals(form.getQuerynetid()) && null != form.getQuerynetid()){
			Network network = new Network();
			network.setNetid(form.getQuerynetid());
			network = networkDao.findByNetid(network);
			HashMap<String, String> conditionmap = new HashMap<String, String>();
			conditionmap.put("title", getMessage("network.netname"));
			conditionmap.put("content", network.getNetname());
			conditionlist.add(conditionmap);
		}
		if(!"".equals(form.getQueryareacode()) && null != form.getQueryareacode()){
			Area area = new Area();
			area.setNetid(Integer.valueOf(form.getQuerynetid()));
			area.setAreacode(form.getQueryareacode());
			area = areaDao.findByAreacode(area);
			if(area == null){
				area = new Area();
			}
			HashMap<String, String> conditionmap = new HashMap<String, String>();
			conditionmap.put("title", getMessage("area.areacode"));
			conditionmap.put("content", area.getAreaname());
			conditionlist.add(conditionmap);
		}
		
		//每列标志
		String[] columntitle = {"type1", "type2", "num"};
		Operator operator = (Operator)getSession().getAttribute("Operator");
		form.setReturninfo(resultSetToExcel(form, columntitle, conditionlist, "UserdetailStat_OperitorId" + operator.getOperatorname(), response));
	
		return null;
	}
	
	//导出EXCEL
	public static String resultSetToExcel(Object obj, String[] columntitle, List<HashMap<String, String>> conditionlist, String reportName, HttpServletResponse response) throws Exception {
		XSSFWorkbook workbook = reportTypeHandler(obj, conditionlist, reportName, columntitle);
		return workbook != null ? downloadExcel(workbook, reportName, response) : "fail";
	}

	// 需要在此方法中根据ReportNmae把传入的OBJECT转化相应的PO对象
	// 比如在CONTROLLER中传入的reportName为StoreReport_Storeid15,以"_"分割后的数组[0]就是StoreReport
	// 则在本方法中OBJECT应该转化为StoreReport对应的BusinessReport对象后再进行填表处理
	// 当需要导出不同的Report时需在本方法中增加IF条件来处理
	public static XSSFWorkbook reportTypeHandler(Object obj, List<HashMap<String, String>> conditionlist,String reportName, String[] columntitle) {
		XSSFWorkbook workbook = new XSSFWorkbook();
		String[] type = reportName.split("_");
		XSSFSheet sheet = workbook.createSheet(type[1]);
		// EXCEL 主SHEET 名称
		XSSFRow row = sheet.createRow(0);
		XSSFCell cell = null;
		Statreport target = (Statreport) obj;
		if("NORMAL".equals(target.getExporttype()) || "NORMAL" == target.getExporttype()){//普通统计操作
			int nColumn = columntitle.length;
			int rowIndex = 0;
			//填写条件
			for(HashMap<String, String> conditionmap : conditionlist){
				cell = row.createCell((int)(0));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(conditionmap.get("title"));
				cell = row.createCell((int)(1));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(conditionmap.get("content"));
				rowIndex++;
				row = sheet.createRow((int) rowIndex);
			}
			// 填写表头
			for (int i = 0; i < nColumn; i++) {
				cell = row.createCell((int)(i));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(columntitle[i]);
			}
			rowIndex++;
			// 向EXCEL中逐行填表
			for (Statreport businessReport : target.getStatreportList()) {
				row = sheet.createRow((int) rowIndex);
				for (int j = 0; j < nColumn; j++) {
					cell = row.createCell(j);
					// 如果可以转化为数字则填入数字，如果不行则填入String方便Excel后续处理数据
					/*try {
						Double number = Double.parseDouble(businessReport.getExcelMap().get(columntitle[j]));
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(number);
					} catch (Exception e) {*/
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(businessReport.getExcelMap().get(columntitle[j]));
					//}
				}
				rowIndex++;
			}
		}else if("USERDETAILSTAT".equals(target.getExporttype()) || "USERDETAILSTAT" == target.getExporttype()){
			//前端用户明细统计导出excel特殊处理
			int nColumn = columntitle.length;
			int rowIndex = 0;
			int conditionlength;
			//填写条件
			for(HashMap<String, String> conditionmap : conditionlist){
				row = sheet.createRow((int) rowIndex);
				cell = row.createCell((int)(0));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(conditionmap.get("title"));
				cell = row.createCell((int)(1));
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(conditionmap.get("content"));
				rowIndex++;
			}
			conditionlength = rowIndex;
			// 向EXCEL中逐行填表
			for (Statreport businessReport : target.getStatreportList()) {
				row = sheet.createRow((int) rowIndex);
				for (int j = 0; j < nColumn; j++) {
					cell = row.createCell(j);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(businessReport.getExcelMap().get(columntitle[j]));
				}
				rowIndex++;
			}
			//合并单元格
			sheet.addMergedRegion(new CellRangeAddress(0 + conditionlength,0 + conditionlength,0,1));
			sheet.addMergedRegion(new CellRangeAddress(1 + conditionlength,rowIndex,0,0));
		}	
		return workbook;// 返回数据填写完毕的workbook
	}

	public static String downloadExcel(XSSFWorkbook workbook, String reportName, HttpServletResponse response) throws Exception {
		String filename = reportName + ".xlsx";
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment; filename=" + filename);
		OutputStream ouputStream = response.getOutputStream();
		workbook.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
		return "success";
	}

}
