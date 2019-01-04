package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;

/**
 * 用户实体类
 */
public class Rolemenuref extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private Integer roleid; // 角色编号（用于多语言国际化）
	private Integer meunuid; // 角色名称
	private String remark; // 角色类型（0-默认；1-用户添加）

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleid() {
		return roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}

	public Integer getMeunuid() {
		return meunuid;
	}

	public void setMeunuid(Integer meunuid) {
		this.meunuid = meunuid;
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
