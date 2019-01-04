package com.gospell.boss.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.dao.IUserTaxpayerDao;
import com.gospell.boss.po.Store;
import com.gospell.boss.po.UserTaxpayer;
import com.gospell.boss.service.ISystemparaService;
/**
 * 控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/taxpayer")
public class UserTaxpayerControllor extends BaseController{
	@Autowired
	private IUserTaxpayerDao userTaxpayerDao;
	@Autowired
	private IStoreDao storeDao;
	@Autowired
	private ISystemparaService systemparaService;
	@ResponseBody
	@RequestMapping("/saveUsertaxpayerMsg")
	public String saveUsertaxpayerMsg(UserTaxpayer usertaxpayer){
		if(usertaxpayer != null){
			//查询是否已存在，存在则更新，否则保存
			UserTaxpayer taxpayer = userTaxpayerDao.findByUserid(usertaxpayer.getUserid());
			if(taxpayer == null){
				userTaxpayerDao.save(usertaxpayer);
			}else{
				userTaxpayerDao.update(usertaxpayer);
			}
		}
		return "success";
	}
	@ResponseBody
	@RequestMapping("/findStore")
	public Store findStore(Integer storeid){
		Store store = new Store();
		if(storeid != null){
			store = storeDao.findById(storeid);
		}
		return store;
	}
	@ResponseBody
	@RequestMapping("/getUsertaxpayer")
	public HashMap<String,Object> getUsertaxpayer(Integer userid){
		//封装返回给页面的json对象
		HashMap<String,Object> responseJson = new HashMap<String,Object>();
		
		//是否打印纳税人识别号和纳税人名称:1 打印 
		String systempara = systemparaService.findSystemParaByCodeStr("print_taxpayer_flag");
		//纳税人信息
		UserTaxpayer taxpayer = null;
		if("1".equals(systempara)){
			taxpayer = userTaxpayerDao.findByUserid(userid);
		}
		if(taxpayer == null){
			taxpayer = new UserTaxpayer();
		}
		responseJson.put("taxpayername", taxpayer.getTaxpayername());
		responseJson.put("taxpayercode", taxpayer.getTaxpayercode());
		responseJson.put("flag", "1");
		
		return responseJson;
	}
}
