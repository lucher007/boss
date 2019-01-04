package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Productserviceref extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String productid;	       //产品ID
	private String productname;		   //产品名称
	private String serviceid;          //业务ID
	private String servicename;        //业务名称
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Productserviceref product;
	private List<Productserviceref> productlist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String queryproductname;
	private String queryproductid;
	private String querynetid;
	private String queryservicename;
	private String queryserviceid;
	
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
	public String getServiceid() {
		return serviceid;
	}
	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Productserviceref getProduct() {
		return product;
	}
	public void setProduct(Productserviceref product) {
		this.product = product;
	}
	public List<Productserviceref> getProductlist() {
		return productlist;
	}
	public void setProductlist(List<Productserviceref> productlist) {
		this.productlist = productlist;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
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
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQueryservicename() {
		return queryservicename;
	}
	public void setQueryservicename(String queryservicename) {
		this.queryservicename = queryservicename;
	}
	public String getQueryserviceid() {
		return queryserviceid;
	}
	public void setQueryserviceid(String queryserviceid) {
		this.queryserviceid = queryserviceid;
	}
	
	
	
	
	
}
