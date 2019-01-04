package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Computer extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private Integer storeid;           //所属营业厅
	private String computercode;       //电脑编号
	private String ip;	               //IP地址
	private String macaddress;		   //MAC地址
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Computer computer;
	private List<Computer> computerlist;
	private Map<Integer, String> networkmap;
	private Map<Integer, String> storemap;
	private Network network;
	private Store store;
	private Integer querystoreid;
	
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
	public Integer getStoreid() {
		return storeid;
	}
	public void setStoreid(Integer storeid) {
		this.storeid = storeid;
	}
	public String getComputercode() {
		return computercode;
	}
	public void setComputercode(String computercode) {
		this.computercode = computercode;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getMacaddress() {
		return macaddress;
	}
	public void setMacaddress(String macaddress) {
		this.macaddress = macaddress;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Computer getComputer() {
		return computer;
	}
	public void setComputer(Computer computer) {
		this.computer = computer;
	}
	public List<Computer> getComputerlist() {
		return computerlist;
	}
	public void setComputerlist(List<Computer> computerlist) {
		this.computerlist = computerlist;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public Map<Integer, String> getStoremap() {
		return storemap;
	}
	public void setStoremap(Map<Integer, String> storemap) {
		this.storemap = storemap;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}
	public Integer getQuerystoreid() {
		return querystoreid;
	}
	public void setQuerystoreid(Integer querystoreid) {
		this.querystoreid = querystoreid;
	}
	
	
	
	
}
