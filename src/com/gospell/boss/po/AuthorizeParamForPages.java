package com.gospell.boss.po;

import java.io.Serializable;

import com.gospell.boss.cas.ConditionAddr;
import com.gospell.boss.cas.EmailOrOsdMsg;
import com.gospell.boss.cas.GaoAnEmail;
import com.gospell.boss.cas.GaoanOsdParam;



/**
 * 用户实体类
 */
public class AuthorizeParamForPages extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private String addressing_mode;
	private String starttime; //
	private String endtime; //
	private String stbno; //
	private String startstbno; //
	private String endstbno; //
	private String caobject; //
	private Product product;
	private String cardid;
	private String startcardid;
	private String endcardid;
	private Integer netid; //网络ID
	private String versiontype; //cas版本类型
	private String cancel_control;

	
	/****************** 数据库辅助字段 *************************/
	private String queryproductname; //
	private String queryproductid; //
	private GaoanOsdParam gaoanosdparam;
	private GaoAnEmail gaoanemail;
	private EmailOrOsdMsg emailorosdmsg;
	private ConditionAddr conditionaddr;
	private String querynetid;
	
	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getStartcardid() {
		return startcardid;
	}

	public void setStartcardid(String startcardid) {
		this.startcardid = startcardid;
	}

	public String getEndcardid() {
		return endcardid;
	}

	public void setEndcardid(String endcardid) {
		this.endcardid = endcardid;
	}

	public String getQueryproductname() {
		return queryproductname;
	}

	public void setQueryproductname(String queryproductname) {
		this.queryproductname = queryproductname;
	}

	public String getQueryproductid() {
		return queryproductid;
	}

	public void setQueryproductid(String queryproductid) {
		this.queryproductid = queryproductid;
	}

	public String getAddressing_mode() {
		return addressing_mode;
	}

	public void setAddressing_mode(String addressing_mode) {
		this.addressing_mode = addressing_mode;
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

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
	}

	public String getStartstbno() {
		return startstbno;
	}

	public void setStartstbno(String startstbno) {
		this.startstbno = startstbno;
	}

	public String getEndstbno() {
		return endstbno;
	}

	public void setEndstbno(String endstbno) {
		this.endstbno = endstbno;
	}

	public String getCaobject() {
		return caobject;
	}

	public void setCaobject(String caobject) {
		this.caobject = caobject;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public GaoanOsdParam getGaoanosdparam() {
		return gaoanosdparam;
	}

	public void setGaoanosdparam(GaoanOsdParam gaoanosdparam) {
		this.gaoanosdparam = gaoanosdparam;
	}

	public String getCancel_control() {
		return cancel_control;
	}

	public void setCancel_control(String cancel_control) {
		this.cancel_control = cancel_control;
	}

	public GaoAnEmail getGaoanemail() {
		return gaoanemail;
	}

	public void setGaoanemail(GaoAnEmail gaoanemail) {
		this.gaoanemail = gaoanemail;
	}

	public EmailOrOsdMsg getEmailorosdmsg() {
		return emailorosdmsg;
	}

	public void setEmailorosdmsg(EmailOrOsdMsg emailorosdmsg) {
		this.emailorosdmsg = emailorosdmsg;
	}

	public ConditionAddr getConditionaddr() {
		return conditionaddr;
	}

	public void setConditionaddr(ConditionAddr conditionaddr) {
		this.conditionaddr = conditionaddr;
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

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

}
