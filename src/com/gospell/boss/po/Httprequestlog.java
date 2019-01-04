package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;

import com.gospell.boss.po.BaseField;

public class Httprequestlog extends BaseField implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id; // ID主键
	private String requesturl; // 请求URL
	private String requestparam; // 请求参数
	private String result; // 请求结果
	private String addtime;
	private String remark; // 备注
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRequesturl() {
		return requesturl;
	}

	public void setRequesturl(String requesturl) {
		this.requesturl = requesturl;
	}

	public String getRequestparam() {
		return requestparam;
	}

	public void setRequestparam(String requestparam) {
		this.requestparam = requestparam;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
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

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}


}
