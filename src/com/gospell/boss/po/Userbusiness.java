package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户业务实体类
 */
public class Userbusiness extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private Integer operatorid;        //操作员ID
	private String  areacode;          //所属区域号
	private Integer userid;	           //订户ID
	private Integer storeid;		   //营业厅ID
	private BigDecimal totalmoney;     //费用总金额
	private BigDecimal score;          //消费积分（已经弃用）
	private BigDecimal scoremoney;     //积分抵扣金额（已经弃用）
	private BigDecimal accountmoney;   //余额抵扣金额
	private BigDecimal shouldmoney;    //应付金额
	private BigDecimal paymoney;       //实付金额
	private BigDecimal discount;       //折扣
	private String  addtime;           //添加时间
	private String logout;             //注销标志（默认为0-正常；1-注销）
	private String source;             //业务来源（0-BOSS；1-MPS；2-代买）
	private Integer buyerid;           //代买人ID(代付款的时候保存代付人ID)
	private String paytype;            //支付类型（0-现金支付；1-余额支付；2-积分支付；3-其他支付）
	private String invoicecode;        //发票编号
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private String querynetid;
	private String queryuserid;
	private String queryoperatorid;
	private String querylogout;
	private String querysource;
	
	private Userbusiness userbusiness;
	private List<Userbusiness> userbusinesslist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String businesstype;       //业务类型
	private String businesstypekey;    //业务类型Key	
	private String cardid;
	private String stbno;
	private String terminalid;        //终端号
	private String terminaltype;      //终端类型
	private String productid;
	private String address;
	private String stbstate;
    private String cardstate;
    private Integer userproductid;   //订户产品ID
    private String devicestate;      //设备回收状态
    private String terminalids;      //批量终端号
	private String productids;
    
    //发票模板
    private Map<String, String> templateMap;
    
    //发票模板
    private List<Printtemplate> templateList;
    
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
	public Integer getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getStoreid() {
		return storeid;
	}
	public void setStoreid(Integer storeid) {
		this.storeid = storeid;
	}
	public BigDecimal getTotalmoney() {
		if( totalmoney == null){
			return new BigDecimal(0);
		}
		return totalmoney;
	}
	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
	}
	public BigDecimal getScore() {
		if( score == null){
			return new BigDecimal(0);
		}
		return score;
	}
	public void setScore(BigDecimal score) {
		this.score = score;
	}
	public BigDecimal getScoremoney() {
		if( scoremoney == null){
			return new BigDecimal(0);
		}
		return scoremoney;
	}
	public void setScoremoney(BigDecimal scoremoney) {
		this.scoremoney = scoremoney;
	}
	public BigDecimal getAccountmoney() {
		if( accountmoney == null){
			return new BigDecimal(0);
		}
		return accountmoney;
	}
	public void setAccountmoney(BigDecimal accountmoney) {
		this.accountmoney = accountmoney;
	}
	public BigDecimal getShouldmoney() {
		return shouldmoney;
	}
	public void setShouldmoney(BigDecimal shouldmoney) {
		this.shouldmoney = shouldmoney;
	}
	public BigDecimal getPaymoney() {
		return paymoney;
	}
	public void setPaymoney(BigDecimal paymoney) {
		this.paymoney = paymoney;
	}
	public BigDecimal getDiscount() {
		return discount;
	}
	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getLogout() {
		return logout;
	}
	public void setLogout(String logout) {
		this.logout = logout;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQueryuserid() {
		return queryuserid;
	}
	public void setQueryuserid(String queryuserid) {
		this.queryuserid = queryuserid;
	}
	public String getQueryoperatorid() {
		return queryoperatorid;
	}
	public void setQueryoperatorid(String queryoperatorid) {
		this.queryoperatorid = queryoperatorid;
	}
	public String getQuerylogout() {
		return querylogout;
	}
	public void setQuerylogout(String querylogout) {
		this.querylogout = querylogout;
	}
	public String getQuerysource() {
		return querysource;
	}
	public void setQuerysource(String querysource) {
		this.querysource = querysource;
	}
	public Userbusiness getUserbusiness() {
		return userbusiness;
	}
	public void setUserbusiness(Userbusiness userbusiness) {
		this.userbusiness = userbusiness;
	}
	public List<Userbusiness> getUserbusinesslist() {
		return userbusinesslist;
	}
	public void setUserbusinesslist(List<Userbusiness> userbusinesslist) {
		this.userbusinesslist = userbusinesslist;
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
	public String getBusinesstype() {
		return businesstype;
	}
	public void setBusinesstype(String businesstype) {
		this.businesstype = businesstype;
	}
	public String getBusinesstypekey() {
		return businesstypekey;
	}
	public void setBusinesstypekey(String businesstypekey) {
		this.businesstypekey = businesstypekey;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStbstate() {
		return stbstate;
	}
	public void setStbstate(String stbstate) {
		this.stbstate = stbstate;
	}
	public String getCardstate() {
		return cardstate;
	}
	public void setCardstate(String cardstate) {
		this.cardstate = cardstate;
	}
	public String getTerminalid() {
		return terminalid;
	}
	public void setTerminalid(String terminalid) {
		this.terminalid = terminalid;
	}
	public String getTerminaltype() {
		return terminaltype;
	}
	public void setTerminaltype(String terminaltype) {
		this.terminaltype = terminaltype;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public Map<String, String> getTemplateMap() {
		return templateMap;
	}
	public void setTemplateMap(Map<String, String> templateMap) {
		this.templateMap = templateMap;
	}
	public Integer getUserproductid() {
		return userproductid;
	}
	public void setUserproductid(Integer userproductid) {
		this.userproductid = userproductid;
	}
	public String getDevicestate() {
		return devicestate;
	}
	public void setDevicestate(String devicestate) {
		this.devicestate = devicestate;
	}
	public List<Printtemplate> getTemplateList() {
		return templateList;
	}
	public void setTemplateList(List<Printtemplate> templateList) {
		this.templateList = templateList;
	}
	public Integer getBuyerid() {
		return buyerid;
	}
	public void setBuyerid(Integer buyerid) {
		this.buyerid = buyerid;
	}
	public String getInvoicecode() {
		return invoicecode;
	}
	public void setInvoicecode(String invoicecode) {
		this.invoicecode = invoicecode;
	}
	public String getProductids() {
		return productids;
	}
	public void setProductids(String productids) {
		this.productids = productids;
	}
	public String getTerminalids() {
		return terminalids;
	}
	public void setTerminalids(String terminalids) {
		this.terminalids = terminalids;
	}
	
	
}
