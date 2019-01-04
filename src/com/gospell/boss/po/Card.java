package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Card extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private String cardid; // 智能卡号
	private Integer providerid; // 智能卡供应商
	private Integer netid; // 网络ID
	private String versiontype; //CAS版本类型
	private Integer serverid; // 所属前端ID
	private String state; // 卡状态（0-库存；1：使用；2：维修；3：损坏；）
	private String inputtime; // 入库时间
	private String outtime; // 出库时间
	private String batchnum; // 入库批号
	private String pincode; // PIN码
	private String incardflag; //是否内置卡(0-外置卡；1-内置卡）
	private String stbno;    //配对机顶盒号
	private String remark; // 备注

	/****************** 数据库辅助字段 *************************/
	private Card card;
	private List<Card> cardlist;

	private Provider provider;
	private List<Provider> providerlist;
	private Map<Integer, String> providermap;
	private Server server;
	private List<Server> serverlist;
	private Map<Integer, String> servermap;
	private Network network;
	private List<Network> networklist;
	private Map<Integer, String> networkmap;

	private String querynetid;
	private String queryversiontype;
	private String queryserverid;
	private String queryproviderid;
	private String querycardid;
	private String querystate;
	private String querymodel;
	private String queryincardflag;
	private String querystbno;
	private String replacecardid;
	private Integer startcard;
	private Integer endcard;
	private Integer addmode;
	
	private String stbcardpair;
	private String startcardid;
	private String endcardid;
	private String cardids;
	private String[] querycardids;
	
	/******************规则型号字段*************************/
	private String companyname;  //公司名称
	private String model;	  //机顶盒型号
	private BigDecimal mainprice; //主终端价格
	private BigDecimal subprice;  //副终端价格
	
	private BigDecimal saleprice; //出售的价格
	
	public Integer getStartcard() {
		return startcard;
	}

	public void setStartcard(Integer startcard) {
		this.startcard = startcard;
	}

	public Integer getEndcard() {
		return endcard;
	}

	public void setEndcard(Integer endcard) {
		this.endcard = endcard;
	}

	public Integer getAddmode() {
		return addmode;
	}

	public void setAddmode(Integer addmode) {
		this.addmode = addmode;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Integer getProviderid() {
		return providerid;
	}

	public void setProviderid(Integer providerid) {
		this.providerid = providerid;
	}

	public Integer getServerid() {
		return serverid;
	}

	public void setServerid(Integer serverid) {
		this.serverid = serverid;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInputtime() {
		return inputtime;
	}

	public void setInputtime(String inputtime) {
		this.inputtime = inputtime;
	}

	public String getOuttime() {
		return outtime;
	}

	public void setOuttime(String outtime) {
		this.outtime = outtime;
	}

	public String getBatchnum() {
		return batchnum;
	}

	public void setBatchnum(String batchnum) {
		this.batchnum = batchnum;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}

	public List<Card> getCardlist() {
		return cardlist;
	}

	public void setCardlist(List<Card> cardlist) {
		this.cardlist = cardlist;
	}

	public Provider getProvider() {
		return provider;
	}

	public void setProvider(Provider provider) {
		this.provider = provider;
	}

	public Map<Integer, String> getProvidermap() {
		return providermap;
	}

	public void setProvidermap(Map<Integer, String> providermap) {
		this.providermap = providermap;
	}

	public Server getServer() {
		return server;
	}

	public void setServer(Server server) {
		this.server = server;
	}

	public Map<Integer, String> getServermap() {
		return servermap;
	}

	public void setServermap(Map<Integer, String> servermap) {
		this.servermap = servermap;
	}

	public String getQueryproviderid() {
		return queryproviderid;
	}

	public void setQueryproviderid(String queryproviderid) {
		this.queryproviderid = queryproviderid;
	}

	public String getQuerycardid() {
		return querycardid;
	}

	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

	public String getQuerymodel() {
		return querymodel;
	}

	public void setQuerymodel(String querymodel) {
		this.querymodel = querymodel;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getCardid() {
		return cardid;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getIncardflag() {
		return incardflag;
	}

	public void setIncardflag(String incardflag) {
		this.incardflag = incardflag;
	}

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
	}

	public String getReplacecardid() {
		return replacecardid;
	}

	public void setReplacecardid(String replacecardid) {
		this.replacecardid = replacecardid;
	}

	public String getVersiontype() {
		return versiontype;
	}

	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}

	public String getQueryversiontype() {
		return queryversiontype;
	}

	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}

	public List<Provider> getProviderlist() {
		return providerlist;
	}

	public void setProviderlist(List<Provider> providerlist) {
		this.providerlist = providerlist;
	}

	public List<Server> getServerlist() {
		return serverlist;
	}

	public void setServerlist(List<Server> serverlist) {
		this.serverlist = serverlist;
	}

	public List<Network> getNetworklist() {
		return networklist;
	}

	public void setNetworklist(List<Network> networklist) {
		this.networklist = networklist;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public BigDecimal getMainprice() {
		return mainprice;
	}

	public void setMainprice(BigDecimal mainprice) {
		this.mainprice = mainprice;
	}

	public BigDecimal getSubprice() {
		return subprice;
	}

	public void setSubprice(BigDecimal subprice) {
		this.subprice = subprice;
	}

	public BigDecimal getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(BigDecimal saleprice) {
		this.saleprice = saleprice;
	}

	public String getQueryincardflag() {
		return queryincardflag;
	}

	public void setQueryincardflag(String queryincardflag) {
		this.queryincardflag = queryincardflag;
	}

	public String getQuerystbno() {
		return querystbno;
	}

	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}

	public String getStbcardpair() {
		return stbcardpair;
	}

	public void setStbcardpair(String stbcardpair) {
		this.stbcardpair = stbcardpair;
	}

	public String getStartcardid() {
		return startcardid;
	}

	public void setStartcardid(String startcardid) {
		this.startcardid = startcardid;
	}

	public String getEndcardid() {
		return endcardid;
	}

	public void setEndcardid(String endcardid) {
		this.endcardid = endcardid;
	}

	public String getCardids() {
		return cardids;
	}

	public void setCardids(String cardids) {
		this.cardids = cardids;
	}

	public String[] getQuerycardids() {
		return querycardids;
	}

	public void setQuerycardids(String[] querycarids) {
		this.querycardids = querycarids;
	}

	
}
