package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
/**
 * 用户实体类
 */
public class Userlevelproduct extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer userlevelid;       //订户级别ID
	private String levelname;          //订户级别名称
	private Integer netid;
	private String productid;	       //产品ID
	private String productname;		   //产品名称
	private BigDecimal pricepermonth;  //产品包月单价
	private BigDecimal priceperday;    //产品每天价格
	private BigDecimal subpricepermonth;
	private BigDecimal subpriceperday;
	private String remark;             //备注
	
	private String state;
	private String queryproductid;
	private String queryproductname;
	
	/******************数据库辅助字段*************************/
	private Userlevelproduct userlevelproduct;
	private List<Userlevelproduct> userlevelproductlist;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserlevelid() {
		return userlevelid;
	}
	public void setUserlevelid(Integer userlevelid) {
		this.userlevelid = userlevelid;
	}
	public String getLevelname() {
		return levelname;
	}
	public void setLevelname(String levelname) {
		this.levelname = levelname;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Userlevelproduct getUserlevelproduct() {
		return userlevelproduct;
	}
	public void setUserlevelproduct(Userlevelproduct userlevelproduct) {
		this.userlevelproduct = userlevelproduct;
	}
	public List<Userlevelproduct> getUserlevelproductlist() {
		return userlevelproductlist;
	}
	public void setUserlevelproductlist(List<Userlevelproduct> userlevelproductlist) {
		this.userlevelproductlist = userlevelproductlist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public BigDecimal getPricepermonth() {
		return pricepermonth;
	}
	public void setPricepermonth(BigDecimal pricepermonth) {
		this.pricepermonth = pricepermonth;
	}
	public BigDecimal getPriceperday() {
		return priceperday;
	}
	public void setPriceperday(BigDecimal priceperday) {
		this.priceperday = priceperday;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public BigDecimal getSubpricepermonth() {
		return subpricepermonth;
	}
	public void setSubpricepermonth(BigDecimal subpricepermonth) {
		this.subpricepermonth = subpricepermonth;
	}
	public BigDecimal getSubpriceperday() {
		return subpriceperday;
	}
	public void setSubpriceperday(BigDecimal subpriceperday) {
		this.subpriceperday = subpriceperday;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getQueryproductid() {
		return queryproductid;
	}
	public void setQueryproductid(String queryproductid) {
		this.queryproductid = queryproductid;
	}
	public String getQueryproductname() {
		return queryproductname;
	}
	public void setQueryproductname(String queryproductname) {
		this.queryproductname = queryproductname;
	}
	
	
	
	
}
