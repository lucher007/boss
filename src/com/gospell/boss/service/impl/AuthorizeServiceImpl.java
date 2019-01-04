package com.gospell.boss.service.impl;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.CasEmmDao;
import com.gospell.boss.cas.EmailOrOsdMsg;
import com.gospell.boss.cas.Forcedrestart;
import com.gospell.boss.cas.GosgnCaDao;
import com.gospell.boss.cas.GospnCaDao;
import com.gospell.boss.cas.PvrAuthEmm;
import com.gospell.boss.cas.Researchprogram;
import com.gospell.boss.cas.Stbdefaultmsg;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAuthorizeDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IProductservicerefDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Authorize;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Caspnblackcard;
import com.gospell.boss.po.Caspnblackstb;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Caspnproductplay;
import com.gospell.boss.po.Constant;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Systempara;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IAuthorizeService;
import com.gospell.boss.service.IGosgnCaService;
import com.gospell.boss.service.IGospnCaService;

/**
 * @Title GosgnCaDao.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("authorizeService")
public class AuthorizeServiceImpl implements IAuthorizeService {
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IServerDao serverDao;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private IProductservicerefDao productservicerefDao;
	@Autowired
	private IGosgnCaService gosgnCaService;
	@Autowired
	private IGospnCaService gospnCaService;
	@Autowired
	private IAuthorizeDao authorizeDao; 
	@Autowired
	private IUsercardDao usercardDao; 
	@Autowired
	private IUserproductDao userproductDao; 
	@Autowired
	private IUserstbDao userstbDao; 
	@Autowired
	private ISystemparaDao systemparaDao;
	
	/**
	 * 机顶盒购买业务
	 */
	public void  saveAuthorize_buyStb(Userstb userstb) {
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//机顶盒购买
		authorizer.setStbno(userstb.getStbno());
		authorizer.setCardid("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//高安服务器
		if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			
			//1-机顶盒激活
			String activateStbCommand = gosgnCaService.getActivateStbCommand(userstb);
			authorizer.setCommandtype("165");
			authorizer.setCommand(activateStbCommand);
			authorizeDao.save(authorizer);
			
			//2-运营商初始化
			//封装机顶盒的主副机信息
			if("0".equals(userstb.getMothercardflag())){//主机
				//查询该机顶盒关联的副机
				List<Userstb> subuserstblist = userstbDao.findByMotherstbno(userstb.getStbno());
				userstb.setMatherOrSonStbList(subuserstblist);
				
			}else if("1".equals(userstb.getMothercardflag())){//副机
				List<Userstb> mainuserstbList = new ArrayList<Userstb>();
				Userstb mainuserstb = userstbDao.findByStbnoStr(userstb.getMothercardid());
				if(mainuserstb != null){
					mainuserstbList.add(mainuserstb);
				}
				userstb.setMatherOrSonStbList(mainuserstbList);
			}
			
			String initStbCommand = gosgnCaService.getInitStbCommand(userstb);
			authorizer.setCommandtype("166");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
			
			//终端控制
			String openStbCommand = gosgnCaService.getStopAndOnStbCommand(userstb, "1");
			authorizer.setCommandtype("167");
			authorizer.setCommand(openStbCommand);
			authorizeDao.save(authorizer);
			
		}
	}

	/**
	 * 智能卡购买业务
	 */
	public void  saveAuthorize_buyCard(Usercard usercard) {
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(usercard.getCardid());
		authorizer.setTerminaltype("1");//智能卡购买
		authorizer.setCardid(usercard.getCardid());
		authorizer.setStbno("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//1-运营商发卡
			String initCardCommand = gospnCaService.getInitCardCommand(usercard);
			authorizer.setCommandtype("10");
			authorizer.setCommand(initCardCommand);
			authorizeDao.save(authorizer);
			//2-智能卡开卡
			String activateCardCommand = gospnCaService.getActivateCardCommand(usercard);
			authorizer.setCommandtype("11");
			authorizer.setCommand(activateCardCommand);
			authorizeDao.save(authorizer);
			//机卡绑定
			//获取系统配置参数-是否发送机卡配对指令（0-否；1-是）
			String send_stbcardpair_flag =  getSystemParaByCode("send_stbcardpair_flag");
			if("1".equals(send_stbcardpair_flag)){
				List<Usercard> userardidList = new ArrayList<Usercard>();
				if(!StringUtils.isEmpty(usercard.getStbno())){//绑定机顶盒不为空，表示要绑定
					Usercard usercardPair = usercardDao.findByStbnoStr(usercard.getStbno());
					userardidList.add(usercardPair);
					Userstb userstb = new Userstb();
					userstb.setStbno(usercard.getStbno());
					userstb.setBingUsercardList(userardidList);
					String stbBingCardCommand = gospnCaService.getStbBingCardCommand(userstb);
					authorizer.setCommandtype("36");
					authorizer.setCommand(stbBingCardCommand);
					authorizeDao.save(authorizer);
				}
			}
		}
	}
	
	/**
	 * 单个产品购买授权业务
	 */
	public void  saveAuthorize_buyProduct(Userproduct userproduct) {
		//获取订户信息
		User user = userDao.findById(userproduct.getUserid());
        //获取终端信息
		String terminalid = userproduct.getTerminalid();
		//获取终端类型
		String terminaltype = userproduct.getTerminaltype();
		//获取服务器信息
		Server server = serverDao.findById(userproduct.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(terminalid);
		authorizer.setTerminaltype(terminaltype);
		authorizer.setStbno(userproduct.getStbno());
		authorizer.setCardid(userproduct.getCardid());
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//购买产品授权
			Usercard usercard = usercardDao.findByCardidStr(userproduct.getTerminalid());
			if(usercard == null ){
				usercard = new Usercard();
				usercard.setCardid(userproduct.getTerminalid());
			}
			List<Userproduct> userproductList = new ArrayList<Userproduct>();
			userproductList.add(userproduct);
			usercard.setUserproductList(userproductList);
			String productCommand = gospnCaService.getBuyProductCommand(usercard);
			authorizer.setCommandtype("1");
			authorizer.setCommand(productCommand);
			authorizeDao.save(authorizer);
			
			//母卡是否给子卡授权
			if("0".equals(usercard.getMothercardflag())){//主机
				//副机是否继承主机的产品授权
				String sub_hold_main_flag = getSystemParaByCode("sub_hold_main_flag");
				if("1".equals(sub_hold_main_flag)){//副机继承主机的授权
					//查询该智能卡拥有的子卡
					List<Usercard> subusercardlist =  usercardDao.findByMothercardid(usercard.getCardid());
					for (Usercard subusercard : subusercardlist) {
						//循环给每个子卡都授权该产品
						subusercard.setUserproductList(userproductList);
						String subproductCommand = gospnCaService.getBuyProductCommand(subusercard);
						authorizer.setCardid(subusercard.getCardid());
						authorizer.setTerminalid(subusercard.getCardid());
						authorizer.setCommandtype("1");
						authorizer.setCommand(subproductCommand);
						authorizeDao.save(authorizer);
					}
				}
			}
			
			
	    //高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			//购买产品授权
			Userstb userstb = userstbDao.findByStbnoStr(userproduct.getTerminalid());
			if(userstb == null ){
				userstb = new Userstb();
				userstb.setStbno(userproduct.getTerminalid());
			}
			
			List<Userproduct> userproductList = new ArrayList<Userproduct>();
			userproductList.add(userproduct);
			userstb.setUserproductList(userproductList);
			String productCommand = gosgnCaService.getBuyProductCommand(userstb);
			authorizer.setCommandtype("193");
			authorizer.setCommand(productCommand);
			authorizeDao.save(authorizer);
			
			//主机是否给副机授权
			if("0".equals(userstb.getMothercardflag())){//主机
				//副机是否继承主机的产品授权
				String sub_hold_main_flag = getSystemParaByCode("sub_hold_main_flag");
				if("1".equals(sub_hold_main_flag)){//副机继承主机的授权
					//查询该智能卡拥有的子卡
					List<Userstb> subuserstblist =  userstbDao.findByMotherstbno(userstb.getStbno());
					for (Userstb subuserstb : subuserstblist) {
						//循环给每个子卡都授权该产品
						subuserstb.setUserproductList(userproductList);
						String subproductCommand = gosgnCaService.getBuyProductCommand(subuserstb);
						authorizer.setCommandtype("193");
						authorizer.setStbno(subuserstb.getStbno());
						authorizer.setTerminalid(subuserstb.getStbno());
						authorizer.setCommand(subproductCommand);
						authorizeDao.save(authorizer);
					}
				}
			}
		}
	}
	
	/**
	 * 产品购买授权业务_集团订户批量购买
	 */
	public void  saveAuthorize_buyProduct_batch(List<Userproduct> userproductlist) {
		
	    //获取第一个订购产品作为代表
		Userproduct userproduct = userproductlist.get(0);
		//获取订户信息
		User user = userDao.findById(userproduct.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userproduct.getServerid());
		
		//订购产品授权List
		List<Authorize> authorizerlist = new ArrayList<Authorize>();
		for (Userproduct userproduct2 : userproductlist) {
			//封装授权信息
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(userproduct2.getTerminalid());
			authorizer.setTerminaltype(userproduct2.getTerminaltype());
			authorizer.setStbno(userproduct2.getStbno());
			authorizer.setCardid(userproduct2.getCardid());
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
				Usercard usercard = new Usercard();
				usercard.setCardid(userproduct2.getTerminalid());
				List<Userproduct> userproductList = new ArrayList<Userproduct>();
				userproductList.add(userproduct2);
				usercard.setUserproductList(userproductList);
				String productCommand = gospnCaService.getBuyProductCommand(usercard);
				authorizer.setCommandtype("1");
				authorizer.setCommand(productCommand);
			}else if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
				Userstb userstb = new Userstb();
				userstb.setStbno(userproduct2.getTerminalid());
				List<Userproduct> userproductList = new ArrayList<Userproduct>();
				userproductList.add(userproduct2);
				userstb.setUserproductList(userproductList);
				String productCommand = gosgnCaService.getBuyProductCommand(userstb);
				authorizer.setCommandtype("193");
				authorizer.setCommand(productCommand);
			}
			
			authorizerlist.add(authorizer);
		}
		
		authorizeDao.saveBatch(authorizerlist);
	   
	}
	
	/**
	 * 停开机顶盒
	 * 
	 * @param userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnStb(Userstb userstb,String commandType){
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//机顶盒停开机
		authorizer.setStbno(userstb.getStbno());
		authorizer.setCardid("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//高安服务器
		if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			//停开机
			String initStbCommand = gosgnCaService.getStopAndOnStbCommand(userstb,commandType);
			authorizer.setCommandtype("167");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 批量停开机顶盒
	 * 
	 * @param userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnStb_batch(List<Userstb> userstblist,String commandType){
		Userstb userstb = userstblist.get(0);
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装授权信息
		List<Authorize> authorizelist_11 = new ArrayList<Authorize>();
		for (Userstb userstb2 : userstblist) {
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(userstb2.getStbno());
			authorizer.setTerminaltype("0");//机顶盒停开机
			authorizer.setStbno(userstb2.getStbno());
			authorizer.setCardid("");
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			//停开机
			String initStbCommand = gosgnCaService.getStopAndOnStbCommand(userstb,commandType);
			authorizer.setCommandtype("167");
			authorizer.setCommand(initStbCommand);
			authorizelist_11.add(authorizer);
		}
		
		//高安服务器
		if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			authorizeDao.saveBatch(authorizelist_11);
		}
	}
	
	/**
	 * 停开智能卡
	 * 
	 * @param userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnCard(Usercard usercard,String commandType){
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(usercard.getCardid());
		authorizer.setTerminaltype("1");//智能卡停开机
		authorizer.setCardid(usercard.getCardid());
		authorizer.setStbno("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//停开机
			String initStbCommand = gospnCaService.getStopAndOnCardCommand(usercard,commandType);
			authorizer.setCommandtype("11");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 批量停开智能卡
	 * 
	 * @param userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnCard_batch(List<Usercard> usercardlist,String commandType){
		//获取第一个作为代表
		Usercard usercard = usercardlist.get(0);
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		List<Authorize> authorizelist_11 = new ArrayList<Authorize>();
		for (Usercard usercard2 : usercardlist) {
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(usercard2.getCardid());
			authorizer.setTerminaltype("1");//智能卡停开机
			authorizer.setCardid(usercard2.getCardid());
			authorizer.setStbno("");
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			String initStbCommand = gospnCaService.getStopAndOnCardCommand(usercard,commandType);
			authorizer.setCommandtype("11");
			authorizer.setCommand(initStbCommand);
			authorizelist_11.add(authorizer);
		}
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//停开机
			authorizeDao.saveBatch(authorizelist_11);
		}
	}
	
	/**
	 * 销户-机顶盒处理
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_cancelUser_userstb(Userstb userstb){
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//机顶盒停开机
		authorizer.setStbno(userstb.getStbno());
		authorizer.setCardid("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//高安服务器
		if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			//停机
			String initStbCommand = gosgnCaService.getStopAndOnStbCommand(userstb,"0");
			authorizer.setCommandtype("167");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	
	/**
	 * 销户-智能卡处理
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_cancelUser_usercard(Usercard usercard){
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(usercard.getCardid());
		authorizer.setTerminaltype("1");//智能卡停开机
		authorizer.setCardid(usercard.getCardid());
		authorizer.setStbno("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//停机
			String initStbCommand = gospnCaService.getStopAndOnCardCommand(usercard,"0");
			authorizer.setCommandtype("11");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 更换机顶盒
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_replaceStb(Userstb userstb,Userstb olduserstb){
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装新机顶盒授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//机顶盒
		authorizer.setStbno(userstb.getStbno());
		authorizer.setCardid("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//封装旧机顶盒授权信息
		Authorize  oldauthorizer = new Authorize();
		oldauthorizer.setNetid(user.getNetid());
		oldauthorizer.setServerid(server.getId());
		oldauthorizer.setAreacode(user.getAreacode());
		oldauthorizer.setUserid(user.getId());
		oldauthorizer.setTerminalid(olduserstb.getStbno());
		oldauthorizer.setTerminaltype("0");//机顶盒
		oldauthorizer.setStbno(olduserstb.getStbno());
		oldauthorizer.setCardid("");
		oldauthorizer.setAddtime(Tools.getCurrentTime());
		oldauthorizer.setVersiontype(server.getVersiontype());
		oldauthorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			
			//获取系统配置参数-是否发送机卡配对指令（0-否；1-是）
			String send_stbcardpair_flag =  getSystemParaByCode("send_stbcardpair_flag");
			if("1".equals(send_stbcardpair_flag)){
				//旧机顶盒机卡绑定
				List<Usercard> olduserardidList = new ArrayList<Usercard>();
				olduserstb.setBingUsercardList(olduserardidList);
				String oldstbBingCardCommand = gospnCaService.getStbBingCardCommand(olduserstb);
				oldauthorizer.setCommandtype("36");
				oldauthorizer.setCommand(oldstbBingCardCommand);
				authorizeDao.save(oldauthorizer);
				
				//新机顶盒机卡绑定
				List<Usercard> userardidList = new ArrayList<Usercard>();
				Usercard usercard = usercardDao.findByStbnoStr(userstb.getStbno());
				userardidList.add(usercard);
				userstb.setBingUsercardList(userardidList);
				String stbBingCardCommand = gospnCaService.getStbBingCardCommand(userstb);
				authorizer.setCommandtype("36");
				authorizer.setCommand(stbBingCardCommand);
				authorizeDao.save(authorizer);
			}
			
			
		} else if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			//1-机顶盒激活
			String activateStbCommand = gosgnCaService.getActivateStbCommand(userstb);
			authorizer.setCommandtype("165");
			authorizer.setCommand(activateStbCommand);
			authorizeDao.save(authorizer);
			
			//2-运营商初始化
			//封装机顶盒的主副机信息
			if("0".equals(userstb.getMothercardflag())){//主机
				//查询该机顶盒关联的副机
				List<Userstb> subuserstblist = userstbDao.findByMotherstbno(userstb.getStbno());
				userstb.setMatherOrSonStbList(subuserstblist);
			}else if("1".equals(userstb.getMothercardflag())){//副机
				List<Userstb> mainuserstbList = new ArrayList<Userstb>();
				Userstb mainuserstb = userstbDao.findByStbnoStr(userstb.getMothercardid());
				if(mainuserstb != null){
					mainuserstbList.add(mainuserstb);
				}
				userstb.setMatherOrSonStbList(mainuserstbList);
			}
			String initStbCommand = gosgnCaService.getInitStbCommand(userstb);
			authorizer.setCommandtype("166");
			authorizer.setCommand(initStbCommand);
			authorizeDao.save(authorizer);
			
			//新机顶盒终端控制
			String openStbCommand = gosgnCaService.getStopAndOnStbCommand(userstb, "1");
			authorizer.setCommandtype("167");
			authorizer.setCommand(openStbCommand);
			authorizeDao.save(authorizer);
			
			//旧机顶盒停机
			String stopStbCommand = gosgnCaService.getStopAndOnStbCommand(olduserstb, "0");
			oldauthorizer.setCommandtype("167");
			oldauthorizer.setCommand(stopStbCommand);
			authorizeDao.save(oldauthorizer);
			
			//新机顶盒发送产品授权
			List<Userproduct> userproductList = userproductDao.findByTerminalidStr(userstb.getStbno());
			if(userproductList!=null && userproductList.size() > 0){
				userstb.setUserproductList(userproductList);
				String productCommand = gosgnCaService.getBuyProductCommand(userstb);
				authorizer.setCommandtype("193");
				authorizer.setCommand(productCommand);
				authorizeDao.save(authorizer);
			}
			
			//旧机顶盒发送产品反授权
			if(userproductList != null && userproductList.size() > 0){
				for (Userproduct userproduct : userproductList) {
					//产品反授权的开始时间等于结束时间
					userproduct.setStarttime(userproduct.getEndtime());
				}
				olduserstb.setUserproductList(userproductList);
				String oldproductCommand = gosgnCaService.getBuyProductCommand(olduserstb);
				oldauthorizer.setCommandtype("193");
				oldauthorizer.setCommand(oldproductCommand);
				authorizeDao.save(oldauthorizer);
			}
			
			//如果是子机更换，如果系统是自动继承母机授权，还得发送继承母机的授权
			if("1".equals(userstb.getMothercardflag())){//子机
				//副机是否继承主机的产品授权
				String sub_hold_main_flag = getSystemParaByCode("sub_hold_main_flag");
				if("1".equals(sub_hold_main_flag)){//副机继承主机的授权
					//查询该改子机对应的母机
					Userstb mainuserstb =  userstbDao.findByStbnoStr(userstb.getMothercardid());
					//主机的产品授权
					List<Userproduct> mainproductList = userproductDao.findByTerminalidStr(mainuserstb.getStbno());
					//新机顶盒发送主机的产品授权
					if(mainproductList!=null && mainproductList.size() > 0){
						userstb.setUserproductList(mainproductList);
						String productCommand = gosgnCaService.getBuyProductCommand(userstb);
						authorizer.setCommandtype("193");
						authorizer.setCommand(productCommand);
						authorizeDao.save(authorizer);
					}
					
					//旧机顶盒发送产品反授权
					if(mainproductList != null && mainproductList.size() > 0){
						for (Userproduct userproduct : mainproductList) {
							//产品反授权的开始时间等于结束时间
							userproduct.setStarttime(userproduct.getEndtime());
						}
						olduserstb.setUserproductList(mainproductList);
						String oldproductCommand = gosgnCaService.getBuyProductCommand(olduserstb);
						oldauthorizer.setCommandtype("193");
						oldauthorizer.setCommand(oldproductCommand);
						authorizeDao.save(oldauthorizer);
					}
					
				}
			}
			
		}
		
	}
	
	/**
	 * 更换智能卡
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_replaceCard(Usercard usercard,Usercard oldusercard){
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(usercard.getCardid());
		authorizer.setTerminaltype("1");//智能卡
		authorizer.setStbno("");
		authorizer.setCardid(usercard.getCardid());
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//封装旧智能卡授权信息
		Authorize  oldauthorizer = new Authorize();
		oldauthorizer.setNetid(user.getNetid());
		oldauthorizer.setServerid(server.getId());
		oldauthorizer.setAreacode(user.getAreacode());
		oldauthorizer.setUserid(user.getId());
		oldauthorizer.setTerminalid(oldusercard.getCardid());
		oldauthorizer.setTerminaltype("1");//智能卡
		oldauthorizer.setStbno("");
		oldauthorizer.setCardid(oldusercard.getCardid());
		oldauthorizer.setAddtime(Tools.getCurrentTime());
		oldauthorizer.setVersiontype(server.getVersiontype());
		oldauthorizer.setState("0");
		
		//1-发送机卡绑定授权
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//1-运营商发卡
			String initCardCommand = gospnCaService.getInitCardCommand(usercard);
			authorizer.setCommandtype("10");
			authorizer.setCommand(initCardCommand);
			authorizeDao.save(authorizer);
			//2-智能卡开卡
			String activateCardCommand = gospnCaService.getActivateCardCommand(usercard);
			authorizer.setCommandtype("11");
			authorizer.setCommand(activateCardCommand);
			authorizeDao.save(authorizer);
			//3-机卡绑定
			//获取系统配置参数-是否发送机卡配对指令（0-否；1-是）
			String send_stbcardpair_flag =  getSystemParaByCode("send_stbcardpair_flag");
			
			if("1".equals(send_stbcardpair_flag)){
				if(!StringUtils.isEmpty(usercard.getStbno())){//有机顶盒在，表示有机卡绑定
					//旧智能卡先解绑
					Userstb olduserstb = new Userstb();
					olduserstb.setStbno(oldusercard.getStbno());
					List<Usercard> olduserardidList = new ArrayList<Usercard>();
					olduserstb.setBingUsercardList(olduserardidList);
					String oldstbBingCardCommand = gospnCaService.getStbBingCardCommand(olduserstb);
					
					oldauthorizer.setCommandtype("36");
					oldauthorizer.setCommand(oldstbBingCardCommand);
					authorizeDao.save(oldauthorizer);
					
					//新智能卡机卡绑定
					Userstb userstb = new Userstb();
					userstb.setStbno(usercard.getStbno());
					List<Usercard> userardidList = new ArrayList<Usercard>();
					userardidList.add(usercard);
					userstb.setBingUsercardList(userardidList);
					String stbBingCardCommand = gospnCaService.getStbBingCardCommand(userstb);
					authorizer.setCommandtype("36");
					authorizer.setCommand(stbBingCardCommand);
					authorizeDao.save(authorizer);
				}
			}
			
			//旧卡停卡
			String oldstopAndOnCardCommand = gospnCaService.getStopAndOnCardCommand(oldusercard,"0");
			oldauthorizer.setCommandtype("11");
			oldauthorizer.setCommand(oldstopAndOnCardCommand);
			authorizeDao.save(oldauthorizer);
			
			//发送产品授权
			List<Userproduct> userproductList = userproductDao.findByTerminalidStr(usercard.getCardid());
			if(userproductList!=null && userproductList.size() >0){
				usercard.setUserproductList(userproductList);
				String productCommand = gospnCaService.getBuyProductCommand(usercard);
				authorizer.setCommandtype("1");
				authorizer.setCommand(productCommand);
				authorizeDao.save(authorizer);
			}
			
			//旧卡发送产品反授权
			if(userproductList != null && userproductList.size() > 0){
				for (Userproduct userproduct : userproductList) {
					//产品反授权的开始时间等于结束时间
					userproduct.setStarttime(userproduct.getEndtime());
				}
				oldusercard.setUserproductList(userproductList);
				String oldproductCommand = gospnCaService.getBuyProductCommand(oldusercard);
				oldauthorizer.setCommandtype("1");
				oldauthorizer.setCommand(oldproductCommand);
				authorizeDao.save(oldauthorizer);
			}
			
			//如果是子机更换，如果系统是自动继承母机授权，还得发送继承母机的授权
			if("1".equals(usercard.getMothercardflag())){//子机
				//副机是否继承主机的产品授权
				String sub_hold_main_flag = getSystemParaByCode("sub_hold_main_flag");
				if("1".equals(sub_hold_main_flag)){//副机继承主机的授权
					//查询该改子机对应的母机
					Usercard mainusercard =  usercardDao.findByCardidStr(usercard.getMothercardid());
					//主机的产品授权
					List<Userproduct> mainproductList = userproductDao.findByTerminalidStr(mainusercard.getCardid());
					//新机顶盒发送主机的产品授权
					if(mainproductList!=null && mainproductList.size() > 0){
						usercard.setUserproductList(mainproductList);
						String productCommand = gospnCaService.getBuyProductCommand(usercard);
						authorizer.setCommandtype("1");
						authorizer.setCommand(productCommand);
						authorizeDao.save(authorizer);
					}
					
					//旧机顶盒发送产品反授权
					if(mainproductList != null && mainproductList.size() > 0){
						for (Userproduct userproduct : mainproductList) {
							//产品反授权的开始时间等于结束时间
							userproduct.setStarttime(userproduct.getEndtime());
						}
						oldusercard.setUserproductList(mainproductList);
						String oldproductCommand = gospnCaService.getBuyProductCommand(oldusercard);
						oldauthorizer.setCommandtype("1");
						oldauthorizer.setCommand(oldproductCommand);
						authorizeDao.save(oldauthorizer);
					}
					
				}
			}else{//母机更换，得更新子卡的发卡指令（更新子母卡绑定关系）
				//获取该母卡的所有子卡信息
				List<Usercard> subusercardlist = usercardDao.findByMothercardid(usercard.getCardid());
				if(subusercardlist != null && subusercardlist.size() > 0){
					for (Usercard subusercard : subusercardlist) {
						//封装子卡开卡信息（更新子母卡关系）
						Authorize  subauthorizer = new Authorize();
						subauthorizer.setNetid(user.getNetid());
						subauthorizer.setServerid(server.getId());
						subauthorizer.setAreacode(user.getAreacode());
						subauthorizer.setUserid(user.getId());
						subauthorizer.setTerminalid(subusercard.getCardid());
						subauthorizer.setTerminaltype("1");//智能卡
						subauthorizer.setStbno("");
						subauthorizer.setCardid(subusercard.getCardid());
						subauthorizer.setAddtime(Tools.getCurrentTime());
						subauthorizer.setVersiontype(server.getVersiontype());
						subauthorizer.setState("0");
						//1-子卡运营商发卡
						String initSubCardCommand = gospnCaService.getInitCardCommand(subusercard);
						subauthorizer.setCommandtype("10");
						subauthorizer.setCommand(initSubCardCommand);
						authorizeDao.save(subauthorizer);
					}
				}
			}
			
		}
	}
	
	
	/**
	 * 机顶盒电子钱包充值
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_rechargeWallet_userstb(Userstb userstb){
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//智能卡
		authorizer.setStbno(userstb.getStbno());
		authorizer.setCardid("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//1-发送电子钱包充值授权
		//高安服务器
		if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
			//1-发送电子钱包
			String rechargeWalletCommand = gosgnCaService.getRechargeWalletCommand(userstb);
			authorizer.setCommandtype("168");
			authorizer.setCommand(rechargeWalletCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 智能卡电子钱包充值
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_rechargeWallet_usercard(Usercard usercard){
		//获取订户信息
		User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(usercard.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(server.getId());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(user.getId());
		authorizer.setTerminalid(usercard.getCardid());
		authorizer.setTerminaltype("1");//智能卡
		authorizer.setStbno("");
		authorizer.setCardid(usercard.getCardid());
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		//1-发送电子钱包充值授权
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
			//1-运营商发卡
			String initCardCommand = gospnCaService.getRechargeWalletCommand(usercard);
			authorizer.setCommandtype("16");
			authorizer.setCommand(initCardCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 新邮件指令
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_newemail(Caspnnewemail caspnnewemail){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnnewemail.getNetid());
		authorizer.setVersiontype(caspnnewemail.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnnewemail.getVersiontype())){
			// 封装新邮件所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnnewemail.getVersiontype());
			caCommandParam.setCommandtype("35"); //  new mail
			caCommandParam.setCaspnnewemail(caspnnewemail);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("35");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnnewemail.getVersiontype())){
			// 封装新邮件所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnnewemail.getVersiontype());
			caCommandParam.setCommandtype("185"); //电子邮件commandtype=185，0xb9;  
			
			//由于高安CAS与普安CAS的添加和删除刚好相反，故此是高安时，得重新赋值
			if("0".equals(caspnnewemail.getEmailoper())){
				caspnnewemail.setEmailoper("1");
			}else{
				caspnnewemail.setEmailoper("0");
			}
			
			caCommandParam.setCaspnnewemail(caspnnewemail);
			caCommandParam.setAddressingmode(caspnnewemail.getAddressingmode());
			caCommandParam.setConditioncount(caspnnewemail.getConditioncount());
			caCommandParam.setConditioncontent(caspnnewemail.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("185");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 强制OSD指令
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_forcedosd(Caspnforcedosd caspnforcedosd){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnforcedosd.getNetid());
		authorizer.setVersiontype(caspnforcedosd.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnforcedosd.getVersiontype())){
			// 强制OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnforcedosd.getVersiontype());
			caCommandParam.setCommandtype("14");//条件OSD
			caCommandParam.setConditioncontent(caspnforcedosd.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("29"); // force osd
			innerComanndParam.setCaspnforcedosd(caspnforcedosd);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnforcedosd.getVersiontype())){
			// 强制OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnforcedosd.getVersiontype());
			caCommandParam.setCommandtype("178"); //OSD指令 (commandtype=178，0xb2)
			caCommandParam.setCaspnforcedosd(caspnforcedosd);
			caCommandParam.setAddressingmode(caspnforcedosd.getAddressingmode());
			caCommandParam.setConditioncount(caspnforcedosd.getConditioncount());
			caCommandParam.setConditioncontent(caspnforcedosd.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("185");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 新版指纹指令
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_newfinger(Caspnnewfinger caspnnewfinger){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnnewfinger.getNetid());
		authorizer.setVersiontype(caspnnewfinger.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnnewfinger.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnnewfinger.getVersiontype());
			caCommandParam.setCommandtype("14");//条件
			caCommandParam.setConditioncontent(caspnnewfinger.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("60"); // 新版指纹
			innerComanndParam.setCaspnnewfinger(caspnnewfinger);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnnewfinger.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnnewfinger.getVersiontype());
			caCommandParam.setCommandtype("179"); //新版指纹 (commandtype=179，0xb3)
			caCommandParam.setCaspnnewfinger(caspnnewfinger);
			caCommandParam.setAddressingmode(caspnnewfinger.getAddressingmode());
			caCommandParam.setConditioncount(caspnnewfinger.getConditioncount());
			caCommandParam.setConditioncontent(caspnnewfinger.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("179");     // 新版指纹 (commandtype=179，0xb3)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 强制换台
	 * @param Caspnforcedcc
	 * @return
	 */
	public void saveAuthorize_forcedcc(Caspnforcedcc caspnforcedcc){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnforcedcc.getNetid());
		authorizer.setVersiontype(caspnforcedcc.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnforcedcc.getVersiontype())){
			//强制换台所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnforcedcc.getVersiontype());
			caCommandParam.setCommandtype("14");//条件
			caCommandParam.setConditioncontent(caspnforcedcc.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("32"); // 强制换台
			innerComanndParam.setCaspnforcedcc(caspnforcedcc);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnforcedcc.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnforcedcc.getVersiontype());
			caCommandParam.setCommandtype("180"); //强制换台 (commandtype=180，0xb4)
			caCommandParam.setCaspnforcedcc(caspnforcedcc);
			caCommandParam.setAddressingmode(caspnforcedcc.getAddressingmode());
			caCommandParam.setConditioncount(caspnforcedcc.getConditioncount());
			caCommandParam.setConditioncontent(caspnforcedcc.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("180");     //强制换台 (commandtype=180，0xb4)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 机顶盒默认开机节目
	 * @param Stbdefaultmsg
	 * @return
	 */
	public void saveAuthorize_stbdefaultmsg(Stbdefaultmsg stbdefaultmsg){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(stbdefaultmsg.getNetid());
		authorizer.setVersiontype(stbdefaultmsg.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(stbdefaultmsg.getVersiontype())){
			//强制换台所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(stbdefaultmsg.getVersiontype());
			caCommandParam.setCommandtype("34");//机顶盒默认开机信息
			caCommandParam.setStbdefaultmsg(stbdefaultmsg);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("34");     //机顶盒默认开机信息
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(stbdefaultmsg.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(stbdefaultmsg.getVersiontype());
			caCommandParam.setCommandtype("183"); //机顶盒默认开机信息 (commandtype=183，0xb7)
			caCommandParam.setStbdefaultmsg(stbdefaultmsg);
			caCommandParam.setAddressingmode(stbdefaultmsg.getAddressingmode());
			caCommandParam.setConditioncount(stbdefaultmsg.getConditioncount());
			caCommandParam.setConditioncontent(stbdefaultmsg.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("183");     //机顶盒默认开机信息 (commandtype=183，0xb7)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 机顶盒强制重启
	 * @param Forcedrestart
	 * @return
	 */
	public void saveAuthorize_forcedrestart(Forcedrestart sorcedrestart){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(sorcedrestart.getNetid());
		authorizer.setVersiontype(sorcedrestart.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(sorcedrestart.getVersiontype())){
			//强制换台所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(sorcedrestart.getVersiontype());
			caCommandParam.setCommandtype("33");//强制重启
			caCommandParam.setForcedrestart(sorcedrestart);
			caCommandParam.setCardid(sorcedrestart.getCardid());//设置卡号
			caCommandParam.setAreacode(sorcedrestart.getAreacode());//设置区域号
			caCommandParam.setExpired_Time(sorcedrestart.getExpired_Time());//到期日期
			
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("33");     //强制重启
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(sorcedrestart.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(sorcedrestart.getVersiontype());
			caCommandParam.setCommandtype("181"); //机顶盒默认开机信息 (commandtype=181，0xb5)
			caCommandParam.setForcedrestart(sorcedrestart);
			caCommandParam.setAddressingmode(sorcedrestart.getAddressingmode());
			caCommandParam.setConditioncount(sorcedrestart.getConditioncount());
			caCommandParam.setConditioncontent(sorcedrestart.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("181");     //机顶盒默认开机信息 (commandtype=181，0xb5)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 重新搜索节目
	 * @param Forcedrestart
	 * @return
	 */
	public void saveAuthorize_researchprogram(Researchprogram researchprogram){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(researchprogram.getNetid());
		authorizer.setVersiontype(researchprogram.getVersiontype());
		authorizer.setState("0");
		
		if(Constant.SERVER_GOS_GN.equals(researchprogram.getVersiontype())){
			//所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(researchprogram.getVersiontype());
			caCommandParam.setCommandtype("182"); //重新搜索节目(commandtype=182，0xb6)
			caCommandParam.setResearchprogram(researchprogram);
			caCommandParam.setAddressingmode(researchprogram.getAddressingmode());
			caCommandParam.setConditioncount(researchprogram.getConditioncount());
			caCommandParam.setConditioncontent(researchprogram.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("182");     //重新搜索节目(commandtype=182，0xb6)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * PVA再授权
	 * @param PvrAuthEmm
	 * @return
	 */
	public void saveAuthorize_pvrauthemm(PvrAuthEmm pvrAuthEmm){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(pvrAuthEmm.getNetid());
		authorizer.setVersiontype(pvrAuthEmm.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(pvrAuthEmm.getVersiontype())){
			//强制换台所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(pvrAuthEmm.getVersiontype());
			caCommandParam.setCommandtype("38");//PVR在授权
			caCommandParam.setPvrAuthEmm(pvrAuthEmm);
			
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("38");     //PVR在授权
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}else if(Constant.SERVER_GOS_GN.equals(pvrAuthEmm.getVersiontype())){
			// 新版指纹所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(pvrAuthEmm.getVersiontype());
			caCommandParam.setCommandtype("188"); //PVR节目再授权 (commandtype=188，0xbc)
			caCommandParam.setPvrAuthEmm(pvrAuthEmm);
			caCommandParam.setAddressingmode(pvrAuthEmm.getAddressingmode());
			caCommandParam.setStbno(pvrAuthEmm.getTeminalid());
			caCommandParam.setConditioncount(pvrAuthEmm.getConditioncount());
			caCommandParam.setConditioncontent(pvrAuthEmm.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("188");     //机顶盒默认开机信息 (commandtype=181，0xb5)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 机顶盒黑名单
	 * @param Caspnblackstb
	 * @return
	 */
	public void saveAuthorize_blackstb(Caspnblackstb caspnblackstb){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnblackstb.getNetid());
		authorizer.setVersiontype(caspnblackstb.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnblackstb.getVersiontype())){
			
			//1-机卡绑定(36)
			if("0".equals(caspnblackstb.getOperatorType())){//黑名单添加时，才发送机卡绑定指令
				CaCommandParam stbbingcard = new CaCommandParam();
				stbbingcard.setVersiontype(caspnblackstb.getVersiontype());
				stbbingcard.setCommandtype("36");
				stbbingcard.setStbno(caspnblackstb.getStbno());
				stbbingcard.setPair_Type("0");
				stbbingcard.setStbBingCardidList(caspnblackstb.getBlackStbCardidList());
				String StbBingCard_command = GospnCaDao.getCaCommand(stbbingcard);
				authorizer.setCommandtype("36");     //机卡绑定
				authorizer.setCommand(StbBingCard_command);
				System.out.println("***********command************: " + authorizer.getCommand());
				authorizeDao.save(authorizer);
			}
			
			//2-发送机顶盒黑名单指令。
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnblackstb.getVersiontype());
			caCommandParam.setCommandtype("46");//机顶盒黑名单
			caCommandParam.setCaspnblackstb(caspnblackstb);
			caCommandParam.setStbno(caspnblackstb.getStbno());
			caCommandParam.setOperatorType(caspnblackstb.getOperatorType());
			caCommandParam.setSend_now_flag(caspnblackstb.getSend_now_flag());
			caCommandParam.setExpired_Time(caspnblackstb.getExpired_Time());
			caCommandParam.setBlackStbCardidList(caspnblackstb.getBlackStbCardidList());
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			authorizer.setCommandtype("46");     //机顶盒黑名单
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
			
		}
	}
	
	/**
	 * 智能卡黑名单
	 * @param Caspnblackcard
	 * @return
	 */
	public void saveAuthorize_blackcard(Caspnblackcard caspnblackcard){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnblackcard.getNetid());
		authorizer.setVersiontype(caspnblackcard.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnblackcard.getVersiontype())){
			
			//1-发送智能卡黑名单指令。
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnblackcard.getVersiontype());
			caCommandParam.setCommandtype("44");//智能卡黑名单
			caCommandParam.setCaspnblackcard(caspnblackcard);
			caCommandParam.setCardid(caspnblackcard.getCardid());
			caCommandParam.setOperatorType(caspnblackcard.getOperatorType());
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			authorizer.setCommandtype("44");     //智能卡黑名单
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	
	/**
	 * 产品信息同步
	 * @param 
	 * @return
	 */
	public void saveAuthorize_pushproductinfo(){
		
		//高安服务器
		Server serverForm = new Server();
		serverForm.setQueryservertype("cas");
		serverForm.setQueryversiontype(Constant.SERVER_GOS_GN);
		List<Server> serverlist = serverDao.queryByList(serverForm);
		for (Server server : serverlist) {
			Product productForm =  new Product();
			productForm.setQuerynetid(String.valueOf(server.getNetid()));
			productForm.setQuerystate("1");
			List<Product> productlist = productDao.queryByList(productForm);
			
			for (int i=0; productlist != null && i<productlist.size();i++) {
				
				//套餐种个数
				String total_package_count = String.valueOf(productlist.size());
				
				Product product = productlist.get(i);
				//开始或结束标志位。如果为0，表示本命令是一系列套餐包设置命令的第一个，否则为1（如果只有一个套餐，该字段也为0）。
				String start_flag = "0"; 
				if(i != 0){
					start_flag = "1";
				}
				//封装授权信息
				Authorize  authorizer = new Authorize();
				authorizer.setAddtime(Tools.getCurrentTime());
				authorizer.setNetid(server.getNetid());
				authorizer.setVersiontype(server.getVersiontype());
				authorizer.setState("0");
				
				Productserviceref ref = new Productserviceref();
				ref.setNetid(product.getNetid());
				ref.setProductid(product.getProductid());
				List<Productserviceref> reflist = productservicerefDao.findByProductid(ref);
				product.setReflist(reflist);
				
				//产品信息同步指令。
				CaCommandParam caCommandParam = new CaCommandParam();
				caCommandParam.setVersiontype(server.getVersiontype());
				caCommandParam.setCommandtype("160");//同步产品信息
				caCommandParam.setStart_flag(start_flag);//开始或结束标志位
				caCommandParam.setTotal_package_count(total_package_count);//套餐包数的总数
				caCommandParam.setProduct(product);
				
				String final_command = GosgnCaDao.getCaCommand(caCommandParam);
				authorizer.setCommandtype("160");     //同步产品信息
				authorizer.setCommand(final_command);
				System.out.println("***********command************: " + authorizer.getCommand());
				authorizeDao.save(authorizer);
			}
		}

	}
	
	/**
	 * 重置PIN码
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_resetpincode(CaCommandParam caCommandParam){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caCommandParam.getVersiontype())){
			//强制换台所需的参数
			//CaCommandParam caCommandParam = new CaCommandParam();
			//caCommandParam.setVersiontype(form.getVersiontype());
			caCommandParam.setCommandtype("3");//重置PIN码commandtype=3;
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("3");     //重置PIN码commandtype=3;
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器
		}else if(Constant.SERVER_GOS_GN.equals(caCommandParam.getVersiontype())){
			// 新版指纹所需的参数
			//CaCommandParam caCommandParam = new CaCommandParam();
			//caCommandParam.setVersiontype(form.getVersiontype());
			caCommandParam.setCommandtype("162"); //重置PIN码 (commandtype=162，0xA2)
			//caCommandParam.setAddressingmode(form.getAddressingmode());
			//caCommandParam.setConditioncount(form.getConditioncount());
			//caCommandParam.setConditioncontent(form.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("162");     //重置PIN码 (commandtype=162，0xA2)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 清除PIN码
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_cleanpincode(CaCommandParam caCommandParam){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		if(Constant.SERVER_GOS_GN.equals(caCommandParam.getVersiontype())){
			// 新版指纹所需的参数
			//CaCommandParam caCommandParam = new CaCommandParam();
			//caCommandParam.setVersiontype(form.getVersiontype());
			caCommandParam.setCommandtype("161"); //清除PIN码 (commandtype=161，0xA1)
			//caCommandParam.setAddressingmode(form.getAddressingmode());
			//caCommandParam.setConditioncount(form.getConditioncount());
			//caCommandParam.setConditioncontent(form.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("161");     //清除PIN码 (commandtype=161，0xA1)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 删除错误发卡指令
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_deleteerrcard(CaCommandParam caCommandParam){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caCommandParam.getVersiontype())){
			//强制换台所需的参数
			//CaCommandParam caCommandParam = new CaCommandParam();
			//caCommandParam.setVersiontype(form.getVersiontype());
			caCommandParam.setCommandtype("51");//删除错误的发卡信息（Command_Type ＝ 51）
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("51");     //删除错误的发卡信息（Command_Type ＝ 51）
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	
	/**
	 * 批量预授权
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_batchpreauthorize(CaCommandParam caCommandParam){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caCommandParam.getVersiontype())){
			//批量预授权所需参数
			caCommandParam.setCommandtype("1"); //授权
			String final_command = CasEmmDao.getCaCommand(caCommandParam);

			authorizer.setTerminaltype("1"); // 终端类型（0-机顶盒号；1-智能卡号）
			authorizer.setCardid(caCommandParam.getCardid());
			authorizer.setTerminalid(caCommandParam.getCardid());
			authorizer.setCommandtype("1"); // 节目授权
			authorizer.setCommand(final_command);
			authorizeDao.save(authorizer);

		//高安服务器
		}else if(Constant.SERVER_GOS_GN.equals(caCommandParam.getVersiontype())){
			// 新版指纹所需的参数
			//CaCommandParam caCommandParam = new CaCommandParam();
			//caCommandParam.setVersiontype(form.getVersiontype());
			caCommandParam.setCommandtype("193"); //套餐和节目授权 (commandtype=193，0xc1)
			caCommandParam.setAddressingmode("0");
			//caCommandParam.setConditioncount(form.getConditioncount());
			//caCommandParam.setConditioncontent(form.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			
			authorizer.setCommandtype("193");     //套餐和节目授权 (commandtype=193，0xc1)
			authorizer.setTerminaltype("0"); // 终端类型（0-机顶盒号；1-智能卡号）
			authorizer.setCardid(caCommandParam.getStbno());
			authorizer.setTerminalid(caCommandParam.getStbno());
			authorizer.setCommand(final_command);
			authorizeDao.save(authorizer);
		}
	}
	
	
	/**
	 * 机卡绑定关系(针对机顶盒)
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_stbBingCard(Userstb userstb){
		
		//机卡绑定
		//获取订户信息
		User user = userDao.findById(userstb.getUserid());
		//获取服务器信息
		Server server = serverDao.findById(userstb.getServerid());
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(user.getNetid());
		authorizer.setServerid(userstb.getServerid());
		authorizer.setAreacode(user.getAreacode());
		authorizer.setUserid(userstb.getUserid());
		authorizer.setTerminalid(userstb.getStbno());
		authorizer.setTerminaltype("0");//机顶盒
		authorizer.setCardid("");
		authorizer.setStbno(userstb.getStbno());
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(server.getVersiontype());
		authorizer.setState("0");
		
		List<Usercard> userardidList = new ArrayList<Usercard>();
		Usercard usercardpair = usercardDao.findByStbnoStr(userstb.getStbno());
		if(usercardpair != null){//等于空，表示没有智能卡跟该机顶盒绑定
			userardidList.add(usercardpair);
		}
		
		//获取系统配置参数-是否发送机卡配对指令（0-否；1-是）
		String send_stbcardpair_flag =  getSystemParaByCode("send_stbcardpair_flag");
		if("1".equals(send_stbcardpair_flag)){
			userstb.setBingUsercardList(userardidList);
			String stbBingCardCommand = gospnCaService.getStbBingCardCommand(userstb);
			authorizer.setCommandtype("36");
			authorizer.setCommand(stbBingCardCommand);
			//发送指令
			authorizeDao.save(authorizer);
		}
		
	}
	
	
	/**
	 * 订户迁移业务
	 */
	public void  saveAuthorize_transferAddress(User user) {
		
		//查询出所有的无卡机顶盒
		List<Userstb> userstblist = userstbDao.queryNocardUserstbByUserid(user.getId());
		for (Userstb userstb : userstblist) {
			Server server = serverDao.findById(userstb.getServerid());
			//封装授权信息
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(userstb.getStbno());
			authorizer.setTerminaltype("0");
			authorizer.setStbno(userstb.getStbno());
			authorizer.setCardid("");
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			
			//高安服务器
			if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
				//机顶盒初始化
				//封装机顶盒的主副机信息
				if("0".equals(userstb.getMothercardflag())){//主机
					//查询该机顶盒关联的副机
					List<Userstb> subuserstblist = userstbDao.findByMotherstbno(userstb.getStbno());
					userstb.setMatherOrSonStbList(subuserstblist);
					
				}else if("1".equals(userstb.getMothercardflag())){//副机
					List<Userstb> mainuserstbList = new ArrayList<Userstb>();
					Userstb mainuserstb = userstbDao.findByStbnoStr(userstb.getMothercardid());
					if(mainuserstb != null){
						mainuserstbList.add(mainuserstb);
					}
					userstb.setMatherOrSonStbList(mainuserstbList);
				}
				
				String initStbCommand = gosgnCaService.getInitStbCommand(userstb);
				authorizer.setCommandtype("166");
				authorizer.setCommand(initStbCommand);
				authorizeDao.save(authorizer);
			}
		}
		
		//查询出所有智能卡信息
		List<Usercard> usercardlist = usercardDao.findByUserid(user.getId());
		for (Usercard usercard : usercardlist) {
			Server server = serverDao.findById(usercard.getServerid());
			//封装授权信息
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(usercard.getCardid());
			authorizer.setTerminaltype("1");
			authorizer.setStbno("");
			authorizer.setCardid(usercard.getCardid());
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
				//1-运营商发卡
				String initCardCommand = gospnCaService.getInitCardCommand(usercard);
				authorizer.setCommandtype("10");
				authorizer.setCommand(initCardCommand);
				authorizeDao.save(authorizer);
			}
		}
	}
	
	/**
	 * 订户过户业务
	 */
	public void  saveAuthorize_transferUser(User user) {
		
		//查询出所有的无卡机顶盒
		List<Userstb> userstblist = userstbDao.queryNocardUserstbByUserid(user.getId());
		for (Userstb userstb : userstblist) {
			Server server = serverDao.findById(userstb.getServerid());
			//封装授权信息
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(userstb.getStbno());
			authorizer.setTerminaltype("0");
			authorizer.setStbno(userstb.getStbno());
			authorizer.setCardid("");
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			
			//高安服务器
			if(Constant.SERVER_GOS_GN.equals(server.getVersiontype())){
				//机顶盒初始化
				//封装机顶盒的主副机信息
				if("0".equals(userstb.getMothercardflag())){//主机
					//查询该机顶盒关联的副机
					List<Userstb> subuserstblist = userstbDao.findByMotherstbno(userstb.getStbno());
					userstb.setMatherOrSonStbList(subuserstblist);
					
				}else if("1".equals(userstb.getMothercardflag())){//副机
					List<Userstb> mainuserstbList = new ArrayList<Userstb>();
					Userstb mainuserstb = userstbDao.findByStbnoStr(userstb.getMothercardid());
					if(mainuserstb != null){
						mainuserstbList.add(mainuserstb);
					}
					userstb.setMatherOrSonStbList(mainuserstbList);
				}
				
				String initStbCommand = gosgnCaService.getInitStbCommand(userstb);
				authorizer.setCommandtype("166");
				authorizer.setCommand(initStbCommand);
				authorizeDao.save(authorizer);
			}
		}
		
		//查询出所有智能卡信息
		List<Usercard> usercardlist = usercardDao.findByUserid(user.getId());
		for (Usercard usercard : usercardlist) {
			Server server = serverDao.findById(usercard.getServerid());
			//封装授权信息
			Authorize  authorizer = new Authorize();
			authorizer.setNetid(user.getNetid());
			authorizer.setServerid(server.getId());
			authorizer.setAreacode(user.getAreacode());
			authorizer.setUserid(user.getId());
			authorizer.setTerminalid(usercard.getCardid());
			authorizer.setTerminaltype("1");
			authorizer.setStbno("");
			authorizer.setCardid(usercard.getCardid());
			authorizer.setAddtime(Tools.getCurrentTime());
			authorizer.setVersiontype(server.getVersiontype());
			authorizer.setState("0");
			
			//普安服务器
			if(Constant.SERVER_GOS_PN.equals(server.getVersiontype())){
				//1-运营商发卡
				String initCardCommand = gospnCaService.getInitCardCommand(usercard);
				authorizer.setCommandtype("10");
				authorizer.setCommand(initCardCommand);
				authorizeDao.save(authorizer);
			}
		}
	}
	
	/**
	 * 智能卡批量发卡操作
	 */
	public void  saveAuthorize_batchsendCard(Card card,String userareacode) {
		//获取订户信息
		//User user = userDao.findById(usercard.getUserid());
		//获取服务器信息
		//Server server = serverDao.findById(card.getServerid());
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setNetid(card.getNetid());
		authorizer.setServerid(card.getServerid());
		authorizer.setAreacode(userareacode);
		//authorizer.setUserid(user.getId());
		authorizer.setTerminalid(card.getCardid());
		authorizer.setTerminaltype("1");//智能卡购买
		authorizer.setCardid(card.getCardid());
		authorizer.setStbno("");
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setVersiontype(card.getVersiontype());
		authorizer.setState("0");
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(card.getVersiontype())){
			//1-运营商发卡
			String initCardCommand = gospnCaService.getBatchsendcardCommand(card,userareacode);
			authorizer.setCommandtype("10");
			authorizer.setCommand(initCardCommand);
			authorizeDao.save(authorizer);
		}
	}
	
	//取系统参数值
	public  String getSystemParaByCode(String code){
		Systempara para = new Systempara();
		para.setCode(code);
		para = systemparaDao.findByCode(para);
		if(para != null && !"".equals(para.getValue())){
			return para.getValue();
		}else{
			return "";
		}
	}
	
	/**
	 * OSD指令
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_osd(EmailOrOsdMsg emailOrOsdMsg){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(emailOrOsdMsg.getNetid());
		authorizer.setVersiontype(emailOrOsdMsg.getVersiontype());
		authorizer.setState("0");//未发送
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(emailOrOsdMsg.getVersiontype())){
			// OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(emailOrOsdMsg.getVersiontype());
			caCommandParam.setCommandtype("14");//条件OSD
			caCommandParam.setConditioncontent(emailOrOsdMsg.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("2"); // osd
			//innerComanndParam.setCaspnforcedosd(caspnforcedosd);
			innerComanndParam.setEmailOrOsdMsg(emailOrOsdMsg);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
//		}else if(Constant.SERVER_GOS_GN.equals(caspnforcedosd.getVersiontype())){
//			// 强制OSD所需的参数
//			CaCommandParam caCommandParam = new CaCommandParam();
//			caCommandParam.setVersiontype(caspnforcedosd.getVersiontype());
//			caCommandParam.setCommandtype("178"); //OSD指令 (commandtype=178，0xb2)
//			caCommandParam.setCaspnforcedosd(caspnforcedosd);
//			caCommandParam.setAddressingmode(caspnforcedosd.getAddressingmode());
//			caCommandParam.setConditioncount(caspnforcedosd.getConditioncount());
//			caCommandParam.setConditioncontent(caspnforcedosd.getConditioncontent());
//			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
//			// 发送封装指令。
//			authorizer.setCommandtype("185");     // 新版邮件指令
//			authorizer.setCommand(final_command);
//			System.out.println("***********command************: " + authorizer.getCommand());
//			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * Email指令
	 * @param EmailOrOsdMsg
	 * @return
	 */
	public void saveAuthorize_email(EmailOrOsdMsg emailOrOsdMsg){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(emailOrOsdMsg.getNetid());
		authorizer.setVersiontype(emailOrOsdMsg.getVersiontype());
		authorizer.setState("0");//未发送
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(emailOrOsdMsg.getVersiontype())){
			// OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(emailOrOsdMsg.getVersiontype());
			caCommandParam.setCommandtype("14");//条件email
			caCommandParam.setConditioncontent(emailOrOsdMsg.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("13"); // email
			//innerComanndParam.setCaspnforcedosd(caspnforcedosd);
			innerComanndParam.setEmailOrOsdMsg(emailOrOsdMsg);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		//高安服务器	
//		}else if(Constant.SERVER_GOS_GN.equals(caspnforcedosd.getVersiontype())){
//			// 强制OSD所需的参数
//			CaCommandParam caCommandParam = new CaCommandParam();
//			caCommandParam.setVersiontype(caspnforcedosd.getVersiontype());
//			caCommandParam.setCommandtype("178"); //OSD指令 (commandtype=178，0xb2)
//			caCommandParam.setCaspnforcedosd(caspnforcedosd);
//			caCommandParam.setAddressingmode(caspnforcedosd.getAddressingmode());
//			caCommandParam.setConditioncount(caspnforcedosd.getConditioncount());
//			caCommandParam.setConditioncontent(caspnforcedosd.getConditioncontent());
//			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
//			// 发送封装指令。
//			authorizer.setCommandtype("185");     // 新版邮件指令
//			authorizer.setCommand(final_command);
//			System.out.println("***********command************: " + authorizer.getCommand());
//			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 指纹指令
	 * @param EmailOrOsdMsg
	 * @return
	 */
	public void saveAuthorize_finger(EmailOrOsdMsg emailOrOsdMsg){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(emailOrOsdMsg.getNetid());
		authorizer.setVersiontype(emailOrOsdMsg.getVersiontype());
		authorizer.setState("0");//未发送
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(emailOrOsdMsg.getVersiontype())){
			
			// 封装新邮件所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(emailOrOsdMsg.getVersiontype());
			caCommandParam.setCommandtype("6"); //  new mail
			caCommandParam.setEmailOrOsdMsg(emailOrOsdMsg);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("6");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
			
		//高安服务器	
//		}else if(Constant.SERVER_GOS_GN.equals(caspnforcedosd.getVersiontype())){
//			// 强制OSD所需的参数
//			CaCommandParam caCommandParam = new CaCommandParam();
//			caCommandParam.setVersiontype(caspnforcedosd.getVersiontype());
//			caCommandParam.setCommandtype("178"); //OSD指令 (commandtype=178，0xb2)
//			caCommandParam.setCaspnforcedosd(caspnforcedosd);
//			caCommandParam.setAddressingmode(caspnforcedosd.getAddressingmode());
//			caCommandParam.setConditioncount(caspnforcedosd.getConditioncount());
//			caCommandParam.setConditioncontent(caspnforcedosd.getConditioncontent());
//			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
//			// 发送封装指令。
//			authorizer.setCommandtype("185");     // 新版邮件指令
//			authorizer.setCommand(final_command);
//			System.out.println("***********command************: " + authorizer.getCommand());
//			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 产品限播指令
	 * @param Caspnproductplay
	 * @return
	 */
	public void saveAuthorize_productplaylimit(Caspnproductplay caspnproductplay){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnproductplay.getNetid());
		authorizer.setVersiontype(caspnproductplay.getVersiontype());
		authorizer.setState("0");//未发送
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnproductplay.getVersiontype())){
			
			// OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnproductplay.getVersiontype());
			caCommandParam.setCommandtype("14");//条件email
			caCommandParam.setConditioncontent(caspnproductplay.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			if("0".equals(caspnproductplay.getIsControl())){
				innerComanndParam.setCommandtype("17"); // 启动产品限播
			}else if("1".equals(caspnproductplay.getIsControl())){
				innerComanndParam.setCommandtype("18"); // 取消产品限播
			}
			
			innerComanndParam.setCaspnproductplay(caspnproductplay);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
			
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnproductplay.getVersiontype())){
			// 强制OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnproductplay.getVersiontype());
			caCommandParam.setCommandtype("169"); //产品限播 (commandtype=169，0xa9)
			caCommandParam.setCaspnproductplay(caspnproductplay);
			caCommandParam.setAddressingmode(caspnproductplay.getAddressingmode());
			caCommandParam.setConditioncount(caspnproductplay.getConditioncount());
			caCommandParam.setConditioncontent(caspnproductplay.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("169");     // 新版邮件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}
	
	/**
	 * 产品准播指令
	 * @param Caspnproductplay
	 * @return
	 */
	public void saveAuthorize_productplayallow(Caspnproductplay caspnproductplay){
		
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caspnproductplay.getNetid());
		authorizer.setVersiontype(caspnproductplay.getVersiontype());
		authorizer.setState("0");//未发送
		
		//普安服务器
		if(Constant.SERVER_GOS_PN.equals(caspnproductplay.getVersiontype())){
			
			// OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnproductplay.getVersiontype());
			caCommandParam.setCommandtype("14");//条件email
			caCommandParam.setConditioncontent(caspnproductplay.getConditioncontent());
			//条件对象
			CaCommandParam innerComanndParam = new CaCommandParam(); // 内层
			innerComanndParam.setCommandtype("31"); // 启动产品准播
			innerComanndParam.setCaspnproductplay(caspnproductplay);
			caCommandParam.setCndAddrPara(innerComanndParam);
			String final_command = GospnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("14");     // 条件指令
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
			
		//高安服务器	
		}else if(Constant.SERVER_GOS_GN.equals(caspnproductplay.getVersiontype())){
			// 强制OSD所需的参数
			CaCommandParam caCommandParam = new CaCommandParam();
			caCommandParam.setVersiontype(caspnproductplay.getVersiontype());
			caCommandParam.setCommandtype("170"); //产品准播 (commandtype=170，0xaa)
			caCommandParam.setCaspnproductplay(caspnproductplay);
			caCommandParam.setAddressingmode(caspnproductplay.getAddressingmode());
			caCommandParam.setConditioncount(caspnproductplay.getConditioncount());
			caCommandParam.setConditioncontent(caspnproductplay.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("170");     // 产品准播 (commandtype=170，0xaa)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);
		}
	}

	/**
	 * pvr功能控制
	 */
	@Override
	public void saveAuthorize_pvrfunctionControl(CaCommandParam caCommandParam) {
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		if(Constant.SERVER_GOS_GN.equals(caCommandParam.getVersiontype())){
			caCommandParam.setCommandtype("190"); //pvr功能控制 (commandtype=190，0xbe)
			caCommandParam.setAddressingmode(caCommandParam.getAddressingmode());
			caCommandParam.setConditioncount(caCommandParam.getConditioncount());
			caCommandParam.setConditioncontent(caCommandParam.getConditioncontent());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("190");     //pvr功能控制 (commandtype=190，0xbe)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);		
		}
		
	}
	
	/**
	 * 父母锁密码复位
	 */
	@Override
	public void saveAuthorize_parentlock(CaCommandParam caCommandParam) {
		//封装授权信息
		Authorize  authorizer = new Authorize();
		authorizer.setAddtime(Tools.getCurrentTime());
		authorizer.setNetid(caCommandParam.getNetid());
		authorizer.setVersiontype(caCommandParam.getVersiontype());
		authorizer.setState("0");
		
		if(Constant.SERVER_GOS_GN.equals(caCommandParam.getVersiontype())){
			caCommandParam.setCommandtype("174"); //父母锁密码复位 (commandtype=174，0xae)
			caCommandParam.setAddressingmode(caCommandParam.getAddressingmode());
			caCommandParam.setConditioncount(caCommandParam.getConditioncount());
			caCommandParam.setConditioncontent(caCommandParam.getConditioncontent());
			caCommandParam.setStbno(caCommandParam.getStbno());
			String final_command = GosgnCaDao.getCaCommand(caCommandParam);
			// 发送封装指令。
			authorizer.setCommandtype("174");     ////父母锁密码复位 (commandtype=174，0xae)
			authorizer.setCommand(final_command);
			System.out.println("***********command************: " + authorizer.getCommand());
			authorizeDao.save(authorizer);		
		}
		
	}
	
}
