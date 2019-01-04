package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Product extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 数据库ID
	private Integer netid; // 所属网络ID
	private String productid; // 产品ID
	private String productname; // 产品名称
	private String producttype; // 产品类型（1-数字电视；2-广播；3-数据业务）
	private BigDecimal pricepermonth; // 包月价格
	private BigDecimal priceperday; // 每天价格
	private String extendflag; // 是否推广（0-否；1-是）
	private String state; // 状态（0-无效；1-有效）
	private BigDecimal subpricepermonth; //副机包月价格
	private BigDecimal subpriceperday; //副机每天价格
	private String remark; // 备注

	/****************** 数据库辅助字段 *************************/
	private Product product;
	private List<Product> productlist;
	private Network network;
	private Map<Integer, String> networkmap;

	private List<Service> servicelist;
	private List<Productserviceref> reflist;

	private String queryproductname;
	private String queryproductid;
	private String querynetid;
	private String querystate;

	private String cardid; // 购买产品的智能卡号
	private String stbno; // 购买产品的机顶盒号
	private String starttime; // 授权开始时间
	private String endtime; // 授权结束时间
	private Integer buyamount; // 购买授权月数
	private String unit;//购买方式
	private BusinessReport businessReport;
	private Integer extendinfocount;
	private List<Productextend> productextendlist;
	private Integer productetendid;
	private String mothercardflag; //主副机标志（0-主机；1-子机）
	private String mothercardid;  //主机号
	
	private List<Network> networklist;
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public String getProductid() {
		return productid;
	}

	public void setProductid(String productid) {
		this.productid = productid;
	}

	public String getProducttype() {
		return producttype;
	}

	public void setProducttype(String producttype) {
		this.producttype = producttype;
	}

	public String getExtendflag() {
		return extendflag;
	}

	public void setExtendflag(String extendflag) {
		this.extendflag = extendflag;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public List<Product> getProductlist() {
		return productlist;
	}

	public void setProductlist(List<Product> productlist) {
		this.productlist = productlist;
	}

	public Network getNetwork() {
		return network;
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public String getQueryproductname() {
		return queryproductname;
	}

	public void setQueryproductname(String queryproductname) {
		this.queryproductname = queryproductname;
	}

	public String getQueryproductid() {
		return queryproductid;
	}

	public void setQueryproductid(String queryproductid) {
		this.queryproductid = queryproductid;
	}

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

	public String getQuerystate() {
		return querystate;
	}

	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public List<Service> getServicelist() {
		return servicelist;
	}

	public void setServicelist(List<Service> servicelist) {
		this.servicelist = servicelist;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public BigDecimal getPricepermonth() {
		return pricepermonth;
	}

	public void setPricepermonth(BigDecimal pricepermonth) {
		this.pricepermonth = pricepermonth;
	}

	public BigDecimal getPriceperday() {
		return priceperday;
	}

	public void setPriceperday(BigDecimal priceperday) {
		this.priceperday = priceperday;
	}

	public BusinessReport getBusinessReport() {
		return businessReport;
	}

	public void setBusinessReport(BusinessReport businessReport) {
		this.businessReport = businessReport;
	}

	public Integer getExtendinfocount() {
		return extendinfocount;
	}

	public void setExtendinfocount(Integer extendinfocount) {
		this.extendinfocount = extendinfocount;
	}

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
	}

	public List<Productserviceref> getReflist() {
		return reflist;
	}

	public void setReflist(List<Productserviceref> reflist) {
		this.reflist = reflist;
	}

	public List<Productextend> getProductextendlist() {
		return productextendlist;
	}

	public void setProductextendlist(List<Productextend> productextendlist) {
		this.productextendlist = productextendlist;
	}

	public Integer getProductetendid() {
		return productetendid;
	}

	public void setProductetendid(Integer productetendid) {
		this.productetendid = productetendid;
	}

	public Integer getBuyamount() {
		return buyamount;
	}

	public void setBuyamount(Integer buyamount) {
		this.buyamount = buyamount;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public List<Network> getNetworklist() {
		return networklist;
	}

	public void setNetworklist(List<Network> networklist) {
		this.networklist = networklist;
	}

	public BigDecimal getSubpricepermonth() {
		return subpricepermonth;
	}

	public void setSubpricepermonth(BigDecimal subpricepermonth) {
		this.subpricepermonth = subpricepermonth;
	}

	public BigDecimal getSubpriceperday() {
		return subpriceperday;
	}

	public void setSubpriceperday(BigDecimal subpriceperday) {
		this.subpriceperday = subpriceperday;
	}

	public String getMothercardflag() {
		return mothercardflag;
	}

	public void setMothercardflag(String mothercardflag) {
		this.mothercardflag = mothercardflag;
	}

	public String getMothercardid() {
		return mothercardid;
	}

	public void setMothercardid(String mothercardid) {
		this.mothercardid = mothercardid;
	}

	

}
