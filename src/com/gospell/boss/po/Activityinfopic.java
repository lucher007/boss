package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Activityinfopic extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer activityinfoid;    //活动信息ID
	private String filename;		   //原文件名
	private String preservefilename;   //活动内容
	private String preserveurl;		   //服务器存放地址
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Activityinfopic activityinfopic;
	private List<Activityinfopic> activityinfopiclist;
	
	private String title;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getActivityinfoid() {
		return activityinfoid;
	}
	public void setActivityinfoid(Integer activityinfoid) {
		this.activityinfoid = activityinfoid;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getPreservefilename() {
		return preservefilename;
	}
	public void setPreservefilename(String preservefilename) {
		this.preservefilename = preservefilename;
	}
	public String getPreserveurl() {
		return preserveurl;
	}
	public void setPreserveurl(String preserveurl) {
		this.preserveurl = preserveurl;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Activityinfopic getActivityinfopic() {
		return activityinfopic;
	}
	public void setActivityinfopic(Activityinfopic activityinfopic) {
		this.activityinfopic = activityinfopic;
	}
	public List<Activityinfopic> getActivityinfopiclist() {
		return activityinfopiclist;
	}
	public void setActivityinfopiclist(List<Activityinfopic> activityinfopiclist) {
		this.activityinfopiclist = activityinfopiclist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
