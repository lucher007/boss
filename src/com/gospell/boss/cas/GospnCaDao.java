package com.gospell.boss.cas;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.gospell.boss.common.Tools;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Caspnproductplay;
import com.gospell.boss.po.Userproduct;

/**
 * @Title GospnCaDao.java
 * @version 1.0 高斯贝尔普安Ca实现类
 */
public class GospnCaDao  {
	
	//从智能卡号截取发送的智能卡ID，智能卡号长度大于10位,只取后10位有效位
	public static String getCardId(String cardId) {
	    if(StringUtils.isNotEmpty(cardId)){
	    	String casCardId = cardId;
	    	if(casCardId.length()>10){//智能卡号长度大于10位,只取后10位有效位
	    		casCardId = casCardId.substring(casCardId.length()-10);
	    	}
			return casCardId;
	    }else{
	    	return "";
	    }
		
	}
	
	///日期格式化转化成16进制字符串
	public static String formatDateToHexString(String eDate) {
		
		//如果为空，就取默认下月的今天
		if(StringUtils.isEmpty(eDate)){
			return cas_expiredTime();
		}
		
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dateTime = null;
		try {
			dateTime = sdf.parse(eDate);
		} catch (ParseException e) {
			dateTime = new Date();
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return StringUtils.leftPad(Long.toHexString((dateTime).getTime() / 1000), 8, "0");//
	}	
	
	///CAS 到期后就不用再发送该命令了 当前日期+30天
	public static String  cas_expiredTime() {
		 Calendar cal = Calendar.getInstance();//使用默认时区和语言环境获得一个日历。
		 cal.add(Calendar.MONTH, 1);//取当前日期的后一月.
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 String cas_expired = format.format(cal.getTime());//命令过期时间 到期了CAS就不发送
		 return formatDateToHexString(cas_expired);
		//  cas_expired;
	}	
	
	
	/**
	 * 获取普安CA命令头文件+指令类型commandtype;
	 */
	public static String casDatahead(String commandtype) {
		// 消息序列号
	   //00010104000C0015210500000005576029FF
		String commandtypeStr =StringUtils.leftPad(Long.toHexString(Long.parseLong(commandtype)), 2, "0");
		String dataHead="000002"+commandtypeStr;///000002 消息序列号+指令类型
		// 数据头文件
		return dataHead;
	}
	
	/**
	 * 获取普安的CA指令接口
	 */
	public static String getCaCommand(CaCommandParam caCommandPara) {
		StringBuffer MsgBuff = new StringBuffer();//消息体
		//ca指令头信息
		String dataHead = casDatahead(caCommandPara.getCommandtype());
		// 数据体
		String dataBody = orderbody(caCommandPara);
		// 数据体长度
		String dateBodyLength = StringUtils.leftPad(Integer.toHexString(dataBody
			.length() / 2), 4, "0");// 数据体长度占的字节数为2
		//包头+命令+数据包长度+数据包体
		return MsgBuff.append(dataHead).append(dateBodyLength).append(dataBody).toString();
	}
	
	/**
	 * 将协议命令组合成数据包  
	 */
	public static String orderbody(CaCommandParam caCommandPara){
		//产品授权commandtype=1;
		if("1".equals(caCommandPara.getCommandtype())){
			return productAuthorize(caCommandPara);
		//OSD EMAIL授权commandtype=2 OR commandtype=13;
		}else if("2".equals(caCommandPara.getCommandtype()) || "13".equals(caCommandPara.getCommandtype())){
			return sendEmailOrOsd(caCommandPara);
		//重置PIN码commandtype=3;
		}else if("3".equals(caCommandPara.getCommandtype())){
			return pinReset(caCommandPara);
		//启动机卡对应（Command_Type ＝ 4）	
		}else if("4".equals(caCommandPara.getCommandtype())){
			return cardtoStbRef(caCommandPara);
		//取消机卡对应（Command_Type ＝ 5）
		}else if("5".equals(caCommandPara.getCommandtype())){
			return cancelStbtoCardRef(caCommandPara);
		//显示指纹commandtype=6;
		}else if("6".equals(caCommandPara.getCommandtype())){
			return showFinger(caCommandPara);
		//启动区域锁定（Command_Type ＝ 8 ）
		}else if("8".equals(caCommandPara.getCommandtype())){
			return lockArea(caCommandPara);
		//取消区域锁定（Command_Type ＝ 9）
		}else if("9".equals(caCommandPara.getCommandtype())){
			return cancelLockArea(caCommandPara);
		//运营商发卡（Command_Type ＝ 10）
		}else if("10".equals(caCommandPara.getCommandtype())){
			return sendCard(caCommandPara);
		//开卡/停卡（Command_Type ＝ 11）
		}else if("11".equals(caCommandPara.getCommandtype())){
			return startOrStopCard(caCommandPara);
		//发送EMM（Command_Type ＝ 12）
		}else if("12".equals(caCommandPara.getCommandtype())){
			return sendEmm(caCommandPara);
		//条件寻址（Command_Type ＝ 14）	
		}else if("14".equals(caCommandPara.getCommandtype())){
			return sendcndAddr(caCommandPara);
		//IPPV/NVOD金额点充值（Command_Type ＝ 16）
		}else if("16".equals(caCommandPara.getCommandtype())){
			return chargeForNovd(caCommandPara);
		//条件限播（Command_Type ＝ 17） OR 取消条件限播（Command_Type ＝ 18）
		}else if("17".equals(caCommandPara.getCommandtype()) || "18".equals(caCommandPara.getCommandtype())){
			return limitBroadcast(caCommandPara);
		//分区控制（Command_Type = 27）
		}else if("27".equals(caCommandPara.getCommandtype())){
			return areaControl(caCommandPara);
	    //强制OSD（Command_Type ＝ 29）
		}else if("29".equals(caCommandPara.getCommandtype())){
			return forcedOsd(caCommandPara);
		//授权准播（Command_Type ＝ 31）
		}else if("31".equals(caCommandPara.getCommandtype())){
			return authBroadcast(caCommandPara);
		//强制换台（Command_Type ＝ 32）
		}else if("32".equals(caCommandPara.getCommandtype())){
			return forcedChangeChannel(caCommandPara);
		//强制重启机顶盒（Command_Type ＝ 33）
		}else if("33".equals(caCommandPara.getCommandtype())){
			return forceRestartStb(caCommandPara);
		//指定机顶盒默认开机节目（Command_Type ＝ 34）
		}else if("34".equals(caCommandPara.getCommandtype())){
			return stbDefaultMsg(caCommandPara);
		//新Email指令（Command_Type ＝ 35）
		}else if("35".equals(caCommandPara.getCommandtype())){
			return newEmail(caCommandPara);
		// 机卡绑定A(对机顶盒操作)（Command_Type ＝ 36）
		}else if("36".equals(caCommandPara.getCommandtype())){
			return stbBingCard(caCommandPara);
		//PVR再授权指令(对机顶盒操作)（Command_Type ＝ 38）
		}else if("38".equals(caCommandPara.getCommandtype())){
			return pvrAuthEmm(caCommandPara);
		//卡号黑名单添加,删除（Command_Type ＝ 44）
		}else if("44".equals(caCommandPara.getCommandtype())){
			return blackCard(caCommandPara);
		//顶盒黑名单添加删除（Command_Type ＝ 46）
		}else if("46".equals(caCommandPara.getCommandtype())){
			return blackStb(caCommandPara);
		//设置节目号（Command_Type ＝ 47）
		}else if("47".equals(caCommandPara.getCommandtype())){
			return setProgramNo(caCommandPara);
		//设置产品号（Command_Type ＝ 48）
		}else if("48".equals(caCommandPara.getCommandtype())){
			return setProductNo(caCommandPara);
		//删除错误的发卡信息（Command_Type ＝ 51）
		}else if("51".equals(caCommandPara.getCommandtype())){
			return deleteErrCardno(caCommandPara);
		// 新类型的印度指纹显示（Command_Type ＝ 60）
		}else if("60".equals(caCommandPara.getCommandtype())){
			return newFinger(caCommandPara);
		//条件开启或者关闭机顶盒的PVR功能（Command_Type = 63）
		}else if("63".equals(caCommandPara.getCommandtype())){
			return startOrClosePVR(caCommandPara);
		}else{
			return "";
		}
		
	}
	
	/**
	 * 产品授权commandtype=1;
	 */
	public static String productAuthorize(CaCommandParam caCommandPara){ 
		//卡号
		String cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		// 是否快速发送方式
		String quickSendFlag = StringUtils.leftPad(Integer.toHexString(1), 2,"0");// 1位字节
		// 产品（套餐）授权个数
		String productAmount = "";
		//是否发送
		String sendOrNot = StringUtils.leftPad(Integer.toHexString(1), 2,"0");// 1位字节
		// 是否录像（不录像）
		String tapingCtrl = StringUtils.leftPad(Integer.toHexString(1), 2,"0");// 1位字节
		
		StringBuffer productBuff = new StringBuffer();
		List<Userproduct> userproductlist = caCommandPara.getUserproductlist();
		if(userproductlist != null && userproductlist.size() > 0){
			productAmount = StringUtils.leftPad(Integer.toHexString(userproductlist.size()), 2, "0");
			for (Userproduct userproduct : userproductlist) {
				//产品号
				String productNumber = StringUtils.leftPad(Long.toHexString(Long.parseLong(userproduct.getProductid())), 4, "0");	
				// 授权开始时间
				Date productstartdate = Tools.getDateFromStr(userproduct.getStarttime(), "yyyy-MM-dd HH:mm:ss","GMT+8");
				String productBeginTime = StringUtils.leftPad(Long
							.toHexString(productstartdate.getTime() /1000), 8, "0");
				// 授权结束时间
				Date productenddate = Tools.getDateFromStr(userproduct.getEndtime(), "yyyy-MM-dd HH:mm:ss","GMT+8");
				String productEndTime = StringUtils.leftPad(Long
							.toHexString(productenddate.getTime() / 1000), 8, "0");
				// 描述长度-1位字节
				String descLen = StringUtils.leftPad(Integer.toHexString(0), 2, "0");
				// 描述内容（目前为空，不需要组织）
				String descontent = "";
				productBuff.append(sendOrNot).append(tapingCtrl).append(
						productNumber).append(productBeginTime).append(
						productEndTime).append(descLen).append(descontent);
			}
		}
		
		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
		// 数据体
		dataBody.append(cardId).append(quickSendFlag).append(productAmount)
			.append(productBuff.toString());
		//返回数据体
		return dataBody.toString();
	 } 
    
	/**
	 * OSD EMAIL授权commandtype=2 OR commandtype=13;
	 */
	public static String sendEmailOrOsd(CaCommandParam caCommandPara){
		StringBuffer dataBody = new StringBuffer();
		//智能卡ID 4个字节8位
		String cardId = caCommandPara.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		
		EmailOrOsdMsg emailOrOsdMsg = caCommandPara.getEmailOrOsdMsg();
		//编码方式
		String remark = emailOrOsdMsg.getRemark();
		//发送OSD
		if ("2".equals(caCommandPara.getCommandtype())){
			//过期日期4个字节
			String exipredtime = formatDateToHexString(emailOrOsdMsg.getExpiredtime());
			//show_Times_len 2个字节 显示时间长度
			String show_Times_len =StringUtils.leftPad(Long.toHexString(Long.parseLong(emailOrOsdMsg.getDuration())), 4, "0");
			//showTimes显示次数 1个字节
			String showTimes  =StringUtils.leftPad(Long.toHexString(Long.parseLong(emailOrOsdMsg.getShowtimes())), 2, "0");//=  
			///Priority 1个字节
			String Priority  =StringUtils.leftPad(Long.toHexString(Long.parseLong(emailOrOsdMsg.getPriority())), 2, "0");//= 
			//Msg 消息内容
			String msg = null;
			if("BE".equals(remark)){
				msg = Tools.toUniCodeBE(emailOrOsdMsg.getContent());
			}else if("LE".equals(remark)){
				msg = Tools.toUniCodeLE(emailOrOsdMsg.getContent());
			}else{
				msg = Tools.toCodeGB2312(emailOrOsdMsg.getContent());
			}
			//msgLenth 消息内容长度
			String msgLenth=StringUtils.leftPad(Integer.toHexString(msg.length() / 2), 2, "0");
			
			//封装指令数据
			dataBody.append(cardId).append(exipredtime).append(show_Times_len).append(showTimes).append(Priority)
						.append(msgLenth).append(msg);
			
	   //发送邮件EMAIL	
	   } else if ("13".equals(caCommandPara.getCommandtype())) {
		   
		   //过期时间
		   String exipredtime =  formatDateToHexString(emailOrOsdMsg.getExpiredtime());
		   //写信时间 4个字节
		   String writeTime = formatDateToHexString(emailOrOsdMsg.getAddtime());
		   //邮件标题名称 
		   String emailTile = null;
			///邮件内容 最大不能超过1024个字节。
		   String msg = null;
		   if("BE".equals(remark)){
			   emailTile = Tools.toUniCodeBE(emailOrOsdMsg.getEmailtitle());
			   msg = Tools.toUniCodeBE(emailOrOsdMsg.getEmailcontent());
		   }else if("LE".equals(remark)){
			   emailTile = Tools.toUniCodeLE(emailOrOsdMsg.getEmailtitle());
			   msg = Tools.toUniCodeLE(emailOrOsdMsg.getEmailcontent());
		   }else{
			   emailTile = Tools.toCodeGB2312(emailOrOsdMsg.getEmailtitle());
			   msg = Tools.toCodeGB2312(emailOrOsdMsg.getEmailcontent());
		   }
		 //邮件标题长度 1个字节 不能超过16个字节
		   String emailTitle_Len=StringUtils.leftPad(Integer
					.toHexString(emailTile.length() / 2), 2, "0");
		   //邮件内容长度 2个字节
		   String MsgLenth=StringUtils.leftPad(Integer.toHexString(msg.length() / 2), 4, "0");
		   dataBody.append(cardId).append(writeTime).append(emailTitle_Len).append(emailTile).append(MsgLenth).append(msg)
			       .append(exipredtime);
		}
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * 重置PIN码commandtype=3;
	 */
	public static String pinReset(CaCommandParam caCommandPara){
		//智能卡ID 4个字节8位
		String cardId = caCommandPara.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
	//	String cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
//		String expired_time = cas_expiredTime();
	//	String expired_time = caCommandPara.getExpired_Time();
		String expired_time = formatDateToHexString(caCommandPara.getExpired_Time());

		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
		dataBody.append(cardId).append(expired_time);
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * 启动机卡对应（Command_Type ＝ 4）
	 */
	public static   String cardtoStbRef(CaCommandParam caCommandPara) {
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
        String count = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getCorrespondCount())), 8, "0");
		String expired_time = cas_expiredTime();
     	StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		dataBody.append(cardid).append(count).append(expired_time);
		//返回数据体
		return dataBody.toString();
	}
	
	/**
	 * 取消机卡对应（Command_Type ＝ 5）
	 */
	public static String cancelStbtoCardRef(CaCommandParam caCommandPara){
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		String expired_time = cas_expiredTime();
	    StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
	    dataBody.append(cardid).append(expired_time);
	    //返回数据体
	    return dataBody.toString();
	}
	
	/**
	 * 显示指纹commandtype=6;
	 */
	public static String showFinger(CaCommandParam caCommandPara){
		
		EmailOrOsdMsg emailOrOsdMsg = caCommandPara.getEmailOrOsdMsg();
		
		//智能卡ID 4个字节8位
		String cardId = emailOrOsdMsg.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(cardId.toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		
		
		String duration = StringUtils.leftPad(Long.toHexString(Long.parseLong(emailOrOsdMsg.getDuration())), 4, "0");// 2个字节
		
	    //过期时间
		String exipredtime =  formatDateToHexString(emailOrOsdMsg.getExpiredtime());
		
		StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		dataBody.append(cardId).append(duration).append(exipredtime);
		
		//返回数据体
		return dataBody.toString();
	}
	
	/**
	 * 启动区域锁定（Command_Type ＝ 8 ）
	 */
	public static String lockArea(CaCommandParam caCommandPara){
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		String expired_time = cas_expiredTime();
		dataBody.append(cardid).append(expired_time);
		
		//返回数据体
		return dataBody.toString();
		
	}
	
	/**
	 * 取消区域锁定（Command_Type ＝ 9）
	 */
	public static String cancelLockArea(CaCommandParam caCommandPara){
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		String expired_time = cas_expiredTime();
		dataBody.append(cardid).append(expired_time);
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * 运营商发卡（Command_Type ＝ 10）
	 */
	public static String sendCard(CaCommandParam caCommandPara) {
	     String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
	     SendCardPara sendCardPara = caCommandPara.getSendCardPara();
	     String sendOrNot = StringUtils.leftPad(Long.toHexString(Long.parseLong("1")), 2, "0");
	     String mothercard= StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(sendCardPara.getMotherCard_ID()))), 8, "0");// 4位字节
	     String standflag = StringUtils.leftPad(Long.toHexString(Long.parseLong("1")), 2, "0");
	     String decryptCWTimes=StringUtils.leftPad(Long.toHexString(Long.parseLong(sendCardPara.getDecryptCWTimes())), 8, "0");// 4位字节
	     String intervalTime= StringUtils.leftPad(Long.toHexString(Long.parseLong(sendCardPara.getIntervalTime())), 8, "0");// 4位字节
	     String runArea=StringUtils.leftPad(Long.toHexString(Long.parseLong(sendCardPara.getRun_Area())), 4, "0");// 2位字节
	     String vip_Class=StringUtils.leftPad(Long.toHexString(Long.parseLong("1")), 2, "0");
	     String userArea=StringUtils.leftPad(Tools.getHexStringAreacode(sendCardPara.getUser_Area()), 8, "0");// 4位字节
		 String name = StringUtils.rightPad(Tools.toCodeGB2312(sendCardPara.getName()), 40, "0");
		 String other = StringUtils.rightPad(Tools.toCodeGB2312(sendCardPara.getOther()), 40, "0");
		 //过期日期
		 String expired_time = cas_expiredTime();
		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
			// 数据体
		dataBody.append(cardid).append(sendOrNot).append(mothercard).append(
				standflag).append(decryptCWTimes).append(intervalTime)
					.append(runArea).append(vip_Class).append(userArea).append(name).append(other).append(expired_time);
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * 开卡/停卡（Command_Type ＝ 11）
	 * cardstatus 卡状态
	 */
	public static   String startOrStopCard(CaCommandParam caCommandPara){
		  String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4字节
		  String Send_Or_Not = StringUtils.leftPad(Long.toHexString(Long.parseLong("1")), 2, "0");// 1字节
		  String cardstatus = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getCard_Status())), 2, "0");//1字节
		  String expired_time = cas_expiredTime();
		  StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		  dataBody.append(cardid).append(Send_Or_Not).append(cardstatus).append(expired_time);
		  
		  //返回数据体
		  return dataBody.toString();
	}  
	
	/**
	 * 发送EMM（Command_Type ＝ 12）
	 */
	public static String sendEmm(CaCommandParam caCommandPara){
		  String expired_time = cas_expiredTime();
		  String Emm_Len = caCommandPara.getEmm_Len();
		  String Emm_Data = caCommandPara.getEmm_Data();
		  StringBuffer dataBody = new StringBuffer();	// 数据体（不包含头文件格式）
		  dataBody.append(expired_time).append(Emm_Len).append(Emm_Data);
		  //返回数据体
		  return dataBody.toString();
	}  
	
	/**
	 * 条件寻址（Command_Type ＝ 14）
	 */
	public static  String sendcndAddr(CaCommandParam caCommandPara){
		
		//条件内容(页面封装的时候自带结尾逻辑判断符，应该去掉后俩位)
		String Condition = caCommandPara.getConditioncontent();
		Condition = Condition.substring(0,Condition.length()-2);//去掉条件结尾的逻辑号（俩位）
		
		// 条件长度
		String conditionLen = StringUtils.leftPad(Integer
				.toHexString(Condition.length() / 2), 4, "0");
		// 条件寻址命令对象
		CaCommandParam cndAddrPara = caCommandPara.getCndAddrPara();
		String condition_Cmd_Type = StringUtils.leftPad(Long.toHexString(Long.parseLong(cndAddrPara.getCommandtype())), 2, "0");// 1个字节
		
		//条件寻址命令内容
		String conType_Content = orderbody(cndAddrPara);
		
		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();	
		dataBody.append(conditionLen).append(Condition).append(condition_Cmd_Type).append(conType_Content);
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * IPPV/NVOD金额点充值（Command_Type ＝ 16）
	 */
	public static  String chargeForNovd(CaCommandParam caCommandPara){
	   
		//卡号
	    String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		//充值点数 2个字节
	    String chargePoint =StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getChargePoint())), 4, "0");//= 
		String send_Or_Not ="01";//立即发送
		
		//充值时间
		String Charge_Time = formatDateToHexString(caCommandPara.getCharge_Time());
		
		//使用有效时间,若为0xffffffff ，表示不限使用的时间
		String use_Expired_Time = "";
		if(StringUtils.isNotEmpty(caCommandPara.getUse_Expired_Time())){
			use_Expired_Time = formatDateToHexString(caCommandPara.getUse_Expired_Time());
		}else{
			use_Expired_Time = "ffffffff";
		}
		
		//CAS过期时间
		String cas_exipredDate = cas_expiredTime();
		 
		// 数据体（不包含头文件格式）
	    StringBuffer dataBody = new StringBuffer();	
		dataBody.append(cardid).append(chargePoint).append(Charge_Time).append(use_Expired_Time).append(cas_exipredDate).append(send_Or_Not.toString());
		//返回数据体
		return dataBody.toString();
	}
	
	
	/**
	 * 启用条件限播(commandType = 17) 取消条件限播(commandType = 18)
	 */
	public static  String limitBroadcast(CaCommandParam caCommandPara) {
		
		Caspnproductplay params = caCommandPara.getCaspnproductplay();
		//智能卡ID 4个字节8位
		String cardId = caCommandPara.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		// 产品编号
	    String productId = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getProductid())), 4, "0");// 2个字节
	    //过期时间
		String expired_time = formatDateToHexString(params.getExpiredtime());
		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
		if ("17".equals(caCommandPara.getCommandtype())) {
	 		dataBody.append(cardId).append(productId).append(expired_time);	
	 	}else  if ("18".equals(caCommandPara.getCommandtype())) {
	 		 dataBody.append(cardId).append(productId).append(expired_time);	
	 	}
	    return dataBody.toString();
	}
	
	/**
	 * 分区控制（Command_Type = 27）
	 */
	public static  String areaControl(CaCommandParam caCommandPara) {
		//区域号列表
		List<AreaControlParam> areaControlList = caCommandPara.getAreaControlList();
		//区域总数 1个字节
	    String areaNoCount = StringUtils.leftPad(Long.toHexString(areaControlList.size()), 2, "0");// 4位字节
	    // 数据体（不包含头文件格式）
	    StringBuffer dataBody = new StringBuffer();
	    dataBody.append(areaNoCount);
	    for (int i=0; i<areaControlList.size(); i++){
	    	AreaControlParam areaControl = new AreaControlParam();
	    	//区域号，（0xFFFF表示所有分区，此时N只能为1）
	    	String areaNo = StringUtils.leftPad(Long.toHexString(Long.parseLong(areaControl.getAreano())), 4, "0");
	    	//开启/关闭（ 00 开启，01 取消）
	    	String isControl = StringUtils.leftPad(Long.toHexString(Long.parseLong(areaControl.getIsControl())), 2, "0");
	    	//设置时间，以此命令判断矛盾命令的先后,后命令有效
		    Date Set_command_Time_Date = Tools.getDateFromStr(areaControl.getSet_command_Time(), "yyyy-MM-dd HH:mm:ss");
			String Set_command_Time = StringUtils.leftPad(Long.toHexString(Set_command_Time_Date.getTime() / 1000), 8, "0");
	    	//保留字节(0xFF)
			String seserved="00";
			dataBody.append(areaNo).append(isControl).append(Set_command_Time).append(seserved);
	    }
	    String saveServed="00000000";///保留4个字节
	    dataBody.append(saveServed);
	   
	    return dataBody.toString();
	}
	
	/**
	 * 强制OSD（Command_Type ＝ 29）
	 */
	public static String forcedOsd(CaCommandParam caCommandPara){
		StringBuffer dataBody = new StringBuffer();
		
		Caspnforcedosd caspnforcedosd = caCommandPara.getCaspnforcedosd();
		
		//智能卡ID 4个字节8位
		String cardId = caspnforcedosd.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		
		//过期日期
		String exipredtime = formatDateToHexString(caspnforcedosd.getExpiredtime());
		//OSDID
		String osdid = StringUtils.leftPad(Long.toHexString(caspnforcedosd.getId()), 8, "0");
		//Reserved
		String reserved = "FFFFFFFF";
		//操作类型（1：启动，0：取消）
		String IsControl = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getIscontrol())), 2, "0");
		//数据体
		dataBody.append(cardId).append(exipredtime).append(osdid).append(reserved).append(IsControl);
		
		//启动类型
		if("1".equals(caspnforcedosd.getIscontrol())){
			//开始时间
			String StartTime = formatDateToHexString(caspnforcedosd.getStarttime());
			//锁定用户操作
			String Lock = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getLockscreen())), 2, "0");
		    //显示时间长度
			String Duration = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getDuration())), 4, "0");
		    //显示次数
			String ShowTimes = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getShowtimes())), 2, "0");
			//显示频率
			String ShowFreq = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getShowfreq())), 4, "0");
			//优先级
			String Priority = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getPriority())), 2, "0");
			//显示方式
			String Style = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getStyle())), 2, "0");
			//显示方式参数
			String StyleValue = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getStylevalue())), 2, "0");
			//FontSize
			String FontSize = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getFontsize())), 2, "0");
			//foreground_color 前景色RGA
			String FontColor =  StringUtils.leftPad(caspnforcedosd.getForegroundcolor(), 6, "0");
			//foregroundtransparency 前景透明度
			String foregroundtransparency = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getForegroundtransparency())), 2, "0");
			//background_color 背景色RGA
			String BackGroundColor = StringUtils.leftPad(caspnforcedosd.getBackgroundcolor(), 6, "0");
			//backgroundtransparency  背景透明度
			String backgroundtransparency = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedosd.getBackgroundtransparency())), 2, "0");
			//保留字
			String Reserved = "FFFF";
			//font
			String font = StringUtils.leftPad(caspnforcedosd.getFont(), 2, "0");
			String Channel_Flag = "FF";
			
			//编码方式
			String remark = caspnforcedosd.getRemark();
			//Msg 消息内容
			String content = null;
			if("BE".equals(remark)){
				content = Tools.toUniCodeBE(caspnforcedosd.getContent());
			}else if("LE".equals(remark)){
				content = Tools.toUniCodeLE(caspnforcedosd.getContent());
			}else if("GB".equals(remark)){
				content = Tools.toCodeGB2312(caspnforcedosd.getContent());
			}
			//msgLenth 消息内容长度
			String contentLenth=StringUtils.leftPad(Integer.toHexString(content.length() / 2), 4, "0");
		    
			//数据体
			dataBody.append(StartTime).append(Lock).append(Duration).append(ShowTimes).append(ShowFreq)
					.append(Priority).append(Style).append(StyleValue).append(FontSize).append(FontColor).append(foregroundtransparency)
					.append(BackGroundColor).append(backgroundtransparency).append(Reserved).append(font).append(Channel_Flag).append(contentLenth).append(content);
		
		}
		
		//返回数据体
		return dataBody.toString();
	}
	
	/**
	 * 授权准播（Command_Type ＝ 31）
	 * @param params
	 * @return 
	 * @throws ParseException
	 */
	@SuppressWarnings("rawtypes")
	public static String authBroadcast(CaCommandParam caCommandPara){
		Caspnproductplay params = caCommandPara.getCaspnproductplay();
		//智能卡ID 4个字节8位
		String cardId = caCommandPara.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		
		//过期日期
		String exipredtime =  formatDateToHexString(params.getExpiredtime());
	    //生成的授权准播指令标识
		String playid = StringUtils.leftPad(Long.toHexString(params.getPlayid()), 8, "0");
	    //1：启动，0：取消
		String iscontrol = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getIsControl())), 2, "0");
		//授权产品个数
		String productinfos = Tools.getStr(params.getProductinfo());
		String[] productinfosArr = productinfos.split(";");
		 //命令体
	    StringBuffer dataBody = new StringBuffer();	
	    dataBody.append(cardId).append(exipredtime).append(playid).append("FFFF").append(iscontrol);
		
		if(productinfosArr !=null && productinfosArr.length > 0){
			String productAmount  = StringUtils.leftPad(Long.toHexString(productinfosArr.length), 2, "0");// 1个字节
			//拼产品数量
			dataBody.append(productAmount);
			for (String productinfo : productinfosArr) {
				String[] productinfoArr = productinfo.split(",");
				if(productinfoArr != null && productinfoArr.length > 0){
					//拼每个产品的信息
					//是否可以录像
			    	dataBody.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(productinfoArr[0])), 2, "0"));
			    	//产品号
			    	dataBody.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(productinfoArr[1])), 4, "0"));
			    	//授权开始时间
			    	String starttime = formatDateToHexString(String.valueOf(productinfoArr[2]));
					dataBody.append(starttime);
			    	//结束时间
					String endtime = formatDateToHexString(String.valueOf(productinfoArr[3]));
					dataBody.append(endtime);
					
				}
			}
		}
	    return dataBody.toString();
	}
	
	/**
	 * 强制换台（Command_Type ＝ 32）
	 * @param params
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public static String forcedChangeChannel(CaCommandParam caCommandPara){
		
		Caspnforcedcc caspnforcedcc = caCommandPara.getCaspnforcedcc();
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caspnforcedcc.getCardid()))), 8, "0");// 4位字节
		
		//过期时间
  		String expiredtime = formatDateToHexString(caspnforcedcc.getExpiredtime());
		//SMS生成的换台指令标识
		String chcid = StringUtils.leftPad(Long.toHexString(caspnforcedcc.getId()), 8, "0");
		String reserved = "ffffffff";
		//是否启动强制换台
		String iscontrol = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedcc.getIscontrol())), 2, "0");
		//
		StringBuffer dataBuff = new StringBuffer();
		dataBuff.append(cardid).append(expiredtime).append(chcid).append(reserved).append(iscontrol);
		if("1".equals(caspnforcedcc.getIscontrol())){
			//启动强制换台功能
	  		String starttime = formatDateToHexString(caspnforcedcc.getStarttime());
			dataBuff.append(starttime);
			//0表示只切换不锁定，1表示锁定
			String look = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedcc.getLockscreen())), 2, "0"); //是否锁定
			dataBuff.append(look);
			//机顶盒类型(0x00：DVB-C，0x01：DVB-S，0x02: DVB-T)
			String stbtype = StringUtils.leftPad(caspnforcedcc.getStbtype(), 2, "0");
			dataBuff.append(stbtype);
			//时钟的PID
			String pcrpid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedcc.getPcrpid())), 4, "0");
			dataBuff.append(pcrpid);
			//节目号
			String serivceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnforcedcc.getServiceid())), 4, "0");
			dataBuff.append(serivceid);
			//保留2字节
			String reserved1 = "ffff";
			dataBuff.append(reserved1);
			
			//节目组件信息
			StringBuffer programComponentInfoBuff = new StringBuffer();
			ArrayList<HashMap <String,Object>> programComponentInfo = caspnforcedcc.getProgramComponentInfo();
			//节目组件个数(默认为0)
			String programComponentLengh = StringUtils.leftPad(Integer.toHexString(0), 2, "0");
			
			if(programComponentInfo != null && programComponentInfo.size() > 0){
				//给节目组件个数赋值
				programComponentLengh = StringUtils.leftPad(Integer.toHexString(programComponentInfo.size()), 2, "0");
				for (HashMap <String,Object> programComponent : programComponentInfo) {
					//流内容
					String StreamContent = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("StreamContent").toString())), 2, "0");	
					// 基础流类型
					String CompType = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("CompType").toString())), 2, "0");
					//基础流PID
					String CompPID = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("CompPID").toString())), 4, "0");
					// 解扰基础流CW的ECM包的PID
					String ECMPID = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("ECMPID").toString())), 4, "0");
					
					programComponentInfoBuff.append(StreamContent).append(CompType).append(
							CompPID).append(ECMPID);
				}
			}
			
			//数据体封装节目信息
			dataBuff.append(programComponentLengh).append(programComponentInfoBuff);
			
		    //数据体分装DVB信息
			HashMap <String,Object> DVBInfo = caspnforcedcc.getDVBInfo();
			//STBType == 0x00:DVB-C
			if("00".equals(caspnforcedcc.getStbtype())){//STBType == 0x00:DVB-C
				//reserved 
				String reserved_DVBC  = "FFFF";
				//Frequency
				String Frequency = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("Frequency").toString(), 4, 4), 8, "0");
				//reserved_future_use
				String reserved_future_use = "FFF";
				//FEC_outer
				String FEC_outer = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_outer").toString()), 1, "0");
				//Modulation
				String Modulation = StringUtils.leftPad(DVBInfo.get("Modulation").toString(), 2, "0");
				//symbol_rate
				String symbol_rate = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("symbol_rate").toString(), 3, 4), 7, "0");
				//FEC_inner
				String FEC_inner = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_inner").toString()), 1, "0");
			    
				//数据体封装DVB-C信息
				dataBuff.append(reserved_DVBC).append(Frequency).append(reserved_future_use).append(FEC_outer)
						.append(Modulation).append(symbol_rate).append(FEC_inner);
			//STBType == 0x00:DVB-S
			}else if("01".equals(caspnforcedcc.getStbtype())){//STBType == 0x01:DVB-S
				//reserved 
				String reserved_DVBS  = "ffff";
				//Frequency
				String Frequency = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("Frequency").toString(), 3, 5), 8, "0");
				//orbital_position
				String orbital_position = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("orbital_position").toString(), 3, 1), 4, "0");
				//west_east_flag
				String west_east_flag = StringUtils.leftPad(DVBInfo.get("west_east_flag").toString(), 1, "0");
				//polarization
				String polarization = StringUtils.leftPad(DVBInfo.get("polarization").toString(), 2, "0");
			    //modulation
				String modulation = StringUtils.leftPad(DVBInfo.get("modulation").toString(), 5, "0");
				//west_east_flag_polarization_modulation
				String west_east_flag_polarization_modulation = StringUtils.leftPad(Tools.binaryString2hexString(west_east_flag+polarization+modulation), 2, "0");
				//symbol_rate
				String symbol_rate = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("symbol_rate").toString(), 3, 4), 7, "0");
				//FEC_inner
				String FEC_inner = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_inner").toString()), 1, "0");
				
				//数据体封装DVB-S信息
				dataBuff.append(reserved_DVBS).append(Frequency).append(orbital_position).append(west_east_flag_polarization_modulation)
						.append(symbol_rate).append(FEC_inner);
			}	
			
		}		
		
		return dataBuff.toString();	
	}
	
	
	/**
	 * 强制重启机顶盒（Command_Type ＝ 33）
	 * @param params
	 * @return 
	 */
	public static  String forceRestartStb(CaCommandParam caCommandPara){
		//卡号
		String cardid = "ffffffff";
		if(!cardid.equals(caCommandPara.getCardid())){
			cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
		}
		
	    //区域号
	    String areaCode = "ffffffff";
	    if(!areaCode.equals(caCommandPara.getAreacode())){
	    	areaCode = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getAreacode())), 8, "0");
		}
	    
    	//保留字节
	    String reserved = StringUtils.leftPad("f",64,"f");
	    //过期日期
		String expired_time = formatDateToHexString(caCommandPara.getExpired_Time());
		
    	StringBuffer dataBody = new StringBuffer();
		dataBody.append(cardid).append(areaCode).append(reserved).append(expired_time);
	    return dataBody.toString();
	}
	
	/**
	 * 指定机顶盒默认开机节目（Command_Type ＝ 34）
	 * 
	 */  
	public static String stbDefaultMsg(CaCommandParam caCommandPara){
		//机顶盒默认开机参数对象
		Stbdefaultmsg stbdefaultmsg = caCommandPara.getStbdefaultmsg();
		//寻址类型（按卡号寻址或者机顶盒号寻址标识）
		String card_or_stb_tag = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getCard_or_stb_tag())), 2, "0");// 1位字节
		System.out.println("-----card_or_stb_tag------" + card_or_stb_tag);
		//智能卡号
		String cardid = "ffffffff";
		if(!cardid.equals(stbdefaultmsg.getCardid())){
			 cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(stbdefaultmsg.getCardid()))), 8, "0");// 4位字节
		}
		//机顶盒号
		String stb_id = "ffffffff";
		if(!stb_id.equals(stbdefaultmsg.getStbno())){
			 stb_id = StringUtils.leftPad(stbdefaultmsg.getStbno(), 8, "0");// 4个字节
		}
	    //区域号
	    String areano = "ffffffff";
	    if(!areano.equals(stbdefaultmsg.getAreano())){
			 areano = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getAreano())), 8, "0");// 4位字节
		}
		//0表示只切换不锁定，1表示锁定
		String lock = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getLockscreen())), 2, "0");// 1位字节
		//机顶盒的类型
		String stbtype = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getStbtype())), 2, "0");// 1位字节
		//时钟的PID
		String pcrpid = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getPcrpid())), 4, "0");// 2位字节
		
		//数据体
		StringBuffer dataBody = new StringBuffer();	
		if("00".equals(stbdefaultmsg.getCard_or_stb_tag())){//ox00:按卡号寻址
			System.out.println("-----cardid------" + cardid);
			dataBody.append(cardid);
		}else if("01".equals(stbdefaultmsg.getCard_or_stb_tag())){//0x01：按机顶盒号寻址
			System.out.println("-----stb_id------" + stb_id);
			dataBody.append(stb_id);
		}
		dataBody.append(areano).append(lock).append(stbtype).append(pcrpid).append(card_or_stb_tag).append("ffffff");
		
		//节目组件信息
		StringBuffer programComponentInfoBuff = new StringBuffer();
		ArrayList<HashMap <String,Object>> programComponentInfo = stbdefaultmsg.getProgramComponentInfo();
		//节目组件个数(默认为0)
		String programComponentLengh = StringUtils.leftPad(Integer.toHexString(0), 2, "0");
		
		if(programComponentInfo != null && programComponentInfo.size() > 0){
			programComponentLengh = StringUtils.leftPad(Integer.toHexString(programComponentInfo.size()), 2, "0");
			for (HashMap <String,Object> programComponent : programComponentInfo) {
				//流内容
				String StreamContent = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("StreamContent").toString())), 2, "0");	
				System.out.println("-------StreamContent--------" +StreamContent);
				// 基础流类型
				String CompType = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("CompType").toString())), 2, "0");
				System.out.println("-------CompType--------" +CompType);
				//基础流PID
				String CompPID = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("CompPID").toString())), 4, "0");
				System.out.println("-------CompPID--------" +CompPID);
				// 解扰基础流CW的ECM包的PID
				String ECMPID = StringUtils.leftPad(Long.toHexString(Long.parseLong(programComponent.get("ECMPID").toString())), 4, "0");
				System.out.println("-------ECMPID--------" +ECMPID);
				programComponentInfoBuff.append(StreamContent).append(CompType).append(
						CompPID).append(ECMPID);
			}
		}
		
		//数据体封装节目信息
		dataBody.append(programComponentLengh).append(programComponentInfoBuff);
		System.out.println("-------stb_type--------" +stbdefaultmsg.getStbtype());

	    //数据体分装DVB信息
		HashMap <String,Object> DVBInfo = stbdefaultmsg.getDVBInfo();
		//STBType == 0x00:DVB-C
		if("00".equals(stbdefaultmsg.getStbtype())){//STBType == 0x00:DVB-C
			//reserved 
			String reserved  = "ffff";
			//Frequency
			String Frequency = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("Frequency").toString(), 4, 4), 8, "0");
			System.out.println("--------frequencyc--------" +Frequency);
			//reserved_future_use
			String reserved_future_use = StringUtils.leftPad("0",3, "0");
			//FEC_outer
			String FEC_outer = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_outer").toString()), 1, "0");
			System.out.println("--------FEC_outer--------" +FEC_outer);
			//Modulation
			String Modulation = StringUtils.leftPad(DVBInfo.get("Modulation").toString(), 2, "0");
			System.out.println("--------Modulation--------" +Modulation);

			//symbol_rate
			String symbol_rate = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("symbol_rate").toString(), 3, 4), 7, "0");
			System.out.println("------symbol_rate------:" +symbol_rate);
			//FEC_inner
			String FEC_inner = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_inner").toString()), 1, "0");
		    
			//数据体封装DVB-C信息
			dataBody.append(reserved).append(Frequency).append(reserved_future_use).append(FEC_outer)
					.append(Modulation).append(symbol_rate).append(FEC_inner);
		//STBType == 0x00:DVB-S
		}else if("01".equals(stbdefaultmsg.getStbtype())){//STBType == 0x01:DVB-S
			//reserved 
			String reserved  = "ff";
			//Frequency
			String Frequency = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("Frequency").toString(), 4, 4), 8, "0");
			System.out.println("--------frequencyc--------" +Frequency);
			//orbital_position
			String orbital_position = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("orbital_position").toString(), 3, 1), 4, "0");
			//west_east_flag
			String west_east_flag = StringUtils.leftPad(DVBInfo.get("west_east_flag").toString(), 1, "0");
			//polarization
			String polarization = StringUtils.leftPad(DVBInfo.get("polarization").toString(), 2, "0");
		    //modulation
			String modulation = StringUtils.leftPad(DVBInfo.get("modulation").toString(), 5, "0");
			//west_east_flag_polarization_modulation
			String west_east_flag_polarization_modulation = StringUtils.leftPad(Tools.binaryString2hexString(west_east_flag+polarization+modulation), 2, "0");
			//symbol_rate
			String symbol_rate = StringUtils.leftPad(Tools.getBcdCode(DVBInfo.get("symbol_rate").toString(), 3, 4), 7, "0");
			//FEC_inner
			String FEC_inner = StringUtils.leftPad(Tools.binaryString2hexString(DVBInfo.get("FEC_inner").toString()), 1, "0");
			
			//数据体封装DVB-S信息
			dataBody.append(reserved).append(Frequency).append(orbital_position).append(west_east_flag_polarization_modulation)
					.append(symbol_rate).append(FEC_inner);
		}
		
		String Reserved	= StringUtils.leftPad("f",64,"f");
		String serverid = StringUtils.leftPad(Long.toHexString(Long.parseLong(stbdefaultmsg.getServiceid())), 4, "0");// 1位字节
		System.out.println("--------serverid--------" +serverid);

		String expiredtime = formatDateToHexString(stbdefaultmsg.getExpiredtime());
		
		//数据体
		dataBody.append(Reserved).append(serverid).append(expiredtime);
		
		return dataBody.toString();
		
	}
	
	
	/**
	 * 新Email指令（Command_Type ＝ 35）
	 * @param params
	 * @return 
	 */
	public static  String newEmail(CaCommandParam caCommandPara){
		
		Caspnnewemail caspnnewemail = caCommandPara.getCaspnnewemail();
		
		//智能卡号
		//String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewemail.getCardid())), 8, "0");// 4位字节
		//智能卡ID 4个字节8位
		String cardid = caspnnewemail.getCardid();
		if(StringUtils.isNotEmpty(cardid)){//不为空
			if(!"ffffffff".equals(cardid.toLowerCase())){
				cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardid))), 8, "0");// 4位字节
			}
		}else{
			cardid = "";
		}
		
		//EailID
		String emailid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewemail.getId().toString())), 8, "0");// 4位字节
		//EmailOper（ 0:添加 1：删除）
		String emailOper = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewemail.getEmailoper())), 2, "0");// 1位字节
		// Email类型（0：普通 1：重要）
		String email_type = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewemail.getEmailtype())), 2, "0");// 1位字节
		//写信时间
		//String write_paper_time = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewemail.getAddtime())), 8, "0");// 4位字节
		String write_paper_time =  formatDateToHexString(caspnnewemail.getAddtime());
		//编码类型
		String remark = caspnnewemail.getRemark();
		//Email的标题
		String email_title = null;
		//Email 的内容
		String email_content = null;
		if("BE".equals(remark)){
			email_title = Tools.toUniCodeBE(caspnnewemail.getEmailtitle());
			email_content = Tools.toUniCodeBE(caspnnewemail.getEmailcontent());
		}else if("LE".equals(remark)){
			email_title = Tools.toUniCodeLE(caspnnewemail.getEmailtitle());
			email_content = Tools.toUniCodeLE(caspnnewemail.getEmailcontent());
		}else if("GB".equals(remark)){
			email_title =Tools.toCodeGB2312(caspnnewemail.getEmailtitle());
			email_content = Tools.toCodeGB2312(caspnnewemail.getEmailcontent());
		}
		//Email的标题长度
		String email_title_lenth = StringUtils.leftPad(Integer.toHexString(email_title.length() / 2), 2, "0"); //1个字节
		//Email 的内容长度
		String email_content_lenth = StringUtils.leftPad(Integer.toHexString(email_content.length() / 2), 4, "0");//2个字节
		//过期日期4个字节
		String expiredTime = formatDateToHexString(caspnnewemail.getExpiredtime());
		//保留字节
	    String reserved = StringUtils.leftPad("f",64,"f");
	    
	    //数据体
		StringBuffer dataBody = new StringBuffer();
		dataBody.append(cardid).append(emailid).append(emailOper).append(email_type).append(write_paper_time)
	            .append(email_title_lenth).append(email_title).append(email_content_lenth).append(email_content)
	            .append(expiredTime).append(reserved);
		 
		 return dataBody.toString();
		
	}
	
	/**
	 * 机卡绑定A(对机顶盒操作)（Command_Type ＝ 36）
	 * @param params
	 * @return 
	 */
	public static  String stbBingCard(CaCommandParam caCommandPara){
		//机顶盒号
		String stbNo = StringUtils.leftPad(caCommandPara.getStbno(), 8, "0");// 4位字节
		//立即发送标识
		String sendNow = "01";
		//绑定类型（取值说明：0：绑定）
		String pair_Type = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getPair_Type())), 2, "0");// 4位字节
		//过期日期
		String expired_time = cas_expiredTime();
    	//绑定智能卡个数
		List<String> cardids = caCommandPara.getStbBingCardidList();
		String cardidAmount  = StringUtils.leftPad(Long.toHexString(cardids.size()), 2, "0");// 1个字节
		StringBuffer dataBody = new StringBuffer();
		dataBody.append(stbNo).append(sendNow).append(pair_Type).append(expired_time).append(cardidAmount);
		
		for ( int i=0; i<cardids.size(); i++){
		      String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardids.get(i)))), 8, "0");// 4位字节
		      String reserved="0000";//保留字2个字节
		      dataBody.append(cardid).append(reserved);
	    }
		 String lastReserved="0000";//保留字2个字节
		 dataBody.append(lastReserved);
		 
		 return dataBody.toString();
		
	}
	
	/**
	 * PVR再授权指令(对机顶盒操作)（Command_Type ＝ 38）
	 * @param params
	 * @return 
	 */
	public static  String pvrAuthEmm(CaCommandParam caCommandPara){
		PvrAuthEmm pvrEmm = caCommandPara.getPvrAuthEmm();
		//机顶盒号
		String stb_id = StringUtils.leftPad(pvrEmm.getStbno(), 8, "0");// 4个字节
		//PVR的创建时间
		String prvCreateTime =formatDateToHexString(pvrEmm.getTimeInFileID());
		//节目号
		String serviceID = StringUtils.leftPad(Long.toHexString(Long.parseLong(pvrEmm.getServiceID())), 4, "0");// 2个字节
		//授权天数
		String entitle_Days = StringUtils.leftPad(Long.toHexString(Long.parseLong(pvrEmm.getEntitle_Days())), 8, "0");// 4个字节
		//过期时间
		//String expiredtime = cas_expiredTime();
		String expiredtime = formatDateToHexString(pvrEmm.getExpired_Time());

		//保留字段
		String Reserved="00000000"+"00000000"; //2个保留字 8个字节
		StringBuffer dataBody = new StringBuffer();
		///  cmdType=Tools.autoFillStr(Long.toHexString(Long.parseLong(cmdType)), 2, "0");// 1位字节
		dataBody.append(stb_id).append(prvCreateTime).append(serviceID).append(entitle_Days).append(expiredtime).append(Reserved);
		return dataBody.toString();
	}
	    

	/**
	 * 卡号黑名单添加,删除（Command_Type ＝ 44）
	 * @param  operType   操作类型
	 * @return 
	 */
	public static  String blackCard(CaCommandParam caCommandPara){
		//卡号
	    String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 4位字节
	    //操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）。
	    String  cmdType = null;
	    if ("0".equals(caCommandPara.getOperatorType())){///0 添加  
	    	cmdType = "252"; ///11111100前6个bit 为1   后2个bit 0 添加，  2：删除
		} else if ("2".equals(caCommandPara.getOperatorType())) {
		     cmdType="254";////	1  删除
		}
	    cmdType = StringUtils.leftPad(Long.toHexString(Long.parseLong(cmdType)), 2, "0");// 1位字节
		String  reserved="00000000"+"00000000"; //2个保留字 8个字节
		StringBuffer dataBody = new StringBuffer();
		dataBody.append(cardid).append(cmdType).append(reserved);
		
		return dataBody.toString();
	}
	
	
	/**
	 * 机顶盒黑名单添加与删除Command_Type ＝ 46
	 * @param  StbId      顶盒号
	 * @param  operType   操作类型
	 * @param  ExpTime    过期时间
	 * @param  Cards      卡号信息
	 * @return String     返回字符串
	 */  
	public static String blackStb(CaCommandParam caCommandPara){
		//机顶盒号
		String stb_id = StringUtils.leftPad(caCommandPara.getStbno(), 8, "0");// 4个字节
		//操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）。
	    String  cmdType = null;
	    if ("0".equals(caCommandPara.getOperatorType())){///0 添加  
	    	cmdType = "252"; ///11111100前6个bit 为1   后2个bit 0 添加，  2：删除
		} else if ("2".equals(caCommandPara.getOperatorType())) {
		     cmdType="254";////	1  删除
		}
	    cmdType = StringUtils.leftPad(Long.toHexString(Long.parseLong(cmdType)), 2, "0");// 1位字节
	    //立即发送标识（取值说明：0：不立即发送   1：立即发送）
	    String send_now_flag = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getSend_now_flag())), 2, "0");// 1个字节
	    //过期时间
		String expiredtime = caCommandPara.getExpired_Time()!=null ?formatDateToHexString(caCommandPara.getExpired_Time()) : cas_expiredTime();
		//绑定智能卡个数
		List<String> cardids = caCommandPara.getBlackStbCardidList();
		if(cardids == null ){
			cardids = new ArrayList<String>();
		}
		String cardidAmount  = StringUtils.leftPad(Long.toHexString(cardids.size()), 2, "0");// 1个字节
		StringBuffer dataBody = new StringBuffer();	
		dataBody.append(stb_id).append(cmdType).append(send_now_flag).append("00").append(expiredtime).append(cardidAmount);
		 
		for ( int i=0; i<cardids.size(); i++){
		      String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardids.get(i)))), 8, "0");// 4位字节
		      String reserved="0000";//保留字2个字节
		      dataBody.append(cardid).append(reserved);
	    }
		//顶盒保留字节
		String stbReserved = "0000";
		String reserved = "00000000"+"00000000"; //2个保留字 8个字节
		dataBody.append(stbReserved).append(reserved);	
		return dataBody.toString();
	}
	
	/**
	 * 设置节目号  Command_Type = "47";
	 * @param serviceid   
	 * @param opertype 
	 * @throws ParseException
	 */
	public static String setProgramNo(CaCommandParam caCommandPara) {
		
		//操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）。
	    String  cmdType = null;
	    if ("".equals(caCommandPara.getOperatorType())){///0 添加  
	    	cmdType = "252"; ///11111100前6个bit 为1   后2个bit 0 添加，  2：删除
		} else if ("1".equals(caCommandPara.getOperatorType())) {
		     cmdType="255";////	1  删除
		}
	    cmdType = StringUtils.leftPad(Long.toHexString(Long.parseLong(cmdType)), 2, "0");// 1位字节
	    
	    //保留字段
		String reserved = "00000000"+"00000000"; //2个保留字 8个字节
		
		//节目ID
		String serviceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getServiceid())), 4, "0");// 2位字节
		
		StringBuffer dataBody = new StringBuffer();	
		
		dataBody.append(cmdType).append(reserved).append(serviceid);
		
		//节目名称
		String servicename = Tools.toCodeGB2312(caCommandPara.getServicename());
		//servicenameLenth 节目名称长度
		String servicenameLenth=StringUtils.leftPad(Integer.toHexString(servicename.length() / 2), 2, "0");
		
		dataBody.append(servicenameLenth).append(servicename);
		
		return dataBody.toString();		
	}
	
	/**
	 * 设置产品号 Command_Type = "48";
	 * @param args
	 * @return 
	 * @throws ParseException
	 * 
	 */
	public static String setProductNo(CaCommandParam caCommandPara){
		//操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）。
	    String  cmdType = null;
	    if ("".equals(caCommandPara.getOperatorType())){///0 添加  
	    	cmdType = "252"; ///11111100前6个bit 为1   后2个bit 0 添加，  2：删除
		} else if ("1".equals(caCommandPara.getOperatorType())) {
		     cmdType="255";////	1  删除
		}
	    cmdType = StringUtils.leftPad(Long.toHexString(Long.parseLong(cmdType)), 2, "0");// 1位字节
	    
	    //保留字段
		String reserved = "00000000"+"00000000"; //2个保留字 8个字节
		
		//产品ID
		String productid = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getProductid())), 4, "0");// 2位字节
		
		//产品名称
		String productname = Tools.toCodeGB2312(caCommandPara.getProductname());
		//servicenameLenth 节目名称长度
		String productnameLenth=StringUtils.leftPad(Integer.toHexString(productname.length() / 2), 2, "0");
				
		//关联节目个数
		List<String> serviceids = caCommandPara.getServiceList();
		String ServiceCount  = StringUtils.leftPad(Long.toHexString(serviceids.size()), 4, "0");// 1个字节
	    
		//添加到buffer
		StringBuffer dataBody = new StringBuffer();	
		dataBody.append(cmdType).append(reserved).append(productid).append(productnameLenth)
				.append(productname).append(ServiceCount);
		//循环serviceid
		for ( int i=0; i<serviceids.size(); i++){
		      String serviceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(serviceids.get(i))), 8, "0");// 4位字节
		      dataBody.append(serviceid);
	    }
		
		return dataBody.toString();		
	}	
	
	/**
	 * 删除错误的发卡信息（Command_Type ＝ 51）
	 * @param args
	 * @return 
	 * @throws ParseException
	 * 
	 */
	public static String deleteErrCardno(CaCommandParam caCommandPara){
		String reserved="00000000"+"00000000";
		String cardid = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(caCommandPara.getCardid()))), 8, "0");// 1位字节
		StringBuffer dataBuff = new StringBuffer();	
		dataBuff.append(reserved).append(cardid);
		return dataBuff.toString();
	}
	
	/**
	 * 印度新指纹commandtype=60;
	 */
	public static String newFinger(CaCommandParam caCommandPara){
		
		Caspnnewfinger caspnnewfinger = caCommandPara.getCaspnnewfinger();
		
		StringBuffer dataBody = new StringBuffer();
		//智能卡ID 4个字节8位
		String cardId = caspnnewfinger.getCardid();
		if(StringUtils.isNotEmpty(cardId)){//不为空
			if(!"ffffffff".equals(caCommandPara.getCardid().toLowerCase())){
				cardId = StringUtils.leftPad(Long.toHexString(Long.parseLong(getCardId(cardId))), 8, "0");// 4位字节
			}
		}else{
			cardId = "";
		}
		
		//过期日期
		String exipredtime = formatDateToHexString(caspnnewfinger.getExpiredtime());
		//OSDID
		String newfinger_id = StringUtils.leftPad(Long.toHexString(caspnnewfinger.getId()), 8, "0");
		//Reserved
		String reserved = "ffffffff";
		//操作类型（1：启动，0：取消）
		String IsControl = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getIscontrol())), 2, "0");
		//数据体
		dataBody.append(cardId).append(exipredtime).append(newfinger_id).append(reserved).append(IsControl);
		
		//启动类型
		if("1".equals(caspnnewfinger.getIscontrol())){
			//开始时间
			String StartTime = formatDateToHexString(caspnnewfinger.getStarttime());
			//锁定用户操作
			String Lockscreen = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getLockscreen())), 2, "0");
		    //显示时间长度
			String Duration = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getDuration())), 4, "0");
		    //间隔时间
			String interval = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getIntervaltime())), 4, "0");
			//显示次数
			String ShowTimes = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getShowtimes())), 4, "0");
			//字体大小
			String fontsize = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getFontsize())), 2, "0");
			//foreground_color 前景色RGA
			String foreground_color = StringUtils.leftPad(caspnnewfinger.getForegroundcolor(), 6, "0");
			//foregroundtransparency 前景透明度
			String foregroundtransparency = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getForegroundtransparency())), 2, "0");
			//background_color 背景色RGA
			String background_color = StringUtils.leftPad(caspnnewfinger.getBackgroundcolor(), 6, "0");
			//backgroundtransparency  背景透明度
			String backgroundtransparency = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getBackgroundtransparency())), 2, "0");
			
			//显示的位置模式
			String postype = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getPostype())), 2, "0");
			//显示坐标X，PosType为1时有效
			String posx = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getPosx())), 4, "0");
			//显示坐标Y，PosType为1时有效
			String posy = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getPosy())), 4, "0");
			//需要显示FP的频道信息，多个以逗号(,)隔开
			String channelIds = caspnnewfinger.getChannelids();
			//频道数目
			String channelCnt = "00";
			//频道ID
			String channelId = "";
			if(!StringUtils.isEmpty(channelIds)){
				String[] channelIdArr = channelIds.split(",");
				if(channelIdArr != null){
					channelCnt =  StringUtils.leftPad(Long.toHexString(channelIdArr.length), 2, "0");
					for(int i=0;i<channelIdArr.length;i++){
						channelId = channelId + StringUtils.leftPad(Long.toHexString(Long.parseLong(channelIdArr[i])), 4, "0");
			    	}
				}
			}
			//显示频率
			String ShowFreq = StringUtils.leftPad(Long.toHexString(Long.parseLong(caspnnewfinger.getShowfreq())), 2, "0");
			
			//只支持Show_style_Descriptors
			String showtype = StringUtils.leftPad(Tools.hexString2binaryString(caspnnewfinger.getShowtype()), 2, "0");
			String idtype = StringUtils.leftPad(Tools.hexString2binaryString(caspnnewfinger.getIdtype()), 6, "0");
			String Show_style = showtype + idtype;//显示指纹的方式，高2bits：显示类型, 低6bits：ID类型。
			Show_style = StringUtils.leftPad(Tools.binaryString2hexString(Show_style), 2, "0");
			//保留字,务必设置为0xFF；
			String Reserved_for_future  = "ff";
			//内容(8到16个字符)
			String content = Tools.toCodeGB2312(caspnnewfinger.getContent());
			//msgLenth 内容长度
			String contentLenth=StringUtils.leftPad(Integer.toHexString(content.length() / 2), 2, "0");
			
			//Show_style_Descriptors
			String descriptors_tag = "10";
			String descriptor_length = StringUtils.leftPad(String.valueOf(3 + content.length()/2), 2, "0");
			//msgLenth 描述符
			String descriptors = descriptors_tag+descriptor_length+Show_style+Reserved_for_future+contentLenth+content;
		    //描述符长度
			String descriptors_length = StringUtils.leftPad(String.valueOf(5 + content.length()/2), 4, "0");
			
			//数据体
			dataBody.append(StartTime).append(Lockscreen).append(Duration).append(interval).append(ShowTimes).append(fontsize)
					.append(foreground_color).append(foregroundtransparency).append(background_color).append(backgroundtransparency).append(postype).append(posx).append(posy)
					.append(channelCnt).append(channelId).append(ShowFreq).append(descriptors_length).append(descriptors);
		
		}
		
		//返回数据体
		return dataBody.toString();
		
	}
	
	
	/**
	 * 条件开启或者关闭机顶盒的PVR功能（Command_Type = 63）
	 * @param args
	 * @return 
	 * @throws ParseException
	 * 
	 */
	public static String startOrClosePVR(CaCommandParam caCommandPara) {
		String send_Or_Not="01";
		String pvrStatus = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getPvrStatus())), 2, "0");// 1位字节
	    String endDate="ffffffff";//暂时没有,使用默认为4个字节
	    String reserved="ff";		
	    //过期时间
  		String expiredtime = cas_expiredTime();
		StringBuffer dataBuff = new StringBuffer();	
		dataBuff.append(send_Or_Not).append(pvrStatus).append(endDate).append(reserved).append(expiredtime);
		
		return dataBuff.toString();	
		
	}
	

}
