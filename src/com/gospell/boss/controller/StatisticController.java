package com.gospell.boss.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.common.ExportExcel;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAuthorizehistoryDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IStatisticDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Store;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userbusinessdetail;
import com.gospell.boss.po.Userproduct;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/statistic")
@Transactional
public class StatisticController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IOperatorDao operatorDao;
	@Autowired
	private IStoreDao storeDao;
	@Autowired
	private IUserproductDao userproductDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IUserbusinessdetailDao userbusinessdetailDao;
	@Autowired
	private IAuthorizehistoryDao authorizehistoryDao;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private IStatisticDao statisticDao;

	/**
	 * 操作员信息
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/findOperatorList")
	public String findOperatorList(Operator form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(operatorDao.findByCount(form));
		form.setOperatorlist(operatorDao.findByList(form));
		// 构建StoreMap对象
		List<Store> storelist = storeDao.queryByList(new Store());
		Map<Integer, String> storemap = new HashMap<Integer, String>();
		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			storemap.put(store.getId(), store.getStorename());
		}
		form.setStoremap(storemap);

		if (form.getJumping().equals("findOperatorListForOperationStatistic")) {
			return "statistic/findOperatorListForOperationStatistic";
		} else if (form.getJumping().equals("findOperatorListForReport")) {
			return "statistic/findOperatorListForReport";
		} else {
			return "statistic/findOperatorListForReport";
		}
	}

	/**
	 * 营业厅信息
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/findStoreList")
	public String findStoreList(Store form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(storeDao.findByCount(form));
		List<Store> storelist = storeDao.findByList(form);
		for (Store store : storelist) {
			store.setNetwork(networkDao.findById(store.getNetid()));
		}
		form.setStorelist(storelist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "statistic/findStoreList";
	}

	/**
	 * 产品信息
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/findUserProductList")
	public String findProductList(Product form, HttpServletRequest request) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(productDao.findByCount(form));
		List<Product> productlist = productDao.findByList(form);
		// 如果用户选择了querystarttime和queryendtime则用用户选择的,如果没有则选择当前日期前三十天的；
		String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
		String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
		request.setAttribute("querystarttime", querystarttime);
		request.setAttribute("queryendtime", queryendtime);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
			BusinessReport businessReport = new BusinessReport();
			businessReport.setProductid(product.getProductid());
			businessReport.setQuerystarttime(querystarttime);
			businessReport.setQueryendtime(queryendtime);
			//初始订户数量
			businessReport.setOpeningBalance(statisticDao.findOpeningBalance(businessReport));
			//结束订户数量
			businessReport.setClosingBalance(statisticDao.findClosingBalance(businessReport));
			//授权增加人数
			businessReport.setEntitlementAdded(statisticDao.findEntitlementAdded(businessReport));
			//反授权人数
			businessReport.setEntitlementRemoved(statisticDao.findEntitlementRemoved(businessReport));
			//授权到期人数
			businessReport.setEntitlementExpired(statisticDao.findEntitlementExpired(businessReport));
			
			product.setBusinessReport(businessReport);
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
		return "statistic/findUserProductList";
	}

	/**
	 * 订户状态信息
	 */
	@RequestMapping(value = "/findUserList")
	public String findUserList(User form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userDao.findUserStateReportByCount(form));
		List<User> userlist = userDao.findUserStateReport(form);
		for (User user : userlist) {
			user.setNetwork(networkDao.findById(user.getNetid()));
		}
		form.setUserlist(userlist);
		return "statistic/findUserList";
	}

	/**
	 * 操作员日报弹窗
	 */
	@RequestMapping(value = "/operatorReportForDialog")
	public String operatorReportForDialog(BusinessReport form) {
		if(("1").equals(form.getQuerydatetype())){   // 1- year   2-month 3-day
			form.setQuerydate(form.getQueryyear());
		}else if(("2").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQuerymonth());
		}else if(("3").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQueryday());
		}
		
		//Integer count = userbusinessdetailDao.findOperatorReport(form).size();
		//form.setPager_openset(5);
		
		List<BusinessReport> list = userbusinessdetailDao.findOperatorReport(form);
		form.setPager_count(list.size());
		form.setBusinessReportList(list);
		return "statistic/operatorReportForDialog";
	}

	/**
	 * 操作员记录弹窗
	 */
	@RequestMapping(value = "/operationRecordForDialog")
	public String operationRecordForDialog(Userbusinessdetail form) {
		if (("1").equals(form.getQuerydatetype())){   // 1-year 2-month 3-day
			form.setQuerydate(form.getQueryyear());
		}else if (("2").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQuerymonth());
		}else if (("3").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQueryday());
		}
		form.setPager_openset(5);
		form.setPager_count(userbusinessdetailDao.findByCount(form));
		List<Userbusinessdetail> list = userbusinessdetailDao.findOperationByOperatorid(form);
		for(Userbusinessdetail userbusinessdetail : list){
			userbusinessdetail.setUser(userDao.findById(userbusinessdetail.getUserid()));
		}
		form.setUserbusinessdetaillist(list);
		return "statistic/operationRecordForDialog";
	}

	/**
	 * 营业厅弹窗
	 */
	@RequestMapping(value = "/storeReportForDialog")
	public String storeReportForDialog(BusinessReport form) {
		if (("1").equals(form.getQuerydatetype())){   //1-year 2-month 3-day
			form.setQuerydate(form.getQueryyear());
		}else if (("2").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQuerymonth());
		}else if (("3").equals(form.getQuerydatetype())){
			form.setQuerydate(form.getQueryday());
		}
		form.setPager_openset(5);
		form.setPager_count(userbusinessdetailDao.findStoreReport(form).size());
		List<BusinessReport> list = userbusinessdetailDao.findStoreReport(form);
		form.setBusinessReportList(list);
		return "statistic/storeReportForDialog";
	}

	/**
	 * 导出操作员报表excel
	 */
	@RequestMapping(value = "/findExportOperatorReportExcel")
	public String findExportOperatorReportExcel(BusinessReport form, HttpServletResponse response) throws Exception {
		if (("1").equals(form.getQuerydatetype())) {   //1- year 2-month 3-day
			form.setQuerydate(form.getQueryyear());
		}else if (("2").equals(form.getQuerydatetype())) {
			form.setQuerydate(form.getQuerymonth());
		}else if (("3").equals(form.getQuerydatetype())) {
			form.setQuerydate(form.getQueryday());
		}
		List<BusinessReport> list = userbusinessdetailDao.findOperatorReport(form);
		if (list != null) {
			Integer totalprice = 0;
			form.setBusinessReportList(list);
			for (BusinessReport businessReport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("business.type"), getMessage("business.type." + businessReport.getBusinesstypekey()));
				excelmap.put(getMessage("statistic.count"), businessReport.getCount().toString());
				excelmap.put(getMessage("statreport.business.price"), businessReport.getTotalprice().toString());
				totalprice = businessReport.getTotalprice().intValue()+totalprice;
				businessReport.setExcelMap(excelmap);
			}
			//计算总金额
			Map<String, String> excelmap = new HashMap<String, String>();
			excelmap.put(getMessage("statistic.count"), getMessage("statistic.totalprice"));
			excelmap.put(getMessage("statreport.business.price"), totalprice.toString());
			BusinessReport bs = new BusinessReport();
			bs.setExcelMap(excelmap);
			list.add(bs);
			String[] columntitle = { getMessage("business.type"), getMessage("statistic.count"), getMessage("statreport.business.price") };
			form.setReturninfo(ExportExcel.resultSetToExcel(form, columntitle, "OperatorReport_Operatorid" + form.getOperatorid(), response));
		}
		return null;
	}

	/**
	 * 导出营业厅报表excel
	 */
	@RequestMapping(value = "/findExportStoreReportExcel")
	public String findExportStoreReportExcel(BusinessReport form, HttpServletResponse response) throws Exception {
		if (("1").equals(form.getQuerydatetype())) {   //1- year 2-month 3-day
			form.setQuerydate(form.getQueryyear());
		}else if (("2").equals(form.getQuerydatetype())) {
			form.setQuerydate(form.getQuerymonth());
		}else if (("3").equals(form.getQuerydatetype())) {
			form.setQuerydate(form.getQueryday());
		}
		List<BusinessReport> list = userbusinessdetailDao.findStoreReport(form);
		if (list != null) {
			form.setBusinessReportList(list);
			for (BusinessReport businessReport : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				businessReport.setBusinesstypekey(getMessage(businessReport.getBusinesstypekey()));
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				excelmap.put(getMessage("business.type"), getMessage("business.type." + businessReport.getBusinesstypekey()));
				excelmap.put(getMessage("statistic.count"), businessReport.getCount().toString());
				excelmap.put(getMessage("statistic.totalprice"), businessReport.getTotalprice().toString());
				businessReport.setExcelMap(excelmap);
			}
			String[] columntitle = { getMessage("business.type"), getMessage("statistic.count"), getMessage("statistic.totalprice") };
			form.setReturninfo(ExportExcel.resultSetToExcel(form, columntitle, "StoreReport_storeid" + form.getStoreid(), response));
		}
		return null;
	}

	@RequestMapping(value = "/findExportUserProductReportExcel")
	public String findExportUserProductReportExcel(Product form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Product> productlist = productDao.findForExcel(form);
		if (productlist != null) {
			form.setProductlist(productlist);
			// 如果用户选择了querystarttime和queryendtime则用用户选择的,如果没有则选择当前日期前三十天的；
			String querystarttime = request.getParameter("querystarttime") != "" && request.getParameter("querystarttime") != null ? request.getParameter("querystarttime") : Tools.getSpecifiedDayBefore(Tools.getDateMonthDayStrTwo(), "yyyy-MM-dd", 30);
			String queryendtime = request.getParameter("queryendtime") != "" && request.getParameter("queryendtime") != null ? request.getParameter("queryendtime") : Tools.getDateMonthDayStrTwo();
			String timeperiod = querystarttime +"_"+ queryendtime;
			for (Product product : productlist) {
				product.setNetwork(networkDao.findById(product.getNetid()));
				BusinessReport businessReport = new BusinessReport();
				businessReport.setProductid(product.getProductid());
				businessReport.setQuerystarttime(querystarttime);
				businessReport.setQueryendtime(queryendtime);
				businessReport.setEntitlementAdded(statisticDao.findEntitlementAdded(businessReport));
				businessReport.setEntitlementExpired(statisticDao.findEntitlementExpired(businessReport));
				businessReport.setEntitlementRemoved(statisticDao.findEntitlementRemoved(businessReport));
				businessReport.setOpeningBalance(statisticDao.findOpeningBalance(businessReport));
				businessReport.setClosingBalance(statisticDao.findClosingBalance(businessReport));
				Map<String, String> excelmap = new HashMap<String, String>();
				excelmap.put(getMessage("statistic.userproduct.openbalance"), businessReport.getOpeningBalance().toString());
				excelmap.put(getMessage("statistic.userproduct.closingbalance"), businessReport.getClosingBalance().toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementadded"), businessReport.getEntitlementAdded().toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementremoved"), businessReport.getEntitlementRemoved().toString());
				excelmap.put(getMessage("statistic.userproduct.entitlementexpired"), businessReport.getEntitlementExpired().toString());
				excelmap.put(getMessage("statistic.userproduct.timeperiod"), timeperiod);
				excelmap.put(getMessage("product.productname"), product.getProductname());
				excelmap.put(getMessage("network.netname"), product.getNetwork().getNetname());
				excelmap.put(getMessage("userproduct.state"), getMessage("product.state."+ product.getState()));
				businessReport = new BusinessReport();// 之前取值已经结束，清空类从而减少传输压力
				businessReport.setExcelMap(excelmap);
				product.setBusinessReport(businessReport);
			}
			String[] columntitle = { getMessage("network.netname"), 
												getMessage("product.productname"), 
												getMessage("userproduct.state"), 
												getMessage("statistic.userproduct.openbalance"),
												getMessage("statistic.userproduct.closingbalance"), 
												getMessage("statistic.userproduct.entitlementadded"), 
												getMessage("statistic.userproduct.entitlementremoved"), 
												getMessage("statistic.userproduct.entitlementexpired"), 
												getMessage("statistic.userproduct.timeperiod") };
			form.setReturninfo(ExportExcel.resultSetToExcel(form, columntitle, "ProductReport_" + timeperiod, response));
		}
		return null;
	}

}
