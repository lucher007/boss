package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 * 用户实体类
 */
public class Authorizehistory extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long id;
	private Integer netid;
	private Integer serverid;
	private String areacode;
	private Integer userid;
	private String versiontype; // CA版本类型(gos_gn,gos_pn)
	private String cardid;
	private String stbno;
	private String commandtype; // CA命令类型指令
	private String conditionaddr;
	private String command;
	private String addtime; // 添加时间
	private String remark;
	private String terminalid;
	private String terminaltype;

	private String usercode; // 用户编码

	/*** 数据库辅助字段 ***/
	private List<Authorizehistory> authorizehistorylist;
	private String querystarttime;
	private String queryendtime;
	private String querycardid;
	private String queryusercode;
	private String queryterminalid;
	private String queryterminaltype;

	public String getQueryterminaltype() {
		return queryterminaltype;
	}

	public void setQueryterminaltype(String queryterminaltype) {
		this.queryterminaltype = queryterminaltype;
	}

	public String getQueryterminalid() {
		return queryterminalid;
	}

	public void setQueryterminalid(String queryterminalid) {
		this.queryterminalid = queryterminalid;
	}

	public String getQuerystarttime() {
		return querystarttime;
	}

	public String getUsercode() {
		return StringUtils.leftPad(String.valueOf(userid), 8, "0");
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

	public String getQuerycardid() {
		return querycardid;
	}

	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

	public String getVersiontype() {
		return versiontype;
	}

	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
	}

	public String getCommandtype() {
		return commandtype;
	}

	public void setCommandtype(String commandtype) {
		this.commandtype = commandtype;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<Authorizehistory> getAuthorizehistorylist() {
		return authorizehistorylist;
	}

	public void setAuthorizehistorylist(List<Authorizehistory> authorizehistorylist) {
		this.authorizehistorylist = authorizehistorylist;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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

	public String getQueryusercode() {
		return queryusercode;
	}

	public void setQueryusercode(String queryusercode) {
		this.queryusercode = queryusercode;
	}

	public String getConditionaddr() {
		return conditionaddr;
	}

	public void setConditionaddr(String conditionaddr) {
		this.conditionaddr = conditionaddr;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

}
