package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
/**
 * 用户实体类
 */
public class Userlevel extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String levelname;        //级别名称
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Userlevel userlevel;
	private List<Userlevel> userlevellist;
	private String querylevelname;
	private String productJson;//订户级别关联的产品信息JSON
	
	private List<Product> productlist;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLevelname() {
		return levelname;
	}
	public void setLevelname(String levelname) {
		this.levelname = levelname;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Userlevel getUserlevel() {
		return userlevel;
	}
	public void setUserlevel(Userlevel userlevel) {
		this.userlevel = userlevel;
	}
	public List<Userlevel> getUserlevellist() {
		return userlevellist;
	}
	public void setUserlevellist(List<Userlevel> userlevellist) {
		this.userlevellist = userlevellist;
	}
	public String getQuerylevelname() {
		return querylevelname;
	}
	public void setQuerylevelname(String querylevelname) {
		this.querylevelname = querylevelname;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public List<Product> getProductlist() {
		return productlist;
	}
	public void setProductlist(List<Product> productlist) {
		this.productlist = productlist;
	}
	public String getProductJson() {
		return productJson;
	}
	public void setProductJson(String productJson) {
		this.productJson = productJson;
	}
	
	
	
	
}
