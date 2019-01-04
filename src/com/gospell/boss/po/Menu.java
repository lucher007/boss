package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;

/**
 * 用户实体类
 */
public class Menu extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private Integer pid; // 父ID
	private String menutype; // 菜单级别
	private Double menuorder; // 登录顺序
	private String menuname; // 菜单名称
	private String menucode; // 菜单编码（用于多语言国际化）
	private String state; // 菜单状态(0:无效、1:有效)
	private String menuurl; // 菜单链接地址URL
	private String remark; // 备注

	private Menu menu;
	private List<Menu> menulist;
	private List<Menu> secondmenulist; // 二级菜单
	private Integer roleid;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMenutype() {
		return menutype;
	}

	public void setMenutype(String menutype) {
		this.menutype = menutype;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public String getMenucode() {
		return menucode;
	}

	public void setMenucode(String menucode) {
		this.menucode = menucode;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getMenuurl() {
		return menuurl;
	}

	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public List<Menu> getMenulist() {
		return menulist;
	}

	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public List<Menu> getSecondmenulist() {
		return secondmenulist;
	}

	public void setSecondmenulist(List<Menu> secondmenulist) {
		this.secondmenulist = secondmenulist;
	}

	public Double getMenuorder() {
		return menuorder;
	}

	public void setMenuorder(Double menuorder) {
		this.menuorder = menuorder;
	}

	public Integer getRoleid() {
		return roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}

	/****************** 数据库辅助字段 *************************/

}
