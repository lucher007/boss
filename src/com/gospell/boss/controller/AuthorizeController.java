package com.gospell.boss.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.record.CountryRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.CasEmmDao;
import com.gospell.boss.cas.ConditionAddr;
import com.gospell.boss.cas.EmailOrOsdMsg;
import com.gospell.boss.cas.GaoAnEmail;
import com.gospell.boss.cas.GaoanOsdParam;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IAuthorizeDao;
import com.gospell.boss.dao.IAuthorizehistoryDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Authorize;
import com.gospell.boss.po.AuthorizeParamForPages;
import com.gospell.boss.po.Authorizehistory;
import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/authorize")
@Transactional
public class AuthorizeController extends BaseController {

	@Autowired
	private IAuthorizeDao authorizeDao;
	@Autowired
	private IAuthorizehistoryDao authorizehistoryDao;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IUsercardDao usercardDao;
	@Autowired
	private IUserstbDao userstbDao;
	@Autowired
	private IServerDao serverDao;
	
	@RequestMapping(value = "/findByList")
	public String findByList(Authorizehistory form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(authorizehistoryDao.findByCount(form));
		form.setAuthorizehistorylist(authorizehistoryDao.findByList(form));
		return "authorize/findAuthorizehistoryList";
	}

	@RequestMapping(value = "/authorityRenew")
	public String authorityRenew(Authorizehistory form) {
		return "authorize/authorityRenew";
	}

	@RequestMapping(value = "/authorityRenewForPN")
	public String authorityRenewForPN(Authorizehistory form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(authorizehistoryDao.findByCount(form));
		List<Authorizehistory> authorizehistories = authorizehistoryDao.findByList(form);
		form.setAuthorizehistorylist(authorizehistories);
		return "authorize/authorityRenewForPN";
	}

	@RequestMapping(value = "/saveRenewForPN")
	public String saveRenewForPN(Authorizehistory form, HttpServletRequest request) {
		String[] idArray = request.getParameterValues("ids");
		if (idArray == null || idArray.length < 1) {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Authorizehistory authorizehistory = new Authorizehistory();
				authorizehistory.setId(Long.valueOf(idArray[i]));
				// 接下来找到对应的命令,重发
				String command = form.getCommandtype();
				System.out.println(command);
			}
			form.setReturninfo(getMessage("page.execution.success"));
		}
		return authorityRenewForPN(form);
	}

	@RequestMapping(value = "/authorityRenewForGN")
	public String authorityRenewForGN(Authorizehistory form) {
		return "authorize/authorityRenewForGN";
	}

	@RequestMapping(value = "/preAuthorize")
	public String preAuthorize(Authorizehistory form) {
		return "authorize/preAuthorize";
	}

	@RequestMapping(value = "/preAuthorizeForGN")
	public String preAuthorizeForGN(AuthorizeParamForPages pageParam) {
		                            
		Product query_product = new Product();
		String queryproductid = pageParam.getQueryproductid();
		String queryproductname = pageParam.getQueryproductname();
		query_product.setQueryproductid(queryproductid);
		query_product.setQueryproductname(queryproductname);
		query_product.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		query_product.setPager_count(productDao.findByCount(query_product));
		// 更新页面偏移量的值，因为外面套了一层AuthorizeParamForPages,所以需要手动赋值
		query_product.setPager_offset(pageParam.getPager_offset());
		query_product.setPager_visit(pageParam.getPager_visit());
		List<Product> productlist = productDao.findByList(query_product);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
		}
		query_product.setProductlist(productlist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		query_product.setNetworkmap(map);
		pageParam.setProduct(query_product);
		return "authorize/preAuthorizeForGN";
	}

	@RequestMapping(value = "/savePreAuthorizeForGN")
	public String savePreAuthorizeForGN(AuthorizeParamForPages pageParam, HttpServletRequest request) {
		Authorize authorize = new Authorize();
		CaCommandParam caCommandParam = new CaCommandParam();
		caCommandParam.setVersiontype("gos_gn");
		String addressing_mode = pageParam.getAddressing_mode();
		caCommandParam.setAddressingmode(addressing_mode);
		caCommandParam.setCommandtype("193");
		String starttime = pageParam.getStarttime() + " 00:00:00";
		String endtime = pageParam.getEndtime() + " 23:59:59";

		/************************ 封装userproduct ****************************/
		List<Userproduct> userproductList = new ArrayList<Userproduct>();
		String[] idArray = request.getParameterValues("ids");
		if (idArray == null || idArray.length < 1) {
			pageParam.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Userproduct userproduct = new Userproduct();
				userproduct.setType("1"); // 产品
				userproduct.setProductid(productDao.findById(Integer.parseInt(idArray[i])).getProductid());
				userproduct.setStarttime(starttime);
				userproduct.setEndtime(endtime);
				userproductList.add(userproduct);
			}
		}
		caCommandParam.setUserproductlist(userproductList);

		/************************ 封装stbno ****************************/
		if (addressing_mode.equals("0")) {
			String stbno = pageParam.getStbno();
			caCommandParam.setStbno(stbno);
			authorize.setConditionaddr("single stbno:" + stbno);
		} else if (addressing_mode.equals("1")) {
			String startstbno = pageParam.getStartstbno();
			String endstbno = pageParam.getEndstbno();
			caCommandParam.setConditioncount("1");//一段多播条件
			String conditioncontent = startstbno + endstbno;
			caCommandParam.setConditioncontent(conditioncontent);
			authorize.setConditionaddr("range stbno:" + startstbno + "-" + endstbno);
		}
		String final_command = CasEmmDao.getCaCommand(caCommandParam);

		/************************ 封装authoize表 ****************************/
		//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
		Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
		authorize.setNetid(operator.getNetid());
		authorize.setTerminaltype("0"); // 终端类型（0-机顶盒号；1-智能卡号）
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_gn");
		authorize.setCommandtype("193"); // 套餐和节目授权
		authorize.setCommand(final_command);
		authorize.setState("0");
		authorizeDao.save(authorize);

		pageParam.setReturninfo(getMessage("page.execution.success"));
		return preAuthorizeForGN(pageParam);
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/preAuthorizeForPN")
	public String preAuthorizeForPN(AuthorizeParamForPages pageParam) {

		Product query_product = new Product();
		String queryproductid = pageParam.getQueryproductid();
		String queryproductname = pageParam.getQueryproductname();
		query_product.setQueryproductid(queryproductid);
		query_product.setQueryproductname(queryproductname);
		query_product.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		query_product.setPager_count(productDao.findByCount(query_product));
		// 更新页面偏移量的值，因为外面套了一层AuthorizeParamForPages,所以需要手动赋值
		query_product.setPager_offset(pageParam.getPager_offset());
		query_product.setPager_visit(pageParam.getPager_visit());
		List<Product> productlist = productDao.findByList(query_product);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
		}
		query_product.setProductlist(productlist);
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		query_product.setNetworkmap(map);
		pageParam.setProduct(query_product);
		return "authorize/preAuthorizeForPN";
	}

	@RequestMapping(value = "/savePreAuthorizeForPN")
	public String savePreAuthorizeForPN(AuthorizeParamForPages pageParam, HttpServletRequest request) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("1");
		String addressing_mode = request.getParameter("addressing_mode");
		String starttime = pageParam.getStarttime() + " 00:00:00";
		String endtime = pageParam.getEndtime() + " 23:59:59";

		/***************************** 封装userproduct ****************************/
		List<Userproduct> userproductList = new ArrayList<Userproduct>();
		String[] idArray = request.getParameterValues("ids");
		if (idArray == null || idArray.length < 1) {
			pageParam.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Userproduct userproduct = new Userproduct();
				userproduct.setProductid(productDao.findById(Integer.parseInt(idArray[i])).getProductid());
				userproduct.setStarttime(starttime);
				userproduct.setEndtime(endtime);
				userproductList.add(userproduct);
			}
		}
		caCommandParam.setUserproductlist(userproductList);

		/************************ 封装cardid ****************************/
		if (addressing_mode.equals("0")) {
			String cardid = pageParam.getCardid();
			caCommandParam.setCardid(cardid);
			String final_command = CasEmmDao.getCaCommand(caCommandParam);

			/************************ 封装authoize表 ****************************/
			Authorize authorize = new Authorize();
			//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
			Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
			authorize.setNetid(operator.getNetid());
			authorize.setTerminaltype("1"); // 终端类型（0-机顶盒号；1-智能卡号）
			authorize.setCardid(cardid);
			authorize.setAddtime(Tools.getCurrentTime());
			authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
			authorize.setCommandtype("1"); // 节目授权
			authorize.setCommand(final_command);
			authorize.setState("0");
			authorizeDao.save(authorize);

		} else if (addressing_mode.equals("1")) {
			String startcardid = pageParam.getStartcardid();
			String endcardid = pageParam.getEndcardid();
			int min = Integer.valueOf(startcardid);
			int max = Integer.valueOf(endcardid);
			for (int index = min; index <= max; index++) {
				String cardid = String.valueOf(index);
				caCommandParam.setCardid(cardid);
				String final_command = CasEmmDao.getCaCommand(caCommandParam);

				/************************ 封装authoize表 ****************************/
				Authorize authorize = new Authorize();
				//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
				Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
				authorize.setNetid(operator.getNetid());
				authorize.setTerminaltype("1"); // 终端类型（0-机顶盒号；1-智能卡号）
				authorize.setCardid(cardid);
				authorize.setAddtime(Tools.getCurrentTime());
				authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
				authorize.setCommandtype("1"); // 节目授权
				authorize.setCommand(final_command);
				authorize.setState("0");
				authorizeDao.save(authorize);
			}
		}
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return preAuthorizeForPN(pageParam);
	}

	@RequestMapping(value = "/osdAndMail")
	public String osdAndMail(Authorizehistory form) {
		return "authorize/osdAndMail";
	}

	@RequestMapping(value = "/conditionOsdForPN")
	public String conditionOsdForPN(AuthorizeParamForPages pageParam) {
		return "authorize/conditionOsdForPN";
	}

	@RequestMapping(value = "/saveConditionOsdForPN")
	public String saveConditionOsdForPN(AuthorizeParamForPages pageParam, EmailOrOsdMsg form, ConditionAddr conditionAddr) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(conditionAddr.getConditioncontent());
		CaCommandParam cndAddrPara = new CaCommandParam();
		cndAddrPara.setCommandtype("2");
		cndAddrPara.setEmailOrOsdMsg(form);
		caCommandParam.setCndAddrPara(cndAddrPara);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
		Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
		authorize.setNetid(operator.getNetid());
		authorize.setTerminaltype("1"); // 终端类型（0-机顶盒号；1-智能卡号）
		authorize.setConditionaddr("condition cardid:" + conditionAddr.getStartCardid() + "-" + conditionAddr.getEndCardid());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(final_command);
		authorize.setState("0");
		authorizeDao.save(authorize);
		
		pageParam.setEmailorosdmsg(form);
		pageParam.setConditionaddr(conditionAddr);
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return conditionOsdForPN(pageParam);
	}

	@RequestMapping(value = "/osdForGN")
	public String osdForGN(AuthorizeParamForPages pageParam) {
		return "authorize/osdForGN";
	}

	@RequestMapping(value = "/saveOsdForGN")
	public String saveOsdForGN(AuthorizeParamForPages pageParam, GaoanOsdParam form, HttpServletRequest request) {
		Authorize authorize = new Authorize();
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_gn");
		caCommandParam.setCommandtype("178");
		String addressing_mode = pageParam.getAddressing_mode();
		caCommandParam.setAddressingmode(addressing_mode);
		caCommandParam.setGaoanOsdParam(form);

		if (addressing_mode.equals("0")) {
			String stbno = pageParam.getStbno();
			caCommandParam.setStbno(stbno);
			authorize.setConditionaddr("single stbno:" + stbno);
		} else if (addressing_mode.equals("1")) {
			String startstbno = pageParam.getStartstbno();
			String endstbno = pageParam.getEndstbno();
			caCommandParam.setConditioncount("1");//一段多播条件
			String conditioncontent = startstbno + endstbno;
			caCommandParam.setConditioncontent(conditioncontent);
			authorize.setConditionaddr("range stbno:" + startstbno + "-" + endstbno);
		}
		String final_command = CasEmmDao.getCaCommand(caCommandParam);

		/************************ 封装authoize表 ****************************/
		//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
		Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
		authorize.setNetid(operator.getNetid());
		authorize.setTerminaltype("0"); // 终端类型（0-机顶盒号；1-智能卡号）
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_gn");
		authorize.setCommandtype("178"); // OSD
		authorize.setCommand(final_command);
		authorize.setState("0"); // 状态（0-未发送；1-发送失败）
		authorizeDao.save(authorize);
		pageParam.setGaoanosdparam(form);
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return osdForGN(pageParam);
	}

	@RequestMapping(value = "/mailForPN")
	public String mailForPN(AuthorizeParamForPages pageParam) {
		return "authorize/mailForPN";
	}

	@RequestMapping(value = "/saveMailForPN")
	public String saveMailForPN(AuthorizeParamForPages pageParam, EmailOrOsdMsg form, ConditionAddr conditionAddr, HttpServletRequest request) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(conditionAddr.getConditioncontent());
		CaCommandParam cndAddrPara = new CaCommandParam();
		cndAddrPara.setCommandtype("13");
		form.setAddtime(Tools.getCurrentTime());
		cndAddrPara.setEmailOrOsdMsg(form);
		caCommandParam.setCndAddrPara(cndAddrPara);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		Authorize authorize = new Authorize();
		//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
		Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
		authorize.setNetid(operator.getNetid());
		authorize.setTerminaltype("1"); // 终端类型（0-机顶盒号；1-智能卡号）
		authorize.setConditionaddr("condition cardid:" + conditionAddr.getStartCardid() + "-" + conditionAddr.getEndCardid());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(final_command);
		authorize.setState("0");
		authorizeDao.save(authorize);
		pageParam.setEmailorosdmsg(form);
		pageParam.setConditionaddr(conditionAddr);
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return mailForPN(pageParam);
	}

	@RequestMapping(value = "/mailForGN")
	public String mailForGN(AuthorizeParamForPages pageParam) {
		return "authorize/mailForGN";
	}

	@RequestMapping(value = "/saveMailForGN")
	public String saveMailForGN(AuthorizeParamForPages pageParam, GaoAnEmail form, HttpServletRequest request) {
		Authorize authorize = new Authorize();
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_gn");
		caCommandParam.setCommandtype("185");
		String addressing_mode = pageParam.getAddressing_mode();
		
		/************************ 封装stbno ****************************/
		caCommandParam.setAddressingmode(addressing_mode);
		if (addressing_mode.equals("0")) {
			String stbno = pageParam.getStbno();
			caCommandParam.setStbno(stbno);
			authorize.setConditionaddr("single stbno:" + stbno);
		} else if (addressing_mode.equals("1")) {
			String startstbno = pageParam.getStartstbno();
			String endstbno = pageParam.getEndstbno();
			caCommandParam.setConditioncount("1");//一段多播条件
			String conditioncontent = startstbno + endstbno;
			caCommandParam.setConditioncontent(conditioncontent);
			authorize.setConditionaddr("range stbno:" + startstbno + "-" + endstbno);
		}
		
		caCommandParam.setGaoAnEmail(form);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		
		/************************ 封装authoize表 ****************************/
		//authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); // serverid还没指定
		Operator operator = (Operator) getSession().getAttribute("Operator"); // 通过操作员来获取netid,后期可以改为根据caobject获取
		authorize.setNetid(operator.getNetid());
		authorize.setTerminaltype("0"); // 终端类型（0-机顶盒号；1-智能卡号）
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_gn");
		authorize.setCommandtype("185"); // OSD
		authorize.setCommand(final_command);
		authorize.setState("0"); // 状态（0-未发送；1-发送失败）
		
		authorizeDao.save(authorize);
		pageParam.setGaoanemail(form);
		pageParam.setReturninfo(getMessage("page.execution.success"));
		return mailForGN(pageParam);
	}

	@RequestMapping(value = "/forceRestartStbForPN")
	public String forceRestartStbForPN(CaCommandParam form, Area area) {
		return "authorize/forceRestartStbForPN";
	}
	
	@RequestMapping(value = "/findAreaListForDialog")
	public String findAreaListForDialog(Area form) {
		form.setPager_count(areaDao.findByCount(form));
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		List<Area> arealist =areaDao.findByList(form); 

		for(Area area : arealist){
			area.setNetwork(networkDao.findById(area.getNetid()));
		}
		form.setArealist(arealist);
		return "authorize/findAreaListForDialog";
	}
	
	@RequestMapping(value = "/saveForceRestartStbForPN")
	public String saveForceRestartStbForPN(CaCommandParam form) {
		String final_command = CasEmmDao.getCaCommand(form);
		System.out.println(final_command);
		return forceRestartStbForPN(form,new Area());
	}
	
	@RequestMapping(value = "/pvrEntitleForPN")
	public String pvrEntitleForPN(CaCommandParam form) {
		return "authorize/pvrEntitleForPN";
	}
	
	@RequestMapping(value="/findProductListForDialog")
	public String findProductListForDialog(Product form) {
		form.setQuerystate("1");
		form.setPager_openset(5);
		form.setPager_count(productDao.findByCount(form));
		List<Product> productlist = productDao.findByList(form);
		for (Product product : productlist) {
			product.setNetwork(networkDao.findById(product.getNetid()));
		}
		form.setProductlist(productlist);
		
		return "authorize/findProductListForDialog";
	}
	
	@RequestMapping(value = "/cardBlacklistForPN")
	public String cardBlacklistForPN(CaCommandParam form) {
		return "authorize/cardBlacklistForPN";
	}
	
	/**
	 *  获取用户已经购买的设备信息
	 * @return
	 */
	@RequestMapping(value="/getStbCardInfo")
	public String getStbCardInfo(Userstb form,HttpServletRequest request) {
		String stbno  = request.getParameter("stbno");
		List<Usercard> usercardlist = new ArrayList<Usercard>();
		Usercard usercard = usercardDao.findByStbnoStr(stbno);
		if(usercard !=null ){
			usercardlist.add(usercard);
		}
		form.setBingUsercardList(usercardlist);
		return "authorize/stbCardInfo";
	}
	
	@RequestMapping(value="/findUserstbListForDialog")
	public String findUserstbListForDialog(Userstb form) {
		//form.setQuerystate("1"); //使用 
		form.setPager_openset(5);
		form.setVersiontype("gos_pn");
		form.setPager_count(userstbDao.findUserstbCountByServerVersiontype(form));
		List<Userstb> userstbs = userstbDao.findUserstbListByServerVersiontype(form);
		form.setUserstblist(userstbs);
		return "authorize/findUserstbListForDialog";
	}
	
	@RequestMapping(value = "/stbBlacklistForPN")
	public String stbBlacklistForPN(CaCommandParam form) {
		return "authorize/stbBlacklistForPN";
	}
	
	@RequestMapping(value = "/forceOsdForPN")
	public String forceOsdForPN(CaCommandParam form) {
		return "authorize/forceOsdForPN";
	}
	
	@RequestMapping(value = "/deleteErrCardinfoForPN")
	public String deleteErrCardinfoForPN(CaCommandParam form) {
		return "authorize/deleteErrCardinfoForPN";
	}
	
	
	
	
}
