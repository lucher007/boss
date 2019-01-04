package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.gospell.boss.common.Tools;
/**
 * 用户实体类
 */
public class Userstb extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String  areacode;          //所属区域号
	private Integer userid;	           //订户ID
	private Integer serverid;          //所属CAS服务器的ID
	private String stbno;		       //机顶盒号
	private String incardflag;         //是否内置卡(0-外置卡；1-内置卡；2-无卡）
	private String addtime;            //购买时间
	private String mothercardflag;     //主副机标志（0-主机；1-子机）
	private String mothercardid;       //母卡机顶盒号
	private String state;              //状态（0-报停；1：使用 ；2：维修 ；3：损坏；）
	private BigDecimal price;          //价格
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private String queryuserid;
	private String querystbno;
	private String querystate;
	private String querynetid;
	private String queryareacode;
	private String queryareacodevalid;
	private String queryserverid;
	private String stbnos;
	
	private Userstb userstb;
	private List<Userstb> userstblist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String replacestbno;    //更换新的机顶盒号
	
	private String servername;      //所属CAS服务器名称
	private String versiontype;     //版本类型
	
	private List<Userstb> matherOrSonStbList; //母机或子机列表
	
	private List<Usercard> bingUsercardList;      //绑定的智能卡
	private List<Userproduct> userproductList;    //机顶盒购买的产品
	private String rechargemoney;  //充值金额
	
	private String buycardflag; //该机顶盒是否已购买智能卡（0-未购买；1-已购买）
	private String paircardflag;//该机顶盒在库存中是否有配对智能卡（0-未配对；1-已配对）
	
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getIncardflag() {
		return incardflag;
	}
	public void setIncardflag(String incardflag) {
		this.incardflag = incardflag;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getMothercardflag() {
		return mothercardflag;
	}
	public void setMothercardflag(String mothercardflag) {
		this.mothercardflag = mothercardflag;
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
	public Userstb getUserstb() {
		return userstb;
	}
	public void setUserstb(Userstb userstb) {
		this.userstb = userstb;
	}
	public List<Userstb> getUserstblist() {
		return userstblist;
	}
	public void setUserstblist(List<Userstb> userstblist) {
		this.userstblist = userstblist;
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
	public String getQueryuserid() {
		return queryuserid;
	}
	public void setQueryuserid(String queryuserid) {
		this.queryuserid = queryuserid;
	}
	public String getQuerystbno() {
		return querystbno;
	}
	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getReplacestbno() {
		return replacestbno;
	}
	public void setReplacestbno(String replacestbno) {
		this.replacestbno = replacestbno;
	}
	public Integer getServerid() {
		return serverid;
	}
	public void setServerid(Integer serverid) {
		this.serverid = serverid;
	}
	public String getServername() {
		return servername;
	}
	public void setServername(String servername) {
		this.servername = servername;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public List<Userstb> getMatherOrSonStbList() {
		return matherOrSonStbList;
	}
	public void setMatherOrSonStbList(List<Userstb> matherOrSonStbList) {
		this.matherOrSonStbList = matherOrSonStbList;
	}
	public List<Usercard> getBingUsercardList() {
		return bingUsercardList;
	}
	public void setBingUsercardList(List<Usercard> bingUsercardList) {
		this.bingUsercardList = bingUsercardList;
	}
	public List<Userproduct> getUserproductList() {
		return userproductList;
	}
	public void setUserproductList(List<Userproduct> userproductList) {
		this.userproductList = userproductList;
	}
	public String getRechargemoney() {
		return rechargemoney;
	}
	public void setRechargemoney(String rechargemoney) {
		this.rechargemoney = rechargemoney;
	}
	public String getMothercardid() {
		return mothercardid;
	}
	public void setMothercardid(String mothercardid) {
		this.mothercardid = mothercardid;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getQueryareacode() {
		return queryareacode;
	}
	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}
	public String getQueryserverid() {
		return queryserverid;
	}
	public void setQueryserverid(String queryserverid) {
		this.queryserverid = queryserverid;
	}
	public String getBuycardflag() {
		return buycardflag;
	}
	public void setBuycardflag(String buycardflag) {
		this.buycardflag = buycardflag;
	}
	public String getPaircardflag() {
		return paircardflag;
	}
	public void setPaircardflag(String paircardflag) {
		this.paircardflag = paircardflag;
	}
	public String getQueryareacodevalid() {
		return Tools.getAreacodeValid(queryareacode);
	}
	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}
	public String getStbnos() {
		return stbnos;
	}
	public void setStbnos(String stbnos) {
		this.stbnos = stbnos;
	}
	
	
}
