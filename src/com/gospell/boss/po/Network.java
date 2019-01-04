package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Network extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String netid;              //网络ID
	private Integer pid;               //父网络ID（如果是根节点，此字段为空）
	private String code;	           //网络编号（有规则的编号，方便管理拓扑结构，举例：001，002,001001等。
	private String netname;		       //网络名称
	private String nettype;            //网络类型（0-无备独立前端；1-有独立前端）
	private String address;         //网络地理位置
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Network network;
	private List<Network> networklist;
	private Map<Integer, String> networkmap;
	
	private String querynetname;
	private String oldcode;
	private String newcode;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getNetname() {
		return netname;
	}
	public void setNetname(String netname) {
		this.netname = netname;
	}
	public String getNettype() {
		return nettype;
	}
	public void setNettype(String nettype) {
		this.nettype = nettype;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public List<Network> getNetworklist() {
		return networklist;
	}
	public void setNetworklist(List<Network> networklist) {
		this.networklist = networklist;
	}
	public String getQuerynetname() {
		return querynetname;
	}
	public void setQuerynetname(String querynetname) {
		this.querynetname = querynetname;
	}
	public String getNetid() {
		return netid;
	}
	public void setNetid(String netid) {
		this.netid = netid;
	}
	public String getOldcode() {
		return oldcode;
	}
	public void setOldcode(String oldcode) {
		this.oldcode = oldcode;
	}
	public String getNewcode() {
		return newcode;
	}
	public void setNewcode(String newcode) {
		this.newcode = newcode;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	
	
}
