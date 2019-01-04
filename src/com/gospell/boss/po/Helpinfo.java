package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Helpinfo extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String question;       //问题内容
	private String answer;	       //解决方法
	private String type;		   //类型（0-常见问题 1-其他问题）
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Helpinfo helpinfo;
	private List<Helpinfo> helpinfolist;
	
	
	private String querytype;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getAnswer() {
		return answer;
	}


	public void setAnswer(String answer) {
		this.answer = answer;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Helpinfo getHelpinfo() {
		return helpinfo;
	}


	public void setHelpinfo(Helpinfo helpinfo) {
		this.helpinfo = helpinfo;
	}


	public List<Helpinfo> getHelpinfolist() {
		return helpinfolist;
	}


	public void setHelpinfolist(List<Helpinfo> helpinfolist) {
		this.helpinfolist = helpinfolist;
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


	public String getQuestion() {
		return question;
	}


	public void setQuestion(String question) {
		this.question = question;
	}
	
	
}
