package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;

import com.gospell.boss.common.Tools;

/**
 * 用户实体类
 */
public class BusinessReport extends BaseField implements Serializable {

	private static final long serialVersionUID = 1L;
	private String businesstypekey;
	private Integer count;
	private BigDecimal totalprice;
	private Integer operatorid;
	private Integer netid;
	private List<BusinessReport> businessReportList;
	private String operatorname;
	private String storeid;
	private String productid;
	private String productname;
	private String networkname;
	private String state; // 产品状态
	private Network network;
    
	//开始时间点可以收看该产品的订户总数
	private Integer openingBalance;
	//结束时间点可以收看该产品的订户总数
	private Integer closingBalance;
	//在该时间段之内新购买该产品的用户数
	private Integer entitlementAdded;
	//产品取消订户数
	private Integer entitlementRemoved;
	//授权到期的订户数
	private Integer entitlementExpired;

	@SuppressWarnings("unused")
	private String productcode;
	private Map<String, String> excelMap;
	private String querydate;
	private String querystarttime;
	private String queryendtime;
	
	private String querydatetype;
	private String queryyear;
	private String querymonth;
	private String queryday;

	private String queryareacodevalid;
	
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getBusinesstypekey() {
		return businesstypekey;
	}

	public void setBusinesstypekey(String businesstypekey) {
		this.businesstypekey = businesstypekey;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public BigDecimal getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}

	public Integer getOperatorid() {
		return operatorid;
	}

	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}

	public List<BusinessReport> getBusinessReportList() {
		return businessReportList;
	}

	public void setBusinessReportList(List<BusinessReport> businessReportList) {
		this.businessReportList = businessReportList;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
	}

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}

	public String getQuerymonth() {
		return querymonth;
	}

	public void setQuerymonth(String querymonth) {
		this.querymonth = querymonth;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getStoreid() {
		return storeid;
	}

	public void setStoreid(String storeid) {
		this.storeid = storeid;
	}

	public Network getNetwork() {
		return network;
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public String getProductcode() {
		return StringUtils.leftPad(String.valueOf(productid), 8, "0");
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public Map<String, String> getExcelMap() {
		return excelMap;
	}

	public void setExcelMap(Map<String, String> excelMap) {
		this.excelMap = excelMap;
	}

	public Integer getOpeningBalance() {
		return openingBalance;
	}

	public void setOpeningBalance(Integer openingBalance) {
		this.openingBalance = openingBalance;
	}

	public Integer getClosingBalance() {
		return closingBalance;
	}

	public void setClosingBalance(Integer closingBalance) {
		this.closingBalance = closingBalance;
	}

	public Integer getEntitlementAdded() {
		return entitlementAdded;
	}

	public void setEntitlementAdded(Integer entitlementAdded) {
		this.entitlementAdded = entitlementAdded;
	}

	public Integer getEntitlementRemoved() {
		return entitlementRemoved;
	}

	public void setEntitlementRemoved(Integer entitlementRemoved) {
		this.entitlementRemoved = entitlementRemoved;
	}

	public Integer getEntitlementExpired() {
		return entitlementExpired;
	}

	public void setEntitlementExpired(Integer entitlementExpired) {
		this.entitlementExpired = entitlementExpired;
	}

	public String getQuerystarttime() {
		return querystarttime;
	}

	public void setQuerystarttime(String querystarttime) {
		this.querystarttime = querystarttime;
	}

	public String getQueryendtime() {
		return queryendtime;
	}

	public void setQueryendtime(String queryendtime) {
		this.queryendtime = queryendtime;
	}

	public String getQueryyear() {
		return queryyear;
	}

	public void setQueryyear(String queryyear) {
		this.queryyear = queryyear;
	}

	public String getQueryday() {
		return queryday;
	}

	public void setQueryday(String queryday) {
		this.queryday = queryday;
	}

	public String getQuerydatetype() {
		return querydatetype;
	}

	public void setQuerydatetype(String querydatetype) {
		this.querydatetype = querydatetype;
	}

	public String getQueryareacodevalid() {
		return queryareacodevalid;
	}
	
	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}
	
}
