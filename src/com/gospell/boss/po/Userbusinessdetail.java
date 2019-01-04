package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 用户业务明细实体类
 */
public class Userbusinessdetail extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private Integer netid; // 所属网络ID
	private Integer businessid; // 业务主表ID
	private Integer operatorid; //操作员ID
	private String areacode; // 所属区域号
	private Integer userid; // 订户ID
	private Integer storeid; // 营业厅ID
	private String businesstypekey; // 业务类型Key
	private String businesstypename; // 业务类型名称
	private String terminalid;       //终端号
	private String terminaltype;     //终端类型
	private String cardid;   //智能卡号
	private String stbno;    //机顶盒号
	private String productid;  //产品ID
	private String productname; //产品名称
	private String type;        //产品类型（1-产品；2-业务；3-事件）
	private String addtime;    //添加时间
	private String starttime; //授权开始时间
	private String endtime;   //授权结束时间
	private String feename;   //费用名称
	private String content; // 费用内容
	private BigDecimal price; // 单价
	private BigDecimal totalmoney; // 总费用
	private String logout; // 注销标志（默认为0-正常；1-注销）
	private String source; // 购买来源（0-营业厅；1-MPS；2-代付款）
	private Integer buyerid;   //代买人ID(代付款的时候保存代付人ID)
	private String remark; // 备注

	/****************** 数据库辅助字段 *************************/
	private String querynetid;
	private String queryuserid;
	private String queryoperatorid;
	private String querylogout;
	private String querysource;
	private String querydate;
	private String operatorname;
	private Map<String, String> excelmap;
	private String querydatetype;
	private String queryyear;
	private String querymonth;
	private String queryday;
	private String[] operationReportColumn;
	private Userbusinessdetail userbusinessdetail;
	private List<Userbusinessdetail> userbusinessdetaillist;
	private Network network;
	private Map<Integer, String> networkmap;
	private User user;
	private Operator operator;
	private Businesstype businesstype;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBusinessid() {
		return businessid;
	}

	public void setBusinessid(Integer businessid) {
		this.businessid = businessid;
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

	public String getBusinesstypekey() {
		return businesstypekey;
	}

	public void setBusinesstypekey(String businesstypekey) {
		this.businesstypekey = businesstypekey;
	}

	public String getBusinesstypename() {
		return businesstypename;
	}

	public void setBusinesstypename(String businesstypename) {
		this.businesstypename = businesstypename;
	}

	public String getFeename() {
		return feename;
	}

	public void setFeename(String feename) {
		this.feename = feename;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public BigDecimal getPrice() {
		if(price == null){
			price = new BigDecimal("0");
		}
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getTotalmoney() {
		if(totalmoney == null){
			totalmoney = new BigDecimal("0.00");
		}
		return totalmoney;
	}

	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
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

	public Userbusinessdetail getUserbusinessdetail() {
		return userbusinessdetail;
	}

	public void setUserbusinessdetail(Userbusinessdetail userbusinessdetail) {
		this.userbusinessdetail = userbusinessdetail;
	}

	public List<Userbusinessdetail> getUserbusinessdetaillist() {
		return userbusinessdetaillist;
	}

	public void setUserbusinessdetaillist(
			List<Userbusinessdetail> userbusinessdetaillist) {
		this.userbusinessdetaillist = userbusinessdetaillist;
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

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String[] getOperationReportColumn() {
		return operationReportColumn;
	}

	public void setOperationReportColumn(String[] operationReportColumn) {
		this.operationReportColumn = operationReportColumn;
	}

	public Map<String, String> getExcelmap() {
		return excelmap;
	}

	public void setExcelmap(Map<String, String> excelmap) {
		this.excelmap = excelmap;
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

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public Businesstype getBusinesstype() {
		return businesstype;
	}

	public void setBusinesstype(Businesstype businesstype) {
		this.businesstype = businesstype;
	}

	public String getQuerydatetype() {
		return querydatetype;
	}

	public void setQuerydatetype(String querydatetype) {
		this.querydatetype = querydatetype;
	}

	public String getQueryyear() {
		return queryyear;
	}

	public void setQueryyear(String queryyear) {
		this.queryyear = queryyear;
	}

	public String getQuerymonth() {
		return querymonth;
	}

	public void setQuerymonth(String querymonth) {
		this.querymonth = querymonth;
	}

	public String getQueryday() {
		return queryday;
	}

	public void setQueryday(String queryday) {
		this.queryday = queryday;
	}

	public Integer getBuyerid() {
		return buyerid;
	}

	public void setBuyerid(Integer buyerid) {
		this.buyerid = buyerid;
	}

}
