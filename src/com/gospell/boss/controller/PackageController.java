package com.gospell.boss.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;


import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.common.ConfigUtil;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.dao.ICaspnforcedosdDao;
import com.gospell.boss.dao.IDispatchDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IPackageDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserbusinessDao;
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Businesstype;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Computer;
import com.gospell.boss.po.Dispatch;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Package;
import com.gospell.boss.po.Problemcomplaint;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.Store;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userbusiness;
import com.gospell.boss.po.Userbusinessdetail;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IAuthorizeService;
import com.gospell.boss.service.ISystemparaService;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/package")
@Transactional
public class PackageController extends BaseController {

	@Autowired
	private IProductDao productDao;
	@Autowired
	private IPackageDao packageDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IStbDao stbDao;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IProviderDao providerDao;
	@Autowired
	private IServerDao serverDao;
	@Autowired
	private ICardDao cardDao;
	@Autowired
	private IUserbusinessDao userbusinessDao;
	@Autowired
	private IUserstbDao userstbDao;
	@Autowired
	private IAuthorizeService authorizeService;
	@Autowired
	private IUserbusinessdetailDao userbusinessdetailDao;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IDispatchDao dispatchDao;
	@Autowired
	private IUsercardDao usercardDao;
	@Autowired
	private IUserproductDao userproductDao;
	@Autowired
	private ISystemparaService systemparaService;
	
	public List<Userstb> userstbs = new ArrayList<Userstb>();
	public List<Usercard> usercards = new ArrayList<Usercard>();
	public List<Userproduct> userproducts = new ArrayList<Userproduct>();
	public List<Userbusinessdetail> businessdetails = new ArrayList<Userbusinessdetail>();
	public User user = null;
	
	/**
	 * 查询信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Package form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(packageDao.findByCount(form));
		List<Package> packagelist = packageDao.findByList(form);
		for (Package pack : packagelist) {
			pack.setNetwork(networkDao.findById(pack.getNetid()));
		}
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		form.setNetworklist(list);
		
		form.setPackageList(packagelist);
		return "package/findByList";
	}
	
	/**
	 * 查询列表-套餐购买
	 */
	@RequestMapping(value = "/findPackagelistForBuy")
	public String findPackagelistForBuy(Package form) {
		return "package/findPackagelistForBuy";
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryPackagelistJson")
	public Map<String, Object> queryPackagelistJson(Package form,int rows,int page) {
		form.setPager_offset(rows*(page-1));
		form.setPager_openset(rows);
		Integer total = 0;
		total = packageDao.findByCount(form);
		List<Package> packages= packageDao.findByList(form);
		Map<String, Object> json = new HashMap<String, Object>(); 
		List<HashMap<String, Object>> packagelist = new ArrayList<HashMap<String, Object>>();
		for (Package pack : packages) {
			HashMap<String, Object> packMap = new HashMap<String, Object>();
			packMap.put("id", pack.getId());
			Network network = networkDao.findById(pack.getNetid());
			packMap.put("netname", network!=null ? network.getNetname() : "");
			packMap.put("name", pack.getName());
			packMap.put("type", pack.getType());
			packMap.put("totalmoney", pack.getTotalmoney());
			packMap.put("service_ids", pack.getService_ids());  
			packMap.put("package_json", pack.getPackage_json());
			packMap.put("starttime", pack.getStarttime());
			packMap.put("endtime", pack.getEndtime());
			packMap.put("addtime", pack.getAddtime());
			String starttime = pack.getStarttime().substring(0,10);
			String endtime = pack.getEndtime().substring(0,10);
			String cuurrenttime = Tools.getCurrentTimeByFormat("yyyy-MM-dd");
			//当前时间在开始时间和结束时间之内，才能购买
			if(cuurrenttime.compareTo(starttime) >= 0 && cuurrenttime.compareTo(endtime) <= 0){
				packMap.put("buyfalg", "1");
			}else{
				packMap.put("buyfalg", "0");
			}
			
			packagelist.add(packMap);
		}
		json.put("total", total);
		json.put("rows", packagelist);
		return json;
	}
	
	/**
	 * 购买套餐
	 */
	@RequestMapping(value = "/buyPackageInit")
	public String buyPackage(Package form) {
		Package selected_package = packageDao.findById(form.getId());
		Network network = networkDao.findById(selected_package.getNetid());
		form.setNetwork(network);
		form.setName(selected_package.getName());
		form.setPackage_json(selected_package.getPackage_json());
		form.setType(selected_package.getType());
		form.setService_ids(selected_package.getService_ids());
		form.setTotalmoney(selected_package.getTotalmoney());
		//查询参数设置-是否发送机卡配对指令
		String send_stbcardpair_flag = systemparaService.findSystemParaByCodeStr("send_stbcardpair_flag");
		form.setStbcardpairflag(send_stbcardpair_flag);
		
		return "package/buyPackage";
	}
	
	/**
	 * 查询机顶盒信息
	 */
	@RequestMapping(value="/findStbListForDialog")
	public String findStbListForDialog(Stb form) {
		
		Network network = networkDao.findById(Integer.parseInt(form.getQuerynetid()));
		form.setNetwork(network);
		
		form.setPager_openset(5);
		form.setPager_count(stbDao.findByCount(form));
		List<Stb> stblist = stbDao.findByList(form);
		for (Stb stb : stblist) {
			stb.setProvider(providerDao.findById(stb.getProviderid()));
			stb.setNetwork(networkDao.findById(stb.getNetid()));
			stb.setServer(serverDao.findById(stb.getServerid()));
			Card card = cardDao.findByStbnoStr(stb.getStbno());
			if(card != null){
				stb.setPaircardid(card.getCardid());
			}
		}
		form.setStblist(stblist);
		return "package/findStbListForDialog";
	}
	
	/**
	 * 查询智能卡信息
	 */
	@RequestMapping(value="/findCardListForDialog")
	public String findCardListForDialog(Card form) {
		Network network = networkDao.findById(Integer.parseInt(form.getQuerynetid()));
		form.setNetwork(network);
		form.setPager_openset(5);
		form.setPager_count(cardDao.findByCount(form));
		List<Card> cardlist = cardDao.findByList(form);
		for (Card card : cardlist) {
			card.setProvider(providerDao.findById(card.getProviderid()));
			card.setNetwork(networkDao.findById(card.getNetid()));
			card.setServer(serverDao.findById(card.getServerid()));
		}
		form.setCardlist(cardlist);
		return "package/findCardListForDialog";
	}
	
	/**
	 * 添加套餐优惠包信息初始化
	 */
	@RequestMapping(value = "/addPackageInit")
	public String addPackageInit(Package form) {
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		form.setNetworklist(list);
		
		return "package/addPackage";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Package form) {
		//System.out.println("JSON:" + form.getPackage_json());
		String jsonStr = form.getPackage_json();
		JSONObject jsonObj = new JSONObject(jsonStr);
		JSONArray rows = jsonObj.getJSONArray("rows");
		String service_ids= "";
		for(int i = 0; i < rows.length(); i++){
			JSONObject row = rows.getJSONObject(i)	;
			if ("".equals(service_ids)){
				service_ids +=row.getString("id");
			}else{
				service_ids = service_ids + "," + row.getString("id");
			}
		}
		String type = service_ids.indexOf("1") >= 0 ? "0" : "1";   // 0-开户套餐  1-非开户套餐
		form.setType(type);
		form.setService_ids(service_ids);
		form.setAddtime(Tools.getCurrentTime());
		
		//套餐价格
		String totalprice = String.valueOf(jsonObj.getJSONArray("footer").getJSONObject(0).getDouble("totalprice"));
		BigDecimal totalmoney = new BigDecimal("0");
		if(StringUtils.isNotEmpty(totalprice)){
			totalmoney = new BigDecimal(totalprice);
		}
		form.setTotalmoney(totalmoney);
		
		packageDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addPackageInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Package form){
		
		Package pack = packageDao.findById(form.getId());
		Network network = networkDao.findById(pack.getNetid());
		form.setPack(pack);
		form.setNetwork(network);
		
		return "package/updatePackage";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value = "/update")
	public String update(Package form) {
		//System.out.println("JSON:" + form.getPackage_json());
		String jsonStr = form.getPackage_json();
		JSONObject jsonObj = new JSONObject(jsonStr);
		JSONArray rows = jsonObj.getJSONArray("rows");
		String service_ids= "";
		for(int i = 0; i < rows.length(); i++){
			JSONObject row = rows.getJSONObject(i)	;
			if ("".equals(service_ids)){
				service_ids += row.getString("id");
			}else{
				service_ids = service_ids + "," + row.getString("id");
			}
		}
		String type = service_ids.indexOf("1") >= 0 ? "0" : "1";   // 0-开户套餐  1-非开户套餐
		form.setType(type);
		form.setService_ids(service_ids);
		form.setAddtime(Tools.getCurrentTime());
		
		//套餐价格
		String totalprice = String.valueOf(jsonObj.getJSONArray("footer").getJSONObject(0).getDouble("totalprice"));
		BigDecimal totalmoney = new BigDecimal("0");
		if(StringUtils.isNotEmpty(totalprice)){
			totalmoney = new BigDecimal(totalprice);
		}
		form.setTotalmoney(totalmoney);
		
		packageDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Package form) {
		packageDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
	 * 开户页面
	 */
	@RequestMapping(value="/openAccountInit")
	public String openAccountInit(User form) {
		List<Network> netlist = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = netlist.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "package/openAccountInfo";
	}
	
	/**
	 * 封装产品信息
	 */
	@ResponseBody
	@RequestMapping(value = "/getProductList")   //翻页不用请求服务器
	public Map<String, Object> getProductList(Product form,int rows,int page) {
		
//		form.setQuerystate("1");
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
			productMap.put("pricepermonth", product.getPricepermonth());
			productMap.put("subpricepermonth", product.getSubpricepermonth());
			productMap.put("state", product.getState());
			productList.add(productMap);
		}
		json.put("total", total);
		json.put("rows", productList);
		return json;
	}
	
	@RequestMapping(value="/selectUser")
	public String selectUser(User form,HttpServletRequest request) {
		if(form.getId() !=null){
			User user = userDao.findById(form.getId());
			//封装网络信息
			Network network = networkDao.findById(user.getNetid());
			user.setNetwork(network);
			//封装区域信息
			Area area = new Area();
			area.setNetid(user.getNetid());
			area.setAreacode(user.getAreacode());
			area = areaDao.findByAreacode(area);
			user.setArea(area);
			form.setUser(user);
			form.setReturninfo(getMessage("page.execution.success"));
			List<Userstb> userstbs = userstbDao.queryByUserid(form.getId());
			List<Usercard> usercards = usercardDao.findByUserid(form.getId());
			HashMap<String, Object> userstbMap =  new HashMap<String, Object>();
			HashMap<String, Object> usercardsMap =  new HashMap<String, Object>();
			userstbMap.put("rows", userstbs);
			usercardsMap.put("rows", usercards);
			
			JSONObject userstbsJsonObject = new JSONObject(userstbMap);
			form.setUserstbsJson(userstbsJsonObject.toString());
			JSONObject usercardsjJsonObject = new JSONObject(usercardsMap);
			form.setUsercardsJson(usercardsjJsonObject.toString());
		/*	System.out.println("_____________________________");
			System.out.println(form.getUserstbsJson());
			System.out.println(form.getUsercardsJson());
			System.out.println("_____________________________");*/

			return "package/userInfo";
		}else{
			form.setReturninfo(getMessage("page.execution.fail"));
			return null;
		}
	}
	
	@RequestMapping(value = "/findUserListForDialog")
	public String findUserListForDialog(User form) {
		form.setPager_openset(5);
		form.setPager_count(userDao.findByCount(form));
		List<User> userlist = userDao.findByList(form);
		for (User user : userlist) {
			user.setNetwork(networkDao.findById(user.getNetid()));
		}
		form.setUserlist(userlist);
		return "package/findUserListForDialog";
	}
	
	@RequestMapping(value="/saveBuyInfo")
	public String saveBuyInfo(Package form, HttpServletRequest request ) {
		JSONObject jsStr = new JSONObject(form.getPackage_json());
		JSONArray rowsArray =jsStr.getJSONArray("rows");
		for(int i = 0; i<rowsArray.length();i++){
			JSONObject row = rowsArray.getJSONObject(i);
			String serviceid = row.getString("id");
			if((!"".equals(request.getParameter("userid"))) && request.getParameter("userid")!=null){
				System.out.println("______userid______" +  request.getParameter("userid"));
				user = userDao.findById(Integer.valueOf(request.getParameter("userid")));
			}else{
				System.out.println("userid null:" +  request.getParameter("userid"));
			}
			//根据serviceid分发业务操作    //1-开户；2-机顶盒；3-智能卡；4-节目套餐；5-余额充值
			switch (Integer.valueOf(serviceid)) {
				case 1:    //开户
					JsonToUser(row.getJSONArray("children"));   //更新全局变量user
					saveBusiness_OpenAccount(); //插入user取得userid,更新全局变量user,businessdetails
					break;
				case 2:    //机顶盒
					JsonToList_Stb(row.getJSONArray("children"));   //更新全局变量userstbs和usercards(if内置卡机顶盒)
					break;
				case 3:    //智能卡
					JsonToList_Card(row.getJSONArray("children")); //更新全局变量usercards
					break;
				case 4:    //节目套餐
					JsonToList_Userproduct(row.getJSONArray("children"));
					break;
				case 5:    //余额充值
					System.out.println("recharge");
					saveBusiness_Recharge(row.getJSONArray("children").getJSONObject(0));
					break;
			}
			
		}
		saveAll(jsStr);
		
		form.setReturninfo(getMessage("page.execution.success"));
		
		return buyPackage(form);
	}
	
	private void saveAll(JSONObject jsStr) {
		if (userstbs.size() > 0) {saveBusiness_Stb(); }
		if (usercards.size() > 0) {saveBusiness_Card(); }
		if (userproducts.size() > 0) {saveBusiness_Userproduct(); }
		
		//保存最后的业务日志
		if (businessdetails.size() > 0) {saveUserBusiness(String.valueOf(jsStr.getJSONArray("footer").getJSONObject(0).getDouble("totalprice"))); }
		clearAll();
	}
	
	private void clearAll(){
		userstbs.clear();
		usercards.clear();
		userproducts.clear();
		businessdetails.clear();
		user=null;
	}
	
	//根据JSON封装对象的方法
	private void JsonToUser(JSONArray userArray){
		JSONObject json_user = userArray.getJSONObject(0);  //一个套餐只能开一个户，所以直接index=0
		System.out.println("___________________user:" + json_user.toString());
		user=new User();
		user.setNetid(json_user.getInt("netid"));
		user.setAreacode(json_user.getString("areacode"));
		user.setUsername(json_user.getString("username"));
		user.setMobile(json_user.getString("mobile"));
		user.setTelephone(json_user.getString("telephone"));
		user.setEmail(json_user.getString("email"));
		user.setDocumenttype(json_user.getString("documenttype"));
		user.setDocumentno(json_user.getString("documentno"));
		user.setAddress(json_user.getString("address"));
		user.setPassword(json_user.getString("password"));
		user.setState("1");  		//state：0：注销;1：正常;2-报停
		user.setScore(new BigDecimal(0));
		user.setAccount(new BigDecimal(0));
		user.setRemark(String.valueOf(json_user.getDouble("totalprice")));   //暂存开户价格到REMARK里面，由于没字段了
		//如果页面没有输入订户登陆手机APP的密码，系统默认初始化密码
		if(user.getPassword() == null || "".equals(user.getPassword())){
			user.setPassword(ConfigUtil.getConfigFilePath("app_password","system.properties"));
		}
		//如果页面没有输入订户账户余额支付密码，系统默认初始化密码
		if(user.getPaypassword() == null || "".equals(user.getPaypassword())){
			user.setPaypassword(ConfigUtil.getConfigFilePath("app_paypassword","system.properties"));
		}
	}
	
	private void JsonToList_Stb(JSONArray stbArray){
		for(int i=0; i <stbArray.length(); i++){
			Userstb userstb = new Userstb();
			JSONObject json_stb = stbArray.getJSONObject(i);
			//封装正在购买中的机顶盒
			Stb stb_finder = new Stb();
			stb_finder.setStbno(json_stb.getString("stbno"));
			Stb stb = stbDao.findByStbno(stb_finder);
			Server server = serverDao.findById(stb.getServerid());
			userstb.setNetid(user.getNetid());
			userstb.setAreacode(user.getAreacode());
			userstb.setUserid(user.getId());
			userstb.setServerid(stb.getServerid());
			userstb.setStbno(stb.getStbno());
			userstb.setIncardflag(stb.getIncardflag());
			userstb.setAddtime(Tools.getCurrentTime());
			userstb.setState("1");
			userstb.setPrice(new BigDecimal(String.valueOf(json_stb.getDouble("totalprice"))));
			userstb.setMothercardflag(json_stb.getString("mothercardflag"));
			userstb.setServername(server.getServername());
			userstb.setVersiontype(server.getVersiontype());
			
			userstbs.add(userstb);
		}
	}
	
	private void JsonToList_Card(JSONArray cardArray){
		for(int i=0; i <cardArray.length(); i++){
			Usercard usercard = new Usercard();
			JSONObject json_card = cardArray.getJSONObject(i);
			//封装正在购买中的机顶盒
			Card card_finder = new Card();
			card_finder.setCardid(json_card.getString("cardid"));
			Card card = cardDao.findByCardid(card_finder);
			usercard.setNetid(user.getNetid());
			usercard.setAreacode(user.getAreacode());
			usercard.setUserid(user.getId());
			usercard.setServerid(card.getServerid());
			usercard.setCardid(card.getCardid());
			usercard.setIncardflag(card.getIncardflag());
			usercard.setStbno(json_card.getString("stbno"));
			usercard.setState("1");
			usercard.setPrice(new BigDecimal(String.valueOf(json_card.getDouble("totalprice"))));
			usercard.setMothercardflag(json_card.getString("mothercardflag"));
			usercard.setAddtime(Tools.getCurrentTime());
			if (usercard.getMothercardflag().equals("1")) {
				usercard.setMothercardid(json_card.getString("mothercardid"));
			}else{
				usercard.setMothercardid(null);
			}
			System.out.println("mothercardflag:" + usercard.getMothercardflag());
			System.out.println("mothercardid:" + usercard.getMothercardid());
			usercards.add(usercard);
		}
	}
	
	private void JsonToList_Userproduct(JSONArray userProductArray){
		for(int i=0; i <userProductArray.length(); i++){
			JSONObject json_userproduct = userProductArray.getJSONObject(i);
			Userproduct userproduct = new Userproduct();
			
			String terminaltype = json_userproduct.getString("terminaltype");  //终端类型（0-机顶盒号；1-智能卡号）
			String terminalid = json_userproduct.getString("terminalid");
			Integer serverid = null;//CAS服务器ID
			if("1".equals(terminaltype)){//智能卡购买
				Card card = new Card();
				card.setCardid(terminalid);
				userproduct.setCardid(terminalid);
				card = cardDao.findByCardid(card);
				serverid = card.getServerid();
			}else if("0".equals(terminaltype)){//无卡机顶盒购买
				Stb stb = new Stb();
				stb.setStbno(terminalid);
				userproduct.setStbno(terminalid);
				stb = stbDao.findByStbno(stb);
				serverid = stb.getServerid();
			}
			userproduct.setProductid(String.valueOf(json_userproduct.getInt("productid")));
			userproduct.setProductname(json_userproduct.getString("name"));
			userproduct.setStarttime(Tools.getCurrentTimeByFormat("yyyy-MM-dd") + " 00:00:00");
			
			//开始时间增加购买月份，获得结束时间
			String endtime = Tools.addMonth(userproduct.getStarttime(), Integer.valueOf(json_userproduct.getString("count")));
			//结束时间还得往前减一天
			endtime = Tools.addDay(endtime, -1);
			userproduct.setEndtime(endtime + " 23:59:59");
			
			userproduct.setPrice(new BigDecimal(json_userproduct.getString("price")));
			userproduct.setUnit("month");
			userproduct.setBuyamount(Integer.valueOf(json_userproduct.getString("count")));
			userproduct.setTotalmoney(new BigDecimal(String.valueOf(json_userproduct.getDouble("totalprice"))));
			userproduct.setType("1");
			userproduct.setSource("0");
			userproduct.setState("1");
			userproduct.setUserid(user.getId());
			userproduct.setNetid(user.getNetid());
			userproduct.setServerid(serverid);
			userproduct.setTerminalid(terminalid);
			userproduct.setTerminaltype(terminaltype);
			
			userproducts.add(userproduct);
		}
	}
	
	//保存业务的handler
	private void saveBusiness_OpenAccount(){
		Operator operator = (Operator)getSession().getAttribute("Operator");
		//取得remark中暂存的开户价格，并清空remark
		BigDecimal openAccountPrice = new BigDecimal(user.getRemark());
		user.setRemark(null);
		userDao.save(user);
		user = userDao.findById(user.getId());
		if(user.getId() != null){
			System.out.println("_________userid_________"  + user.getId());
			//封装业务明细
			Userbusinessdetail businessdetail = new Userbusinessdetail();
			//	businessdetail.setBusinessid(userbusiness.getId());
			businessdetail.setNetid(user.getNetid());
			businessdetail.setOperatorid(operator.getId());
			businessdetail.setUserid(user.getId());
			businessdetail.setAreacode(user.getAreacode());
			businessdetail.setStoreid(operator.getStoreid());
			businessdetail.setBusinesstypekey("adduser");
			businessdetail.setBusinesstypename(getMessage("business.type.adduser"));
			businessdetail.setContent(getMessage("user.usercode")+":"+user.getUsercode()+";"+getMessage("user.username")+":"+user.getUsername());
			businessdetail.setPrice(openAccountPrice); 
			businessdetail.setTotalmoney(openAccountPrice);
			businessdetail.setAddtime(Tools.getCurrentTime());
			businessdetail.setLogout("0");
			businessdetail.setSource("0");
			businessdetails.add(businessdetail);
		}
	}
	
	private void saveBusiness_Stb(){
		System.out.println("saveBusiness_Stb");
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		for (Userstb userstb : userstbs) {
			//保存订户机顶盒
			userstb.setAddtime(Tools.getCurrentTime());
			userstbDao.save(userstb);
			//改变机顶盒库存状态
			Stb stb = new Stb();
			stb.setStbno(userstb.getStbno());
			stb = stbDao.findByStbno(stb);
			stb.setState("1");
			stbDao.updateStbState(stb);
			
			//系统是否自动添加安装工单
			String systempara = systemparaService.findSystemParaByCodeStr("auto_add_installation_workorder");
			if("1".equals(systempara)){//0-否；1-是
				//新建工单
				Dispatch  dispatch = new Dispatch();
				dispatch.setNetid(user.getNetid());
				dispatch.setAreacode(user.getAreacode());
				dispatch.setProblemtype("0");
				dispatch.setUserid(user.getId());
				dispatch.setAdddate(Tools.getCurrentTime());
				dispatch.setOperatorid(operator.getId());
				dispatch.setState("0");
				dispatch.setContent(getMessage("dispatch.content.installstb")+";"+getMessage("stb.stbno")+":"+stb.getStbno());
				dispatchDao.save(dispatch);
			}
			
			
			Userbusinessdetail businessdetail = new Userbusinessdetail();
			businessdetail.setNetid(user.getNetid());
			businessdetail.setOperatorid(operator.getId());
			businessdetail.setAreacode(user.getAreacode());
			businessdetail.setUserid(user.getId());
			businessdetail.setStoreid(operator.getStoreid());
			businessdetail.setBusinesstypekey("buystb");
			businessdetail.setBusinesstypename(getMessage("business.type.buystb"));
			businessdetail.setBusinesstypename(getMessage("buystb"));
			businessdetail.setTerminalid(userstb.getStbno());
			businessdetail.setTerminaltype("0");
			businessdetail.setStbno(userstb.getStbno());
			businessdetail.setCardid("");
			businessdetail.setContent(userstb.getStbno());
			businessdetail.setPrice(userstb.getPrice());
			businessdetail.setTotalmoney(userstb.getPrice());
			businessdetail.setAddtime(Tools.getCurrentTime());
			businessdetail.setLogout("0");
			businessdetail.setSource("0");
			businessdetails.add(businessdetail);//封装业务明细
		}
		
		//全部保存完成之后，再来发送机顶盒授权,因为涉及到子母卡查询
		for (Userstb userstb : userstbs) {
			//发送授权指令
			if("2".equals(userstb.getIncardflag())){//无卡机顶盒//保存授权
				authorizeService.saveAuthorize_buyStb(userstb);
			}
		}
		
	}
	
	private void saveBusiness_Card(){
			System.out.println("saveBusiness_Card");
			for (Usercard usercard : usercards) {
				//保存订户智能卡
				usercard.setAddtime(Tools.getCurrentTime());
				usercardDao.save(usercard);
				//改变智能卡库存状态
				Card card = new Card();
				card.setCardid(usercard.getCardid());
				card.setState("1");
				cardDao.updateCardState(card);
				//重置机顶盒配对机顶盒
				card.setStbno(null);
				cardDao.updateStbno(card);
				
				Operator operator =  (Operator)getSession().getAttribute("Operator");
				Userbusinessdetail businessdetail = new Userbusinessdetail();
				businessdetail.setNetid(user.getNetid());
				businessdetail.setOperatorid(operator.getId());
				businessdetail.setUserid(user.getId());
				businessdetail.setAreacode(user.getAreacode());
				businessdetail.setStoreid(operator.getStoreid());
				businessdetail.setBusinesstypekey("buycard");
				businessdetail.setBusinesstypename(getMessage("business.type.buystb"));
				businessdetail.setTerminalid(usercard.getCardid());
				businessdetail.setTerminaltype("1");
				businessdetail.setStbno("");
				businessdetail.setCardid(usercard.getCardid());
				businessdetail.setContent(usercard.getCardid());
				businessdetail.setPrice(usercard.getPrice());
				businessdetail.setTotalmoney(usercard.getPrice());
				businessdetail.setAddtime(Tools.getCurrentTime());
				businessdetail.setLogout("0");
				businessdetail.setSource("0");
				businessdetails.add(businessdetail);//封装业务明细
			}
            
			////全部保存完成之后，再来发送智能卡授权,因为涉及到子母卡查询
			for (Usercard usercard : usercards) {
				//发送授权指令
				System.out.println("+++mothercardid+++:" + usercard.getMothercardid());
				authorizeService.saveAuthorize_buyCard(usercard);
			}
			
	}
	
	private void saveBusiness_Userproduct(){
		System.out.println("saveBusiness_ProductPackage");
		for (Userproduct userproduct : userproducts) {
			//保存订户购买产品
			userproduct.setAddtime(Tools.getCurrentTime());
			userproductDao.save(userproduct);
			////发送授权指令
			authorizeService.saveAuthorize_buyProduct(userproduct);
			
			Operator operator =  (Operator)getSession().getAttribute("Operator");
			Userbusinessdetail businessdetail = new Userbusinessdetail();
			businessdetail.setNetid(user.getNetid());
			businessdetail.setOperatorid(operator.getId());
			businessdetail.setAreacode(user.getAreacode());
			businessdetail.setUserid(user.getId());
			businessdetail.setStoreid(operator.getStoreid());
			businessdetail.setBusinesstypekey("buyproduct");
			businessdetail.setBusinesstypename(getMessage("business.type.buyproduct"));
			businessdetail.setTerminalid(userproduct.getTerminalid());
			businessdetail.setTerminaltype(userproduct.getTerminaltype());
			businessdetail.setCardid(userproduct.getCardid());
			businessdetail.setStbno(userproduct.getStbno());
			businessdetail.setProductid(userproduct.getProductid());
			businessdetail.setProductname(userproduct.getProductname());
			businessdetail.setType(userproduct.getType());
			businessdetail.setAddtime(Tools.getCurrentTime());
			businessdetail.setStarttime(userproduct.getStarttime());
			businessdetail.setEndtime(userproduct.getEndtime());
			businessdetail.setContent(userproduct.getProductname());
			System.out.println("saveBusiness_Userproduct:" + businessdetail.getContent());
			businessdetail.setPrice(userproduct.getPrice()); 
			businessdetail.setTotalmoney(userproduct.getTotalmoney());
			businessdetail.setLogout("0");
			businessdetail.setSource("0");
			businessdetails.add(businessdetail);//封装业务明细
		}
	}
	
	private void saveBusiness_Recharge(JSONObject rechargeinfo){
		//修改订户账户余额
		BigDecimal rechargemoney = new BigDecimal(String.valueOf(rechargeinfo.getDouble("rechargemoney")));
		user.setRechargemoney(rechargemoney);
		userDao.rechargeAccount(user);
		//封装业务明细
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		Userbusinessdetail businessdetail = new Userbusinessdetail();
		businessdetail.setNetid(user.getNetid());
		businessdetail.setOperatorid(operator.getId());
		businessdetail.setUserid(user.getId());
		businessdetail.setAreacode(user.getAreacode());
		businessdetail.setStoreid(operator.getStoreid());
		businessdetail.setBusinesstypekey("rechargeaccount");
		businessdetail.setBusinesstypename(getMessage("business.type.rechargeaccount"));
		BigDecimal totalprice =new BigDecimal(String.valueOf(rechargeinfo.getDouble("totalprice")));
		businessdetail.setPrice(totalprice); 
		businessdetail.setTotalmoney(totalprice);
		businessdetail.setContent(getMessage("userbusiness.accountrecharge.rechargemoney")+":"+rechargemoney + "," + getMessage("userbusiness.accountrecharge.rechargepaymoney")+":"+ totalprice);
		businessdetail.setLogout("0");
		businessdetail.setSource("0");
		businessdetails.add(businessdetail);
	}
	
	private void saveUserBusiness(String totalmoney){
			//业务主表
			Operator operator =  (Operator)getSession().getAttribute("Operator");
			Userbusiness userbusiness = new Userbusiness();
			userbusiness.setNetid(user.getNetid());
			userbusiness.setOperatorid(operator.getId());
			userbusiness.setUserid(user.getId());
			userbusiness.setStoreid(operator.getStoreid());
			userbusiness.setAreacode(user.getAreacode());
			userbusiness.setTotalmoney(new BigDecimal(totalmoney));
			userbusiness.setShouldmoney(new BigDecimal(totalmoney));
			userbusiness.setPaymoney(new BigDecimal(totalmoney));
			userbusiness.setSource("0");
			userbusiness.setLogout("0");
			userbusiness.setAddtime(Tools.getCurrentTime());
			userbusiness.setPaytype("0");
			userbusiness.setAccountmoney(new BigDecimal(0));
			userbusinessDao.save(userbusiness);
			//业务明细表
			for (Userbusinessdetail userbusinessdetail : businessdetails) {
				userbusinessdetail.setBusinessid(userbusiness.getId());
				userbusinessdetail.setAddtime(Tools.getCurrentTime());
				userbusinessdetailDao.save(userbusinessdetail);
			}
	}
	
	

}
