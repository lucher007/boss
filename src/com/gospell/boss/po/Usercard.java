package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.gospell.boss.common.Tools;
/**
 * 用户实体类
 */
public class Usercard extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String  areacode;          //所属区域号
	private Integer userid;	           //订户ID
	private Integer serverid;          //所属CAS服务器的ID
	private String cardid;		       //智能卡号
	private String mothercardflag;     //子母卡标志（0-母卡；1-子卡）
	private String mothercardid;       //母卡卡号
	private String addtime;            //购买时间
	private String state;              //状态（0-报停；1：使用 ；2：维修 ；3：损坏；）
	private String incardflag;         //卡类型（0-外置卡；1-内置卡）
	private String stbno;              //配对机顶盒号
	private BigDecimal price;          //价格
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private String queryuserid;
	private String querycardid;
	private String querystate;
	private String querynetid;
	private String queryareacode;
	private String queryareacodevalid;
	private String queryserverid;
	private String cardids;
	
	private Usercard usercard;
	private List<Usercard> usercardlist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String replacecardid;    //更换新的智能卡号
	private String servername;      //所属CAS服务器名称
	private String versiontype;     //版本类型
	private List<Userproduct> userproductList;  //用户购买的产品列表
	private String rechargemoney;  //充值金额
	private String pairstbflag;//该智能卡在库存中是否有配对机顶盒（0-未配对；1-已配对）
	
	
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
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
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
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
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
	public String getQueryuserid() {
		return queryuserid;
	}
	public void setQueryuserid(String queryuserid) {
		this.queryuserid = queryuserid;
	}
	public String getQuerycardid() {
		return querycardid;
	}
	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	public Usercard getUsercard() {
		return usercard;
	}
	public void setUsercard(Usercard usercard) {
		this.usercard = usercard;
	}
	public List<Usercard> getUsercardlist() {
		return usercardlist;
	}
	public void setUsercardlist(List<Usercard> usercardlist) {
		this.usercardlist = usercardlist;
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
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getIncardflag() {
		return incardflag;
	}
	public void setIncardflag(String incardflag) {
		this.incardflag = incardflag;
	}
	public String getReplacecardid() {
		return replacecardid;
	}
	public void setReplacecardid(String replacecardid) {
		this.replacecardid = replacecardid;
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
	public String getQueryareacodevalid() {
		return Tools.getAreacodeValid(queryareacode);
	}
	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}
	public String getPairstbflag() {
		return pairstbflag;
	}
	public void setPairstbflag(String pairstbflag) {
		this.pairstbflag = pairstbflag;
	}
	public String getCardids() {
		return cardids;
	}
	public void setCardids(String cardids) {
		this.cardids = cardids;
	}
}
