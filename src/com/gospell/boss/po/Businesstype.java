package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
/**
 * 用户实体类
 */
public class Businesstype extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String typekey;           //业务类型编码
	private String typename;          //业务类型名称
	private String feename;           //费用名称
	private BigDecimal price;	       //办理此业务价格
	private String order;		       //页面显示顺序
	private String state;		       //状态（0-无效；1-有效）
	private Double showorder;          //显示排序
	private String remark;             //备注
	private String definedflag;        //自定义标识
	
	private String querydefinedflag;
	
	/******************数据库辅助字段*************************/
	private Businesstype businesstype;
	private List<Businesstype> businesstypelist;
	
	private String querytypekey;
	private String querystate;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTypekey() {
		return typekey;
	}
	public void setTypekey(String typekey) {
		this.typekey = typekey;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getFeename() {
		return feename;
	}
	public void setFeename(String feename) {
		this.feename = feename;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
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
	public Businesstype getBusinesstype() {
		return businesstype;
	}
	public void setBusinesstype(Businesstype businesstype) {
		this.businesstype = businesstype;
	}
	public List<Businesstype> getBusinesstypelist() {
		return businesstypelist;
	}
	public void setBusinesstypelist(List<Businesstype> businesstypelist) {
		this.businesstypelist = businesstypelist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getQuerytypekey() {
		return querytypekey;
	}
	public void setQuerytypekey(String querytypekey) {
		this.querytypekey = querytypekey;
	}
	public Double getShoworder() {
		return showorder;
	}
	public void setShoworder(Double showorder) {
		this.showorder = showorder;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	public String getQuerydefinedflag() {
		return querydefinedflag;
	}
	public void setQuerydefinedflag(String querydefinedflag) {
		this.querydefinedflag = querydefinedflag;
	}
	public String getDefinedflag() {
		return definedflag;
	}
	public void setDefinedflag(String definedflag) {
		this.definedflag = definedflag;
	}
	
	
	
}
