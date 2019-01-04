package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

public class Package extends BaseField implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer netid;
	private String name;
	private String type;
	private String usertype;
	private String areacode;
	private String service_ids;
	private String package_json;
	private String starttime;
	private String endtime;
	private String addtime;
	private BigDecimal totalmoney;
	private String remark;

	/****************** 数据库辅助字段 *************************/
	private List<Package> packageList;
	private Package pack;
	private String queryname;
	private String querytype;
	private String querynetid;
	private Network network;
	private List<Network> networklist;
	
	private User user;
	private Stb stb;
	private Card card;
    
	private String stbcardpairflag; //是否机卡绑定
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Stb getStb() {
		return stb;
	}

	public void setStb(Stb stb) {
		this.stb = stb;
	}

	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
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

	public String getService_ids() {
		return service_ids;
	}

	public void setService_ids(String service_ids) {
		this.service_ids = service_ids;
	}

	public String getPackage_json() {
		return package_json;
	}

	public void setPackage_json(String package_json) {
		this.package_json = package_json;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<Package> getPackageList() {
		return packageList;
	}

	public void setPackageList(List<Package> packageList) {
		this.packageList = packageList;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getQueryname() {
		return queryname;
	}

	public void setQueryname(String queryname) {
		this.queryname = queryname;
	}

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public Package getPack() {
		return pack;
	}

	public void setPack(Package pack) {
		this.pack = pack;
	}

	public String getStbcardpairflag() {
		return stbcardpairflag;
	}

	public void setStbcardpairflag(String stbcardpairflag) {
		this.stbcardpairflag = stbcardpairflag;
	}

	public BigDecimal getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
	}

}
