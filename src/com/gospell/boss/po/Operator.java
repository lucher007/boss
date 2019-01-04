package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.gospell.boss.common.Tools;

/**
 * 用户实体类
 */
public class Operator extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private String loginname; // 登录账号
	private String password; // 登录密码
	private Integer netid; // 所属网络
	private String areacode; //所属区域编码
	private Integer storeid; // 所属营业厅
	private String operatorcode; // 操作员编号
	private String operatorname; // 操作员姓名
	private String operatortype; // 操作员类型（0-超级管理人员；1-操作员;2-施工人员;3-管理人员）
	private String operatorlevel; // 操作员级别（0-系统级别；1-网络级别；2-区域级别）
	private String documenttype; // 证件类型
	private String documentno; // 证件号码
	private String email; // 电子邮件
	private String address; // 地址
	private String telephone; // 固话
	private String mobile; // 移动电话
	private String addtime; // 添加时间
	private String state; // 操作员状态(0:无效、1:有效)
	private String remark; // 备注

	private Operator operator;
	private List<Operator> operatorlist;

	private Menu menu;
	private List<Menu> menulist;
    
	private Store store;
	private List<Store> storelist;
	private Map<Integer, String> storemap;

	private Network network;
	private Area area;
	private List<Network> networklist;
	private Map<Integer, String> networkmap;
	private Map<Integer, String> rolemap;

	/****************** 页面查询条件辅助字段 *************************/
	private int rember; // 是否记住密码
	private String logincode; // 登录验证码
	private String confirmpassword; // 确认密码
	private String queryloginname; // 登录密码查询
	private String queryoperatorname; // 操作员姓名查询
	private String querynetid; // 所属网络
	private String queryareacode; // 所属区域
	private String querystoreid; // 所属营业厅
	private String queryoperatorcode; // 操作员编号
	private String querystate; // 操作员状态
	private String queryoperatortype; //操作员类型查询
	private String queryoperatorlevel;  //操作员级别查询

	private User user; // 操作的订户对象
	private String jumping; // 跳转标识符
	private Integer roleid;
    private String queryareacodevalid;//区域有效位
	/*******************************************/
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOperatorcode() {
		return StringUtils.leftPad(String.valueOf(id), 8, "0");
	}

	public void setOperatorcode(String operatorcode) {
		this.operatorcode = operatorcode;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
	}

	public String getOperatortype() {
		return operatortype;
	}

	public void setOperatortype(String operatortype) {
		this.operatortype = operatortype;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getDocumenttype() {
		return documenttype;
	}

	public void setDocumenttype(String documenttype) {
		this.documenttype = documenttype;
	}

	public String getDocumentno() {
		return documentno;
	}

	public void setDocumentno(String documentno) {
		this.documentno = documentno;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public List<Operator> getOperatorlist() {
		return operatorlist;
	}

	public void setOperatorlist(List<Operator> operatorlist) {
		this.operatorlist = operatorlist;
	}

	public int getRember() {
		return rember;
	}

	public void setRember(int rember) {
		this.rember = rember;
	}

	public String getLogincode() {
		return logincode;
	}

	public void setLogincode(String logincode) {
		this.logincode = logincode;
	}

	public String getQueryloginname() {
		return queryloginname;
	}

	public void setQueryloginname(String queryloginname) {
		this.queryloginname = queryloginname;
	}

	public String getQueryoperatorname() {
		return queryoperatorname;
	}

	public void setQueryoperatorname(String queryoperatorname) {
		this.queryoperatorname = queryoperatorname;
	}

	public String getConfirmpassword() {
		return confirmpassword;
	}

	public void setConfirmpassword(String confirmpassword) {
		this.confirmpassword = confirmpassword;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public List<Menu> getMenulist() {
		return menulist;
	}

	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public Integer getStoreid() {
		return storeid;
	}

	public void setStoreid(Integer storeid) {
		this.storeid = storeid;
	}

	public String getQuerystoreid() {
		return querystoreid;
	}

	public void setQuerystoreid(String querystoreid) {
		this.querystoreid = querystoreid;
	}

	public String getQueryoperatorcode() {
		return queryoperatorcode;
	}

	public void setQueryoperatorcode(String queryoperatorcode) {
		this.queryoperatorcode = queryoperatorcode;
	}

	public Store getStore() {
		return store;
	}

	public void setStore(Store store) {
		this.store = store;
	}

	public List<Store> getStorelist() {
		return storelist;
	}

	public void setStorelist(List<Store> storelist) {
		this.storelist = storelist;
	}

	public Map<Integer, String> getStoremap() {
		return storemap;
	}

	public void setStoremap(Map<Integer, String> storemap) {
		this.storemap = storemap;
	}

	public Network getNetwork() {
		return network;
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public List<Network> getNetworklist() {
		return networklist;
	}

	public void setNetworklist(List<Network> networklist) {
		this.networklist = networklist;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getJumping() {
		return jumping;
	}

	public void setJumping(String jumping) {
		this.jumping = jumping;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

	public Map<Integer, String> getRolemap() {
		return rolemap;
	}

	public void setRolemap(Map<Integer, String> rolemap) {
		this.rolemap = rolemap;
	}

	public Integer getRoleid() {
		return roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}

	public String getQueryoperatortype() {
		return queryoperatortype;
	}

	public void setQueryoperatortype(String queryoperatortype) {
		this.queryoperatortype = queryoperatortype;
	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getOperatorlevel() {
		return operatorlevel;
	}

	public void setOperatorlevel(String operatorlevel) {
		this.operatorlevel = operatorlevel;
	}

	public String getQueryareacode() {
		return queryareacode;
	}

	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getQueryoperatorlevel() {
		return queryoperatorlevel;
	}

	public void setQueryoperatorlevel(String queryoperatorlevel) {
		this.queryoperatorlevel = queryoperatorlevel;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

	public String getQueryareacodevalid() {
		return Tools.getAreacodeValid(queryareacode);
	}

	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}

	
	
	

}
