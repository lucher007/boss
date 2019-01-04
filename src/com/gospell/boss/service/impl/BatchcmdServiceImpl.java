package com.gospell.boss.service.impl;


import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IUserbusinessDao;
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.dao.IUsercardDao;
import com.gospell.boss.dao.IUserproductDao;
import com.gospell.boss.dao.IUserstbDao;
import com.gospell.boss.po.Batchcmd;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Constant;
import com.gospell.boss.po.Userbusiness;
import com.gospell.boss.po.Userbusinessdetail;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;
import com.gospell.boss.service.IAuthorizeService;
import com.gospell.boss.service.IBatchcmdService;

/**
 * @Title BatchcmdServiceImpl.java
 * @version 1.0  批量操作实现类
 */
@Service("batchcmdService")
public class BatchcmdServiceImpl implements IBatchcmdService {
	
	@Autowired
	private IUserproductDao userproductDao; 
	@Autowired
	private IUserbusinessdetailDao userbusinessdetailDao; 
	@Autowired
	private IUserbusinessDao userbusinessDao;
	@Autowired
	private IAuthorizeService authorizeService;
	@Autowired
	private IUsercardDao usercardDao; 
	@Autowired
	private IUserstbDao userstbDao; 
	
	/**
	 * 批量授权
	 * @param CaCommandParam
	 * @return
	 */
	public void saveBatchcmd_authorize(Batchcmd batchcmd){
		
		String versiontype =  batchcmd.getVersiontype();
		if(Constant.SERVER_GOS_PN.equals(versiontype)){//普安
			List<Usercard> usercardlist = batchcmd.getUsercardlist();
			for (Usercard usercard : usercardlist) {
				List<Userproduct> userproductList = batchcmd.getUserproductList();
				for (Userproduct userproductform : userproductList) {
					Userproduct userproduct = new Userproduct();
					userproduct.setUserid(usercard.getUserid());
					userproduct.setNetid(usercard.getNetid());
					userproduct.setAreacode(usercard.getAreacode());
					userproduct.setServerid(usercard.getServerid());
					userproduct.setTerminalid(usercard.getCardid());
					userproduct.setTerminaltype("1");
					userproduct.setCardid(usercard.getCardid());
					userproduct.setStbno("");
					userproduct.setProductid(userproductform.getProductid());
					userproduct.setProductname(userproductform.getProductname());
					userproduct.setStarttime(userproductform.getStarttime());
					userproduct.setEndtime(userproductform.getEndtime());
					userproduct.setUnit("day");//批量授权都是按天计算
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date startdate = null;
					Date enddate = null;
					int amount = 0;
					try {
						startdate = sdf.parse(userproduct.getStarttime());
						enddate = sdf.parse(userproduct.getEndtime());
						amount = Tools.differentDays(startdate, enddate);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					userproduct.setBuyamount(amount);
					BigDecimal price = new BigDecimal(0);
					userproduct.setPrice(price);
					userproduct.setTotalmoney(price.multiply(new BigDecimal(userproduct.getBuyamount())));
					userproduct.setType("1");
					userproduct.setSource("0");
					userproduct.setState("1");
					userproduct.setAddtime(Tools.getCurrentTime());
					//封装订户产品
					userproductDao.save(userproduct);
					//封装订户业务表
					Userbusiness userbusiness = new Userbusiness();
					userbusiness.setNetid(usercard.getNetid());
					userbusiness.setOperatorid(batchcmd.getOperator().getId());
					userbusiness.setUserid(usercard.getUserid());
					userbusiness.setStoreid(batchcmd.getOperator().getStoreid());
					userbusiness.setAreacode(usercard.getAreacode());
					userbusiness.setTotalmoney(new BigDecimal(0));
					userbusiness.setShouldmoney(new BigDecimal(0));
					userbusiness.setPaymoney(new BigDecimal(0));
					userbusiness.setAddtime(Tools.getCurrentTime());
					userbusiness.setSource("0");
					userbusiness.setLogout("0");
					userbusiness.setPaytype("0");
					userbusinessDao.save(userbusiness);
					//封装新订户业务明细表
					Userbusinessdetail businessdetail = new Userbusinessdetail();
					businessdetail.setBusinessid(userbusiness.getId());
					businessdetail.setNetid(usercard.getNetid());
					businessdetail.setOperatorid(batchcmd.getOperator().getId());
					businessdetail.setUserid(usercard.getUserid());
					businessdetail.setAreacode(usercard.getAreacode());
					businessdetail.setStoreid(batchcmd.getOperator().getStoreid());
					businessdetail.setBusinesstypekey(batchcmd.getBusinesstypekey());
					businessdetail.setBusinesstypename(batchcmd.getBusinesstypename());
					businessdetail.setTerminalid(usercard.getCardid());
					businessdetail.setTerminaltype("1");
					businessdetail.setCardid(usercard.getCardid());
					businessdetail.setStbno("");
					businessdetail.setProductid(userproduct.getProductid());
					businessdetail.setProductname(userproduct.getProductname());
					businessdetail.setType(userproduct.getType());
					businessdetail.setAddtime(Tools.getCurrentTime());
					businessdetail.setStarttime(userproduct.getStarttime());
					businessdetail.setEndtime(userproduct.getEndtime());
					businessdetail.setContent(userproductform.getProductname());
					businessdetail.setPrice(new BigDecimal(0)); 
					businessdetail.setTotalmoney(new BigDecimal(0));
					businessdetail.setAddtime(Tools.getCurrentTime());
					businessdetail.setLogout("0");
					businessdetail.setSource("0");
					userbusinessdetailDao.save(businessdetail);
				}
			}
		}else if(Constant.SERVER_GOS_GN.equals(versiontype)){//高安
			List<Userstb> userstblist = batchcmd.getUserstblist();
			for (Userstb userstb : userstblist) {
				List<Userproduct> userproductList = batchcmd.getUserproductList();
				for (Userproduct userproductform : userproductList) {
					Userproduct userproduct = new Userproduct();
					userproduct.setUserid(userstb.getUserid());
					userproduct.setNetid(userstb.getNetid());
					userproduct.setAreacode(userstb.getAreacode());
					userproduct.setServerid(userstb.getServerid());
					userproduct.setTerminalid(userstb.getStbno());
					userproduct.setTerminaltype("0");
					userproduct.setCardid("");
					userproduct.setStbno(userstb.getStbno());
					userproduct.setProductid(userproductform.getProductid());
					userproduct.setProductname(userproductform.getProductname());
					userproduct.setStarttime(userproductform.getStarttime());
					userproduct.setEndtime(userproductform.getEndtime());
					userproduct.setUnit("day");//批量授权都是按天计算
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date startdate = null;
					Date enddate = null;
					int amount = 0;
					try {
						startdate = sdf.parse(userproduct.getStarttime());
						enddate = sdf.parse(userproduct.getEndtime());
						amount = Tools.differentDays(startdate, enddate);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					userproduct.setBuyamount(amount);
					BigDecimal price = new BigDecimal(0);
					userproduct.setPrice(price);
					userproduct.setTotalmoney(price.multiply(new BigDecimal(userproduct.getBuyamount())));
					userproduct.setType("1");
					userproduct.setSource("0");
					userproduct.setState("1");
					userproduct.setAddtime(Tools.getCurrentTime());
					//封装订户产品
					userproductDao.save(userproduct);
					//封装订户业务表
					Userbusiness userbusiness = new Userbusiness();
					userbusiness.setNetid(userstb.getNetid());
					userbusiness.setOperatorid(batchcmd.getOperator().getId());
					userbusiness.setUserid(userstb.getUserid());
					userbusiness.setStoreid(batchcmd.getOperator().getStoreid());
					userbusiness.setAreacode(userstb.getAreacode());
					userbusiness.setTotalmoney(new BigDecimal(0));
					userbusiness.setShouldmoney(new BigDecimal(0));
					userbusiness.setPaymoney(new BigDecimal(0));
					userbusiness.setAddtime(Tools.getCurrentTime());
					userbusiness.setSource("0");
					userbusiness.setLogout("0");
					userbusiness.setPaytype("0");
					userbusinessDao.save(userbusiness);
					//封装新订户业务明细表
					Userbusinessdetail businessdetail = new Userbusinessdetail();
					businessdetail.setBusinessid(userbusiness.getId());
					businessdetail.setNetid(userstb.getNetid());
					businessdetail.setOperatorid(batchcmd.getOperator().getId());
					businessdetail.setUserid(userstb.getUserid());
					businessdetail.setAreacode(userstb.getAreacode());
					businessdetail.setStoreid(batchcmd.getOperator().getStoreid());
					businessdetail.setBusinesstypekey(batchcmd.getBusinesstypekey());
					businessdetail.setBusinesstypename(batchcmd.getBusinesstypename());
					businessdetail.setTerminalid(userstb.getStbno());
					businessdetail.setTerminaltype("0");
					businessdetail.setCardid("");
					businessdetail.setStbno(userstb.getStbno());
					businessdetail.setProductid(userproduct.getProductid());
					businessdetail.setProductname(userproduct.getProductname());
					businessdetail.setType(userproduct.getType());
					businessdetail.setAddtime(Tools.getCurrentTime());
					businessdetail.setStarttime(userproduct.getStarttime());
					businessdetail.setEndtime(userproduct.getEndtime());
					businessdetail.setContent(userproductform.getProductname());
					businessdetail.setPrice(new BigDecimal(0)); 
					businessdetail.setTotalmoney(new BigDecimal(0));
					businessdetail.setAddtime(Tools.getCurrentTime());
					businessdetail.setLogout("0");
					businessdetail.setSource("0");
					userbusinessdetailDao.save(businessdetail);
				}
			}
		}
	}
	
	/**
	 * 批量关停
	 * @param CaCommandParam
	 * @return
	 */
	public void saveBatchcmd_stop(Batchcmd batchcmd){
		
		String versiontype =  batchcmd.getVersiontype();
		if(Constant.SERVER_GOS_PN.equals(versiontype)){//普安
			List<Usercard> usercardlist = batchcmd.getUsercardlist();
			for (Usercard usercard : usercardlist) {
				//1-把该终端下面所有的未到期的产品报停，同时保存授权剩余天数
				Userproduct userproductform= new Userproduct();
				userproductform.setTerminalid(usercard.getCardid());
				userproductform.setEndtime(Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
				List<Userproduct> userproductlist = userproductDao.queryByList(userproductform);
				for (Userproduct userproduct : userproductlist) {
					Date startDate = Tools.getDateFromStr(userproduct.getStarttime(), "yyyy-MM-dd HH:mm:ss");
					Date endDate = Tools.getDateFromStr(userproduct.getEndtime(), "yyyy-MM-dd HH:mm:ss");
					Integer restday = 0;
					if(startDate.getTime() < new Date().getTime()){//产品开始日期少于当前时间，剩余授权天数从当天开始算
						restday = Tools.differentDays(new Date(), endDate);
					}else{//授权剩余天数从开始时间开始计算
						restday = Tools.differentDays(startDate, endDate);
					}
					if(restday >= 1){//授权剩余时间大于1，产品才进行报停操作
						userproduct.setRestday(new BigDecimal(restday));
						userproduct.setState("0");//报停
						userproductDao.update(userproduct);//保存修改
						
						//产品发送反授权
						userproduct.setStarttime(userproduct.getEndtime());//产品反授权的开始时间等于结束时间
						authorizeService.saveAuthorize_buyProduct(userproduct);
					}
				}
				
				//2-修改卡的状态
				usercard.setState("0");//报停
				usercardDao.updateStateByCardid(usercard);//保存修改
				
				//3-发送授权指令
				authorizeService.saveAuthorize_stopAndOnCard(usercard,"0");
				
				//4-封装订户业务表
				Userbusiness userbusiness = new Userbusiness();
				userbusiness.setNetid(usercard.getNetid());
				userbusiness.setOperatorid(batchcmd.getOperator().getId());
				userbusiness.setUserid(usercard.getUserid());
				userbusiness.setStoreid(batchcmd.getOperator().getStoreid());
				userbusiness.setAreacode(usercard.getAreacode());
				userbusiness.setTotalmoney(new BigDecimal(0));
				userbusiness.setShouldmoney(new BigDecimal(0));
				userbusiness.setPaymoney(new BigDecimal(0));
				userbusiness.setAddtime(Tools.getCurrentTime());
				userbusiness.setSource("0");
				userbusiness.setLogout("0");
				userbusiness.setPaytype("0");
				userbusinessDao.save(userbusiness);
				//5-封装新订户业务明细表
				Userbusinessdetail businessdetail = new Userbusinessdetail();
				businessdetail.setBusinessid(userbusiness.getId());
				businessdetail.setNetid(usercard.getNetid());
				businessdetail.setOperatorid(batchcmd.getOperator().getId());
				businessdetail.setUserid(usercard.getUserid());
				businessdetail.setAreacode(usercard.getAreacode());
				businessdetail.setStoreid(batchcmd.getOperator().getStoreid());
				businessdetail.setBusinesstypekey(batchcmd.getBusinesstypekey());
				businessdetail.setBusinesstypename(batchcmd.getBusinesstypename());
				businessdetail.setTerminalid(usercard.getCardid());
				businessdetail.setTerminaltype("1");
				businessdetail.setCardid(usercard.getCardid());
				businessdetail.setStbno("");
				businessdetail.setProductid(null);
				businessdetail.setProductname(null);
				businessdetail.setType(null);
				businessdetail.setAddtime(Tools.getCurrentTime());
				businessdetail.setStarttime(null);
				businessdetail.setEndtime(null);
				businessdetail.setContent(usercard.getCardid()+":"+batchcmd.getContent());
				businessdetail.setPrice(new BigDecimal(0)); 
				businessdetail.setTotalmoney(new BigDecimal(0));
				businessdetail.setAddtime(Tools.getCurrentTime());
				businessdetail.setLogout("0");
				businessdetail.setSource("0");
				userbusinessdetailDao.save(businessdetail);
			}
		} else if (Constant.SERVER_GOS_GN.equals(versiontype)){//高安
			List<Userstb> userstblist = batchcmd.getUserstblist();
			for (Userstb userstb : userstblist) {
				
				//1-把该终端下面所有的未到期的产品报停，同时保存授权剩余天数
				Userproduct userproductform= new Userproduct();
				userproductform.setTerminalid(userstb.getStbno());
				userproductform.setEndtime(Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
				List<Userproduct> userproductlist = userproductDao.queryByList(userproductform);
				for (Userproduct userproduct : userproductlist) {
					Date startDate = Tools.getDateFromStr(userproduct.getStarttime(), "yyyy-MM-dd HH:mm:ss");
					Date endDate = Tools.getDateFromStr(userproduct.getEndtime(), "yyyy-MM-dd HH:mm:ss");
					Integer restday = 0;
					if(startDate.getTime() < new Date().getTime()){//产品开始日期少于当前时间，剩余授权天数从当天开始算
						restday = Tools.differentDays(new Date(), endDate);
					}else{//授权剩余天数从开始时间开始计算
						restday = Tools.differentDays(startDate, endDate);
					}
					if(restday >= 1){//授权剩余时间大于1，产品才进行报停操作
						userproduct.setRestday(new BigDecimal(restday));
						userproduct.setState("0");//报停
						userproductDao.update(userproduct);//保存修改
						
						//产品发送反授权
						userproduct.setStarttime(userproduct.getEndtime());//产品反授权的开始时间等于结束时间
						authorizeService.saveAuthorize_buyProduct(userproduct);
					}
				}
				
				//2-修改机顶盒状态
				userstb.setState("0");//报停
				userstbDao.updateStateByStbno(userstb);//保存修改
				
				//3-发送授权指令
				authorizeService.saveAuthorize_stopAndOnStb(userstb,"0");
				
				//4-封装订户业务表
				Userbusiness userbusiness = new Userbusiness();
				userbusiness.setNetid(userstb.getNetid());
				userbusiness.setOperatorid(batchcmd.getOperator().getId());
				userbusiness.setUserid(userstb.getUserid());
				userbusiness.setStoreid(batchcmd.getOperator().getStoreid());
				userbusiness.setAreacode(userstb.getAreacode());
				userbusiness.setTotalmoney(new BigDecimal(0));
				userbusiness.setShouldmoney(new BigDecimal(0));
				userbusiness.setPaymoney(new BigDecimal(0));
				userbusiness.setAddtime(Tools.getCurrentTime());
				userbusiness.setSource("0");
				userbusiness.setLogout("0");
				userbusiness.setPaytype("0");
				userbusinessDao.save(userbusiness);
				
				//5-封装新订户业务明细表
				Userbusinessdetail businessdetail = new Userbusinessdetail();
				businessdetail.setBusinessid(userbusiness.getId());
				businessdetail.setNetid(userstb.getNetid());
				businessdetail.setOperatorid(batchcmd.getOperator().getId());
				businessdetail.setUserid(userstb.getUserid());
				businessdetail.setAreacode(userstb.getAreacode());
				businessdetail.setStoreid(batchcmd.getOperator().getStoreid());
				businessdetail.setBusinesstypekey(batchcmd.getBusinesstypekey());
				businessdetail.setBusinesstypename(batchcmd.getBusinesstypename());
				businessdetail.setTerminalid(userstb.getStbno());
				businessdetail.setTerminaltype("0");
				businessdetail.setCardid("");
				businessdetail.setStbno(userstb.getStbno());
				businessdetail.setProductid(null);
				businessdetail.setProductname(null);
				businessdetail.setType(null);
				businessdetail.setAddtime(Tools.getCurrentTime());
				businessdetail.setStarttime(null);
				businessdetail.setEndtime(null);
				businessdetail.setContent(userstb.getStbno()+":"+batchcmd.getContent());
				businessdetail.setPrice(new BigDecimal(0)); 
				businessdetail.setTotalmoney(new BigDecimal(0));
				businessdetail.setAddtime(Tools.getCurrentTime());
				businessdetail.setLogout("0");
				businessdetail.setSource("0");
				userbusinessdetailDao.save(businessdetail);
			}
		}
	}
	
	
	/**
	 * 批量授权刷新
	 * @param CaCommandParam
	 * @return
	 */
	public void saveBatchcmd_batchauthorizerefresh(Batchcmd batchcmd){
		
		String versiontype =  batchcmd.getVersiontype();
		if(Constant.SERVER_GOS_PN.equals(versiontype)){//普安
			List<Usercard> usercardlist = batchcmd.getUsercardlist();
			for (Usercard usercard : usercardlist) {
				//1-把该终端下面所有的未到期的产品报停，同时保存授权剩余天数
				Userproduct userproductform= new Userproduct();
				userproductform.setTerminalid(usercard.getCardid());
				userproductform.setEndtime(Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
				List<Userproduct> userproductlist = userproductDao.queryByList(userproductform);
				for (Userproduct userproduct : userproductlist) {
					//发送授权
					authorizeService.saveAuthorize_buyProduct(userproduct);
				}
			}
		} else if (Constant.SERVER_GOS_GN.equals(versiontype)){//高安
			List<Userstb> userstblist = batchcmd.getUserstblist();
			for (Userstb userstb : userstblist) {
				
				//1-把该终端下面所有的未到期的产品报停，同时保存授权剩余天数
				Userproduct userproductform= new Userproduct();
				userproductform.setTerminalid(userstb.getStbno());
				userproductform.setEndtime(Tools.getCurrentTimeByFormat("yyyy-MM-dd"));
				List<Userproduct> userproductlist = userproductDao.queryByList(userproductform);
				for (Userproduct userproduct : userproductlist) {
					//发送授权
					authorizeService.saveAuthorize_buyProduct(userproduct);
				}
			}
		}
	}
	
	/**
	 * 批量发卡
	 * @param CaCommandParam
	 * @return
	 */
	public void saveBatchcmd_batchsendcard(Batchcmd batchcmd){
		
		String userareacode = batchcmd.getUserareacode();
		String versiontype =  batchcmd.getVersiontype();
		if(Constant.SERVER_GOS_PN.equals(versiontype)){//普安
			List<Card> cardlist = batchcmd.getCardlist();
			for (Card card : cardlist) {
				authorizeService.saveAuthorize_batchsendCard(card,userareacode);
			}
		}
	}
	
}
