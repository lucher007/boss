package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Userfeedback extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络
	private Integer userid;            //订户ID
	private String type;               //反馈类型（1-意见反馈 ； 2-产品使用反馈）
	private String producttype;	       //产品类型（1-产品；2-业务；3-事件）
	private String productid;		   //产品ID
	private String productname;		   //产品名称
	private String content;		       //反馈内容
	private String mobile;		       //联系电话(type为1时有)
	private String addtime;            //添加时间
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Userfeedback userfeedback;
	private List<Userfeedback> userfeedbacklist;
	
	private String querytype;
	private String queryuserid;
	private String querynetid;
	private Network network;
	private User user;
	
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
	public String getProducttype() {
		return producttype;
	}
	public void setProducttype(String producttype) {
		this.producttype = producttype;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Userfeedback getUserfeedback() {
		return userfeedback;
	}
	public void setUserfeedback(Userfeedback userfeedback) {
		this.userfeedback = userfeedback;
	}
	public List<Userfeedback> getUserfeedbacklist() {
		return userfeedbacklist;
	}
	public void setUserfeedbacklist(List<Userfeedback> userfeedbacklist) {
		this.userfeedbacklist = userfeedbacklist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getQuerytype() {
		return querytype;
	}
	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}
	public String getQueryuserid() {
		return queryuserid;
	}
	public void setQueryuserid(String queryuserid) {
		this.queryuserid = queryuserid;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	
}
