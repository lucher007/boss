package com.gospell.boss.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.ICardService;
import com.gospell.boss.service.IStbService;
import com.gospell.boss.service.ISystemparaService;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/userproduct")
@Transactional
public class UserProductController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IUserproductDao userproductDao; 
	@Autowired
	private IStbService stbService;
	@Autowired
	private ICardService cardService;
	@Autowired
	private IUserstbDao userstbDao; 
	@Autowired
	private IUsercardDao usercardDao; 
	@Autowired
	private ISystemparaService systemparaService;
	
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Userproduct form) {
		//默认查询所有授权的产品
		//form.setEndtime(Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
		form.setPager_openset(5);
		form.setPager_count(userproductDao.findByCount(form));
		List<Userproduct> userproductlist = userproductDao.findByList(form);
		form.setUserproductlist(userproductlist);
		return "user/findUserproductList";
	}
	
	/**
	 * 查询当前订户的订购产品的授权结束时间
	 * @return
	 */
	@ResponseBody //此标志就是返回jesion数据给页面的标志
	@RequestMapping(value="/findLastEndTimeByProductid")
	public Map<String,Object> findLastEndTimeByProductid(Userproduct form) {
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		
		String endtime = userproductDao.findLastEndTimeByProductid(form);
		
		if(StringUtils.isNotEmpty(endtime)){
			//将最后授权时间的后一天封装给页面
			responseJson.put("endtime", Tools.getSpecifiedDayAfter(endtime,"yyyy-MM-dd",1));
		}else{
			//将当前时间封装给页面
			responseJson.put("endtime", Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
		}
		
		//页面能选择的最早时间不能超过今天
		responseJson.put("lastendtime", Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
		
		return responseJson;
	}
	
	/**
     * 初始化订户主机列表
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initMothercardListJson")
    public Map<String,Object> initMothercardListJson(Userproduct form) {
		//封装返回给页面的json对象
		HashMap<String,Object> moghercardListJson = new HashMap<String,Object>();
		//找出当前操作的订户
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		User user = operator.getUser();
		
		if("0".equals(form.getTerminaltype())){//查询机顶盒
			if("".equals(user.getUserstblist()) || user.getUserstblist() == null){
				Userstb userstbform = new Userstb();
				userstbform.setUserid(user.getId());
				List<Userstb> userstblist = userstbDao.queryByList(userstbform);
				for(Userstb userstb : userstblist){
					if("2".equals(userstb.getIncardflag()) && "0".equals(userstb.getMothercardflag())){//只封装无卡主机机顶盒
						if(!form.getTerminalid().equals(userstb.getStbno())){//过滤自己本身
							moghercardListJson.put(userstb.getStbno(), userstb.getStbno());
						}
					}
				}
			}else{
				for (Userstb userstb : user.getUserstblist()) {//封装已经购买的机顶盒
					if("2".equals(userstb.getIncardflag()) && "0".equals(userstb.getMothercardflag())){//只封装无卡主机机顶盒
						if(!form.getTerminalid().equals(userstb.getStbno())){//过滤自己本身
							moghercardListJson.put(userstb.getStbno(), userstb.getStbno());
						}
					}
				}
			}
			for (Userstb buyinguserstb : user.getBuyingstblist()) {//封装正在购买的机顶盒
				if("2".equals(buyinguserstb.getIncardflag()) && "0".equals(buyinguserstb.getMothercardflag())){//只封装无卡主机机顶盒
					if(!form.getTerminalid().equals(buyinguserstb.getStbno())){//过滤自己本身
						moghercardListJson.put(buyinguserstb.getStbno(), buyinguserstb.getStbno());
					}
				}
			}
		}else if("1".equals(form.getTerminaltype())){
			if("".equals(user.getUsercardlist()) || user.getUsercardlist() == null){
				Usercard usercardform = new Usercard();
				usercardform.setUserid(user.getId());
				List<Usercard> usercardlist = usercardDao.queryByList(usercardform);
				for(Usercard usercard : usercardlist){
					if("0".equals(usercard.getMothercardflag())){//只封装主机
						if(!form.getTerminalid().equals(usercard.getCardid())){//过滤自己本身
							moghercardListJson.put(usercard.getCardid(), usercard.getCardid());
						}
					}
				}
			}else{
				for (Usercard usercard : user.getUsercardlist()) {//封装已经购买的智能卡
					if("0".equals(usercard.getMothercardflag())){//只封装主机
						if(!form.getTerminalid().equals(usercard.getCardid())){//过滤自己本身
							moghercardListJson.put(usercard.getCardid(), usercard.getCardid());
						}
					}
				}
			}
			for (Usercard buyingusercard : user.getBuyingcardlist()) {//封装正在购买的智能卡
				if("0".equals(buyingusercard.getMothercardflag())){//只封装主机
					if(!form.getTerminalid().equals(buyingusercard.getCardid())){//过滤自己本身
						moghercardListJson.put(buyingusercard.getCardid(),buyingusercard.getCardid());
					}
				}
			}
		}
		
 		return moghercardListJson;
    }
	
	
	/**
	 * 修改购买中的设备主副机属性
	 * @return
	 */
	@ResponseBody //此标志就是返回jesion数据给页面的标志
	@RequestMapping(value="/updateMothercardflag")
	public Map<String,Object> updateMothercardflag(Userproduct form) {
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		
		Operator operator =  (Operator)getSession().getAttribute("Operator");
		User user = operator.getUser();
		
		//主副机标志
		String mothercardflag = Tools.getStr(getRequest().getParameter("mothercardflag"));
		//副机关联的主机号码
		String mothercardid = Tools.getStr(getRequest().getParameter("mothercardid"));
		
		//系统设置的每台主机允许的副机数量
		String sub_number_allowed = systemparaService.findSystemParaByCodeStr("number_subdevice_allowed_per_main");
		if(StringUtils.isEmpty(sub_number_allowed)){
			sub_number_allowed =  "2";
		}
		
		//临时保存的主机数据库存在的副机数量
		Integer sub_number_now = 0;
		
		if("0".equals(form.getTerminaltype())){//修改机顶盒
			
			//如果是修改成副机时，判断关联的主机允许的副机数量是否超过
			if("1".equals(getRequest().getParameter("mothercardflag"))){
				List<Userstb> subuserstblist = userstbDao.findByMotherstbno(mothercardid);
				if(subuserstblist != null && subuserstblist.size() > 0){
					sub_number_now += subuserstblist.size();
				}
			}
			//循环叠加购买中的副机数量
			for (Userstb buyinguserstb : user.getBuyingstblist()) {
				if("1".equals(buyinguserstb.getMothercardflag())){//判断是否为子机，如果是子机
					if(mothercardid.equals(buyinguserstb.getMothercardid())){//判断该子机的主机号是否等于
						sub_number_now += 1;//每找到一次就循环加1
					}
				}
			}
			
			//此主设备的子设备数量超出指定的数量
			if(sub_number_now >= Integer.parseInt(sub_number_allowed)){
				responseJson.put("flag", "0");//修改主副机标志失败
				responseJson.put("error", getMessage("userbusiness.subnumber.beyond"));
				return responseJson;
			}
			
			
			for (Userstb buyinguserstb : user.getBuyingstblist()) {//封装正在购买的机顶盒
				if(form.getTerminalid().equals(buyinguserstb.getStbno())){//找到该机顶盒
					//修改主副机标志
					buyinguserstb.setMothercardflag(mothercardflag);
					//查询机顶盒的主副机对应价格
					Stb stb = stbService.findStbInfoByStbnoStr(buyinguserstb.getStbno());
					if("1".equals(getRequest().getParameter("mothercardflag"))){//设置为副机
						//修改副机关联的主机号码
						buyinguserstb.setMothercardid(mothercardid);
						//修改副机对应的机顶盒购买价格
						buyinguserstb.setPrice(stb.getSubprice());//修改成副机的价格
					}else{//设置为主机
						//清空副机关联的主机号码
						buyinguserstb.setMothercardid("");
						//修改主机对应的机顶盒购买价格
						buyinguserstb.setPrice(stb.getMainprice());//修改成主机的价格
					}
					
					//删除购买中的产品信息
		    		List<Userproduct> buyingproductlist = user.getBuyingproductlist();
		    		Iterator <Userproduct> productIterator = buyingproductlist.iterator();  
		    		while(productIterator.hasNext()){
		    			if(productIterator.next().getStbno().equals(buyinguserstb.getStbno())){
		    				productIterator.remove();
		    			}
		    		}
		    		//重新封装正在购买中的智能卡
		    		user.setBuyingproductlist(buyingproductlist);
					
				}
			}
		}else if("1".equals(form.getTerminaltype())){//修改智能卡
			
			//如果是修改成副机时，判断关联的主机允许的副机数量是否超过
			if("1".equals(getRequest().getParameter("mothercardflag"))){
				List<Usercard> subusecardlist = usercardDao.findByMothercardid(mothercardid);
				if(subusecardlist != null && subusecardlist.size() > 0){
					sub_number_now += subusecardlist.size();
				}
			}
			//循环叠加购买中的副机数量
			for (Usercard buyingusercard : user.getBuyingcardlist()) {
				if("1".equals(buyingusercard.getMothercardflag())){//判断是否为子机，如果是子机
					if(mothercardid.equals(buyingusercard.getMothercardid())){//判断该子机的主机号是否等于
						sub_number_now += 1;//每找到一次就循环加1
					}
				}
			}
			
			//此主设备的子设备数量超出指定的数量
			if(sub_number_now >= Integer.parseInt(sub_number_allowed)){
				responseJson.put("flag", "0");//修改主副机标志失败
				responseJson.put("error", getMessage("userbusiness.subnumber.beyond"));
				return responseJson;
			}
			
			for (Usercard buyingusercard : user.getBuyingcardlist()) {//封装正在购买的智能卡
				if(form.getTerminalid().equals(buyingusercard.getCardid())){//找到该智能卡
					
					//修改主副机标志
					buyingusercard.setMothercardflag(mothercardflag);
					//查询智能卡的主副机对应价格
					Card card = cardService.findCardInfoByCardidStr(buyingusercard.getCardid());
					
					if("1".equals(getRequest().getParameter("mothercardflag"))){//设置为副机
						//修改副机关联的主机号码
						buyingusercard.setMothercardid(mothercardid);
						//修改副机对应的智能卡购买价格
						buyingusercard.setPrice(card.getSubprice());//修改成副机的价格
					}else{
						//清空副机关联的主机号码
						buyingusercard.setMothercardid("");
						//修改主机对应的智能卡购买价格
						buyingusercard.setPrice(card.getMainprice());//修改成主机的价格
					}
					
					//删除购买中的产品信息
		    		List<Userproduct> buyingproductlist = user.getBuyingproductlist();
		    		Iterator <Userproduct> productIterator = buyingproductlist.iterator();  
		    		while(productIterator.hasNext()){
		    			if(productIterator.next().getCardid().equals(buyingusercard.getCardid())){
		    				productIterator.remove();
		    			}
		    		}
		    		//重新封装正在购买中的智能卡
		    		user.setBuyingproductlist(buyingproductlist);
					
				}
			}
		}
		
		operator.setUser(user);
		getSession().setAttribute("Operator", operator);
		responseJson.put("flag", "1");//修改主副机标志成功
		
		return responseJson;
	}
	
	/**
	 * 验证该产品授权时间是否已经开始
	 * @return
	 */
	@ResponseBody //此标志就是返回jesion数据给页面的标志
	@RequestMapping(value="/checkedUserproductCancel")
	public Map<String,Object> checkedUserproductCancel(Userproduct form) {
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		Userproduct userproductform = new Userproduct();
		userproductform.setQproductids(form.getProductids().split(","));
		List<Userproduct> userproductlist = userproductDao.queryByList(userproductform);
		for(Userproduct userproduct : userproductlist){
			if(userproduct != null && StringUtils.isNotEmpty(userproduct.getStarttime())){
				//授权开始时间
				String starttime = userproduct.getStarttime();
				String currenttime = Tools.getCurrentTimeByFormat("yyyy-MM-dd HH:mm:ss");
				int flag = Tools.compare_date(starttime, currenttime, "yyyy-MM-dd HH:mm:ss");
				if(flag != 1){//授权开始时间在当前时间之前，说明已经开始授权
					responseJson.put("flag", "0");//不能取消该产品
					break;
				}else{
					responseJson.put("flag", "1");//能取消该产品
				}
			}else{
				responseJson.put("flag", "0");
			}
		}
		
		//方便测试，随时都可以取消该产品（如果需要验证产品时间，请屏蔽下面代码）
		responseJson.put("flag", "1");//能取消该产品
		
		return responseJson;
	}
	
	
}
