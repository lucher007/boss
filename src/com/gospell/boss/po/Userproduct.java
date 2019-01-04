package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Userproduct extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String  areacode;          //所属区域号
	private Integer userid;	           //订户ID
	private Integer serverid;          //CAS服务器ID
	private String terminalid;         //终端号
	private String terminaltype;       //终端类型
	private String cardid;		       //智能卡号
	private String stbno;              //机顶盒号
	private String productid;          //产品ID
	private String productname;        //产品名称
	private String type;               //产品类型（1-产品；2-业务；3-事件）
	private String source;             //购买来源（0-营业厅；1-MPS）
	private Integer buyerid;            //代办人
	private String addtime;            //购买时间
	private String starttime;          //授权开始时间
	private String endtime;            //授权结束时间
	private String state;              //状态（0-报停；1-正常）
	private BigDecimal restday;        //报停剩下天数 
	private BigDecimal price;          //价格
	private String unit;               //单位（年/月/周/日/小时/个）
	private Integer buyamount;         //购买授权数量
	private BigDecimal totalmoney;     //总费用
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private String queryuserid;
	private String querycardid;
	private String querystbno;
	private String querystate;
	private String queryproductid;
	private String querynetid;
	private String queryareacode;
	private String terminalids;
	private String[] qterminalids;
	private String queryterminalid;
	
	private String productids;
	private String[] qproductids;
	
	private Userproduct userproduct;
	private List<Userproduct> userproductlist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public BigDecimal getRestday() {
		return restday;
	}
	public void setRestday(BigDecimal restday) {
		this.restday = restday;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getQueryuserid() {
		return queryuserid;
	}
	public void setQueryuserid(String queryuserid) {
		this.queryuserid = queryuserid;
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
	public Userproduct getUserproduct() {
		return userproduct;
	}
	public void setUserproduct(Userproduct userproduct) {
		this.userproduct = userproduct;
	}
	public List<Userproduct> getUserproductlist() {
		return userproductlist;
	}
	public void setUserproductlist(List<Userproduct> userproductlist) {
		this.userproductlist = userproductlist;
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
	public String getQueryproductid() {
		return queryproductid;
	}
	public void setQueryproductid(String queryproductid) {
		this.queryproductid = queryproductid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public BigDecimal getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
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
	public Integer getServerid() {
		return serverid;
	}
	public void setServerid(Integer serverid) {
		this.serverid = serverid;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQueryareacode() {
		return queryareacode;
	}
	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}
	public Integer getBuyamount() {
		return buyamount;
	}
	public void setBuyamount(Integer buyamount) {
		this.buyamount = buyamount;
	}
	public Integer getBuyerid() {
		return buyerid;
	}
	public void setBuyerid(Integer buyerid) {
		this.buyerid = buyerid;
	}
	public String getTerminalids() {
		return terminalids;
	}
	public void setTerminalids(String terminalids) {
		this.terminalids = terminalids;
	}
	public String[] getQterminalids() {
		return qterminalids;
	}
	public void setQterminalids(String[] qterminalids) {
		this.qterminalids = qterminalids;
	}
	public String getQuerystbno() {
		return querystbno;
	}
	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}
	public String getQueryterminalid() {
		return queryterminalid;
	}
	public void setQueryterminalid(String queryterminalid) {
		this.queryterminalid = queryterminalid;
	}
	public String getProductids() {
		return productids;
	}
	public void setProductids(String productids) {
		this.productids = productids;
	}
	public String[] getQproductids() {
		return qproductids;
	}
	public void setQproductids(String[] qproductids) {
		this.qproductids = qproductids;
	}
	
	
	
	
}
