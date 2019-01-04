package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Systempara extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;               //数据库ID
	private String name;              //参数名称
	private String code;              //参数编码
	private String value;             //参数值
	private String state;             //状态(1有效；0无效）
	private String remark;            //备注
	
	/******************数据库辅助字段*************************/
	private Systempara systempara;
	private List<Systempara> systemparalist;
	
	private String querycode;
	private String querystate;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Systempara getSystempara() {
		return systempara;
	}
	public void setSystempara(Systempara systempara) {
		this.systempara = systempara;
	}
	public List<Systempara> getSystemparalist() {
		return systemparalist;
	}
	public void setSystemparalist(List<Systempara> systemparalist) {
		this.systemparalist = systemparalist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getQuerycode() {
		return querycode;
	}
	public void setQuerycode(String querycode) {
		this.querycode = querycode;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	
	
	
}
