package com.gospell.boss.po;

import java.io.Serializable;

/**
 * 基础实体类
 * @author tangsh
 *
 */
public class BaseField implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String returninfo;
	private String returnurl;
	private String flag;
	
	private int returncode;
	private int pager_count;
	private int pager_offset;
	private int pager_openset;
	private int pager_visit;
	
	//easyui 分页参数
	private int page; // 当前页数  
	private int rows; // 每页显示行数  
	private int page_start; //每次查询开始数
	private int total;  //总数
	
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getReturnurl() {
		return returnurl;
	}
	public void setReturnurl(String returnurl) {
		this.returnurl = returnurl;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pager_count) {
		this.pager_count = pager_count;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pager_offset) {
		this.pager_offset = pager_offset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pager_openset) {
		this.pager_openset = pager_openset;
	}
	public int getPager_visit() {
		return pager_visit;
	}
	public void setPager_visit(int pager_visit) {
		this.pager_visit = pager_visit;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPage_start() {
		return (page - 1) * rows;
	}
	public void setPage_start(int page_start) {
		this.page_start = page_start;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
