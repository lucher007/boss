package com.gospell.boss.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.GaoAn_InitStb;
import com.gospell.boss.cas.GosgnCaDao;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Constant;
import com.gospell.boss.po.Systempara;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IGosgnCaService;

/**
 * @Title GosgnCaDao.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("gosgnCaService")
public class GosgnCaServiceImpl implements IGosgnCaService {
	
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IAreaDao areaDao;
	
	
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
	
	//------------------------------------------------------------------------------
	
	/**
	 * 初始化机顶盒发卡命令 (commandtype=166，0xA6)
	 */
	public String  getInitStbCommand(Userstb userstb) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		
		//指令值
		caCommandParam.setCommandtype("166");
	    //单播
		caCommandParam.setAddressingmode("0");
	    //终端号码
		caCommandParam.setStbno(userstb.getStbno());
		
		//初始化机顶盒CAS对象
		GaoAn_InitStb gaoAnInitStb = new GaoAn_InitStb();
		//运营商区域ID
		gaoAnInitStb.setArea_id(getSystemParaByCode(Constant.OPERATORS_AREAID));
//		//订户所在区域CAS区域控制ID
//		Area areaform = new Area();
//		areaform.setNetid(userstb.getNetid());
//		areaform.setAreacode(userstb.getAreacode());
//		areaform = areaDao.findByAreacode(areaform);
//		if(areaform != null){
//			String code = areaform.getCode();//CAS分区ID在remark中保存着
//			if(StringUtils.isNotEmpty(code)){//如果remark中没有值，就取areacode发送
//				gaoAnInitStb.setArea_id(code);
//			}else{
//				gaoAnInitStb.setArea_id(areaform.getAreacode());
//			}
//		}else{//如果区域没有，默认发送0.1.0.0
//			gaoAnInitStb.setArea_id("000001000000");
//		}
		
		//网络ID
		gaoAnInitStb.setNet_id(getSystemParaByCode(Constant.OPERATORS_NETID));
		//信束ID
		gaoAnInitStb.setBouquet_id(getSystemParaByCode(Constant.OPERATORS_BOUQUETID));
		//节目预览时间
		gaoAnInitStb.setPreviewinterval("0");
		//运营商定期激活周期
		gaoAnInitStb.setOperatorinterval("0");
		//用户VIP级别
		gaoAnInitStb.setUser_vip_class(getSystemParaByCode(Constant.USER_VIP_CLASS));
		//成人级
		gaoAnInitStb.setMaturity_rating(getSystemParaByCode(Constant.MATURITY_RATING));
		//终端类型
		String terminalType = userstb.getMothercardflag();
		if(StringUtils.isEmpty(terminalType)){
			terminalType = "0";
		}
		gaoAnInitStb.setTerminal_type(terminalType);
		//子机或者母机List
		ArrayList<String> stbList = new ArrayList<String>();
		List<Userstb> userstblist = userstb.getMatherOrSonStbList();
		for (Userstb subuserstb : userstblist) {
			stbList.add(subuserstb.getStbno());
		}
		gaoAnInitStb.setStbList(stbList);
		//本地激活标识
		gaoAnInitStb.setActiveflag("0");
		//本地激活周期
		gaoAnInitStb.setActiveinterval("0");
		//计费货币代码
		gaoAnInitStb.setCurrencycode(getSystemParaByCode(Constant.CURRENCY_CODE));
		//货币转换因子分母部分
		gaoAnInitStb.setCondenominator("10");
		//货币转换因子分子部分
		gaoAnInitStb.setConversion_numerator("1");
		//运营商信息
		gaoAnInitStb.setOperatorinfo(getSystemParaByCode(Constant.OPERATOR_INFO));
		
		caCommandParam.setGaoAnInitStb(gaoAnInitStb);
		
		return GosgnCaDao.getCaCommand(caCommandParam);
		
	}
	
	
	/**
	 * 机顶盒激活命令 (commandtype=165，0xA5)
	 */
	public String  getActivateStbCommand(Userstb userstb) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("165");
	    //单播
		caCommandParam.setAddressingmode("0");
	    //终端号码
		caCommandParam.setStbno(userstb.getStbno());
		
		return GosgnCaDao.getCaCommand(caCommandParam);
	}

	/**
	 * 购买产品授权 (commandtype=193，0xc1)
	 */
	public String  getBuyProductCommand(Userstb userstb) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("193");
		 //单播
		caCommandParam.setAddressingmode("0");
	    //终端号码
		caCommandParam.setStbno(userstb.getStbno());
		//购买产品列表
		caCommandParam.setUserproductlist(userstb.getUserproductList());
		
		return GosgnCaDao.getCaCommand(caCommandParam);
	}
	
	/**
	 * 终端状态控制 (commandtype=167，0xA7) 
	 *@param commandType:指令类型（0-停；1-开）
	 */
	public String  getStopAndOnStbCommand(Userstb userstb,String commandType) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("167");
		 //单播
		caCommandParam.setAddressingmode("0");
	    //终端号码
		caCommandParam.setStbno(userstb.getStbno());
		//终端开启状态
		caCommandParam.setTerminal_status(commandType);
		//终端开启日期(系统默认到2038-12-30 23:59:59)
		caCommandParam.setOpen_expired_time("2038-12-30 23:59:59");
		
		return GosgnCaDao.getCaCommand(caCommandParam);
	}
	
	
	/**
	 * 电子钱包充值 (commandtype=168，0xA8)
	 */
	public String  getRechargeWalletCommand(Userstb userstb) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		
		//指令值
		caCommandParam.setCommandtype("168");
	    //单播
		caCommandParam.setAddressingmode("0");
	    //终端号码
		caCommandParam.setStbno(userstb.getStbno());
		
		//充值金额
		String rechargemoney = userstb.getRechargemoney();
		//货币转换因子之分母
		String denominator = getSystemParaByCode(Constant.CURRENCY_CONVERSION_DENOMINATOR);//货币转换因子之分母
		//充值点数等于充值金额乘以转换因子之分母
		BigDecimal chargePoint = new BigDecimal(rechargemoney).multiply(new BigDecimal(denominator));
		//充值点数
		caCommandParam.setChargePoint(String.valueOf(chargePoint));
		//充值时间
		caCommandParam.setCharge_Time(Tools.getCurrentTime());
		
		return GosgnCaDao.getCaCommand(caCommandParam);
		
	}
	
	
}
