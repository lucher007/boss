package com.gospell.boss.cas;

import java.io.Serializable;
import java.util.Map;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class PvrAuthEmm extends BaseField implements Serializable {
	
	private   Integer netid;       //网络ID
	private   String stbno;        //机顶盒号
	private   String timeInFileID ;///PVR的创建时间
	private   String serviceID ;   //节目号
	private   String entitle_Days ;//授权天数
	private   String expiredTime ;// 过期时间
	private   String expired_Time;//CAS过期时间
	private   String reserved1 ;//保留1
	private   String reserved2 ;//保留2
	
	//高安指令需要字段
	private String addtime;   //添加时间
	private String starttime; // 开始时间
	private String endtime;  //结束时间
	private String iscontrol; // 1：启动，0：取消
	private String versiontype;//cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent;// 条件内容
	
	private String teminalid;   //终端号
	private String pvrid;   //节目编号
	private String serviceid; //录制节目的service id
	private String opratorid; //运营商id
	
	private Map<Integer, String> networkmap;

	
	
	public String getTimeInFileID() {
		return timeInFileID;
	}
	public void setTimeInFileID(String timeInFileID) {
		this.timeInFileID = timeInFileID;
	}
	public String getServiceID() {
		return serviceID;
	}
	public void setServiceID(String serviceID) {
		this.serviceID = serviceID;
	}
	public String getEntitle_Days() {
		return entitle_Days;
	}
	public void setEntitle_Days(String entitle_Days) {
		this.entitle_Days = entitle_Days;
	}
	public String getExpiredTime() {
		return expiredTime;
	}
	public void setExpiredTime(String expiredTime) {
		this.expiredTime = expiredTime;
	}
	public String getReserved1() {
		return reserved1;
	}
	public void setReserved1(String reserved1) {
		this.reserved1 = reserved1;
	}
	public String getReserved2() {
		return reserved2;
	}
	public void setReserved2(String reserved2) {
		this.reserved2 = reserved2;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
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
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getExpired_Time() {
		return expired_Time;
	}
	public void setExpired_Time(String expired_Time) {
		this.expired_Time = expired_Time;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public String getTeminalid() {
		return teminalid;
	}
	public void setTeminalid(String teminalid) {
		this.teminalid = teminalid;
	}
	public String getPvrid() {
		return pvrid;
	}
	public void setPvrid(String pvrid) {
		this.pvrid = pvrid;
	}
	public String getServiceid() {
		return serviceid;
	}
	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}
	public String getOpratorid() {
		return opratorid;
	}
	public void setOpratorid(String opratorid) {
		this.opratorid = opratorid;
	}
	
	
	
	
	
	
	

}
