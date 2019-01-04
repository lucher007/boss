package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gospell.boss.common.ConfigUtil;
import com.gospell.boss.common.DesSecretEncode;
import com.gospell.boss.common.HostBoard;
import com.gospell.boss.common.ReadFromFile;
import com.gospell.boss.common.SystemUtils;
import com.gospell.boss.common.Tools;
import com.gospell.boss.common.ToolsForIpMac;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IComputerDao;
import com.gospell.boss.dao.IMenuDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IOperatorrolerefDao;
import com.gospell.boss.dao.IRoleDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Computer;
import com.gospell.boss.po.Menu;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Operatorroleref;
import com.gospell.boss.po.Role;
import com.gospell.boss.po.Statreport;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.Store;
import com.gospell.boss.controller.SessionListener;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/operator")
@Transactional
public class OperatorController extends BaseController {

	private static final String LOGIN_COOKIE_STARTNAME = "tfc_login_cookie_";// 用户首页cookie前缀名

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IOperatorDao operatorDao;
	@Autowired
	private IMenuDao menuDao;
	@Autowired
	private IStoreDao storeDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IRoleDao roleDao;
	@Autowired
	private IOperatorrolerefDao operatorrolerefDao;
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IComputerDao computerDao; 
	@Autowired
	private IAreaDao areaDao; 
	
	/**
	 * 初始化登录验证
	 */
	@RequestMapping(value = "/initLogin")
	public String initLogin(HttpSession httpSession, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		
		String client_auth_flag = systemparaDao.findByCodeStr("client_auth_flag").getValue();
		if("1".equals(client_auth_flag)){//需要认证客户端
			//String ip = Tools.getIpAddr(request);
			String ip = SystemUtils.getIpAddr(request);
			if(!StringUtils.isEmpty(ip)){
				if((!"0:0:0:0:0:0:0:1".equals(ip)) && (!"127.0.0.1".equals(ip))){
					String macaddress = Tools.getMacAddrByIp(ip);
					//String macaddress = SystemUtils.getMacAddress(ip);
					if(!StringUtils.isEmpty(macaddress)){
						System.out.println("-----------macaddress="+macaddress);
						Computer computerForm = new Computer();
						computerForm.setMacaddress(macaddress);
						computerForm = computerDao.findByMacaddress(computerForm);
						if(computerForm == null || computerForm.getId() == null){
							model.addAttribute("returninfo", getMessage("main.client.notCertified"));
							return "notCertified";
						}
					}else{
						model.addAttribute("returninfo", getMessage("main.client.notCertified"));
						return "notCertified";
					}
				}
			}
		}
		
		// 判断是否需要验证码
		String captcha_check = ConfigUtil.getConfigFilePath("captcha_check", "system.properties");
		model.addAttribute("captcha_check", captcha_check);
		return "login";
		
		
	}

	/**
	 * 初始化登录验证
	 */
	@RequestMapping(value = "/changeLanguage")
	public String changeLanguage(HttpSession httpSession, HttpServletRequest request, Locale locale, Model model) {
		// 判断是否需要验证码
		String captcha_check = ConfigUtil.getConfigFilePath("captcha_check", "system.properties");
		model.addAttribute("captcha_check", captcha_check);
		return "login";
	}

	/**
	 * 用户登录
	 */
	@ResponseBody
	// 此标志就是返回json数据给页面的标志
	@RequestMapping(value = "/login")
	public Map<String, Object> login(Operator form, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 封装返回给页面的json对象
		HashMap<String, Object> responseJson = new HashMap<String, Object>();
        
		//获取服务器徐否需要验证授权标志
		String authorize_check = ConfigUtil.getConfigFilePath("authorize_check", "system.properties");
		if("1".equals(authorize_check)){//需要验证、、
			String authorize_key_path = servletContext.getInitParameter("authorize_key_path");
			String folderpath = servletContext.getRealPath(File.separator) + authorize_key_path + File.separatorChar + "bosskey.key";
			//授权原内容（加密）
			String boss_authorize = ReadFromFile.readFileByLines(folderpath);
			System.out.println("*******boss_authorize_encrypt:"+boss_authorize);
			//授权解密
			boss_authorize = DesSecretEncode.decrypt(boss_authorize);
			System.out.println("*******boss_authorize_decrypt:"+boss_authorize);
			
			if(boss_authorize.isEmpty()){//项目未授权
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("authorize.authorized.not"));
				return responseJson;
			}
			
			String[] authorizeArr = boss_authorize.split(",");
			if(authorizeArr == null || authorizeArr.length != 3){//授权文件错误
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("authorize.key.error"));
				return responseJson;
			}
			
			if(!"BOSS".equals(authorizeArr[0])){//授权文件错误
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("authorize.key.error"));
				return responseJson;
			}
			
			//获取本机所有的MAC地址
			//判断MAC地址标志
//			Boolean macaddress_Flag = false;
//			List<String> macaddresslist = ToolsForIpMac.getMacIds();//获取服务器的MAC地址
//			for (String macaddress : macaddresslist) {
//				if(macaddress.equals(authorizeArr[1])){
//					macaddress_Flag = true;
//					break;
//				}
//			}
//			判断主板序列号标志
			Boolean motherboar_Flag = false;
			//获取本机主板序列号
			String motherboard = HostBoard.getMotherboardSN();
			if(motherboard.equals(authorizeArr[1])){
				motherboar_Flag = true;
			}
			if(!motherboar_Flag){//服务器未授权
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("authorize.authorized.not"));
				return responseJson;
			}
			
			if(!"FFFFFFFF".equals(authorizeArr[2])){//FF表示永久授权
				//验收是否授权已到期
				String currectTime = Tools.getCurrentTimeByFormat("yyyy-MM-dd");
				int date_flag = Tools.compare_date(currectTime, authorizeArr[2], "yyyy-MM-dd");
				if(date_flag == 1){//当前时间在授权时间之后，标识授权以及到期
					responseJson.put("flag", "loginname_error");
					responseJson.put("error", getMessage("authorize.date.expired"));
					return responseJson;
				}else{
					getSession().setAttribute("authorizeexpireddate", authorizeArr[2].substring(0, 10));
				}
			}else{
				getSession().setAttribute("authorizeexpireddate", getMessage("authorize.expiration.permanent"));
			}
		}
		
		//验证客户端是否已经认证
		String client_auth_flag = systemparaDao.findByCodeStr("client_auth_flag").getValue();
		if("1".equals(client_auth_flag)){//需要认证客户端
			String ip = Tools.getIpAddr(request);
			if(!StringUtils.isEmpty(ip)){
				if((!"0:0:0:0:0:0:0:1".equals(ip)) && (!"127.0.0.1".equals(ip))){
					String macaddress = Tools.getMacAddrByIp(ip);
					if(!StringUtils.isEmpty(macaddress)){
						System.out.println("-----------macaddress="+macaddress);
						Computer computerForm = new Computer();
						computerForm.setMacaddress(macaddress);
						computerForm = computerDao.findByMacaddress(computerForm);
						if(computerForm == null || computerForm.getId() == null){
							responseJson.put("flag", "loginname_error");
							responseJson.put("error", getMessage("main.client.notCertified"));
							return responseJson;
						}
					}
				}
			}else{
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("main.client.notCertified"));
				return responseJson;
			}
		}
		
		System.out.println(form.getLoginname());
		System.out.println(form.getPassword());

		// 判断是否需要验证码
		String captcha_check = ConfigUtil.getConfigFilePath("captcha_check", "system.properties");
		if ("1".equals(captcha_check)) {// 系统要求输入验证码
			if (!form.getLogincode().equalsIgnoreCase(session.getAttribute("captcha").toString())) {
				responseJson.put("flag", "logincode_error");
				responseJson.put("error", getMessage("login.logincode.error"));
				return responseJson;
			}
		}

		Operator operator = operatorDao.findByLoginname(form);
		if (operator != null) {
			if (!"1".equals(operator.getState())) {
				responseJson.put("flag", "loginname_error");
				responseJson.put("error", getMessage("operator.state.invalid"));
				return responseJson;
			} else if (!operator.getPassword().equals(form.getPassword())) {
				responseJson.put("flag", "password_error");
				responseJson.put("error", getMessage("login.password.error"));
				return responseJson;
			}
			// 保存操作员到session中
			//operator.setNetid(137);
			session.setAttribute("Operator", operator);

			// 判断是否单点登录（不允许同一个操作员登录同时在俩个客户端在线）
			String single_login = ConfigUtil.getConfigFilePath("single_login", "system.properties");
			if (single_login.equals("1")) {
				SessionListener.isLogined(session, form.getLoginname());
			}
			responseJson.put("flag", "0");
			return responseJson;
		} else {
			responseJson.put("flag", "loginname_error");
			responseJson.put("error", getMessage("login.loginname.error"));
			return responseJson;
		}
	}

	/**
	 * 用户登录后判断权限
	 * 
	 * @Title: logined
	 */
	@RequestMapping(value = "/logined")
	public String logined(Operator form, Model model, HttpSession session) {
		//系统版本号
		String system_version = ConfigUtil.getConfigFilePath("system_version", "system.properties");
		Operator operator = (Operator) session.getAttribute("Operator");
		//菜单对象
		List<Menu> menulist = new ArrayList<Menu>();
		if("admin".equals(operator.getLoginname())){//超级管理员admin能查询到所有的菜单
			  // 查询所有一级菜单
			  Menu menuform = new Menu(); 
			  menuform.setMenutype("1");
			  menuform.setState("1");
			  // 查询有效的菜单
			  menulist = menuDao.queryByList(menuform);
			  // 封装各种1级菜单下的二级菜单
			  if (menulist != null && menulist.size() > 0) { 
				  for (Menu menu : menulist) { 
					  List<Menu> secondmenulist = menuDao.querySecondMenuByPid(menu);
					  menu.setSecondmenulist(secondmenulist); 
			      } 
			  } else {
				  System.out.println("该用户没有权限!");
			  }
		}else{
			Integer roleid = operatorrolerefDao.findByOperatorid(operator.getId()).getRoleid();
			List<Menu> list = menuDao.queryFirstMenuByRoleid(roleid);
			List<Integer> ids = new ArrayList<Integer>();
			for (Menu pid : list) {
				ids.add(pid.getPid());
			}
			menulist = menuDao.queryMenuByIds(ids);
			if (menulist != null && menulist.size() > 0) {
				for (Menu firstmenu : menulist) {
					Menu findsecondmenu = new Menu();
					findsecondmenu.setRoleid(roleid);
					findsecondmenu.setPid(firstmenu.getId());
					List<Menu> secondmenulist = menuDao.queryRelatedSecondMenu(findsecondmenu);
					firstmenu.setSecondmenulist(secondmenulist);
				}
			} else {
				// menu.setReturninfo("该用户没有权限!");
				System.out.println("该用户没有权限!");
			}
		}
		  
		
		
		
		model.addAttribute("menulist", menulist);
		model.addAttribute("operator", operator);
		model.addAttribute("system_version", system_version);
		// saveOpLog(user,
		// Constant.LOGS_OPERATETYPE_LOGIN_ON,"用户登录",this.getRequest());
		return "main/main";
	}

	/**
	 * 重新回到登录界面（SESSION断掉）
	 */
	@RequestMapping(value = "/noPermission")
	public String noPermission(HttpSession httpSession, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		return "noPermission";
	}
	
	/**
	 * 退出系统
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpSession httpSession, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		
		//清空操作员
		httpSession.setAttribute("Operator", null);
		
		
		// 判断是否需要验证码
		String captcha_check = ConfigUtil.getConfigFilePath("captcha_check", "system.properties");
		model.addAttribute("captcha_check", captcha_check);
		return "login";
	}
	
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Operator form) {
		if (StringUtils.isEmpty(form.getQuerystate())) {
			form.setQuerystate("1");
		}
//		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
//		form.setPager_count(operatorDao.findByCount(form));
//		form.setOperatorlist(operatorDao.findByList(form));

		// 构建StoreMap对象
		List<Store> storelist = storeDao.queryByList(new Store());
		Map<Integer, String> storemap = new HashMap<Integer, String>();
		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			storemap.put(store.getId(), store.getStorename());
		}
		form.setStoremap(storemap);

		return "operator/findOperatorList";
	}
	/**
	 * 操作员信息Json
	 */
	@ResponseBody
	@RequestMapping(value = "/operatorBusinessJson")
	public Map<String, Object> operatorBusinessStatJson(Operator form) {
		
		//总数
		Integer total = 0;
		
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> operatorlist = new ArrayList<HashMap<String, Object>>();
		Operator currentoperator = (Operator)getSession().getAttribute("Operator");
		//普通操作员只能查询自己
		if("1".equals(currentoperator.getOperatortype()) || "2".equals(currentoperator.getOperatortype())){
			total = 1;
			HashMap<String, Object> operatorMap = new HashMap<String, Object>();
			operatorMap.put("id", currentoperator.getId());
			Network network = networkDao.findById(currentoperator.getNetid());
			operatorMap.put("netid", currentoperator.getNetid());
			operatorMap.put("netname", network!=null ? network.getNetname() : "");
			Area areaForm = new Area();
			areaForm.setNetid(currentoperator.getNetid());
			areaForm.setAreacode(currentoperator.getAreacode());
			Area area = areaDao.findByAreacode(areaForm);
			Store store = storeDao.findById(currentoperator.getStoreid());
			operatorMap.put("storeid", currentoperator.getStoreid());
			operatorMap.put("storename", store!=null ? store.getStorename() : "");
			operatorMap.put("areacode", currentoperator.getAreacode());
			operatorMap.put("areaname", area!=null ? area.getAreaname() : "");
			operatorMap.put("loginname", currentoperator.getLoginname());  
			operatorMap.put("operatorname", currentoperator.getOperatorname());
			operatorMap.put("operatorcode", currentoperator.getOperatorcode());
			operatorMap.put("operatorlevel", currentoperator.getOperatorlevel());
			operatorMap.put("operatortype", currentoperator.getOperatortype());
			operatorlist.add(operatorMap);
		}else{
			total = operatorDao.findByCount(form);
			List<Operator> list = operatorDao.findByList(form);
			for (Operator operator : list) {
				HashMap<String, Object> operatorMap = new HashMap<String, Object>();
				operatorMap.put("id", operator.getId());
				Network network = networkDao.findById(operator.getNetid());
				operatorMap.put("netid", operator.getNetid());
				operatorMap.put("netname", network!=null ? network.getNetname() : "");
				Area areaForm = new Area();
				areaForm.setNetid(operator.getNetid());
				areaForm.setAreacode(operator.getAreacode());
				Area area = areaDao.findByAreacode(areaForm);
				Store store = storeDao.findById(operator.getStoreid());
				operatorMap.put("storeid", operator.getStoreid());
				operatorMap.put("storename", store!=null ? store.getStorename() : "");
				operatorMap.put("areacode", operator.getAreacode());
				operatorMap.put("areaname", area!=null ? area.getAreaname() : "");
				operatorMap.put("loginname", operator.getLoginname());  
				operatorMap.put("operatorname", operator.getOperatorname());
				operatorMap.put("operatorcode", operator.getOperatorcode());
				operatorMap.put("operatorlevel", operator.getOperatorlevel());
				operatorMap.put("operatortype", operator.getOperatortype());
				operatorlist.add(operatorMap);
			}
		}
		
		result.put("total", total);//页面总数
		result.put("rows", operatorlist);
		return result;
		
	}
	/**
	 * 添加用户信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Operator form) {
		// 构建网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		Map<Integer, String> networkmap = new HashMap<Integer, String>();
		for (Iterator iterator = networklist.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			networkmap.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(networkmap);

		// 构建Role对象
		List<Role> roleList = roleDao.queryByList(new Role());
		Map<Integer, String> roleMap = new HashMap<Integer, String>();
		for (Role role : roleList) {
			roleMap.put(role.getId(), getMessage(role.getRolename()));
		}
		form.setRolemap(roleMap);
		

		// 构建StoreMap对象
		Store storeForm = new Store();
		storeForm.setQuerystate("1");//只查询有效的营业厅
		List<Store> storelist = storeDao.queryByList(storeForm);
		Map<Integer, String> storemap = new HashMap<Integer, String>();
		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			storemap.put(store.getId(), store.getStorename());
		}
		form.setStoremap(storemap);

		return "operator/addOperator";
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Operator form) {
		form.setOperatorcode("A01");
//		form.setOperatortype("0");// 普通操作员
		form.setState("1");// 有效
		form.setAddtime(Tools.getCurrentTime());// 取当前时间
		if ("".equals(form.getLoginname())) {
			form.setReturninfo(getMessage("operator.loginname.empty"));
			return addInit(form);
		} else {
			Operator oldOperator = operatorDao.findByLoginname(form);
			if (oldOperator != null) {
				form.setReturninfo(getMessage("operator.loginname.existed"));
				return addInit(form);
			}
		}
		
		//根据操作员级别,来设置网络和区域值
		if("0".equals(form.getOperatorlevel())){//系统级别，不需要网络和区域
			form.setNetid(null);
			form.setAreacode("");
		}else if("1".equals(form.getOperatorlevel())){//网络级别，不需要区域号
			form.setAreacode("");
		}
		
		operatorDao.save(form);
		System.out.println("after operator id:" + form.getId());

		Operatorroleref orref = new Operatorroleref();
		orref.setOperatorid(form.getId());
		orref.setRoleid(form.getRoleid());
		operatorrolerefDao.save(orref);

		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateInit")
	public String updateInit(Operator form) {

		form.setOperator(operatorDao.findById(form.getId()));
		
		Operatorroleref operatorroleref = operatorrolerefDao.findByOperatorid(form.getId());
		if(operatorroleref == null){
			operatorroleref = new Operatorroleref();
		}

		form.setRoleid(operatorroleref.getRoleid());

		// 构建网络Map对象
		List<Network> networklist = networkDao.queryByList(new Network());
		Map<Integer, String> networkmap = new HashMap<Integer, String>();
		for (Iterator iterator = networklist.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			networkmap.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(networkmap);

		// 构建Role对象
		List<Role> roleList = roleDao.queryByList(new Role());
		Map<Integer, String> roleMap = new HashMap<Integer, String>();
		for (Role role : roleList) {
			roleMap.put(role.getId(), getMessage(role.getRolename()));
		}
		form.setRolemap(roleMap);

		// 构建StoreMap对象
		Store storeForm = new Store();
		storeForm.setQuerystate("1");//只查询有效的营业厅
		List<Store> storelist = storeDao.queryByList(storeForm);
		Map<Integer, String> storemap = new HashMap<Integer, String>();
		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			storemap.put(store.getId(), store.getStorename());
		}
		form.setStoremap(storemap);
		return "operator/updateOperator";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Operator form,HttpSession session) {
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("operator.operatorcode.empty"));
			return updateInit(form);
		}
		if ("".equals(form.getLoginname())) {
			form.setReturninfo(getMessage("operator.loginname.empty"));
			return addInit(form);
		} else {
			Operator oldOperator = operatorDao.findByLoginname(form);
			if (oldOperator != null) {
				form.setReturninfo(getMessage("operator.loginname.existed"));
				return addInit(form);
			}
		}
		// 此操作员选择了营业厅
		if (form.getStoreid() != null) {
			Store store = storeDao.findById(form.getStoreid());
			if (store != null) {
				//System.out.println("store!=null");
				form.setNetid(store.getNetid());
			}
		}
		Operatorroleref orref = operatorrolerefDao.findByOperatorid(form.getId());
		orref.setOperatorid(form.getId());
		orref.setRoleid(form.getRoleid());
		operatorrolerefDao.update(orref);
		// 修改网络信息
		
		//根据操作员级别,来设置网络和区域值
		if("0".equals(form.getOperatorlevel())){//系统级别，不需要网络和区域
			form.setNetid(null);
			form.setAreacode("");
		}else if("1".equals(form.getOperatorlevel())){//网络级别，不需要区域号
			form.setAreacode("");
		}
		
		operatorDao.update(form);
		Operator beforeOperator = (Operator) session.getAttribute("Operator");
		form.setLoginname(beforeOperator.getLoginname());
		session.setAttribute("Operator", operatorDao.findByLoginname(form));
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 密码修改初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updatePasswordInit")
	public String updatePasswordInit(Operator form) {
		form.setOperator(operatorDao.findById(form.getId()));
		return "operator/updatePassword";
	}

	/**
	 * 密码修改
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updatePassword")
	public String updatePassword(Operator form) {
		if ("dialog".equals(form.getRemark())) {
			Operator oldOperator = operatorDao.findById(form.getId());
			String oldpassword = oldOperator.getPassword();
			if (oldpassword != null) {
				if (!oldpassword.equals(getRequest().getParameter("oldPassword"))) {
					form.setReturninfo(getMessage("operator.oldpassword.error"));
					return updatePasswordInit(form);
				}
			}
		}
		form.setPassword(getRequest().getParameter("password"));
		Integer updateFlag = operatorDao.updatePassword(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updatePasswordInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Operator form) {

		// 删除网络，实际上就是修改state为0-无效
		Operator operatordmp = operatorDao.findById(form.getId());
		operatordmp.setState("0");
		operatorDao.update(operatordmp);

		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
    
	/**
	 * 主界面系统帮助
	 * 
	 * @return
	 */
	@RequestMapping(value = "/helpInfoInit")
	public String helpInfoInit() {
		return "operator/helpInfo";
	}
	
	
	/**
	 * 系统帮助文档下载
	 */
	@RequestMapping(value = "/downloadHelpDocument")
	public void downloadHelpDocument(Operator form, HttpServletRequest request, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String filename = "";
			if("stbfiletemplate".equals(request.getParameter("filetype"))){ //机顶盒入库文件模板
				filename = "stbinfo_template.xls";
			}else if("cardfiletemplate".equals(request.getParameter("filetype"))){
				filename = "cardinfo_template.xls";
			}
			
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + filename;
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
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
	}
	
	
	/**
	 * 查询操作员信息
	 */
	@RequestMapping(value = "/findOperatorListForDialog")
	public String findOperatorListForDialog(Operator form) {
		if (StringUtils.isEmpty(form.getQuerystate())) {
			form.setQuerystate("1");
		}
		form.setPager_openset(5);
		form.setPager_count(operatorDao.findByCount(form));
		form.setOperatorlist(operatorDao.findByListForOldPage(form));

		// 构建StoreMap对象
		List<Store> storelist = storeDao.queryByList(new Store());
		Map<Integer, String> storemap = new HashMap<Integer, String>();
		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			storemap.put(store.getId(), store.getStorename());
		}
		form.setStoremap(storemap);

		return "operator/findOperatorListForDialog";
	}
	
	/**
	 * 生成授权KEY
	 */
	@RequestMapping(value = "/createAuthorizeKey")
	public String createAuthorizeKey(Operator   form, HttpServletResponse response) {
		try {
//			List<String> macaddresslist = ToolsForIpMac.getMacIds();//获取服务器的MAC地址
//			if(macaddresslist == null || macaddresslist.size()<0){
//				return null;
//			}
			String motherboard = HostBoard.getMotherboardSN();//获取主板序列号
			if(motherboard == null || motherboard == ""){
				return null;
			}
			//默认获取第一个MAC地址信息
//			String macaddress = macaddresslist.get(0);
//			macaddress = "BOSS," + macaddress;
			
			//用DES加密
//			String macaddress_encrypt = DesSecretEncode.encrypt(macaddress);
			String motherboard_encrypt = DesSecretEncode.encrypt("BOSS,"+motherboard);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + motherboard_encrypt.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("boss_authorize.key", "UTF-8"));
			InputStream fis = new ByteArrayInputStream(motherboard_encrypt.getBytes());  
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
	 * 初始化上传授权KEY
	 */
	@RequestMapping(value = "/uploadAuthorizeKeyInit")
	public String uploadAuthorizeKeyInit(Operator form) {
		return "uploadKey";
	}
	
	/**
	 * 上传授权KEY
	 */
	@RequestMapping(value = "/uploadAuthorizeKey")
	public String uploadAuthorizeKey(Operator form, @RequestParam("uploadfile") MultipartFile file) {
		
		String filename = file.getOriginalFilename();
		if (filename == null || "".equals(filename)) {
			form.setReturninfo(getMessage("uploadify.filename.null"));
			return uploadAuthorizeKeyInit(form);
		}
		// 文件类型
		String[] strArray = filename.split("[.]");
		String type = strArray[strArray.length - 1];
		if (!"key".equals(type)) {
			form.setReturninfo(getMessage("uploadify.filetype.error"));
			return uploadAuthorizeKeyInit(form);
		}
		
		String authorize_key_path = servletContext.getInitParameter("authorize_key_path");
		String folderpath = servletContext.getRealPath(File.separator) + authorize_key_path + File.separatorChar + "bosskey.key";
		try {
			File savefile = new File(folderpath);
			file.transferTo(savefile);
			form.setReturninfo(getMessage("page.execution.success"));
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
			return uploadAuthorizeKeyInit(form);
		}
		return uploadAuthorizeKeyInit(form);
	}
	
	/**
     * 获取area的树形下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getAreaTreeJson")
	public List<Map<String,Object>> getAreaTreeJson(Area form) {  
		Operator operator = (Operator)getSession().getAttribute("Operator");
		String areacode = operator.getAreacode();
		//区域对象
		List<Map<String, Object>> areaTreeJSON = new ArrayList<Map<String, Object>>();
		
		//如果该操作员的区域为空，增加 请选择
		if(StringUtils.isEmpty(areacode)){
			//添加请选择项-默认为空，查询所有
		    HashMap<String,Object> selectMap = new HashMap<String, Object>();
		    selectMap.put("id", "");
		    selectMap.put("text", getMessage("page.select"));
		    areaTreeJSON.add(selectMap);
		    //先判断网络有没有选择
		    if(StringUtils.isNotEmpty(form.getQuerynetid())){
		    	form.setQueryareacode(areacode);
		    	List<Area> areaList = areaDao.queryByList(form);
			    //封装区域属性结构信息
			    for(Area area:areaList){  
			    	if(null == area.getPid()){ 
			    	    HashMap<String,Object> areaMap = new HashMap<String, Object>();
			    	    areaMap.put("id", area.getAreacode());
			    	    areaMap.put("text", area.getAreaname()+"("+area.getAreacode()+")");
			    	    
			    	    List<Map<String, Object>> children = buildNode(area.getId(),areaList);  
			    	    if(null != children && 0 < children.size()){ 
			            	areaMap.put("state", "closed");
			            	areaMap.put("children", children);
			            }  
			            areaTreeJSON.add(areaMap);  
			    	}
			    }  
		    }
		}else{
			 //先判断网络有没有选择
		    if(StringUtils.isNotEmpty(form.getQuerynetid())){
		    	form.setQueryareacode(areacode);
		    	List<Area> areaList = areaDao.queryByList(form);
			    //封装区域属性结构信息
			    for(Area area:areaList){  
			    	if(areacode.equals(area.getAreacode())){//从自己开始封装
			    		 HashMap<String,Object> areaMap = new HashMap<String, Object>();
				    	    areaMap.put("id", area.getAreacode());
				    	    areaMap.put("text", area.getAreaname()+"("+area.getAreacode()+")");
				    	    
				    	    List<Map<String, Object>> children = buildNode(area.getId(),areaList);  
				    	    if(null != children && 0 < children.size()){ 
				            	areaMap.put("state", "closed");
				            	areaMap.put("children", children);
				            }  
				            areaTreeJSON.add(areaMap);  
			    	}
			    }  
		    }
		}
		
	    
	    
	   return areaTreeJSON;
	}  
	
	/** 
	 * 构建区域树型菜单json数据 
	 */  
	public List<Map<String, Object>> buildNode(int pid,List<Area> areaList){  
	    List<Map<String, Object>> areaTreeJSON = new ArrayList<Map<String, Object>>();
	    for(Area area:areaList){  
	    	 HashMap<String,Object> areaMap = new HashMap<String, Object>();
	        if(null != area.getPid() && area.getPid().equals(pid)){  
	        	areaMap.put("id", area.getAreacode());
	    	    areaMap.put("text", area.getAreaname()+"("+area.getAreacode()+")");
	    	    List<Map<String, Object>> children = buildNode(area.getId(),areaList);  
	            if(null != children && 0 < children.size()){ 
	            	areaMap.put("state", "closed");
	            	areaMap.put("children", children);
	            }  
	            areaTreeJSON.add(areaMap);   
	        }  
	    }  
	    return areaTreeJSON;  
	} 
}
