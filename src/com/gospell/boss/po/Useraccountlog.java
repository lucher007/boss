package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Useraccountlog extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private Integer userid;            //订户ID
	private String type;               //类型（0-入账；1-出账）
	private BigDecimal money;          //金额
	private Integer operatorid;	       //操作员ID
	private String addtime;            //操作日期
	private String source;		       //操作类型(0-BOSS;1-MPS;2-代付款)
	private String businesstypekey;    //业务类型（rechargeaccount-账户充值；giftcardpayment-充值卡充值；scorerecharge-积分充值）
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Useraccountlog useraccountlog;
	private List<Useraccountlog> useraccountloglist;
	private Operator operator;
	
	//查询条件
	private String querytype;  //类型

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public Integer getOperatorid() {
		return operatorid;
	}

	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
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

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Useraccountlog getUseraccountlog() {
		return useraccountlog;
	}

	public void setUseraccountlog(Useraccountlog useraccountlog) {
		this.useraccountlog = useraccountlog;
	}

	public List<Useraccountlog> getUseraccountloglist() {
		return useraccountloglist;
	}

	public void setUseraccountloglist(List<Useraccountlog> useraccountloglist) {
		this.useraccountloglist = useraccountloglist;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public String getBusinesstypekey() {
		return businesstypekey;
	}

	public void setBusinesstypekey(String businesstypekey) {
		this.businesstypekey = businesstypekey;
	}
	
}
