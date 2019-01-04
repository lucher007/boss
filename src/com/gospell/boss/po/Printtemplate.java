package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Printtemplate extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String code;
	private String name;
	private String value;
	private String addtime;
	private String remark;

	/* 数据库辅助字段 */
	private String querycode;
	private String queryname;
	private List<Printtemplate> printtemplatelist;
	private Map<Integer, String> printParaMap;
	private Map<String, String> templateMap;
	private Printtemplate printtemplate;

	/* 页面辅助字段 */
	private String width;
	private String height;
	private String image;
	private String parameters;

	
	
	
	
	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getParameters() {
		return parameters;
	}

	public void setParameters(String parameters) {
		this.parameters = parameters;
	}

	public String getQuerycode() {
		return querycode;
	}

	public void setQuerycode(String querycode) {
		this.querycode = querycode;
	}

	public String getQueryname() {
		return queryname;
	}

	public void setQueryname(String queryname) {
		this.queryname = queryname;
	}

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

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
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

	public List<Printtemplate> getPrinttemplatelist() {
		return printtemplatelist;
	}

	public void setPrinttemplatelist(List<Printtemplate> printtemplatelist) {
		this.printtemplatelist = printtemplatelist;
	}

	public Map<Integer, String> getPrintParaMap() {
		return printParaMap;
	}

	public void setPrintParaMap(Map<Integer, String> printParaMap) {
		this.printParaMap = printParaMap;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Printtemplate getPrinttemplate() {
		return printtemplate;
	}

	public void setPrinttemplate(Printtemplate printtemplate) {
		this.printtemplate = printtemplate;
	}

	public Map<String, String> getTemplateMap() {
		return templateMap;
	}

	public void setTemplateMap(Map<String, String> templateMap) {
		this.templateMap = templateMap;
	}



}
