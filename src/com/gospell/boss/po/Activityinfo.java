package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Activityinfo extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String type;               //类型（0-文字；1-图片）
	private String title;	           //活动标题
	private String content;		        //活动内容
	private String state;		       //状态(0-失效；1-有效）
	private String remark;             //备注
	
	
	/******************数据库辅助字段*************************/
	private Activityinfo activityinfo;
	private List<Activityinfo> activityinfolist;
	private List<Activityinfopic> activityinfopiclist;
	
	//包含的图片个数
	private Integer activityinfopiccount;
	
	//查询条件
	private String querytitle;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Activityinfo getActivityinfo() {
		return activityinfo;
	}

	public void setActivityinfo(Activityinfo activityinfo) {
		this.activityinfo = activityinfo;
	}

	public List<Activityinfo> getActivityinfolist() {
		return activityinfolist;
	}

	public void setActivityinfolist(List<Activityinfo> activityinfolist) {
		this.activityinfolist = activityinfolist;
	}

	public String getQuerytitle() {
		return querytitle;
	}

	public void setQuerytitle(String querytitle) {
		this.querytitle = querytitle;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<Activityinfopic> getActivityinfopiclist() {
		return activityinfopiclist;
	}

	public void setActivityinfopiclist(List<Activityinfopic> activityinfopiclist) {
		this.activityinfopiclist = activityinfopiclist;
	}

	public Integer getActivityinfopiccount() {
		return activityinfopiccount;
	}

	public void setActivityinfopiccount(Integer activityinfopiccount) {
		this.activityinfopiccount = activityinfopiccount;
	}     
}
