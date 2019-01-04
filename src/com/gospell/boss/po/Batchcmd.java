package com.gospell.boss.po;

import java.util.List;

public class Batchcmd {
	private List<Userproduct> userproductList; //封装订户产品
	private List<String> terminalidlist;       //封装终端ID
	private String versiontype;                //版本类型(gos_gn,gos_pn)
	private List<Usercard> usercardlist;        //订户智能卡List
	private List<Userstb> userstblist;        //订户机顶盒List
	private int netid;                         //所属网络ID
	private Server server;                     //所属服务器
	private int operatorid;                    //操作员ID
	private Operator operator;                 //操作员
	private String businesstypekey;             //业务类型KYE
	private String Businesstypename;            //业务类型名称
	private String content;                     //操作内容
	private String userareacode;                //发卡订户区域号
	private List<Card> cardlist;               //智能卡List
	private List<Stb> stblist;                 //机顶盒List
	
	public List<Userproduct> getUserproductList() {
		return userproductList;
	}
	public void setUserproductList(List<Userproduct> userproductList) {
		this.userproductList = userproductList;
	}
	public List<String> getTerminalidlist() {
		return terminalidlist;
	}
	public void setTerminalidlist(List<String> terminalidlist) {
		this.terminalidlist = terminalidlist;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}
	public int getNetid() {
		return netid;
	}
	public void setNetid(int netid) {
		this.netid = netid;
	}
	public Server getServer() {
		return server;
	}
	public void setServer(Server server) {
		this.server = server;
	}
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	public List<Usercard> getUsercardlist() {
		return usercardlist;
	}
	public void setUsercardlist(List<Usercard> usercardlist) {
		this.usercardlist = usercardlist;
	}
	public List<Userstb> getUserstblist() {
		return userstblist;
	}
	public void setUserstblist(List<Userstb> userstblist) {
		this.userstblist = userstblist;
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
	public String getBusinesstypename() {
		return Businesstypename;
	}
	public void setBusinesstypename(String businesstypename) {
		Businesstypename = businesstypename;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserareacode() {
		return userareacode;
	}
	public void setUserareacode(String userareacode) {
		this.userareacode = userareacode;
	}
	public List<Card> getCardlist() {
		return cardlist;
	}
	public void setCardlist(List<Card> cardlist) {
		this.cardlist = cardlist;
	}
	public List<Stb> getStblist() {
		return stblist;
	}
	public void setStblist(List<Stb> stblist) {
		this.stblist = stblist;
	}
	
}
