package com.gospell.boss.cas;

import java.io.Serializable;
import java.util.Map;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Productplay extends BaseField implements Serializable {
	
	//普安条件准播和条件限播
	private Integer playid;         //播放ID
	private Integer netid;        //网络ID
	private String cardid;        //智能卡号
	private String productid;     //产品ID
	private String expiredTime ;  //过期时间
	private String expired_Time;  //CAS过期时间 
	
	//高安指令需要字段
	private String addtime;   //添加时间
	private String starttime; // 开始时间
	private String endtime;  //结束时间
	private String iscontrol; // 1：启动，0：取消
	private String versiontype;//cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent;//条件内容
	
	private String productinfo;   //productid-starttime-endtime;
	
	private Map<Integer, String> networkmap;
	public Integer getPlayid() {
		return playid;
	}
	public void setPlayid(Integer playid) {
		this.playid = playid;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getExpiredTime() {
		return expiredTime;
	}
	public void setExpiredTime(String expiredTime) {
		this.expiredTime = expiredTime;
	}
	public String getExpired_Time() {
		return expired_Time;
	}
	public void setExpired_Time(String expired_Time) {
		this.expired_Time = expired_Time;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getIscontrol() {
		return iscontrol;
	}
	public void setIscontrol(String iscontrol) {
		this.iscontrol = iscontrol;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}
	public String getAddressingmode() {
		return addressingmode;
	}
	public void setAddressingmode(String addressingmode) {
		this.addressingmode = addressingmode;
	}
	public String getConditioncount() {
		return conditioncount;
	}
	public void setConditioncount(String conditioncount) {
		this.conditioncount = conditioncount;
	}
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
	public String getProductinfo() {
		return productinfo;
	}
	public void setProductinfo(String productinfo) {
		this.productinfo = productinfo;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	

}
