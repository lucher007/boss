package com.gospell.boss.po;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

public class Caspnforcedcc extends BaseField implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer netid;
	private String cardid; // 智能卡号
	private String conditioncontent;// 条件内容
	private String expiredtime; // 过期时间
	private String starttime; // 开始时间
	private String endtime;  //结束时间
	private String lockscreen; // 锁定用
	private String stbtype; // 机顶盒的类型（0x00：DVB-C，0x01：DVB-S，0x02: DVB-T）
	private String pcrpid; // 时钟的PID
	private String serviceid; // 节目号
	private String iscontrol; // 1：启动，0：取消
	private String remark;  //
	private String addtime;
	private Map<Integer, String> networkmap;

	
	//---------高安需要的字段
	private String versiontype;//cas版本类型
	private String stbno;  //机顶盒号
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String network_match; //网络匹配标识(0-不匹配；1-匹配）
	private String operator_match; //运营商匹配标识(0-不匹配；1-匹配）
	private String area_match;   //区域匹配标识(0-不匹配；1-匹配）
	private String device_type_match; //设备类型匹配标识(0-不匹配；1-匹配）
	private String terminal_type_match;//终端类型匹配标识(0-不匹配；1-匹配）
	private String vip_class_match;//VIP级别匹配标识(0-不匹配；1-匹配）
	private String network_id; //匹配网络ID
	private String operator_id;//匹配运营商ID
	private String area_id; //匹配区域ID
	private String device_type;//匹配设备类型(0–固定终端；1–手持终端)
	private String terminal_type;//匹配终端类型(0 - 主机；1 - 子机)
	private String vip_class;//VIP等级
	private String tsid; //TS流ID
	
	
	private ArrayList<HashMap <String,Object>> programComponentInfo;
	private HashMap <String,Object> DVBInfo; //DVB信息
	private List<Caspnforcedcc> caspnforcedcclist;
	private String querydate;
	private String queryversiontype;
	private String querynetid;
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getConditioncontent() {
		return conditioncontent;
	}

	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}

	public String getExpiredtime() {
		return expiredtime;
	}

	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getLockscreen() {
		return lockscreen;
	}

	public void setLockscreen(String lockscreen) {
		this.lockscreen = lockscreen;
	}

	public String getStbtype() {
		return stbtype;
	}

	public void setStbtype(String stbtype) {
		this.stbtype = stbtype;
	}

	public String getPcrpid() {
		return pcrpid;
	}

	public void setPcrpid(String pcrpid) {
		this.pcrpid = pcrpid;
	}

	public String getServiceid() {
		if(StringUtils.isEmpty(serviceid)){
			serviceid = "0";
		}
		return serviceid;
	}

	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}

	public String getIscontrol() {
		return iscontrol;
	}

	public void setIscontrol(String iscontrol) {
		this.iscontrol = iscontrol;
	}

	public HashMap<String, Object> getDVBInfo() {
		return DVBInfo;
	}

	public void setDVBInfo(HashMap<String, Object> dVBInfo) {
		DVBInfo = dVBInfo;
	}

	public ArrayList<HashMap<String, Object>> getProgramComponentInfo() {
		return programComponentInfo;
	}

	public void setProgramComponentInfo(
			ArrayList<HashMap<String, Object>> programComponentInfo) {
		this.programComponentInfo = programComponentInfo;
	}

	public List<Caspnforcedcc> getCaspnforcedcclist() {
		return caspnforcedcclist;
	}

	public void setCaspnforcedcclist(List<Caspnforcedcc> caspnforcedcclist) {
		this.caspnforcedcclist = caspnforcedcclist;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getVersiontype() {
		return versiontype;
	}

	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
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

	public String getNetwork_match() {
		return network_match;
	}

	public void setNetwork_match(String network_match) {
		this.network_match = network_match;
	}

	public String getOperator_match() {
		return operator_match;
	}

	public void setOperator_match(String operator_match) {
		this.operator_match = operator_match;
	}

	public String getArea_match() {
		return area_match;
	}

	public void setArea_match(String area_match) {
		this.area_match = area_match;
	}

	public String getDevice_type_match() {
		return device_type_match;
	}

	public void setDevice_type_match(String device_type_match) {
		this.device_type_match = device_type_match;
	}

	public String getTerminal_type_match() {
		return terminal_type_match;
	}

	public void setTerminal_type_match(String terminal_type_match) {
		this.terminal_type_match = terminal_type_match;
	}

	public String getVip_class_match() {
		return vip_class_match;
	}

	public void setVip_class_match(String vip_class_match) {
		this.vip_class_match = vip_class_match;
	}

	public String getNetwork_id() {
		if(StringUtils.isEmpty(network_id)){
			network_id = "0";
		}
		return network_id;
	}

	public void setNetwork_id(String network_id) {
		this.network_id = network_id;
	}

	public String getOperator_id() {
		if(StringUtils.isEmpty(operator_id)){
			operator_id = "0";
		}
		return operator_id;
	}

	public void setOperator_id(String operator_id) {
		this.operator_id = operator_id;
	}

	public String getArea_id() {
		if(StringUtils.isEmpty(area_id)){
			area_id = "0";
		}
		return area_id;
	}

	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}

	public String getDevice_type() {
		return device_type;
	}

	public void setDevice_type(String device_type) {
		this.device_type = device_type;
	}

	public String getTerminal_type() {
		return terminal_type;
	}

	public void setTerminal_type(String terminal_type) {
		this.terminal_type = terminal_type;
	}

	public String getVip_class() {
		if(StringUtils.isEmpty(vip_class)){
			vip_class = "0";
		}
		return vip_class;
	}

	public void setVip_class(String vip_class) {
		this.vip_class = vip_class;
	}

	public String getTsid() {
		if(StringUtils.isEmpty(tsid)){
			tsid = "0";
		}
		return tsid;
	}

	public void setTsid(String tsid) {
		this.tsid = tsid;
	}

	public String getQueryversiontype() {
		return queryversiontype;
	}

	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

}
