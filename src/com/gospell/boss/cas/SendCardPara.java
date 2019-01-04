package com.gospell.boss.cas;

import java.util.Date;

/**
 * 运营商发卡
 */
public class SendCardPara {
	private String cardid;                 //智能卡号
 	private String MotherCard_ID ;         //母卡号
    private int StandardFlag;              //子母卡配对判断
	private String IntervalTime;           //间隔时间
	private String DecryptCWTimes;        //解密CW 的次数
	private String Vip_Class;             //订户等级
	private String Run_Area;               //运行区域
	private String User_Area;              //用户区域
	private String Name;                   //运营商名称
	private String Other;                  //运营商其他信息
	private Date  Expired_Time;            //过期时间
	
	public String getMotherCard_ID() {
		return MotherCard_ID;
	}
	public void setMotherCard_ID(String motherCard_ID) {
		MotherCard_ID = motherCard_ID;
	}

	public int getStandardFlag() {
		return StandardFlag;
	}
	public void setStandardFlag(int standardFlag) {
		StandardFlag = standardFlag;
	}


	public String getVip_Class() {
		return Vip_Class;
	}
	public void setVip_Class(String vip_Class) {
		Vip_Class = vip_Class;
	}
	public String getIntervalTime() {
		return IntervalTime;
	}
	public void setIntervalTime(String intervalTime) {
		IntervalTime = intervalTime;
	}
	public String getRun_Area() {
		return Run_Area;
	}
	public void setRun_Area(String run_Area) {
		Run_Area = run_Area;
	}

	
	
	public String getUser_Area() {
		return User_Area;
	}
	public void setUser_Area(String user_Area) {
		User_Area = user_Area;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getOther() {
		return Other;
	}
	public void setOther(String other) {
		Other = other;
	}
	public Date getExpired_Time() {
		return Expired_Time;
	}
	public void setExpired_Time(Date expired_Time) {
		Expired_Time = expired_Time;
	}
	public String getDecryptCWTimes() {
		return DecryptCWTimes;
	}
	public void setDecryptCWTimes(String decryptCWTimes) {
		DecryptCWTimes = decryptCWTimes;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

}
