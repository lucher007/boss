package com.gospell.boss.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.GospnCaDao;
import com.gospell.boss.cas.SendCardPara;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Constant;
import com.gospell.boss.po.Systempara;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IGospnCaService;

/**
 * @Title GosgnCaDao.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("gospnCaService")
public class GospnCaServiceImpl implements IGospnCaService {
	
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
	 * 运营商发卡命令 (commandtype=10)
	 */
	public String  getInitCardCommand(Usercard usercard) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		
		//指令值
		caCommandParam.setCommandtype("10");
	    //智能卡号
		caCommandParam.setCardid(usercard.getCardid());
		
		//运营商发卡对象
		SendCardPara sendCardPara = new SendCardPara();
		//设置母卡卡号
		if(StringUtils.isEmpty(usercard.getMothercardflag())|| "0".equals(usercard.getMothercardflag())){//0-母卡；1-子卡
			sendCardPara.setMotherCard_ID("0");//为0 表示此卡本身就是母卡
		}else{
			sendCardPara.setMotherCard_ID(usercard.getMothercardid());
		}
		//子母卡配对失效判断标准
		sendCardPara.setStandardFlag(1);
		//解密CW 的次数
		sendCardPara.setDecryptCWTimes("1000");
		//间隔时间(2天）
		Integer intervalTime = Integer.valueOf(getSystemParaByCode(Constant.MASTER_SLAVE_CARD_INTERVAL_TIME));
		if(intervalTime == null){
			intervalTime = 2;
		}
		sendCardPara.setIntervalTime(String.valueOf(intervalTime*24*3600));
		//运营商区域ID
		sendCardPara.setRun_Area(getSystemParaByCode(Constant.OPERATORS_AREAID));
		//用户地址区域码
		//User user = userDao.findById(usercard.getUserid());
		Area areaform = new Area();
		areaform.setNetid(usercard.getNetid());
		areaform.setAreacode(usercard.getAreacode());
		areaform = areaDao.findByAreacode(areaform);
		if(areaform != null){
			String code = areaform.getCode();//CAS分区ID在code中保存着
			if(StringUtils.isNotEmpty(code)){//如果code中没有值，就取areacode发送
				sendCardPara.setUser_Area(code);
			}else{
				sendCardPara.setUser_Area(areaform.getAreacode());
			}
		}else{//如果区域没有，默认发送0.1.0.0
			sendCardPara.setUser_Area("000001000000");
		}
		
		//运营商名称
		sendCardPara.setName(getSystemParaByCode(Constant.OPERATORS_NAME));
		//运营商其他信息
		sendCardPara.setOther(getSystemParaByCode(Constant.OPERATOR_INFO));
		
		caCommandParam.setSendCardPara(sendCardPara);
		
		return GospnCaDao.getCaCommand(caCommandParam);
		
	}
	
	
	/**
	 * 智能卡激活命令 (commandtype=11)
	 */
	public String  getActivateCardCommand(Usercard usercard) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("11");
	    //智能卡号码
		caCommandParam.setCardid(usercard.getCardid());
		//智能卡状态(1 为开始卡的使用；0 为停止卡的使用)
		caCommandParam.setCard_Status("1");
		
		return GospnCaDao.getCaCommand(caCommandParam);
	}

	/**
	 * 购买产品授权 (commandtype=1)
	 */
	public String  getBuyProductCommand(Usercard usercard) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("1");
	    //智能卡号码
		caCommandParam.setCardid(usercard.getCardid());
		//购买产品列表
		caCommandParam.setUserproductlist(usercard.getUserproductList());
		
		return GospnCaDao.getCaCommand(caCommandParam);
	}
	
	
	/**
	 * 终端状态控制 (commandtype=11) 
	 *@param commandType:指令类型（0-停；1-开）
	 */
	public String  getStopAndOnCardCommand(Usercard usercard,String commandType) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("11");
		//智能卡号码
		caCommandParam.setCardid(usercard.getCardid());
		//终端开启状态
		caCommandParam.setCard_Status(commandType);
		
		return GospnCaDao.getCaCommand(caCommandParam);
	}
	
	
	/**
	 * 机卡绑定A(对机顶盒操作)（Command_Type ＝ 36）
	 */
	public String  getStbBingCardCommand(Userstb userStb) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("36");
	    //机顶盒号码
		caCommandParam.setStbno(userStb.getStbno());
		//绑定类型（取值说明：0：绑定）
		caCommandParam.setPair_Type("0");
		//机顶盒绑定智能卡列表
		List<String> stbBingCardidList = new ArrayList<String>();
		for (Usercard usercard : userStb.getBingUsercardList()) {
			stbBingCardidList.add(usercard.getCardid());
		}
		caCommandParam.setStbBingCardidList(stbBingCardidList);
		
		return GospnCaDao.getCaCommand(caCommandParam);
	}
	
	
	/**
	 * 电子钱包充值 (commandtype=16)
	 */
	public String  getRechargeWalletCommand(Usercard usercard) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		//指令值
		caCommandParam.setCommandtype("16");
	    //智能卡号
		caCommandParam.setCardid(usercard.getCardid());
		//充值金额
		String rechargemoney = usercard.getRechargemoney();
		//货币转换因子之分母
		String denominator = getSystemParaByCode(Constant.CURRENCY_CONVERSION_DENOMINATOR);//货币转换因子之分母
		//充值点数等于充值金额乘以转换因子之分母
		BigDecimal chargePoint = new BigDecimal(rechargemoney).multiply(new BigDecimal(denominator));
		//充值点数
		caCommandParam.setChargePoint(String.valueOf(chargePoint));
		//充值时间
		caCommandParam.setCharge_Time(Tools.getCurrentTime());
		
		
		return GospnCaDao.getCaCommand(caCommandParam);
		
	}
	
	/**
	 * 批量发卡命令 (commandtype=10)
	 */
	public String  getBatchsendcardCommand(Card card,String userareacode) {
		//CA指令对象
		CaCommandParam caCommandParam = new CaCommandParam();
		
		//指令值
		caCommandParam.setCommandtype("10");
	    //智能卡号
		caCommandParam.setCardid(card.getCardid());
		
		//运营商发卡对象
		SendCardPara sendCardPara = new SendCardPara();
		//设置母卡卡号
		sendCardPara.setMotherCard_ID("0");//为0 表示此卡本身就是母卡
		
		//子母卡配对失效判断标准
		sendCardPara.setStandardFlag(1);
		//解密CW 的次数
		sendCardPara.setDecryptCWTimes("1000");
		//间隔时间(2天）
		Integer intervalTime = Integer.valueOf(getSystemParaByCode(Constant.MASTER_SLAVE_CARD_INTERVAL_TIME));
		if(intervalTime == null){
			intervalTime = 2;
		}
		sendCardPara.setIntervalTime(String.valueOf(intervalTime*24*3600));
		//运营商区域ID
		sendCardPara.setRun_Area(getSystemParaByCode(Constant.OPERATORS_AREAID));
		//用户地址区域码
		//User user = userDao.findById(usercard.getUserid());
		Area areaform = new Area();
		areaform.setNetid(card.getNetid());
		areaform.setAreacode(userareacode);
		areaform = areaDao.findByAreacode(areaform);
		if(areaform != null){
			String code = areaform.getCode();//CAS分区ID在remark中保存着
			if(StringUtils.isNotEmpty(code)){//如果remark中没有值，就取areacode发送
				sendCardPara.setUser_Area(code);
			}else{
				sendCardPara.setUser_Area(areaform.getAreacode());
			}
		}else{//如果区域没有，默认发送0.1.0.0
			sendCardPara.setUser_Area("000001000000");
		}
		//sendCardPara.setUser_Area(userareacode);
		//运营商名称
		sendCardPara.setName(getSystemParaByCode(Constant.OPERATORS_NAME));
		//运营商其他信息
		sendCardPara.setOther(getSystemParaByCode(Constant.OPERATOR_INFO));
		
		caCommandParam.setSendCardPara(sendCardPara);
		
		return GospnCaDao.getCaCommand(caCommandParam);
		
	}
}
