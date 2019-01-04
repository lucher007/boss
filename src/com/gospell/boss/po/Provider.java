package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
/**
 * 用户实体类
 */
public class Provider extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String companyname;        //公司名称
	private String model;              //规格型号
	private String type;               //类型(0-机顶盒；1-智能卡)
	private BigDecimal mainprice;      //主终端价格
	private BigDecimal subprice;       //副终端价格
	private String address;            //公司地址
	private String repairaddress;	   //维修地址
	private String factoryaddress;	   //厂房地址
	private String businesscontactername;        //商务联系人姓名
	private String businesscontactertelephone;   //商务联系人电话
	private String businesscontacteremail;       //商务联系人邮件
	private String technicalcontactername;       //技术联系人姓名
	private String technicalcontactertelephone;  //技术联系人电话
	private String technicalcontacteremail;      //技术联系人邮件
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Provider provider;
	private List<Provider> providerlist;
	
	private String querycompanyname;
	private String querymodel;
	private String querytype;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRepairaddress() {
		return repairaddress;
	}
	public void setRepairaddress(String repairaddress) {
		this.repairaddress = repairaddress;
	}
	public String getFactoryaddress() {
		return factoryaddress;
	}
	public void setFactoryaddress(String factoryaddress) {
		this.factoryaddress = factoryaddress;
	}
	public String getBusinesscontactername() {
		return businesscontactername;
	}
	public void setBusinesscontactername(String businesscontactername) {
		this.businesscontactername = businesscontactername;
	}
	public String getBusinesscontactertelephone() {
		return businesscontactertelephone;
	}
	public void setBusinesscontactertelephone(String businesscontactertelephone) {
		this.businesscontactertelephone = businesscontactertelephone;
	}
	public String getTechnicalcontactername() {
		return technicalcontactername;
	}
	public void setTechnicalcontactername(String technicalcontactername) {
		this.technicalcontactername = technicalcontactername;
	}
	public String getTechnicalcontactertelephone() {
		return technicalcontactertelephone;
	}
	public void setTechnicalcontactertelephone(String technicalcontactertelephone) {
		this.technicalcontactertelephone = technicalcontactertelephone;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Provider getProvider() {
		return provider;
	}
	public void setProvider(Provider provider) {
		this.provider = provider;
	}
	public List<Provider> getProviderlist() {
		return providerlist;
	}
	public void setProviderlist(List<Provider> providerlist) {
		this.providerlist = providerlist;
	}
	public String getBusinesscontacteremail() {
		return businesscontacteremail;
	}
	public void setBusinesscontacteremail(String businesscontacteremail) {
		this.businesscontacteremail = businesscontacteremail;
	}
	public String getTechnicalcontacteremail() {
		return technicalcontacteremail;
	}
	public void setTechnicalcontacteremail(String technicalcontacteremail) {
		this.technicalcontacteremail = technicalcontacteremail;
	}
	public String getQuerycompanyname() {
		return querycompanyname;
	}
	public void setQuerycompanyname(String querycompanyname) {
		this.querycompanyname = querycompanyname;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public BigDecimal getMainprice() {
		return mainprice;
	}
	public void setMainprice(BigDecimal mainprice) {
		this.mainprice = mainprice;
	}
	public BigDecimal getSubprice() {
		return subprice;
	}
	public void setSubprice(BigDecimal subprice) {
		this.subprice = subprice;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getQuerymodel() {
		return querymodel;
	}
	public void setQuerymodel(String querymodel) {
		this.querymodel = querymodel;
	}
	public String getQuerytype() {
		return querytype;
	}
	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}
	
	
}
