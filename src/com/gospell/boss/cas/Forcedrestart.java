package com.gospell.boss.cas;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Forcedrestart extends BaseField implements Serializable {
    
	private Integer netid;
	private String cardid;                // 智能卡号
	private String stbno;                // 机顶盒号
	private String card_or_stb_tag;      //按卡号寻址或者机顶盒号寻址标识，（取值说明：0x00：按卡号寻址，0x01：按机顶盒号寻址）
	//private String areano;               //区域号
	private String areacode;             //区域编号-普安用到
	private String lockscreen;      // 0表示只切换不锁定，1表示锁定
	private String stbtype;   // 机顶盒的类型
	private String pcrpid;    // 时钟的PID
	private ArrayList<HashMap <String,Object>> programComponentInfo; // 节目组件信息
	private HashMap <String,Object> DVBInfo; //DVB信息
	private String expired_Time;               //CAS到期日期
	private Map<Integer, String> networkmap;

	
	//高安指令需要字段
	private String addtime;   //添加时间
	private String starttime; // 开始时间
	private String endtime;  //结束时间
	private String iscontrol; // 1：启动，0：取消
	private String versiontype;//cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent;// 条件内容
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
	private String expiredtime;    //到期日期
	private String restartflag;    //重启标志。1表示重启机顶盒，0表示机顶盒待机。
	
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getCard_or_stb_tag() {
		return card_or_stb_tag;
	}
	public void setCard_or_stb_tag(String card_or_stb_tag) {
		this.card_or_stb_tag = card_or_stb_tag;
	}
	public String getStbtype() {
		return stbtype;
	}
	public void setStbtype(String stbtype) {
		this.stbtype = stbtype;
	}
	public String getPcrpid() {
		if(StringUtils.isEmpty(pcrpid)){
			pcrpid = "0";
		}
		return pcrpid;
	}
	public void setPcrpid(String pcrpid) {
		this.pcrpid = pcrpid;
	}
	public ArrayList<HashMap<String, Object>> getProgramComponentInfo() {
		return programComponentInfo;
	}
	public void setProgramComponentInfo(
			ArrayList<HashMap<String, Object>> programComponentInfo) {
		this.programComponentInfo = programComponentInfo;
	}
	public HashMap<String, Object> getDVBInfo() {
		return DVBInfo;
	}
	public void setDVBInfo(HashMap<String, Object> dVBInfo) {
		DVBInfo = dVBInfo;
	}
	public String getExpiredtime() {
		return expiredtime;
	}
	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
	}
	public String getLockscreen() {
		return lockscreen;
	}
	public void setLockscreen(String lockscreen) {
		this.lockscreen = lockscreen;
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
			network_id="0";
		}
		return network_id;
	}
	public void setNetwork_id(String network_id) {
		this.network_id = network_id;
	}
	public String getOperator_id() {
		if(StringUtils.isEmpty(operator_id)){
			operator_id="0";
		}
		return operator_id;
	}
	public void setOperator_id(String operator_id) {
		this.operator_id = operator_id;
	}
	public String getArea_id() {
		if(StringUtils.isEmpty(area_id)){
			area_id="0";
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
			vip_class="0";
		}
		return vip_class;
	}
	public void setVip_class(String vip_class) {
		this.vip_class = vip_class;
	}
	public String getIscontrol() {
		return iscontrol;
	}
	public void setIscontrol(String iscontrol) {
		this.iscontrol = iscontrol;
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
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
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
	public String getRestartflag() {
		return restartflag;
	}
	public void setRestartflag(String restartflag) {
		this.restartflag = restartflag;
	}
	
	
}
