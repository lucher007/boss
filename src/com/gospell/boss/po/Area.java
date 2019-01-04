package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.gospell.boss.common.Tools;
/**
 * 用户实体类
 */
public class Area extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private Integer serverid;          //所属前端ID
	private Integer pid;               //父级区域
	private String code;               //区域编号（有规则的编号，方便管理拓扑结构，举例：001，002,001-001等。
	private String areacode;	       //区域号
	private String areaname;		   //区域名称
	private String remark;             //备注
	private String areacode_12;        //区域编号12位，临时保存，不存在数据库，只用于页面显示
	
	/******************数据库辅助字段*************************/
	private Area area;
	private List<Area> arealist;
	private Map<Integer, String> networkmap;
	private Map<Integer, String> servermap;
	private Network network;
	private Server server;
	private Area parentarea; //父级区域
	private String queryareacode;
	private String queryareacodevalid; //区域有效字段
	
	private String querynetid;
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
	public Integer getServerid() {
		return serverid;
	}
	public void setServerid(Integer serverid) {
		this.serverid = serverid;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Area getArea() {
		return area;
	}
	public void setArea(Area area) {
		this.area = area;
	}
	public List<Area> getArealist() {
		return arealist;
	}
	public void setArealist(List<Area> arealist) {
		this.arealist = arealist;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public Map<Integer, String> getServermap() {
		return servermap;
	}
	public void setServermap(Map<Integer, String> servermap) {
		this.servermap = servermap;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public Server getServer() {
		return server;
	}
	public void setServer(Server server) {
		this.server = server;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQueryserverid() {
		return queryserverid;
	}
	public void setQueryserverid(String queryserverid) {
		this.queryserverid = queryserverid;
	}
	private String queryserverid;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Area getParentarea() {
		return parentarea;
	}
	public void setParentarea(Area parentarea) {
		this.parentarea = parentarea;
	}
	public String getAreacode_12() {
		return areacode_12;
	}
	public void setAreacode_12(String areacode_12) {
		this.areacode_12 = areacode_12;
	}
	public String getQueryareacodevalid() {
		return Tools.getAreacodeValid(queryareacode);
	}
	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}
	public String getQueryareacode() {
		return queryareacode;
	}
	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}
	
	
}
