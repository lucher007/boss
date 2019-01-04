package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Role extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String rolecode;	       //角色编号（用于多语言国际化）
	private String rolename;		   //角色名称
	private String type;               //角色类型（0-默认；1-用户添加）
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Role role;
	private List<Role> rolelist;
	
	private Menu meun;
	private List<Menu> menulist;
	private String queryrolecode;
	private String queryrolename;
	
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRolecode() {
		return rolecode;
	}
	public void setRolecode(String rolecode) {
		this.rolecode = rolecode;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public List<Role> getRolelist() {
		return rolelist;
	}
	public void setRolelist(List<Role> rolelist) {
		this.rolelist = rolelist;
	}
	public Menu getMeun() {
		return meun;
	}
	public void setMeun(Menu meun) {
		this.meun = meun;
	}
	public List<Menu> getMenulist() {
		return menulist;
	}
	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getQueryrolecode() {
		return queryrolecode;
	}
	public void setQueryrolecode(String queryrolecode) {
		this.queryrolecode = queryrolecode;
	}
	public String getQueryrolename() {
		return queryrolename;
	}
	public void setQueryrolename(String queryrolename) {
		this.queryrolename = queryrolename;
	}
	
}
