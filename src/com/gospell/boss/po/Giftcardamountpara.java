package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
/**
 * 用户实体类
 */
public class Giftcardamountpara extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String parakey;	       //价格KEY
	private BigDecimal amount;		   //价格值
	private String state;        //状态（0-无效；1-有效）
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private String querystate;
	private List<Giftcardamountpara> giftcardamountparalist;
	private Giftcardamountpara giftcardamountpara;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getParakey() {
		return parakey;
	}
	public void setParakey(String parakey) {
		this.parakey = parakey;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public List<Giftcardamountpara> getGiftcardamountparalist() {
		return giftcardamountparalist;
	}
	public void setGiftcardamountparalist(List<Giftcardamountpara> giftcardamountparalist) {
		this.giftcardamountparalist = giftcardamountparalist;
	}
	public Giftcardamountpara getGiftcardamountpara() {
		return giftcardamountpara;
	}
	public void setGiftcardamountpara(Giftcardamountpara giftcardamountpara) {
		this.giftcardamountpara = giftcardamountpara;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	
	
}
