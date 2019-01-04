package com.gospell.boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.CasEmmDao;
import com.gospell.boss.cas.ConditionAddr;
import com.gospell.boss.cas.PvrAuthEmm;
import com.gospell.boss.cas.Stbdefaultmsg;
import com.gospell.boss.common.Tools;

import com.gospell.boss.dao.IAuthorizeDao;
import com.gospell.boss.dao.ICaspnblackcardDao;
import com.gospell.boss.dao.ICaspnblackstbDao;
import com.gospell.boss.dao.ICaspnforcedccDao;
import com.gospell.boss.dao.ICaspnforcedosdDao;
import com.gospell.boss.dao.ICaspnnewemailDao;
import com.gospell.boss.dao.ICaspnnewfingerDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserstbDao;

import com.gospell.boss.po.Authorize;
import com.gospell.boss.po.AuthorizeParamForPages;
import com.gospell.boss.po.Caspnblackcard;
import com.gospell.boss.po.Caspnblackstb;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/cas_pn")
@Transactional
public class Cas_pnController extends BaseController {

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
	private ServletContext servletContext;
	@Autowired
	private IAuthorizeDao authorizeDao;
	@Autowired
	private INetworkDao networkDao;	
	@Autowired
	private IProductDao productDao;
	
	@RequestMapping(value = "/add_Cmd01")
	public String add_Cmd01(AuthorizeParamForPages pageParam) {
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
		return "cas_pn/add_Cmd01";
	}
	
	@RequestMapping(value = "/send_Cmd01")
	public String send_Cmd01(AuthorizeParamForPages pageParam, HttpServletRequest request) {
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
			authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
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
				authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
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
		return add_Cmd01(pageParam);
	}
	
	@RequestMapping(value = "/add_Cmd03")
	public String add_Cmd03(CaCommandParam form) {
		return "cas_pn/add_Cmd03";
	}
	
	@RequestMapping(value = "/add_Cmd34")
	public String add_Cmd34(Stbdefaultmsg form) {
		return "cas_pn/add_Cmd34";
	}

	@RequestMapping(value = "/send_Cmd34")
	public String send_Cmd34(Stbdefaultmsg form, HttpServletRequest request) {

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
		if("0".equals(form.getStbtype())){
		//dvbc
		DVBInfo.put("Frequency", request.getParameter("frequency_c"));
		DVBInfo.put("FEC_outer", request.getParameter("fecouter_c"));
		DVBInfo.put("Modulation", request.getParameter("modulation_c"));
		DVBInfo.put("symbol_rate", request.getParameter("symbolrate_c"));
		DVBInfo.put("FEC_inner", request.getParameter("fecinner_c"));
		}else{
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
		
		// 封装CMD32所需的参数
		CaCommandParam caCommandParam = new CaCommandParam();
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("34"); // 机顶盒开机默认信息
		caCommandParam.setStbdefaultmsg(form);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommandtype("34"); // 条件
		authorize.setCommand(CasEmmDao.getCaCommand(caCommandParam));
		System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd34(form);
	}
	
	
	
	@RequestMapping(value = "/send_Cmd03")
	public String send_Cmd03(CaCommandParam form,HttpServletRequest request) {
		form.setVersiontype("gos_pn");
		form.setCommandtype("3");
		String final_command = CasEmmDao.getCaCommand(form);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("3");
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommand(final_command);
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd03(form);
	}
	
	
	
	@RequestMapping(value = "/find_Cmd29_List")
	public String find_Cmd29_List(Caspnforcedosd form) {
		caspnforcedosdDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnforcedosdDao.findByCount(form));
		form.setCaspnforcedosdlist(caspnforcedosdDao.findByList(form));
		return "cas_pn/find_Cmd29_List";
	}

	@RequestMapping(value = "/add_Cmd29_Init")
	public String add_Cmd29_Init(Caspnforcedosd form) {
		return "cas_pn/add_Cmd29";
	}

	@RequestMapping(value = "/send_Cmd29")
	public String send_Cmd29(Caspnforcedosd form, HttpServletRequest request) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(form.getConditioncontent());
		// 先把Force osd存入数据库，获得其递增的osdid
		form.setIscontrol("1"); // 1：启动，0：取消 此为添加页面，全为启动，取消在另外一个方法
		form.setShowfreq("0"); // ShowFreq：显示频率，目前未使用。
		form.setPriority("0"); // 目前不支持，SMS界面不显示，统一设置为0.
		form.setFontsize("ff");// 前版本不支持，目前不支持，机顶盒组建议采用0xFF;。
		form.setFontcolor("ffffffff"); // 目前不支持，机顶盒组建议采用0xFFFFFFFF;
		form.setBackgroundcolor("ffffffff"); // 目前不支持，机顶盒组建议采用0xFFFFFFFF;
		form.setReserved("ffffffff"); // 保留字节0xFFFFFFFF
		form.setAddtime(Tools.getCurrentTime());
		String stylevalue = form.getStyle().equals("0") ? request.getParameter("scroll_direction") : request.getParameter("scalerelativetoscreen");
		form.setStylevalue(stylevalue); 
		caspnforcedosdDao.save(form);
		// 封装CMD29所需的参数
		CaCommandParam innerComanndParam = new CaCommandParam();
		innerComanndParam.setCommandtype("29"); // force osd
		innerComanndParam.setCaspnforcedosd(form);
		caCommandParam.setCndAddrPara(innerComanndParam);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setConditionaddr(form.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(final_command);
		System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd29_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd29")
	public String send_cancel_Cmd29(Caspnforcedosd form) {
		Caspnforcedosd cancelCaspnforcedosd = caspnforcedosdDao.findById(form.getId());
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(cancelCaspnforcedosd.getConditioncontent());

		CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
		innerComanndParam.setCommandtype("29"); // force osd
		cancelCaspnforcedosd.setIscontrol("0");
		innerComanndParam.setCaspnforcedosd(cancelCaspnforcedosd);
		caCommandParam.setCndAddrPara(innerComanndParam);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);

		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setConditionaddr(cancelCaspnforcedosd.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(final_command);
		System.out.println("final_cas_command:" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);

		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd29_List(form);
	}

	@RequestMapping(value = "/delete_Cmd29")
	public String delete_Cmd29(Caspnforcedosd form) {
		caspnforcedosdDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd29_List(form);
	}
	
	@RequestMapping(value = "/find_Cmd32_List")
	public String find_Cmd32_List(Caspnforcedcc form) {
		caspnforcedccDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnforcedccDao.findByCount(form));
		form.setCaspnforcedcclist(caspnforcedccDao.findByList(form));
		return "cas_pn/find_Cmd32_List";
	}

	@RequestMapping(value = "/add_Cmd32_Init")
	public String add_Cmd32_Init(Caspnforcedcc form) {
		return "cas_pn/add_Cmd32";
	}

	@RequestMapping(value = "/send_Cmd32")
	public String send_Cmd32(Caspnforcedcc form, HttpServletRequest request) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(form.getConditioncontent());
		form.setIscontrol("1"); // 1：启动，0：取消 此为添加页面，全为启动，取消在另外一个方法
		form.setAddtime(Tools.getCurrentTime());
		form.setCardid("1111"); 
		//cardid随意填写，但必须填
		//Card_ID：IC 卡号。Card_ID 可以为具体的某个卡的CardID或0xffffffff（表示所有卡），
		//目前版本CAS只支持条件发送，条件发送时Card_ID字段无效，但需要包含。
		caspnforcedccDao.save(form);
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
		if("0".equals(form.getStbtype())){
		//dvbc
		DVBInfo.put("Frequency", request.getParameter("frequency_c"));
		DVBInfo.put("FEC_outer", request.getParameter("fecouter_c"));
		DVBInfo.put("Modulation", request.getParameter("modulation_c"));
		DVBInfo.put("symbol_rate", request.getParameter("symbolrate_c"));
		DVBInfo.put("FEC_inner", request.getParameter("fecinner_c"));
		}else{
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
		
		// 封装CMD32所需的参数
		CaCommandParam innerComanndParam = new CaCommandParam();
		innerComanndParam.setCommandtype("32"); // force osd
		innerComanndParam.setCaspnforcedcc(form);
		caCommandParam.setCndAddrPara(innerComanndParam);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		// authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); //
		// serverid还没指定

		authorize.setConditionaddr(form.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(CasEmmDao.getCaCommand(caCommandParam));
		//System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd32_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd32")
	public String send_cancel_Cmd32(Caspnforcedcc form) {
		Caspnforcedcc cancelcaspnforcedcc = caspnforcedccDao.findById(form.getId());
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(cancelcaspnforcedcc.getConditioncontent());

		CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
		innerComanndParam.setCommandtype("32"); // force cc
		cancelcaspnforcedcc.setIscontrol("0");
		innerComanndParam.setCaspnforcedcc(cancelcaspnforcedcc);
		caCommandParam.setCndAddrPara(innerComanndParam);

		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setConditionaddr(cancelcaspnforcedcc.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(CasEmmDao.getCaCommand(caCommandParam));
		System.out.println("final_cas_command:" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);

		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd32_List(form);
	}

	@RequestMapping(value = "/delete_Cmd32")
	public String delete_Cmd32(Caspnforcedcc form) {
		caspnforcedccDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd32_List(form);
	}
	
	@RequestMapping(value = "/add_Cmd33")
	public String add_Cmd33(CaCommandParam form) {
		return "cas_pn/add_Cmd33";
	}

	@RequestMapping(value = "/send_Cmd33")
	public String send_Cmd33(CaCommandParam form,HttpServletRequest request) {
		form.setVersiontype("gos_pn");
		form.setCommandtype("33");
		String final_command = CasEmmDao.getCaCommand(form);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("33");
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommand(final_command);
		//System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd33(form);
	}
	
	@RequestMapping(value = "/find_Cmd35_List")
	public String find_Cmd35_List(Caspnnewemail form) {
		caspnnewemailDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnnewemailDao.findByCount(form));
		form.setCasemaillist(caspnnewemailDao.findByList(form));
		return "cas_pn/find_Cmd35_List";
	}

	@RequestMapping(value = "/add_Cmd35_Init")
	public String add_Cmd35_Init(Caspnnewemail form) {
		return "cas_pn/add_Cmd35";
	}

	@RequestMapping(value = "/send_Cmd35")
	public String send_Cmd35(Caspnnewemail form, HttpServletRequest request) {
		// 先把new mail存入数据库，获得其递增的emailid
		form.setEmailoper("0");   // 0:添加 1：删除
		form.setAddtime(Tools.getCurrentTime());
		caspnnewemailDao.save(form);
		System.out.println("**************id**************: " + form.getId());
		// 封装CMD35所需的参数
		CaCommandParam caCommandParam = new CaCommandParam();
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("35"); //  new mail
		caCommandParam.setCaspnnewemail(form);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("35"); // 条件
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommand(final_command);
		System.out.println("***********command************: " + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd35_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd35")
	public String send_cancel_Cmd35(Caspnnewemail form) {
		Caspnnewemail cancelCaspnnewemail = caspnnewemailDao.findById(form.getId());
		cancelCaspnnewemail.setEmailoper("1"); //    0:添加 1：删除
		CaCommandParam caCommandParam = new CaCommandParam(); 
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("35");
		caCommandParam.setCaspnnewemail(cancelCaspnnewemail);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);

		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("35"); // 条件
		authorize.setCommand(final_command);
		System.out.println("***********command***********: " + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd35_List(form);
	}

	@RequestMapping(value = "/delete_Cmd35")
	public String delete_Cmd35(Caspnnewemail form) {
		caspnnewemailDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd35_List(form);
	}

	@RequestMapping(value = "/add_Cmd38")
	public String add_Cmd38(CaCommandParam form,PvrAuthEmm pvrEmm) {
		return "cas_pn/add_Cmd38";
	}
	
	@RequestMapping(value = "/send_Cmd38")
	public String send_Cmd38(CaCommandParam form, PvrAuthEmm pvrEmm,HttpServletRequest request) {
		form.setVersiontype("gos_pn");
		form.setCommandtype("38");
		form.setPvrAuthEmm(pvrEmm);
		
		String final_command = CasEmmDao.getCaCommand(form);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("38");
		authorize.setCommand(final_command);
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd38(form,pvrEmm);
	}
	
	@RequestMapping(value = "/find_Cmd44_List")
	public String find_Cmd44_List(Caspnblackcard form) {
		caspnblackcardDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnblackcardDao.findByCount(form));
		form.setCaspnblackcardlist(caspnblackcardDao.findByList(form));
		return "cas_pn/find_Cmd44_List";
	}

	@RequestMapping(value = "/add_Cmd44_Init")
	public String add_Cmd44_Init(CaCommandParam form) {
		return "cas_pn/add_Cmd44";
	}
	
	@RequestMapping(value = "/send_Cmd44")
	public String send_Cmd44(CaCommandParam form, HttpServletRequest request) {
		form.setVersiontype("gos_pn");
		form.setCommandtype("44");
		form.setOperatorType("0");    //（0：添加，2：删除）
		
		//保存黑名单表
		Caspnblackcard blackcard = new Caspnblackcard();
		blackcard.setCardid(form.getCardid());
		caspnblackcardDao.save(blackcard);
		
		// 发送指令
		Authorize authorize = new Authorize();
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("44");
		authorize.setState("0");
		authorize.setAddtime(Tools.getCurrentTime()); 
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommand(CasEmmDao.getCaCommand(form));
		authorizeDao.save(authorize);

		System.out.println(authorize.getCommand());
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd44_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd44")
	public String send_cancel_Cmd44(Caspnblackcard form) {
		Caspnblackcard cancelCaspnblackcard =  caspnblackcardDao.findById(form.getId());
		if(cancelCaspnblackcard !=null){
		CaCommandParam caCommandParam = new CaCommandParam(); 
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("44");
		caCommandParam.setOperatorType("2");    //（0：添加，2：删除）
		caCommandParam.setCardid(cancelCaspnblackcard.getCardid());
		
		// 发送取消指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("44"); // 条件
		authorize.setCommand(CasEmmDao.getCaCommand(caCommandParam));
		System.out.println(authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		}
		
		return find_Cmd44_List(form);
	}

	@RequestMapping(value = "/delete_Cmd44")
	public String delete_Cmd44(Caspnblackcard form) {
		caspnblackcardDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd44_List(form);
	}
	
	@RequestMapping(value = "/find_Cmd46_List")
	public String find_Cmd46_List(Caspnblackstb form) {
		caspnblackstbDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnblackstbDao.findByCount(form));
		form.setCaspnblackstblist(caspnblackstbDao.findByList(form));
		return "cas_pn/find_Cmd46_List";
	}

	@RequestMapping(value = "/add_Cmd46_Init")
	public String add_Cmd46_Init(Caspnblackstb form) {
		return "cas_pn/add_Cmd46";
	}

	@RequestMapping(value = "/send_Cmd46")
	public String send_Cmd46(Caspnblackstb form,CaCommandParam caParam, HttpServletRequest request) {
		String cardids = request.getParameter("cardids");
		String unselectedcardids = request.getParameter("unselectedcardids");
		form.setRemark(cardids);
		caspnblackstbDao.save(form);
		
		// 封装CMD46所需的参数
		caParam.setVersiontype("gos_pn");
		caParam.setCommandtype("46"); 
		caParam.setOperatorType("0");    //（0：添加，2：删除）
		if (cardids == null || "".equals(cardids)) {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			//封装指令需要的参数
			String[] array = cardids.split(",");
			List<String> cardidList = new ArrayList<String>(Arrays.asList(array));
			caParam.setBlackStbCardidList(cardidList);
			
			for(String save_black_cardid :  cardidList){
				Caspnblackcard black_card = new Caspnblackcard();
				black_card.setCardid(save_black_cardid);
				black_card.setRemark(String.valueOf(form.getId()));
				System.out.println("*********************remark" +black_card.getRemark());
				caspnblackcardDao.save(black_card);
			}
			
			//发送绑定指令
			CaCommandParam stbbingcard = new CaCommandParam();
			stbbingcard.setStbno(caParam.getStbno());
			stbbingcard.setPair_Type("0");
			stbbingcard.setStbBingCardidList(cardidList);
			Authorize bind_authorize = new Authorize();
			bind_authorize.setAddtime(Tools.getCurrentTime());
			bind_authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
			bind_authorize.setCommandtype("36"); // 条件
			bind_authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
			bind_authorize.setCommand(CasEmmDao.getCaCommand(stbbingcard));
			bind_authorize.setState("0");
			authorizeDao.save(bind_authorize);
			
			// 解绑未选中的智能卡
			if(unselectedcardids != null && !("".equals(unselectedcardids))){
				String[] unselected = unselectedcardids.split(",");
				for(String card_to_cancel : unselected){
					System.out.println("here to delete cardid:" +  card_to_cancel);
					Usercard cancel = usercardDao.findByCardidStr(card_to_cancel);		
					if(cancel!=null){
						usercardDao.delete(cancel.getId());
					}
				}
			}
			
			// 发送封装指令。
			Authorize authorize = new Authorize();
			authorize.setAddtime(Tools.getCurrentTime());
			authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
			authorize.setCommandtype("46"); // 条件
			authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
			authorize.setCommand(CasEmmDao.getCaCommand(caParam));
			System.out.println("***********command************: " + authorize.getCommand());
			authorize.setState("0");
			authorizeDao.save(authorize);
			form.setReturninfo(getMessage("page.execution.success"));
		}
		return add_Cmd46_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd46")
	public String send_cancel_Cmd46(Caspnblackstb form) {
		Caspnblackstb cancelCaspnblackstb = caspnblackstbDao.findById(form.getId());
		if(cancelCaspnblackstb !=null){
		CaCommandParam caCommandParam = new CaCommandParam(); 
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("46");
		caCommandParam.setOperatorType("2");    //（0：添加，2：删除）
		caCommandParam.setSend_now_flag("1");
		
		 
		//封装46指令需要的参数
		String[] array = cancelCaspnblackstb.getRemark().split(",");
		List<String> cardidList = new ArrayList<String>(Arrays.asList(array));
		for(String cardid : cardidList){
			Caspnblackcard blackcard_finder = new Caspnblackcard();
			blackcard_finder.setCardid(cardid);
			blackcard_finder.setRemark(String.valueOf(form.getId()));
			Caspnblackcard to_delete = caspnblackcardDao.findByRemark(blackcard_finder);
			if(to_delete !=null){   //防止此卡已经在通过CARD黑名单接口操作中移除了
				caspnblackcardDao.delete(to_delete.getId());
			}
		}
		caCommandParam.setBlackStbCardidList(cardidList);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		
		//发送卡和机顶盒绑定指令
		CaCommandParam stbbingcard = new CaCommandParam();
		stbbingcard.setStbno(cancelCaspnblackstb.getStbno());
		stbbingcard.setPair_Type("0");
		stbbingcard.setStbBingCardidList(cardidList);
		Authorize bind_authorize = new Authorize();
		bind_authorize.setAddtime(Tools.getCurrentTime());
		bind_authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		bind_authorize.setCommandtype("36"); // 条件
		bind_authorize.setCommand(CasEmmDao.getCaCommand(stbbingcard));
		bind_authorize.setState("0");
		authorizeDao.save(bind_authorize);
		
		// 发送取消指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("46"); // 条件
		authorize.setCommand(final_command);
		System.out.println("***********command***********: " + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		}
		return find_Cmd46_List(form);
	}

	@RequestMapping(value = "/delete_Cmd46")
	public String delete_Cmd46(Caspnblackstb form) {
		caspnblackstbDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd46_List(form);
	}
	
	@RequestMapping(value = "/add_Cmd51")
	public String add_Cmd51(CaCommandParam form) {
		return "cas_pn/add_Cmd51";
	}

	@RequestMapping(value = "/send_Cmd51")
	public String send_Cmd51(CaCommandParam form, HttpServletRequest request) {
		form.setVersiontype("gos_pn");
		form.setCommandtype("51");
		String final_command = CasEmmDao.getCaCommand(form);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("51");
		authorize.setCommand(final_command);
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd51(form);
	}

	@RequestMapping(value = "/find_Cmd60_List")
	public String find_Cmd60_List(Caspnnewfinger form) {
		caspnnewfingerDao.findByList(form);
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(caspnnewfingerDao.findByCount(form));
		form.setCaspnnewfingerlist(caspnnewfingerDao.findByList(form));
		return "cas_pn/find_Cmd60_List";
	}

	@RequestMapping(value = "/add_Cmd60_Init")
	public String add_Cmd60_Init(Caspnnewfinger form) {
		return "cas_pn/add_Cmd60";
	}

	@RequestMapping(value = "/send_Cmd60")
	public String send_Cmd60(Caspnnewfinger form, HttpServletRequest request) {
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(form.getConditioncontent());
		form.setIscontrol("1"); // 1：启动，0：取消 此为添加页面，全为启动，取消在另外一个方法
		form.setAddtime(Tools.getCurrentTime());
		caspnnewfingerDao.save(form);
		// 封装CMD60所需的参数
		CaCommandParam innerComanndParam = new CaCommandParam();
		innerComanndParam.setCommandtype("60"); // new finger
		innerComanndParam.setCaspnnewfinger(form);
		caCommandParam.setCndAddrPara(innerComanndParam);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);
		// 发送封装指令。
		Authorize authorize = new Authorize();
		// authorize.setServerid(Integer.valueOf(pageParam.getCaobject())); //
		// serverid还没指定

		authorize.setConditionaddr(form.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setNetid(Integer.valueOf(request.getParameter("netid")));
		authorize.setCommand(final_command);
		System.out.println("***************" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);
		form.setReturninfo(getMessage("page.execution.success"));
		return add_Cmd60_Init(form);
	}

	@RequestMapping(value = "/send_cancel_Cmd60")
	public String send_cancel_Cmd60(Caspnnewfinger form) {
		Caspnnewfinger cancelCaspnnewfinger = caspnnewfingerDao.findById(form.getId());
		CaCommandParam caCommandParam = new CaCommandParam(); // 外层
		caCommandParam.setVersiontype("gos_pn");
		caCommandParam.setCommandtype("14");
		caCommandParam.setConditioncontent(cancelCaspnnewfinger.getConditioncontent());

		CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
		innerComanndParam.setCommandtype("60"); // 
		cancelCaspnnewfinger.setIscontrol("0");
		innerComanndParam.setCaspnnewfinger(cancelCaspnnewfinger);
		caCommandParam.setCndAddrPara(innerComanndParam);
		String final_command = CasEmmDao.getCaCommand(caCommandParam);

		// 发送封装指令。
		Authorize authorize = new Authorize();
		authorize.setConditionaddr(cancelCaspnnewfinger.getConditioncontent());
		authorize.setAddtime(Tools.getCurrentTime());
		authorize.setVersiontype("gos_pn"); // CA版本类型(gos_gn,gos_pn)
		authorize.setCommandtype("14"); // 条件
		authorize.setCommand(final_command);
		System.out.println("final_cas_command:" + authorize.getCommand());
		authorize.setState("0");
		authorizeDao.save(authorize);

		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd60_List(form);
	}

	@RequestMapping(value = "/delete_Cmd60")
	public String delete_Cmd60(Caspnnewfinger form) {
		caspnnewfingerDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return find_Cmd60_List(form);
	}


	
	
}
