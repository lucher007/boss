package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class Problemcomplaint extends BaseField implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String complaintno;
	private Integer netid;
	private String areacode;
	private Integer userid;
	private Integer operatorid;
	private String type;
	private String problemtype;
	private String content;
	private String addtime;
	private String state;
	private String result;
	private String resource;
	private String remark;
	private String complaintcode;

	/****************** 数据库辅助字段 *************************/
	private Problemcomplaint problemcomplaint;
	private List<Problemcomplaint> problemcomplaintlist;
	private Network network;
	private Area area;
	private List<User> userlist;
	private User user;
	private Map<Integer, String> networkmap;
	private Map<String, Integer> usermap;
	private String username;
	private String operatorname;
	private Operator operator;

	private String querynetid;
	private String queryareacode;
	private String queryuserid;
	private String queryoperatorid;
	private String querytype;
	private String queryusername;
	private String queryproblemtype;
	private String queryid;
	private String querystate;
    
	private Problemcomplaintdetail problemcomplaintdetail;
	private List<Problemcomplaintdetail> problemcomplaintdetaillist;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getComplaintno() {
		return complaintno;
	}

	public void setComplaintno(String complaintno) {
		this.complaintno = complaintno;
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

	public Integer getOperatorid() {
		return operatorid;
	}

	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProblemtype() {
		return problemtype;
	}

	public void setProblemtype(String problemtype) {
		this.problemtype = problemtype;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getComplaintcode() {
		return StringUtils.leftPad(String.valueOf(id), 8, "0");
	}

	public void setComplaintcode(String complaintcode) {
		this.complaintcode = complaintcode;
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

	public Network getNetwork() {
		if(network != null){
			return network;
		}else{
			return new Network();
		}
		
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public List<User> getUserlist() {
		return userlist;
	}

	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}

	public User getUser() {
		if(user != null){
			return user;
		}else{
			return new User();
		}
		
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
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

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Map<String, Integer> getUsermap() {
		return usermap;
	}

	public void setUsermap(Map<String, Integer> usermap) {
		this.usermap = usermap;
	}

	public String getQueryproblemtype() {
		return queryproblemtype;
	}

	public void setQueryproblemtype(String queryproblemtype) {
		this.queryproblemtype = queryproblemtype;
	}

	public String getQueryid() {
		return queryid;
	}

	public void setQueryid(String queryid) {
		this.queryid = queryid;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getQueryareacode() {
		return queryareacode;
	}

	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}

	public String getQueryusername() {
		return queryusername;
	}

	public void setQueryusername(String queryusername) {
		this.queryusername = queryusername;
	}

	public Area getArea() {
		if(area!=null){
			return area;
		}else{
			return new Area();
		}
		
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public Problemcomplaintdetail getProblemcomplaintdetail() {
		return problemcomplaintdetail;
	}

	public void setProblemcomplaintdetail(
			Problemcomplaintdetail problemcomplaintdetail) {
		this.problemcomplaintdetail = problemcomplaintdetail;
	}

	public List<Problemcomplaintdetail> getProblemcomplaintdetaillist() {
		return problemcomplaintdetaillist;
	}

	public void setProblemcomplaintdetaillist(
			List<Problemcomplaintdetail> problemcomplaintdetaillist) {
		this.problemcomplaintdetaillist = problemcomplaintdetaillist;
	}

}
