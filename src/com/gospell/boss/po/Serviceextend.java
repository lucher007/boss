package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Serviceextend extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String serviceid;
	private Integer netid;

	private String webflag;
	private String rank;
	private String description;
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
	public String getServiceid() {
		return serviceid;
	}
	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getWebflag() {
		return webflag;
	}
	public void setWebflag(String webflag) {
		this.webflag = webflag;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
