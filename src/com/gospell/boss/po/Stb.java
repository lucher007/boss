package com.gospell.boss.po;

import java.io.File;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Stb extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String stbno;              //机顶盒号
	private Integer providerid;		   //供应商Id
	private Integer netid;             //网络ID
	private String versiontype;        //CAS版本类型
	private Integer serverid;          //所属前端ID
	private String stbversion;         //应用软件版本
	private String loaderversion;      //Loader程序版本号
	private String state;              //机顶盒状态 （卡状态（0-库存；1：使用；2：维修；3：损坏；））
	private String inputtime;          //入库时间
	private String outtime;            //出库时间
	private String incardflag;         //是否内置卡
	private String batchnum;           //入库批号
	private String remark;             //备注
	
	private String stbnos;
	private String[] querystbnos;
	private String servername;
	
	/******************数据库辅助字段*************************/
	private Stb stb;
	private List<Stb> stblist;
	private Provider provider;
	private List<Provider> providerlist;
	private Integer cardproviderid; //内置卡的规格型号
	private Provider cardProvider;
	private List<Provider> cardproviderlist;
	private Map<Integer, String> providermap;
	private Server server;
	private Map<Integer, String> servermap;
	private List<Server> serverlist;
	private Network network;
	private Map<Integer, String> networkmap;
	private List<Network> networklist;
	private String querynetid;
	private String queryversiontype;
	private String queryserverid;
	private String queryproviderid;
	private String querystbno;
	private String querystate;
	private String querymodel;
	private String queryincardflag;

	private String replacestbno; //新更换的机顶盒号
	private Integer startstb;
	private Integer endstb;
	private Integer addmode;
	private String cardid;             //内置卡号或终端号
	private String paircardid;         //配对智能卡号
	/******************规则型号字段*************************/
	private String companyname;  //公司名称
	private String model;	  //机顶盒型号
	private BigDecimal mainprice; //主终端价格
	private BigDecimal subprice;  //副终端价格
	
	private BigDecimal saleprice; //出售的价格

	public Integer getId() {
		return id;
	}
	public Integer getStartstb() {
		return startstb;
	}
	public void setStartstb(Integer startstb) {
		this.startstb = startstb;
	}
	public Integer getEndstb() {
		return endstb;
	}
	public void setEndstb(Integer endstb) {
		this.endstb = endstb;
	}
	public Integer getAddmode() {
		return addmode;
	}
	public void setAddmode(Integer addmode) {
		this.addmode = addmode;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getStbversion() {
		return stbversion;
	}
	public void setStbversion(String stbversion) {
		this.stbversion = stbversion;
	}
	public String getLoaderversion() {
		return loaderversion;
	}
	public void setLoaderversion(String loaderversion) {
		this.loaderversion = loaderversion;
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
	public String getIncardflag() {
		return incardflag;
	}
	public void setIncardflag(String incardflag) {
		this.incardflag = incardflag;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getBatchnum() {
		return batchnum;
	}
	public void setBatchnum(String batchnum) {
		this.batchnum = batchnum;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Stb getStb() {
		return stb;
	}
	public void setStb(Stb stb) {
		this.stb = stb;
	}
	public List<Stb> getStblist() {
		return stblist;
	}
	public void setStblist(List<Stb> stblist) {
		this.stblist = stblist;
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
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	public String getQuerystbno() {
		return querystbno;
	}
	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}
	public String getQuerymodel() {
		return querymodel;
	}
	public void setQuerymodel(String querymodel) {
		this.querymodel = querymodel;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
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
	public String getReplacestbno() {
		return replacestbno;
	}
	public void setReplacestbno(String replacestbno) {
		this.replacestbno = replacestbno;
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
	public String getQueryincardflag() {
		return queryincardflag;
	}
	public void setQueryincardflag(String queryincardflag) {
		this.queryincardflag = queryincardflag;
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
	public List<Provider> getCardproviderlist() {
		return cardproviderlist;
	}
	public void setCardproviderlist(List<Provider> cardproviderlist) {
		this.cardproviderlist = cardproviderlist;
	}
	public Integer getCardproviderid() {
		return cardproviderid;
	}
	public void setCardproviderid(Integer cardproviderid) {
		this.cardproviderid = cardproviderid;
	}
	public Provider getCardProvider() {
		return cardProvider;
	}
	public void setCardProvider(Provider cardProvider) {
		this.cardProvider = cardProvider;
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
	public String getPaircardid() {
		return paircardid;
	}
	public void setPaircardid(String paircardid) {
		this.paircardid = paircardid;
	}
	public String getStbnos() {
		return stbnos;
	}
	public void setStbnos(String stbnos) {
		this.stbnos = stbnos;
	}
	public String[] getQuerystbnos() {
		return querystbnos;
	}
	public void setQuerystbnos(String[] querystbnos) {
		this.querystbnos = querystbnos;
	}
	public String getServername() {
		return servername;
	}
	public void setServername(String servername) {
		this.servername = servername;
	}
	
}
