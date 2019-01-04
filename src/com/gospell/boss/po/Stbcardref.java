package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Stbcardref extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String stbno;              //机顶盒号
	private String cardid;             //智能卡号
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Stbcardref stbcardref;
	private List<Stbcardref> stbcardreflist;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
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
	public Stbcardref getStbcardref() {
		return stbcardref;
	}
	public void setStbcardref(Stbcardref stbcardref) {
		this.stbcardref = stbcardref;
	}
	public List<Stbcardref> getStbcardreflist() {
		return stbcardreflist;
	}
	public void setStbcardreflist(List<Stbcardref> stbcardreflist) {
		this.stbcardreflist = stbcardreflist;
	}
	
	
	
	
	
	
}
