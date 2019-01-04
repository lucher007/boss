package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;

/**
 * 用户实体类
 */
public class Authorize extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;
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
	private String state; // 状态（0-未发送；1-发送失败）
	private String result; // 返回结果（保存发送失败返回结果）
	private String addtime; // 添加时间
	private String remark;
	private String terminalid;
	private String terminaltype;
	
	
	/*** 数据库辅助字段 ***/
	private String queryversiontype;
	private String querystate;

	private String querynetid;
	private List<Authorize> authorizelist;

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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public List<Authorize> getAuthorizelist() {
		return authorizelist;
	}

	public void setAuthorizelist(List<Authorize> authorizelist) {
		this.authorizelist = authorizelist;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
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

	public String getConditionaddr() {
		return conditionaddr;
	}

	public void setConditionaddr(String conditionaddr) {
		this.conditionaddr = conditionaddr;
	}

	public String getQueryversiontype() {
		return queryversiontype;
	}

	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

}
