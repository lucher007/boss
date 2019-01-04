package com.gospell.boss.po;
/**
 * 发票实体类：纳税人识别号  纳税人名称
 * @author Administrator
 *
 */
public class UserTaxpayer {
	
	private Integer id;//主键ID
	private Integer userid;//订户ID
	private String taxpayercode;//纳税人识别号
	private String taxpayername;//纳税人识别号
	private String remark;//备注
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getTaxpayercode() {
		return taxpayercode;
	}
	public void setTaxpayercode(String taxpayercode) {
		this.taxpayercode = taxpayercode;
	}
	public String getTaxpayername() {
		return taxpayername;
	}
	public void setTaxpayername(String taxpayername) {
		this.taxpayername = taxpayername;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
}
