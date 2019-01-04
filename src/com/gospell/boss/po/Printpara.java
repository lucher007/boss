package com.gospell.boss.po;

import java.io.Serializable;

/**
 * 用户实体类
 */
public class Printpara extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String code;
	private String name;
	private String remark;
	
	/* 数 据 库 辅 助 字 段 */

	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
