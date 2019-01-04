package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Caspnblackcard extends BaseField implements Serializable {

	private Integer id; // ID主键
	private String cardid; // 智能卡号
	private String remark; // 备注
	private String stbno;  //黑名单绑定的机顶盒
	private Integer netid; //网络ID
	private String versiontype; //cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent;//条件内容
	private String addtime;//添加日期
	
	private String  operatorType;	//操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）对应数字（添加：252，删除：255）
	

	/****************** 数据库辅助字段 *************************/
	private Caspnblackcard caspnblackcard;
	private List<Caspnblackcard> caspnblackcardlist;
	private String querycardid;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Caspnblackcard getCaspnblackcard() {
		return caspnblackcard;
	}
	public void setCaspnblackcard(Caspnblackcard caspnblackcard) {
		this.caspnblackcard = caspnblackcard;
	}
	public List<Caspnblackcard> getCaspnblackcardlist() {
		return caspnblackcardlist;
	}
	public void setCaspnblackcardlist(List<Caspnblackcard> caspnblackcardlist) {
		this.caspnblackcardlist = caspnblackcardlist;
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
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
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
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getOperatorType() {
		return operatorType;
	}
	public void setOperatorType(String operatorType) {
		this.operatorType = operatorType;
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
	


}
