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
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.Userproduct;

/**
 * @Title GosgnCaDao.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
public class GosgnCaDao  {
	
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
		return StringUtils.leftPad(Long.toHexString((dateTime).getTime() / 1000), 8, "0");
	}	
	
	///CAS 到期后就不用再发送该命令了 当前日期+30天
	public static    String  cas_expiredTime() {
		 Calendar cal = Calendar.getInstance();//使用默认时区和语言环境获得一个日历。
		 cal.add(Calendar.MONTH, 1);//取当前日期的后一月.
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 String cas_expired = format.format(cal.getTime());//命令过期时间 到期了CAS就不发送
		 return formatDateToHexString(cas_expired);
		//  cas_expired;
	}	
	
	/**
	 * 获取高安CA命令头文件版本号comtype;
	 */
	public static String casDatahead(String comtype) {
		// 消息序列号
	   //00010104000C0015210500000005576029FF
		String comType =StringUtils.leftPad(Long.toHexString(Long.parseLong(comtype)), 2, "0");
		String dataHead="000002"+comType;///000002 消息序列号+版本号
		// 数据头文件
		return dataHead;
	}
	
	/**
	 * 获取高安的CA指令接口
	 */
	public static String getCaCommand(CaCommandParam caCommandPara) {
		StringBuffer MsgBuff = new StringBuffer();//消息体
		//ca指令头信息
		String dataHead = casDatahead(caCommandPara.getCommandtype());
		
		//寻址条件
		StringBuffer addressing_condition = new StringBuffer();
		//寻址条件长度
		String addressing_condition_len = "";
		
		//命令类型
		String commandtype = caCommandPara.getCommandtype();
		
		//密钥交换(commandtype=101，0x65);套餐包信息(commandtype=160，0xa0)
		//上面俩种指令不需要条件寻址
		if(!"101".equals(commandtype) && !"160".equals(commandtype)){
			//寻址条件判断
			if("0".equals(caCommandPara.getAddressingmode())){//单播-0
				//单寻址长度+寻址方式+终端类型
				String addressing_mode = "00";//单播
				String terminal_type = "00";  //无卡终端
				//String addr_part = "0006"+"00"+"01";
			    //单播机顶盒号
				String stbno = StringUtils.leftPad(caCommandPara.getStbno(), 8, "0");// 4字节
				//寻址条件内容
				addressing_condition.append(addressing_mode).append(terminal_type).append(stbno); 
			    //寻址条件长度
				addressing_condition_len = StringUtils.leftPad(Integer
						.toHexString(addressing_condition.length() / 2), 4, "0"); 
			}else if("1".equals(caCommandPara.getAddressingmode())){//多播-1
				//多寻址长度+寻址方式+终端类型
				//String addr_part="000B"+"01"+"00";
				String addressing_mode = "01";//多播
				String terminal_type = "00";  //无卡终端
				//多播条件段数
				String condition_count = caCommandPara.getConditioncount();
				if(StringUtils.isEmpty(condition_count)){//如果为空，默认多播段数为1段
					condition_count = "1";
				}
				
				condition_count = StringUtils.leftPad(Long.toHexString(Long.parseLong(condition_count)), 2, "0"); // 1字节
			    
				String conditioncontent = StringUtils.leftPad(caCommandPara.getConditioncontent(),16,"0"); // 每一段为8字节
			    //寻址条件内容
			    addressing_condition.append(addressing_mode).append(terminal_type).append(condition_count).append(conditioncontent);
			    //寻址条件长度
			    addressing_condition_len = StringUtils.leftPad(Integer
						.toHexString(addressing_condition.length() / 2), 4, "0"); 
			}
		}
		
		// 命令体
		String commandBody = orderbody(caCommandPara);
		// 命令体长度
		String commandBodyLength = StringUtils.leftPad(Integer.toHexString(commandBody
			.length() / 2), 4, "0");// 数据体长度占的字节数为2
	    //数据体
		StringBuffer dataBody = new StringBuffer();
		dataBody.append(addressing_condition_len).append(addressing_condition).append(commandBodyLength).append(commandBody);
		//数据体长度
		String dataBodyLength = StringUtils.leftPad(Integer.toHexString(dataBody
				.length() / 2), 4, "0");// 数据体长度占的字节数为2
		//包头+命令+数据包长度+数据包体
		return MsgBuff.append(dataHead).append(dataBodyLength).append(dataBody).toString();
	}
	
	/**
	 * 将协议命令组合成数据包  
	 */
	public static String orderbody(CaCommandParam caCommandPara){
		//电子邮件commandtype=185，0xb9;
		if("185".equals(caCommandPara.getCommandtype())){
			return sendEmail(caCommandPara);
		//清除PIN 码 (commandtype=161，0xA1)
		}else if("161".equals(caCommandPara.getCommandtype())){
			return cleanPincode(caCommandPara);
		//重置PIN码 (commandtype=162，0xA2)
		}else if("162".equals(caCommandPara.getCommandtype())){
			return restPincode(caCommandPara);
		//父母锁密码复位 (commandtype=174，0xAE) 
		}else if("174".equals(caCommandPara.getCommandtype())){
			return resetParentCode(caCommandPara);
		//终端状态控制 (commandtype=167，0xA7) 
		}else if("167".equals(caCommandPara.getCommandtype())){
			return terminalcontorl(caCommandPara);
		//电子钱包充值 (commandtype=168，0xA8)
		}else if("168".equals(caCommandPara.getCommandtype())){
			return ippCharge(caCommandPara);
		//产品限播控制 (commandtype=169，0xA9) OR 产品准播控制 (commandtype=170，0xAA)
		//}else if("169".equals(caCommandPara.getCommandtype()) || "170".equals(caCommandPara.getCommandtype())){
		//	return productCastControl(caCommandPara);
		//清除机顶盒信息 (commandtype=172，0xAC) 
		}else if("172".equals(caCommandPara.getCommandtype())){
			return cleanUserinfo(caCommandPara);
		//区域绑定控制 (commandtype=175，0xAF) OR 运营商绑定控制 (commandtype=176，0xb0) OR 网络绑定控制 (commandtype=177，0xb1)
		}else if("175".equals(caCommandPara.getCommandtype()) || "176".equals(caCommandPara.getCommandtype()) || "177".equals(caCommandPara.getCommandtype())){
			return lockControl(caCommandPara);
		//OSD指令 (commandtype=178，0xb2)
		}else if("178".equals(caCommandPara.getCommandtype())){
			return sendOSD(caCommandPara);
	    //新版指纹 (commandtype=179，0xb3)
		}else if("179".equals(caCommandPara.getCommandtype())){
			return newfinger(caCommandPara);
		//强制换台 (commandtype=180，0xb4)
		}else if("180".equals(caCommandPara.getCommandtype())){
			return forcedcc(caCommandPara);
		//强制重启 (commandtype=181，0xb5)
		}else if("181".equals(caCommandPara.getCommandtype())){
			return forcedrestart(caCommandPara);
		//重新搜索节目 (commandtype=182，0xb6)
		}else if("182".equals(caCommandPara.getCommandtype())){
			return researchprogram(caCommandPara);
		//机顶盒默认开机节目 (commandtype=183，0xb7)
		}else if("183".equals(caCommandPara.getCommandtype())){
			return stbdefaultmsg(caCommandPara);
		//旧套餐和节目授权 (commandtype=192，0xc0)
		}else if("192".equals(caCommandPara.getCommandtype())){
			return oldEmm(caCommandPara);
		//套餐和节目授权 (commandtype=193，0xc1)
		}else if("193".equals(caCommandPara.getCommandtype())){
			return productEmm(caCommandPara);
		//初始化机顶盒发卡命令 (commandtype=166，0xA6)
		}else if("166".equals(caCommandPara.getCommandtype())){
			return initStb(caCommandPara);
		//机顶盒激活 (commandtype=165，0xA5)
		}else if("165".equals(caCommandPara.getCommandtype())){
			return activateStb(caCommandPara);
		//套餐包信息(commandtype=160，0xa0)
		}else if("160".equals(caCommandPara.getCommandtype())){
			return pushproductinfo(caCommandPara);
		//PVR在授权 (commandtype=188，0xbc)
		}else if("188".equals(caCommandPara.getCommandtype())){
			return pvrauthEmminfo(caCommandPara);
	    //产品限播 (commandtype=169，0xa9)
		}else if("169".equals(caCommandPara.getCommandtype())){
			return productplay(caCommandPara);
		//产品准播 (commandtype=170，0xaa)
		}else if("170".equals(caCommandPara.getCommandtype())){
			return productplay(caCommandPara);
		//功能控制(commandtype=190，0xbe)
		}else if("190".equals(caCommandPara.getCommandtype())){
			return pvrfunctionControl(caCommandPara);
		}else{
			return "";
		}
	}
	
	/**
	 * 电子邮件commandtype=185，0xb9;  
	 */
	public static String sendEmail(CaCommandParam caCommandPara){
        //高安电子邮件参数
		Caspnnewemail gaoAnEmail = caCommandPara.getCaspnnewemail();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		//到期日期
		String casexipredDate = formatDateToHexString(gaoAnEmail.getCasexpiredtime());//CAS到期后就不在发送;
		dataBuff.append(casexipredDate);
		//邮件ID
		String email_id =  StringUtils.leftPad(Long.toHexString(gaoAnEmail.getEmailid()), 8, "0");
		dataBuff.append(email_id);
		//邮件操作(1为添加，0为删除)
		String  emailcontrol = StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnEmail.getEmailoper())), 2, "0");// 1字节
		dataBuff.append(emailcontrol);
		//优先级
		String  priority = StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnEmail.getEmailpriority())), 2, "0");// 1字节
		dataBuff.append(priority);
		//到期日期
		String exipredDate = formatDateToHexString(gaoAnEmail.getExpiredtime());//到期日期;
		dataBuff.append(exipredDate);
		//编码方式
		String remark = gaoAnEmail.getRemark();
		//发送者名称
		String senderName = "";
		//邮件标题
		String titlecode = "";
		//邮件内容
		String email_content = null;
		//编码方式值
		String encode = "";
		if("BE".equals(remark)){
			encode = "02";
			senderName = Tools.toUniCodeBE(gaoAnEmail.getSendername());
			titlecode = Tools.toUniCodeBE(gaoAnEmail.getEmailtitle());
			email_content = Tools.toUniCodeBE(gaoAnEmail.getEmailcontent());
		}else if("LE".equals(remark)){
			encode = "01";
			senderName = Tools.toUniCodeLE(gaoAnEmail.getSendername());
			titlecode = Tools.toUniCodeLE(gaoAnEmail.getEmailtitle());
			email_content = Tools.toUniCodeLE(gaoAnEmail.getEmailcontent());
		}else if("GB".equals(remark)){
			encode = "00";
			senderName = Tools.toCodeGB2312(gaoAnEmail.getSendername());
			titlecode = Tools.toCodeGB2312(gaoAnEmail.getEmailtitle());
			email_content = Tools.toCodeGB2312(gaoAnEmail.getEmailcontent());
		}
		//多增加一个字节，用于装编码方式
		String senderName_len=StringUtils.leftPad(Long.toHexString(senderName.length()/2 + 1), 2, "0");// 1字节
		dataBuff.append(senderName_len).append(encode).append(senderName);
		//多增加一个字节，用于装编码方式
		String title_len=StringUtils.leftPad(Long.toHexString(titlecode.length()/2 + 1), 2, "0");// 1字节
		dataBuff.append(title_len).append(encode).append(titlecode);
		//多增加一个字节，用于装编码方式
		String email_len=StringUtils.leftPad(Long.toHexString(email_content.length()/2 + 1), 4, "0");// 2字节
		dataBuff.append(email_len).append(encode).append(email_content);
		return  dataBuff.toString(); 
	}
	
	/**
	 * 清除PIN 码 (commandtype=161，0xA1) 
	 */
	public static String cleanPincode(CaCommandParam caCommandPara){
		//到期日期
		String expiredtime = formatDateToHexString(caCommandPara.getExpired_Time());//CAS到期后就不在发送;
				
		StringBuffer dataBuff = new StringBuffer();
		dataBuff.append(expiredtime).toString();
		return dataBuff.toString();	
	} 
	
	/**
	 * 重置PIN码 (commandtype=162，0xA2)
	 */
	public static String restPincode(CaCommandParam caCommandPara){
	    //到期日期
		String expiredtime = formatDateToHexString(caCommandPara.getExpired_Time());//CAS到期后就不在发送;
		
		String pin_code = Tools.toCodeGB2312(caCommandPara.getPin_code());
		String pincode_len=StringUtils.leftPad(Integer.toHexString(pin_code.length() / 2), 2, "0");
		
		StringBuffer dataBuff = new StringBuffer();
		dataBuff.append(expiredtime).append(pincode_len).append(pin_code);
		
		return dataBuff.toString();	
	}
	
	/**
	 * 父母锁密码复位 (commandtype=174，0xAE) 
	 */
	public static String resetParentCode(CaCommandParam caCommandPara){
		//到期日期
		String expiredtime = formatDateToHexString(caCommandPara.getExpired_Time());//CAS到期后就不在发送;
		String parentPassword  = Tools.toCodeGB2312(caCommandPara.getParentPassword());
		String password_len=StringUtils.leftPad(Integer.toHexString(parentPassword.length() / 2), 2, "0");
		StringBuffer dataBuff = new StringBuffer(); 
		dataBuff.append(expiredtime).append(password_len).append(parentPassword);
		
		return dataBuff.toString();	
	}
	
	/**
	 * 终端状态控制 (commandtype=167，0xA7) 
	 */
	public static String terminalcontorl(CaCommandParam caCommandPara) {
		//CAS到期日期
		String expiredtime = cas_expiredTime();//CAS到期后就不在发送;
		//终端开启到期日期
		String open_expired_time = caCommandPara.getOpen_expired_time();
		if(StringUtils.isEmpty(open_expired_time)){
			open_expired_time = "2038-01-01 10:00:00";//默认为2038年
		}
		String open_expiredtime = formatDateToHexString(open_expired_time);
		
		//终端状态
        String status = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getTerminal_status())), 2, "0");
		//立即发送
        String instant_flag="01";
		StringBuffer dataBuff = new StringBuffer(); 
		dataBuff.append(expiredtime).append(instant_flag).append(status).append(open_expiredtime);
		return dataBuff.toString();	 
	}	
	
	/**
	 * 电子钱包充值 (commandtype=168，0xA8) 
	 */
	public static String ippCharge(CaCommandParam caCommandPara){
		
		//CAS到期日期
		String cas_exipredDate = cas_expiredTime();
	    //立即发送
	    String  instant_flag="01";
	    //账户类型预留
	    String  account_type="00";
	    //充值点数
	    String ipptpoint=StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getChargePoint())), 8, "0");// 4位字节
	    //充值时间
		String charge_time = formatDateToHexString(caCommandPara.getCharge_Time());
		//充值额能使用的最后时间,若为0xffffffff ，表示不限使用的时间
		String use_Expired_Time = "";
		if(StringUtils.isNotEmpty(caCommandPara.getUse_Expired_Time())){
			use_Expired_Time = formatDateToHexString(caCommandPara.getUse_Expired_Time());
		}else{
			//终端接收时间超过 当前时间+20年 会溢出
			 Calendar cal = Calendar.getInstance();//使用默认时区和语言环境获得一个日历。
			 cal.add(Calendar.MONTH, 240);//取当前日期的后20年.
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String cas_expired = format.format(cal.getTime());
			 use_Expired_Time = formatDateToHexString(cas_expired);
			//use_Expired_Time = "ffffffff";//--传ffffffff机顶盒显示会出问题
		}
		
		StringBuffer dataBuff = new StringBuffer(); 
		dataBuff.append(cas_exipredDate).append(instant_flag).append(account_type).append(ipptpoint).append(charge_time).append(use_Expired_Time);
		
		return dataBuff.toString();
	
	}
	
	/**
	 *  产品限播控制 (commandtype=169，0xA9) 
	 *  产品准播控制 (commandtype=170，0xAA)
	 */
	@SuppressWarnings("rawtypes")
	public static String productCastControl(CaCommandParam caCommandPara){
		     
		//CAS到期日期
		String cas_expiredtime = cas_expiredTime();
		//立即发送
		String  instant_flag="01";
		//产品控制列表
		List<HashMap> productControlList = caCommandPara.getProductControlList();
		//产品个数
	    String count = StringUtils.leftPad(Long.toHexString(productControlList.size()), 2, "0");// 4位字节
	    StringBuffer dataBuff = new StringBuffer();	
	    dataBuff.append(cas_expiredtime).append(instant_flag).append(count);
	     
	    for(int i=0; i<productControlList.size(); i++){
	    	HashMap productHm = productControlList.get(i);
	    	//限播产品号
	    	dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(productHm.get("product_number").toString())), 4, "0"));
	    	//开始限播产品时间
	    	Date start_Date = Tools.getDateFromStr(productHm.get("start_time").toString(), "yyyy-MM-dd HH:mm:ss");
			String start_time = StringUtils.leftPad(Long.toHexString(start_Date.getTime() / 1000), 8, "0");
	    	dataBuff.append(start_time);
	    	//结束限播产品时间
	    	Date expired_Date = Tools.getDateFromStr(productHm.get("expired_time").toString(), "yyyy-MM-dd HH:mm:ss");
			String expired_time = StringUtils.leftPad(Long.toHexString(expired_Date.getTime() / 1000), 8, "0");
	    	dataBuff.append(expired_time);
	    }

		return dataBuff.toString();	
	}
	
	
	/**
	 * 清除机顶盒信息 (commandtype=172，0xAC) 
	 */
	public static  String  cleanUserinfo(CaCommandParam caCommandPara){
		//CAS到期日期
		String cas_expiredtime = cas_expiredTime();
		//立即发送
		String  instant_flag="01";
		//表示全部清除标志
		String  clear_flag="00f0"; 
	    StringBuffer dataBuff = new StringBuffer();	
	    dataBuff.append(cas_expiredtime).append(instant_flag).append(clear_flag);
		return dataBuff.toString();
	}
	
	/**
	 * 区域绑定控制 (commandtype=175，0xAF)
	 * 运营商绑定控制 (commandtype=176，0xb0) 
	 * 网络绑定控制 (commandtype=177，0xb1)
	 */
	public static String lockControl (CaCommandParam caCommandPara){
	     
		//CAS到期日期
		String cas_expiredtime = cas_expiredTime();
	    //开始时间
		String starttime = "";
		if  ("0".equals(caCommandPara.getStartdate())) {//表示取消区域锁定
			starttime="00000000";//4个字节
	    } else {
	    	Date startDate = Tools.getDateFromStr(caCommandPara.getStartdate(), "yyyy-MM-dd HH:mm:ss");
	    	starttime = StringUtils.leftPad(Long.toHexString(startDate.getTime() / 1000), 8, "0");
	    };
	    
	    //结束时间
	  	String endtime = "";
	    if  ("0".equals(caCommandPara.getEnddate())) {//表示永久启用区域锁定
	    	endtime="00000000";//4个字节
	    }else{
	    	Date endDate = Tools.getDateFromStr(caCommandPara.getEnddate(), "yyyy-MM-dd HH:mm:ss");
	    	endtime = StringUtils.leftPad(Long.toHexString(endDate.getTime() / 1000), 8, "0");
	    }
	    StringBuffer dataBuff = new StringBuffer();	
	    dataBuff.append(cas_expiredtime).append(starttime).append(endtime);
		return dataBuff.toString();	
	}
	
	/**
	 * 旧产品授权 (commandtype=192，0xc0)
	 */
	public static String  oldEmm(CaCommandParam caCommandPara){ 
	    //保留字段
		String reserved="00";
		//产品个数
		String productAmount = "";
		// 是否快速发送方式
		String instant_flag = StringUtils.leftPad(Integer.toHexString(1), 2,"0");// 1位字节
		// 是否录像（不录像）
		String pvr_control = StringUtils.leftPad(Integer.toHexString(1), 2,"0");// 1位字节
		StringBuffer productBuff = new StringBuffer();
		//产品列表
		List<Userproduct> userproductlist = caCommandPara.getUserproductlist();
		if(userproductlist != null && userproductlist.size() > 0){
			productAmount = StringUtils.leftPad(Integer.toHexString(userproductlist.size()), 2, "0");
			for (Userproduct userproduct : userproductlist) {
				String productNumber = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(userproduct.getProductid())), 4, "0");	
				// 授权开始时间
				Date productstartdate = Tools.getDateFromStr(userproduct.getStarttime(), "yyyy-MM-dd HH:mm:ss");
				String productBeginTime = StringUtils.leftPad(Long
							.toHexString(productstartdate.getTime() /1000), 8, "0");
				// 授权结束时间
				Date productenddate = Tools.getDateFromStr(userproduct.getEndtime(), "yyyy-MM-dd HH:mm:ss");
				String productEndTime = StringUtils.leftPad(Long
							.toHexString(productenddate.getTime() / 1000), 8, "0");
				// 描述长度-1位字节
				String descLen = StringUtils.leftPad(Integer.toHexString(0), 2, "0");
				// 描述内容（目前为空，不需要组织）
				String descontent = "";
				productBuff.append(instant_flag).append(pvr_control).append(
						productNumber).append(productBeginTime).append(
						productEndTime).append(descLen).append(descontent);
			}
		}
		
	    // 数据体（不包含头文件格式）
	    StringBuffer dataBody = new StringBuffer();
	    dataBody.append(reserved).append(productAmount)
				.append(productBuff.toString());
	    return dataBody.toString();
    } 
	
	/**
	 * 套餐和节目授权 (commandtype=193，0xc1)
	 */
	public static String  productEmm(CaCommandParam caCommandPara){ 
	    //立即发送
		String instant_flag="01";
		//产品列表
		List<Userproduct> userproductlist = caCommandPara.getUserproductlist();
		//产品个数
		String productAmount = StringUtils.leftPad(Integer.toHexString(userproductlist.size()), 2, "0");
		
		StringBuffer productBuff = new StringBuffer();
		if(userproductlist != null && userproductlist.size() > 0){
			productAmount = StringUtils.leftPad(Integer.toHexString(userproductlist.size()), 2, "0");
			for (Userproduct userproduct : userproductlist) {
				//授权类型
				String  authorize_type = "";
				if("1".equals(userproduct.getType())){//套餐购买
					authorize_type = StringUtils.leftPad("0", 2, "0");
				}else if("2".equals(userproduct.getType())){//节目业务购买
					authorize_type = StringUtils.leftPad("1", 2, "0");
				}
				//产品包或者业务ID
				String package_or_service_id = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(userproduct.getProductid())), 4, "0");	
				// 授权开始时间
				Date productstartdate = Tools.getDateFromStr(userproduct.getStarttime(), "yyyy-MM-dd HH:mm:ss","GMT");
				String productBeginTime = StringUtils.leftPad(Long
							.toHexString(productstartdate.getTime() /1000), 8, "0");
				// 授权结束时间
				Date productenddate = Tools.getDateFromStr(userproduct.getEndtime(), "yyyy-MM-dd HH:mm:ss","GMT");
				
				String productEndTime = StringUtils.leftPad(Long
							.toHexString(productenddate.getTime() / 1000), 8, "0");
				productBuff.append(authorize_type).append(package_or_service_id).append(
						productBeginTime).append(productEndTime);
			}
		}
	    
	    // 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
		// 数据体
		dataBody.append(instant_flag).append(productAmount).append(productBuff);
		
		return dataBody.toString();
	} 
	
	
	/**
	 * 初始化机顶盒发卡命令 (commandtype=166，0xA6)
	 */
	 @SuppressWarnings("rawtypes")
	public static  String  initStb(CaCommandParam caCommandPara) {
		GaoAn_InitStb gaoAnInitStb = caCommandPara.getGaoAnInitStb();
		//CAS到期后就不在发送;
		String cas_expiredtime = cas_expiredTime();
		//立即发送
		String instant_flag="01";
		//运营商区域ID
		String areaid = StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getArea_id())), 4, "0");// 2字节
		//运营商网络ID
		String net_id = gaoAnInitStb.getNet_id();
		String netid = "";
		if(StringUtils.isNotEmpty(net_id)){
			netid = StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getNet_id())), 4, "0");// 2字节 
		}else{
			netid = "FFFF";
		}
		//运营商区域ID
		String bouquet_id = gaoAnInitStb.getBouquet_id();
		String bouquetid = "";
		if(StringUtils.isNotEmpty(bouquet_id)){
			bouquetid = StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getBouquet_id())), 4, "0");// 2字节 
		}else{
			bouquetid = "FFFF";
		}
		//节目预览时间
		String Previe_time=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getPreviewinterval())), 8, "0");// 4字节
		//运营商定期激活周期
		String operator_time=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getOperatorinterval())), 8, "0");// 4字节
		//用户VIP级别
		String vipClass=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getUser_vip_class())), 2, "0");// 1字节
		//成人级
		String avmate=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getMaturity_rating())), 2, "0");// 1字节
		//终端类型
		String termtype=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getTerminal_type())), 2, "0");// 1位字节
		
		//数据体
		StringBuffer dataBuff = new StringBuffer();
	    dataBuff.append(cas_expiredtime).append(instant_flag).append(areaid).append(netid).append(bouquetid).append(Previe_time).append(operator_time).append(vipClass).append(avmate).append(termtype);
	    
	    //主副机顶盒列表
		ArrayList stbList = gaoAnInitStb.getStbList();
	    String stb_count = StringUtils.leftPad(Long.toHexString(stbList.size()), 2, "0");// 1字节
	    dataBuff.append(stb_count);	
	    
	    for (int i=0;i<stbList.size(); i++){
			String stb_Id = (String)stbList.get(i);
	        stb_Id = StringUtils.leftPad(stb_Id, 8, "0");// 1位字节
	        dataBuff.append(stb_Id); 
	    }
	    
	    //本地激活标识
	    String localactivate=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getActiveflag())), 2, "0");// 1字节
	    //本地激活周期
	    String localActivat_time=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getActiveinterval())), 8, "0");// 4字节
	    //计费货币代码
	    String currencyCode=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getCurrencycode())), 4, "0");// 2字节
	    //货币转换因子分母部分
	    String condenominator=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getCondenominator())), 8, "0");// 4位字节
	    //货币转换因子分子部分
	    String condenonumerator=StringUtils.leftPad(Long.toHexString(Long.parseLong(gaoAnInitStb.getConversion_numerator())), 8, "0");// 4位字节
	    //编码方式值,默认为GB2312
		String encode = "00";
	    //运营商信息
	    String operinfo = Tools.toCodeGB2312(Tools.getStr(gaoAnInitStb.getOperatorinfo()));
	    //运营商信息长度
	    String oper_len=StringUtils.leftPad(Long.toHexString(operinfo.length()/2 + 1), 2, "0");
		
		dataBuff.append(localactivate).append(localActivat_time)
		   .append(currencyCode).append(condenominator).append(condenonumerator)
		   .append(oper_len).append(encode).append(operinfo.toString());
			
		return dataBuff.toString();
	}
	
	/**
	 *  OSD指令 (commandtype=178，0xb2)
	 */
	public static String sendOSD(CaCommandParam caCommandPara){
		
		Caspnforcedosd params = caCommandPara.getCaspnforcedosd();
	    //CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		//osdID
		String osd_id =  StringUtils.leftPad(Long.toHexString(params.getOsdid()), 8, "0");
		
		//OSD控制模式+保留字节
		String osdcontrol = params.getIscontrol();//1 - 启动OSD显示；0 – 取消OSD显示
		//String osdcontrol_reserved = osdcontrol + "0000000";
		String osdcontrol_value =  StringUtils.leftPad(osdcontrol, 2, "0");
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		dataBuff.append(cas_exptime).append(osd_id).append(osdcontrol_value);
	
		if("1".equals(osdcontrol)){//1 - 启动OSD显示
			//osd的ID号
			//dataBuff.append(StringUtils.leftPad(Long.toHexString(params.getId()), 8, "0"));
			//开始时间
			String start_time = formatDateToHexString(params.getStarttime()); 
			dataBuff.append(start_time);
			//结束时间
			String end_time = formatDateToHexString(params.getEndtime());
			dataBuff.append(end_time);
			//显示风格（000 - 滚动显示；001 – 弹窗显示；其他 – 预留将来使用）
			String display_style  = params.getDisplay_style();
			//锁屏控制 (0 - 不锁定；1 - 锁定面板和遥控器操作)
			String lockscreen = params.getLockscreen();
			String display_style_lockscreen = StringUtils.leftPad(Tools.binaryString2hexString(display_style+lockscreen),1,"0");
			dataBuff.append(display_style_lockscreen);
			//优先级（低级 - 0 、中级 - 1、高级 - 2 ）	
			String priority = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getPriority())),1,"0");
			dataBuff.append(priority);
			//font
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getFont())), 4, "0"));
			//fontsize
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getFontsize())), 2, "0"));
			//foreground_color 前景色RGA
			dataBuff.append(StringUtils.leftPad(params.getForegroundcolor(), 6, "0"));
			//foregroundtransparency 前景透明度
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getForegroundtransparency())), 2, "0"));
			//background_color 背景色RGA
			dataBuff.append(StringUtils.leftPad(params.getBackgroundcolor(), 6, "0"));
			//backgroundtransparency  背景透明度
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getBackgroundtransparency())), 2, "0"));
			//display_period
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDisplayperiod())), 8, "0"));
			//display_frequency
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDisplayfrequency())), 2, "0"));
			//display_duration_time
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDisplaydurationtime())), 4, "0"));
			//display_style==000 滚动显示
			if("000".equals(display_style)){ 
				//scroll_direction（滚动方向(0–在屏幕底部，自左至右；1 –在屏幕底部，自右至左；2–在屏幕中部，自左至右；3–在屏幕中部，自右至左；4 –在屏幕顶部，自左至右；5 –在屏幕顶部，自右至左；)）
				String scrolldirection = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getScrolldirection())), 2, "0");
				dataBuff.append(scrolldirection);
				//position_X
				//dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getPositionx())), 4, "0"));
				//position_Y
				//dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getPositiony())), 4, "0"));
				//bar_height
				dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getBarheight())), 2, "0"));				
			} else if ("001".equals(display_style)){
				dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getScreencoveragepercentage())), 2, "0"));
				String reserved_6 = "FF";
				dataBuff.append(reserved_6);
			}
			//content_para()
			String cardiddisplayflag = params.getCardiddisplayflag();
			String areaiddisplayflag = params.getAreaiddisplayflag();
			//String terminaliddisplayflag = params.getTerminaliddisplayflag();
			String operatoriddisplayflag = params.getOperatoriddisplayflag();
			String privatecontentflag = params.getPrivatecontentflag();
			String flag = StringUtils.leftPad(Tools.binaryString2hexString(cardiddisplayflag + areaiddisplayflag + operatoriddisplayflag + privatecontentflag), 1, "0");
			String reserved = "F";
			dataBuff.append(flag).append(reserved);
		    
			//节目数
		    Integer service_cnt = 0;
			//serverid 节目号
			String serverids = params.getServiceid();
			StringBuffer serveridBuf = new StringBuffer();
			if(StringUtils.isNotEmpty(serverids)){
				String[] serveridArr = serverids.split(",");
				service_cnt = serveridArr.length;
				for (String serverid : serveridArr) {
					serveridBuf.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(serverid)), 4, "0"));
				}
			}
			
			//先拼接节目数目，在拼接节目ID
			dataBuff.append(StringUtils.leftPad(Long.toHexString(service_cnt), 4, "0")).append(serveridBuf);
			
			if ("1".equals(privatecontentflag)){
				//编码方式
				String remark = params.getRemark();
				//信息内容
				String content = null;
				//编码方式值
				String encode = "";
				if("BE".equals(remark)){
					encode = "02";
					content = Tools.toUniCodeBE(params.getContent());
				}else if("LE".equals(remark)){
					encode = "01";
					content = Tools.toUniCodeLE(params.getContent());
				}else if("GB".equals(remark)){
					encode = "00";
					content = Tools.toCodeGB2312(params.getContent());
				}
				//多增加一个字节，用于装编码方式
				String content_len=StringUtils.leftPad(Long.toHexString(content.length()/2 + 1), 4, "0");// 2字节
				dataBuff.append(content_len).append(encode).append(content);
			}
		}		
	    return  dataBuff.toString(); 
	}
	
	/**
	 * 新版指纹 (commandtype=179，0xb3)
	 * @param Params
	 * @throws ParseException
	 */
	public static String newfinger(CaCommandParam caCommandPara){
		Caspnnewfinger params = caCommandPara.getCaspnnewfinger();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		//CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		dataBuff.append(cas_exptime);	
		
		//fingerID
		String finger_id =  StringUtils.leftPad(Long.toHexString(params.getFingerid()), 8, "0");
		dataBuff.append(finger_id);
		
		//指纹控制模式+保留字节
		String fingercontrol = params.getIscontrol();//1 - 启动OSD显示；0 – 取消OSD显示
		//String osdcontrol_reserved = osdcontrol + "0000000";
		String osdcontrol_value =  StringUtils.leftPad(fingercontrol, 2, "0");
		dataBuff.append(osdcontrol_value);
		
		if("1".equals(fingercontrol)){//1 - 启动指纹显示
			//锁屏控制 (0 - 不锁定；1 - 锁定面板和遥控器操作)
			String lockscreen = params.getLockscreen();
			//是否加密(0-不加密；1-加密）
			String encryptflag = params.getEncryptflag();
			//是否显示卡号（0-不显示；1-显示）
			String cardiddisplayflag = params.getCardiddisplayflag();
			//是否显示终端号（0-不显示；1-显示）
			String areaiddisplayflag = params.getAreaiddisplayflag();
			//是否显示运营商号（0-不显示；1-显示）
			String operatoriddisplayflag = params.getOperatoriddisplayflag();
			//是否显示私有内容（0-不显示；1-显示）
			String privatecontentflag = params.getPrivatecontentflag();
			//指纹显示方式(0-指定位置显示；1-随机显示）
			String ramdompositionflag = params.getRamdompositionflag();
			//是否隐藏（0-不隐藏；1-隐藏）
			String hideflag = params.getHideflag();
			//合并各种参数
			String flag = lockscreen + encryptflag + cardiddisplayflag + areaiddisplayflag
					    + operatoriddisplayflag + privatecontentflag + ramdompositionflag + hideflag;
			String flag_value = StringUtils.leftPad(Tools.binaryString2hexString(flag),2,"0");//1个字节
			dataBuff.append(flag_value);
			//字体类型fonttype
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getFonttype())), 4, "0"));
			//字号fontsize
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getFontsize())), 2, "0"));
			//foreground_color 前景色RGA
			dataBuff.append(StringUtils.leftPad(params.getForegroundcolor(), 6, "0"));
			//foregroundtransparency 前景透明度
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getForegroundtransparency())), 2, "0"));
			//background_color 背景色RGA
			dataBuff.append(StringUtils.leftPad(params.getBackgroundcolor(), 6, "0"));
			//backgroundtransparency  背景透明度
			dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getBackgroundtransparency())), 2, "0"));
			//开始时间
			String start_time = formatDateToHexString(params.getStarttime()); 
			dataBuff.append(start_time);
			//持续时间(以毫秒计)
			String duration = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDuration())), 8, "0");
			dataBuff.append(duration);
			//显示频率
			String displayfrequency = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDisplayfrequency())), 2, "0");
			dataBuff.append(displayfrequency);
			//单次显示持续时间
			String displaydurationtime = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDisplaydurationtime())), 4, "0");
			dataBuff.append(displaydurationtime);
			//显示的布局(0-水平;1-垂直)
			String layout = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getLayout())), 2, "0");
			dataBuff.append(layout);
			//保留字段
			dataBuff.append("FF");
			//指纹显示方式不随机
			if("0".equals(ramdompositionflag)){
				//位置横坐标position_X
				dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getPosx())), 4, "0"));
				//位置纵坐标position_Y
				dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getPosy())), 4, "0"));
				//高度height
				dataBuff.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getFingerheight())), 2, "0"));			
			}
			
			if("1".equals(params.getPrivatecontentflag())){
				
				//编码方式
				String remark = params.getRemark();
				//信息内容
				String content = null;
				//编码方式值
				String encode = "";
				if("BE".equals(remark)){
					encode = "02";
					content = Tools.toUniCodeBE(params.getContent());
				}else if("LE".equals(remark)){
					encode = "01";
					content = Tools.toUniCodeLE(params.getContent());
				}else if("GB".equals(remark)){
					encode = "00";
					content = Tools.toCodeGB2312(params.getContent());
				}
				//多增加一个字节，用于装编码方式
				String content_len=StringUtils.leftPad(Long.toHexString(content.length()/2 + 1), 2, "0");// 2字节
				dataBuff.append(content_len).append(encode).append(content);
			}
		}
	   
	    return  dataBuff.toString(); 
	}
	
	
	/**
	 * 机顶盒激活命令 (commandtype=165，0xA5)
	 */
	public static  String  activateStb(CaCommandParam caCommandPara) {
		//CAS到期后就不在发送;
		String cas_expiredtime = cas_expiredTime();
		//立即发送
		String  instant_flag="01";
		
		//数据体
		StringBuffer dataBuff = new StringBuffer();
	    dataBuff.append(cas_expiredtime).append(instant_flag);
	   
		return dataBuff.toString();
	}
	
	/**
	 * 强制换台 (commandtype=180，0xb4)
	 * @param Params
	 * @throws ParseException
	 */
	public static String forcedcc(CaCommandParam caCommandPara){
		Caspnforcedcc params = caCommandPara.getCaspnforcedcc();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		//CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		dataBuff.append(cas_exptime);	
		
		//网络匹配标识(0-不匹配；1-匹配）
		String network_match = params.getNetwork_match();
		//运营商匹配标识(0-不匹配；1-匹配）
		String operator_match = params.getOperator_match();
		//区域匹配标识(0-不匹配；1-匹配）
		String area_match = params.getArea_match();
		//设备类型匹配标识(0-不匹配；1-匹配）
		String device_type_match = params.getDevice_type_match();
		//终端类型匹配标识(0-不匹配；1-匹配）
		String terminal_type_match = params.getTerminal_type_match();
		//VIP级别匹配标识(0-不匹配；1-匹配）
		String vip_class_match = params.getVip_class_match();
		//保留字段
		String reserved1 = "00";
		//各种匹配字段凑齐一个字节（2位）
		String match = network_match + operator_match + area_match + device_type_match 
				     + terminal_type_match + vip_class_match + reserved1;
		
		String match_value = StringUtils.leftPad(Tools.binaryString2hexString(match),2,"0");//1个字节
		dataBuff.append(match_value);
		
		//1 - 启动强制换台；0 – 取消强制换台
		String iscontrol = params.getIscontrol();//1 - 启动强制换台；0 – 取消强制换台
		String iscontrol_reserved = iscontrol + "0000000";
		dataBuff.append(StringUtils.leftPad(Tools.binaryString2hexString(iscontrol_reserved), 2, "0"));
		
		//匹配网络ID
		if("1".equals(network_match)){
			String network_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getNetwork_id())), 4, "0");
			dataBuff.append(network_id);
		}
		
		//匹配运营商ID
		if("1".equals(operator_match)){
			String operator_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getOperator_id())), 4, "0");
			dataBuff.append(operator_id);
		}
		
		//匹配区域ID
		if("1".equals(area_match)){
			String area_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getArea_id())), 4, "0");
			dataBuff.append(area_id);
		}
		
		//匹配设备类型(0–固定终端；1–手持终端)
		if("1".equals(device_type_match)){
			String device_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDevice_type())), 2, "0");
			dataBuff.append(device_type);
		}
		
		//匹配终端类型(0 - 主机；1 - 子机)
		if("1".equals(terminal_type_match)){
			String terminal_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTerminal_type())), 2, "0");
			dataBuff.append(terminal_type);
		}
		
		//匹配VIP等级
		if("1".equals(vip_class_match)){
			String vip_class =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getVip_class())), 2, "0");
			dataBuff.append(vip_class);
		}
		
		//开始时间
		String start_time = formatDateToHexString(params.getStarttime()); 
		dataBuff.append(start_time);
		//结束时间
		String end_time = formatDateToHexString(params.getEndtime());
		dataBuff.append(end_time);
		
		//TS流ID
		String tsid =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTsid())), 4, "0");
		dataBuff.append(tsid);
		
		//业务ID
		String serviceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getServiceid())), 4, "0");
		dataBuff.append(serviceid);
		
		//是否锁屏
		String lockscreen = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getLockscreen())), 2, "0");
		dataBuff.append(lockscreen);
		
	    return  dataBuff.toString(); 
	}
	
	/**
	 * 强制重启(commandtype=181，0xb5)
	 * @param Params
	 * @throws ParseException
	 */
	public static String forcedrestart(CaCommandParam caCommandPara){
		//取出对象
		Forcedrestart params = caCommandPara.getForcedrestart();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		//CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		dataBuff.append(cas_exptime);	
		
		//网络匹配标识(0-不匹配；1-匹配）
		String network_match = params.getNetwork_match();
		//运营商匹配标识(0-不匹配；1-匹配）
		String operator_match = params.getOperator_match();
		//区域匹配标识(0-不匹配；1-匹配）
		String area_match = params.getArea_match();
		//设备类型匹配标识(0-不匹配；1-匹配）
		String device_type_match = params.getDevice_type_match();
		//终端类型匹配标识(0-不匹配；1-匹配）
		String terminal_type_match = params.getTerminal_type_match();
		//VIP级别匹配标识(0-不匹配；1-匹配）
		String vip_class_match = params.getVip_class_match();
		//保留字段
		String reserved1 = "00";
		//各种匹配字段凑齐一个字节（2位）
		String match = network_match + operator_match + area_match + device_type_match 
				     + terminal_type_match + vip_class_match + reserved1;
		
		String match_value = StringUtils.leftPad(Tools.binaryString2hexString(match),2,"0");//1个字节
		dataBuff.append(match_value);
		
		//1 - 启动强制换台；0 – 取消强制换台
		String iscontrol = params.getIscontrol();//1 - 启动；0 – 取消
		String iscontrol_reserved = iscontrol + "0000000";
		dataBuff.append(StringUtils.leftPad(Tools.binaryString2hexString(iscontrol_reserved), 2, "0"));
		
		//匹配网络ID
		if("1".equals(network_match)){
			String network_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getNetwork_id())), 4, "0");
			dataBuff.append(network_id);
		}
		
		//匹配运营商ID
		if("1".equals(operator_match)){
			String operator_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getOperator_id())), 4, "0");
			dataBuff.append(operator_id);
		}
		
		//匹配区域ID
		if("1".equals(area_match)){
			String area_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getArea_id())), 4, "0");
			dataBuff.append(area_id);
		}
		
		//匹配设备类型(0–固定终端；1–手持终端)
		if("1".equals(device_type_match)){
			String device_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDevice_type())), 2, "0");
			dataBuff.append(device_type);
		}
		
		//匹配终端类型(0 - 主机；1 - 子机)
		if("1".equals(terminal_type_match)){
			String terminal_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTerminal_type())), 2, "0");
			dataBuff.append(terminal_type);
		}
		
		//匹配VIP等级
		if("1".equals(vip_class_match)){
			String vip_class =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getVip_class())), 2, "0");
			dataBuff.append(vip_class);
		}
		
		//开始时间
		String start_time = formatDateToHexString(params.getStarttime()); 
		dataBuff.append(start_time);
		//结束时间
		String end_time = formatDateToHexString(params.getEndtime());
		dataBuff.append(end_time);
		
		//重启标志。1表示重启机顶盒，0表示机顶盒待机。
		String restartflag = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getRestartflag())), 2, "0");
		dataBuff.append(restartflag);
		
	    return  dataBuff.toString(); 
	}
	
	/**
	 * 重新搜索节目(commandtype=182，0xb6)
	 * @param Params
	 * @throws ParseException
	 */
	public static String researchprogram(CaCommandParam caCommandPara){
		//取出对象
		Researchprogram params = caCommandPara.getResearchprogram();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		//CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		dataBuff.append(cas_exptime);	
		
		//网络匹配标识(0-不匹配；1-匹配）
		String network_match = params.getNetwork_match();
		//运营商匹配标识(0-不匹配；1-匹配）
		String operator_match = params.getOperator_match();
		//区域匹配标识(0-不匹配；1-匹配）
		String area_match = params.getArea_match();
		//设备类型匹配标识(0-不匹配；1-匹配）
		String device_type_match = params.getDevice_type_match();
		//终端类型匹配标识(0-不匹配；1-匹配）
		String terminal_type_match = params.getTerminal_type_match();
		//VIP级别匹配标识(0-不匹配；1-匹配）
		String vip_class_match = params.getVip_class_match();
		//保留字段
		String reserved1 = "00";
		//各种匹配字段凑齐一个字节（2位）
		String match = network_match + operator_match + area_match + device_type_match 
				     + terminal_type_match + vip_class_match + reserved1;
		
		String match_value = StringUtils.leftPad(Tools.binaryString2hexString(match),2,"0");//1个字节
		dataBuff.append(match_value);
		
		//1 - 启动强制换台；0 – 取消强制换台
		String iscontrol = params.getIscontrol();//1 - 启动；0 – 取消
		String iscontrol_reserved = iscontrol + "0000000";
		dataBuff.append(StringUtils.leftPad(Tools.binaryString2hexString(iscontrol_reserved), 2, "0"));
		
		//匹配网络ID
		if("1".equals(network_match)){
			String network_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getNetwork_id())), 4, "0");
			dataBuff.append(network_id);
		}
		
		//匹配运营商ID
		if("1".equals(operator_match)){
			String operator_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getOperator_id())), 4, "0");
			dataBuff.append(operator_id);
		}
		
		//匹配区域ID
		if("1".equals(area_match)){
			String area_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getArea_id())), 4, "0");
			dataBuff.append(area_id);
		}
		
		//匹配设备类型(0–固定终端；1–手持终端)
		if("1".equals(device_type_match)){
			String device_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDevice_type())), 2, "0");
			dataBuff.append(device_type);
		}
		
		//匹配终端类型(0 - 主机；1 - 子机)
		if("1".equals(terminal_type_match)){
			String terminal_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTerminal_type())), 2, "0");
			dataBuff.append(terminal_type);
		}
		
		//匹配VIP等级
		if("1".equals(vip_class_match)){
			String vip_class =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getVip_class())), 2, "0");
			dataBuff.append(vip_class);
		}
		
		//开始时间
		String start_time = formatDateToHexString(params.getStarttime()); 
		dataBuff.append(start_time);
		//结束时间
		String end_time = formatDateToHexString(params.getEndtime());
		dataBuff.append(end_time);
		
	    return  dataBuff.toString(); 
	}
	
	
	/**
	 * 机顶盒默认开机节目(commandtype=183，0xb7)
	 * @param Params
	 * @throws ParseException
	 */
	public static String stbdefaultmsg(CaCommandParam caCommandPara){
		//取出机顶盒默认开机对象
		Stbdefaultmsg params = caCommandPara.getStbdefaultmsg();
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		
		//CAS过期时间
		String cas_exptime = formatDateToHexString(params.getExpiredtime());
		dataBuff.append(cas_exptime);	
		
		//网络匹配标识(0-不匹配；1-匹配）
		String network_match = params.getNetwork_match();
		//运营商匹配标识(0-不匹配；1-匹配）
		String operator_match = params.getOperator_match();
		//区域匹配标识(0-不匹配；1-匹配）
		String area_match = params.getArea_match();
		//设备类型匹配标识(0-不匹配；1-匹配）
		String device_type_match = params.getDevice_type_match();
		//终端类型匹配标识(0-不匹配；1-匹配）
		String terminal_type_match = params.getTerminal_type_match();
		//VIP级别匹配标识(0-不匹配；1-匹配）
		String vip_class_match = params.getVip_class_match();
		//保留字段
		String reserved1 = "00";
		//各种匹配字段凑齐一个字节（2位）
		String match = network_match + operator_match + area_match + device_type_match 
				     + terminal_type_match + vip_class_match + reserved1;
		
		String match_value = StringUtils.leftPad(Tools.binaryString2hexString(match),2,"0");//1个字节
		dataBuff.append(match_value);
		
		//1 - 启动强制换台；0 – 取消强制换台
		String iscontrol = params.getIscontrol();//1 - 启动；0 – 取消
		String iscontrol_reserved = iscontrol + "0000000";
		dataBuff.append(StringUtils.leftPad(Tools.binaryString2hexString(iscontrol_reserved), 2, "0"));
		
		//匹配网络ID
		if("1".equals(network_match)){
			String network_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getNetwork_id())), 4, "0");
			dataBuff.append(network_id);
		}
		
		//匹配运营商ID
		if("1".equals(operator_match)){
			String operator_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getOperator_id())), 4, "0");
			dataBuff.append(operator_id);
		}
		
		//匹配区域ID
		if("1".equals(area_match)){
			String area_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getArea_id())), 4, "0");
			dataBuff.append(area_id);
		}
		
		//匹配设备类型(0–固定终端；1–手持终端)
		if("1".equals(device_type_match)){
			String device_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getDevice_type())), 2, "0");
			dataBuff.append(device_type);
		}
		
		//匹配终端类型(0 - 主机；1 - 子机)
		if("1".equals(terminal_type_match)){
			String terminal_type =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTerminal_type())), 2, "0");
			dataBuff.append(terminal_type);
		}
		
		//匹配VIP等级
		if("1".equals(vip_class_match)){
			String vip_class =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getVip_class())), 2, "0");
			dataBuff.append(vip_class);
		}
		
		//开始时间
		String start_time = formatDateToHexString(params.getStarttime()); 
		dataBuff.append(start_time);
		//结束时间
		String end_time = formatDateToHexString(params.getEndtime());
		dataBuff.append(end_time);
		
		//TS流ID
		String tsid =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getTsid())), 4, "0");
		dataBuff.append(tsid);
		
		//业务ID
		String serviceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getServiceid())), 4, "0");
		dataBuff.append(serviceid);
		
	    return  dataBuff.toString(); 
	}
	
	
	/**
	 * 套餐信息同步 (commandtype=160，0xa0)
	 */
	public static String  pushproductinfo(CaCommandParam caCommandPara){ 
	    //开始或结束标志位
		String start_flag = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(caCommandPara.getStart_flag())), 2, "0");
		//产品
		Product product = caCommandPara.getProduct();
		//套餐包号
		String productid = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(product.getProductid())), 2, "0");
		//套餐包总数
		String total_package_count = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(caCommandPara.getTotal_package_count())), 2, "0");
		
		// 数据体（不包含头文件格式）
		StringBuffer dataBody = new StringBuffer();
		
		List<Productserviceref> reflist = product.getReflist();
		//该套餐包中的节目数
		String service_count = StringUtils.leftPad(Integer.toHexString(reflist.size()), 4, "0");
		
		StringBuffer serverids = new StringBuffer();
		for (Productserviceref productserviceref : reflist) {
			//节目号
			String service_id = StringUtils.leftPad(Integer.toHexString(Integer.parseInt(productserviceref.getServiceid())), 4, "0");
			serverids.append(service_id);
		}
				
				
		dataBody.append(start_flag).append(productid).append(
				total_package_count).append(service_count).append(serverids);
			
		return dataBody.toString();
	} 
	
	/**
	 * pvr在授权 (commandtype=188，0xbc)
	 */
	public static String pvrauthEmminfo(CaCommandParam caCommandPara){
		//PVR在授权
		PvrAuthEmm params = caCommandPara.getPvrAuthEmm();
		//到期日期
		String expiredtime = formatDateToHexString(caCommandPara.getExpired_Time());//CAS到期后就不在发送;
		//机顶盒号
		String stbno = StringUtils.leftPad(params.getTeminalid(), 8, "0"); 
		//pvr号
		String pvr_id = StringUtils.leftPad(params.getPvrid(), 8, "0");
		//录制节目的service id
		String serviceid = StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getServiceid())), 4, "0");
		//运营商id
		String operator_id =  StringUtils.leftPad(Long.toHexString(Long.parseLong(params.getOpratorid())), 4, "0");
		//授权可以观看开始时间
		String start_time = formatDateToHexString(params.getStarttime()); 
		//授权可以观看结束时间
		String end_time = formatDateToHexString(params.getEndtime());
		//数据体
		StringBuffer dataBuff = new StringBuffer();
		dataBuff.append(expiredtime).append(stbno).append(pvr_id).append(serviceid).append(operator_id).append(start_time).append(end_time);
		
		return dataBuff.toString();	
	}
	
	/**
	 * 产品限播(commandtype=169，0xa9)或产品准播(commandtype=170，0xaa)
	 */
	public static String productplay(CaCommandParam caCommandPara){
		//PVR在授权
		Caspnproductplay params = caCommandPara.getCaspnproductplay();
		//到期日期
		String expiredtime = formatDateToHexString(params.getExpiredtime());//CAS到期后就不在发送;
		
		//授权产品个数
		String productinfos = Tools.getStr(params.getProductinfo());
		String[] productinfosArr = productinfos.split(";");
		 //命令体
	    StringBuffer dataBody = new StringBuffer();	
	    dataBody.append(expiredtime).append("01");
		
		if(productinfosArr !=null && productinfosArr.length > 0){
			String productAmount  = StringUtils.leftPad(Long.toHexString(productinfosArr.length), 4, "0");// 1个字节
			//拼产品数量
			dataBody.append(productAmount);
			for (String productinfo : productinfosArr) {
				String[] productinfoArr = productinfo.split(",");
				if(productinfoArr != null && productinfoArr.length > 0){
					//拼每个产品的信息
			    	//产品号
			    	dataBody.append(StringUtils.leftPad(Long.toHexString(Long.parseLong(productinfoArr[0])), 4, "0"));
			    	//授权开始时间
			    	String starttime = formatDateToHexString(String.valueOf(productinfoArr[1]));
					dataBody.append(starttime);
			    	//结束时间
					String endtime = formatDateToHexString(String.valueOf(productinfoArr[2]));
					dataBody.append(endtime);
					
				}
			}
		}
	    return dataBody.toString();
	}
	
	/**
	 * 功能控制(commandtype=190，0xbe)
	 */
	private static String pvrfunctionControl(CaCommandParam caCommandPara) {
		// 到期日期
		String expiredtime = formatDateToHexString(caCommandPara.getExpired_Time());//CAS到期后就不在发送;
		//状态
        String status = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getPvrStatus())), 2, "0");
		//PVR付费方式
        String pvr_pay = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getPvr_pay())), 2, "0");
        //PVR计费价格
        String pvr_price = StringUtils.leftPad(Long.toHexString(Long.parseLong(caCommandPara.getPvr_price())), 4, "0");
        //PVR可以免费观看时间
        String pvr_free_watch_time = formatDateToHexString(caCommandPara.getPvr_free_watch_time());
        //PVR可以保留时间
        String pvr_save_time = formatDateToHexString(caCommandPara.getPvr_save_time());
        //命令开始时间
        String startTime = formatDateToHexString(caCommandPara.getStartdate());
        //命令结束时间
        String endTime = formatDateToHexString(caCommandPara.getEnddate());
        //命令体
	    StringBuffer dataBody = new StringBuffer();	
	    dataBody.append(expiredtime).append(status).append(pvr_pay).append(pvr_price).append(pvr_free_watch_time)
	    .append(pvr_save_time).append(startTime).append(endTime);
		return dataBody.toString();
	}
}
