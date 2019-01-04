package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Store extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String storecode;	       //营业厅编号
	private String storename;		   //营业厅名称
	private String address;            //营业厅地址
	private String state;              //营业厅状态(0-无效；1-有效)
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Store store;
	private List<Store> storelist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String querystorename;
	private String querystorecode;
	private String querynetid;
	private String querystate;
	
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
	public String getStorecode() {
		return storecode;
	}
	public void setStorecode(String storecode) {
		this.storecode = storecode;
	}
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}
	public List<Store> getStorelist() {
		return storelist;
	}
	public void setStorelist(List<Store> storelist) {
		this.storelist = storelist;
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
	public String getQuerystorename() {
		return querystorename;
	}
	public void setQuerystorename(String querystorename) {
		this.querystorename = querystorename;
	}
	public String getQuerystorecode() {
		return querystorecode;
	}
	public void setQuerystorecode(String querystorecode) {
		this.querystorecode = querystorecode;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	
	
}
