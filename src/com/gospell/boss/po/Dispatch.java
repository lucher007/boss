package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class Dispatch extends BaseField implements Serializable {

	private static final long serialVersionUID = 45755491181466554L;
	private Integer id;
	private Integer netid;
	private String areacode;                  //区域
	private String dispatchno;                //派工单号
	private Integer complaintid;              //问题投诉ID
	private String complaintno;               //问题投诉单号
	private String problemtype;               //问题类型(1-硬件问题；2-软件问题；0-其他问题)
	private Integer userid;                   //订户ID
	private String adddate;                   //添加时间
	private Integer operatorid;               //操作员ID
	private Integer dispatcherid;             //维修人员id
	private String content;                   //派工内容
	private String dealdate;                  //处理时间
	private String dealresult;                //处理结果
	private String state;                     //状态（0-未派单；1-已派单；2-处理中；3-已处理；4-处理失败； 5-结单）
	private String remark;

	/****************** 数据库辅助字段 *************************/

	private User user;
	private Problemcomplaint problemcomplaint;
	private List<Problemcomplaint> problemcomplaintlist;
	private List<Dispatch> dispatchlist;
	private Network network;
	private Map<Integer, String> networkmap;
	private Area area;
	private Map<Integer, String> areamap;
	private String jumping;
	private Dispatch dispatch;
	private String operatorname;
	private String dispatchcode;
	private String complaintcode;

	private String queryproblemtype;
	private String queryusername;
	private String queryoperatorname;
	private String queryid;
	private String querynetid;
	private String queryareacode;
	private String querystate;
	private Integer querydispatcherid;
	private Operator worker;//维修人员

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

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public Map<Integer, String> getAreamap() {
		return areamap;
	}

	public void setAreamap(Map<Integer, String> areamap) {
		this.areamap = areamap;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDispatchno() {
		return dispatchno;
	}

	public void setDispatchno(String dispatchno) {
		this.dispatchno = dispatchno;
	}

	public Integer getComplaintid() {
		return complaintid;
	}

	public void setComplaintid(Integer complaintid) {
		this.complaintid = complaintid;
	}

	public String getComplaintno() {
		return complaintno;
	}

	public void setComplaintno(String complaintno) {
		this.complaintno = complaintno;
	}

	public String getProblemtype() {
		return problemtype;
	}

	public void setProblemtype(String problemtype) {
		this.problemtype = problemtype;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getAdddate() {
		return adddate;
	}

	public void setAdddate(String adddate) {
		this.adddate = adddate;
	}

	public Integer getOperatorid() {
		return operatorid;
	}

	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}

	public Integer getDispatcherid() {
		return dispatcherid;
	}

	public void setDispatcherid(Integer dispatcherid) {
		this.dispatcherid = dispatcherid;
	}

	public String getDealdate() {
		return dealdate;
	}

	public void setDealdate(String dealdate) {
		this.dealdate = dealdate;
	}

	public String getDealresult() {
		return dealresult;
	}

	public void setDealresult(String dealresult) {
		this.dealresult = dealresult;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Problemcomplaint getProblemcomplaint() {
		return problemcomplaint;
	}

	public void setProblemcomplaint(Problemcomplaint problemcomplaint) {
		this.problemcomplaint = problemcomplaint;
	}

	public List<Problemcomplaint> getProblemcomplaintlist() {
		return problemcomplaintlist;
	}

	public void setProblemcomplaintlist(List<Problemcomplaint> problemcomplaintlist) {
		this.problemcomplaintlist = problemcomplaintlist;
	}

	public List<Dispatch> getDispatchlist() {
		return dispatchlist;
	}

	public void setDispatchlist(List<Dispatch> dispatchlist) {
		this.dispatchlist = dispatchlist;
	}

	public Dispatch getDispatch() {
		return dispatch;
	}

	public void setDispatch(Dispatch dispatch) {
		this.dispatch = dispatch;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
	}

	public String getDispatchcode() {
		return StringUtils.leftPad(String.valueOf(id), 8, "0");
	}

	public void setDispatchcode(String dispatchcode) {
		this.dispatchcode = dispatchcode;
	}

	public String getQueryproblemtype() {
		return queryproblemtype;
	}

	public void setQueryproblemtype(String queryproblemtype) {
		this.queryproblemtype = queryproblemtype;
	}

	public String getQueryusername() {
		return queryusername;
	}

	public void setQueryusername(String queryusername) {
		this.queryusername = queryusername;
	}

	public String getQueryoperatorname() {
		return queryoperatorname;
	}

	public void setQueryoperatorname(String queryoperatorname) {
		this.queryoperatorname = queryoperatorname;
	}

	public String getQueryid() {
		return queryid;
	}

	public void setQueryid(String queryid) {
		this.queryid = queryid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getComplaintcode() {
		return StringUtils.leftPad(String.valueOf(complaintid), 8, "0");
	}

	public void setComplaintcode(String complaintcode) {
		this.complaintcode = complaintcode;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
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

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

	public String getJumping() {
		return jumping;
	}

	public void setJumping(String jumping) {
		this.jumping = jumping;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Operator getWorker() {
		return worker;
	}

	public void setWorker(Operator worker) {
		this.worker = worker;
	}

	public Integer getQuerydispatcherid() {
		return querydispatcherid;
	}

	public void setQuerydispatcherid(Integer querydispatcherid) {
		this.querydispatcherid = querydispatcherid;
	}

}
