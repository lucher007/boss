package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Service extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String serviceid;	       //业务ID
	private String servicename;		   //业务名称
	private String servicetype;        //业务类型
	private String chargetype;         //计费类型（是否允许单独购买。0-不允许单独购买；1-允许单独购买）
	private BigDecimal pricepermonth;  //包月价格
	private BigDecimal priceperday;    //每天价格
	private String unit;               //单位（年/月/周/日/小时/个）
	private String extendflag;         //是否推广（0-否；1-是）
	private String state;              //状态（0-无效；1-有效）
	private BigDecimal subpricepermonth; //副机包月价格
	private BigDecimal subpriceperday; //副机每天价格
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Service service;
	private List<Service> servicelist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private boolean belongproduct;       // 是否已经属于某个产品
	
	private String queryservicename;
	private String queryserviceid;
	private String querynetid;
	private String querystate;
	private Integer extendinfocount;
	private List<Serviceextend> serviceextendlist;
	
	private Integer serviceetendid;
	
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
	public String getServiceid() {
		return serviceid;
	}
	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public String getServicetype() {
		return servicetype;
	}
	public void setServicetype(String servicetype) {
		this.servicetype = servicetype;
	}
	public String getChargetype() {
		return chargetype;
	}
	public void setChargetype(String chargetype) {
		this.chargetype = chargetype;
	}
	public String getExtendflag() {
		return extendflag;
	}
	public void setExtendflag(String extendflag) {
		this.extendflag = extendflag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public List<Service> getServicelist() {
		return servicelist;
	}
	public void setServicelist(List<Service> servicelist) {
		this.servicelist = servicelist;
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
	public String getQueryservicename() {
		return queryservicename;
	}
	public void setQueryservicename(String queryservicename) {
		this.queryservicename = queryservicename;
	}
	public String getQueryserviceid() {
		return queryserviceid;
	}
	public void setQueryserviceid(String queryserviceid) {
		this.queryserviceid = queryserviceid;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
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
	public boolean isBelongproduct() {
		return belongproduct;
	}
	public void setBelongproduct(boolean belongproduct) {
		this.belongproduct = belongproduct;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Integer getExtendinfocount() {
		return extendinfocount;
	}
	public void setExtendinfocount(Integer extendinfocount) {
		this.extendinfocount = extendinfocount;
	}
	public List<Serviceextend> getServiceextendlist() {
		return serviceextendlist;
	}
	public void setServiceextendlist(List<Serviceextend> serviceextendlist) {
		this.serviceextendlist = serviceextendlist;
	}
	public Integer getServiceetendid() {
		return serviceetendid;
	}
	public void setServiceetendid(Integer serviceetendid) {
		this.serviceetendid = serviceetendid;
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
	
}
