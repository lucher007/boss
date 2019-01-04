package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Caspnproductplay extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;           // 数据库ID
	private Integer netid;        //网络ID
	private Long playid;         //邮件ID
	private String cardid;        // 
	private String conditioncontent; // 条件内容
	private String productid; //产品品ID
	private String productinfo;     //产品内容
	private String addtime;       // 写信时间
	private String expiredtime;   // 过期时间
	private String casexpiredtime;//CAS过期时间
	private String versiontype;   // cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String remark;        
	
	private String isControl;    //1：启动，0：取消
	
	/****************** 数据库辅助字段 *************************/
	private Caspnproductplay caspnproductplay;
	private List<Caspnproductplay> Caspnproductplaylist;
	private String querycardid;
	private String querydate;
	private String queryversiontype;
	private String querynetid;
	private Map<Integer, String> networkmap;

	private String cardid_option; //页面条件需要

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public Long getPlayid() {
		return playid;
	}

	public void setPlayid(Long playid) {
		this.playid = playid;
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

	public String getProductinfo() {
		return productinfo;
	}

	public void setProductinfo(String productinfo) {
		this.productinfo = productinfo;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getExpiredtime() {
		return expiredtime;
	}

	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
	}

	public String getCasexpiredtime() {
		return casexpiredtime;
	}

	public void setCasexpiredtime(String casexpiredtime) {
		this.casexpiredtime = casexpiredtime;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Caspnproductplay getCaspnproductplay() {
		return caspnproductplay;
	}

	public void setCaspnproductplay(Caspnproductplay caspnproductplay) {
		this.caspnproductplay = caspnproductplay;
	}

	public List<Caspnproductplay> getCaspnproductplaylist() {
		return Caspnproductplaylist;
	}

	public void setCaspnproductplaylist(List<Caspnproductplay> caspnproductplaylist) {
		Caspnproductplaylist = caspnproductplaylist;
	}

	public String getQuerycardid() {
		return querycardid;
	}

	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
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

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public String getCardid_option() {
		return cardid_option;
	}

	public void setCardid_option(String cardid_option) {
		this.cardid_option = cardid_option;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getIsControl() {
		return isControl;
	}

	public void setIsControl(String isControl) {
		this.isControl = isControl;
	}

	public String getProductid() {
		return productid;
	}

	public void setProductid(String productid) {
		this.productid = productid;
	}
	

}
