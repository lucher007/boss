package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class Problemcomplaintdetail extends BaseField implements Serializable {

	
	private static final long serialVersionUID = -4869572351726017637L;

	private Integer id;
	private Integer complaintid;
	private Integer complaintno;
	private Integer netid;
	private String type;
	private String filename;
	private String preservefilename;
	private String preserveurl;
	private String remark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getComplaintid() {
		return complaintid;
	}

	public void setComplaintid(Integer complaintid) {
		this.complaintid = complaintid;
	}

	public Integer getComplaintno() {
		return complaintno;
	}

	public void setComplaintno(Integer complaintno) {
		this.complaintno = complaintno;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
