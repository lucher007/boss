package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.gospell.boss.common.Tools;
/**
 * 用户实体类
 */
public class User extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络
	private String areacode;		   //区域号
	private String usercode;		   //用户编码
	private String username;		   //订户姓名
	private String usertype;		   //订户类型(0-普通订户；1-集团订户）
	private String mobile;             //移动电话
	private String telephone;          //固定电话
	private String documenttype;       //证件类型
	private String documentno;         //证件号码
	private String email;	           //邮件地址
	private String address;	           //地址
	private String password;           //登录MPP密码
	private String paypassword;        //账户余额支付密码
	private String matchbankno;        //是否绑定银行卡
	private String bankno;             //绑定银行卡号码
	private BigDecimal score;          //订户积分(默认为0)
	private BigDecimal account;        //账户余额(默认为0)
	private String state;              //状态（0：注销;1：正常;2-报停）
	private String addtime;            //
	private String remark;             //备注
	private Integer userlevelid;       //订户级别
	private String userstbsJson;
	private String usercardsJson;

	private String searchtype;

	
	private User user;
	private List<User> userlist;
	private Network network;
	private List<Network> networklist;
	private Map<Integer, String> networkmap;
	
	private Area area;
	private Map<Integer, String> areamap;
	
	private Server server;
	private Map<Integer, String> servermap;
	
	private List<Userstb> userstblist;
	private List<Usercard> usercardlist;
	//订户产品ID
	private Integer userproductid;
	private List<Userproduct> userproductlist;
	
	//将要购买的机顶盒
	private String buyingstbno;
	private List<Userstb> buyingstblist;
	//将要购买的智能卡
	private String buyingcardid;
	private List<Usercard> buyingcardlist;
	//将要购买的产品
	private String buyingproductid;
	private List<Userproduct> buyingproductlist;
	//将要产生的业务
	private String buyingbusinessid;
	private Userbusiness buyingbusiness;
	private List<Userbusiness> buyingbusinesslist;
	//将要产生的明细
	private String buyingbusinessdetailid;
	private List<Userbusinessdetail> buyingbusinessdetaillist;
	//将要收取的其他费用
	private List<Businesstype> buyingotherfeelist;
	//过户新用户
	private String transferuserid;
	private User transferuser;
	//更换新机顶盒
	private Stb replacestb;
	//更换智能卡
	private Card replacecard;
	
	//终端ID
	private String terminalid;
	//终端类型 
	private String terminaltype;
    //订户等级
	private Userlevel userlevel;
	//充值卡号
	private String giftcardno;
	
	private String stbcardpairflag; //是否机卡绑定
	private String printtaxpayerflag; //是否发票打印纳税人信息
		
	/******************页面查询条件辅助字段*************************/
	private String querynetid;
	private String queryareacode;
	private String queryusername;
	private String queryusercode;
	private String querystate;
	private String querymobile;
	private String querytelephone;
	private String queryaddress;
	private String querydocumentno;
	private String querystbno;
	private String querycardid;
	private String queryuserlevelid;
	private String count;
	private String businesstype;
	private BigDecimal rechargemoney;
    private String queryareacodevalid;
	
	/*******************************************/
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
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getUsercode() {
		return StringUtils.leftPad(String.valueOf(id), 10, "0");
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDocumenttype() {
		return documenttype;
	}
	public void setDocumenttype(String documenttype) {
		this.documenttype = documenttype;
	}
	public String getDocumentno() {
		return documentno;
	}
	public void setDocumentno(String documentno) {
		this.documentno = documentno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMatchbankno() {
		return matchbankno;
	}
	public void setMatchbankno(String matchbankno) {
		this.matchbankno = matchbankno;
	}
	public String getBankno() {
		return bankno;
	}
	public void setBankno(String bankno) {
		this.bankno = bankno;
	}
	public BigDecimal getScore() {
		return score;
	}
	public void setScore(BigDecimal score) {
		this.score = score;
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<User> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public List<Network> getNetworklist() {
		return networklist;
	}
	public void setNetworklist(List<Network> networklist) {
		this.networklist = networklist;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public String getQueryusername() {
		return queryusername;
	}
	public void setQueryusername(String queryusername) {
		this.queryusername = queryusername;
	}
	public String getQueryusercode() {
		return queryusercode;
	}
	public void setQueryusercode(String queryusercode) {
		this.queryusercode = queryusercode;
	}
	public BigDecimal getAccount() {
		return account;
	}
	public void setAccount(BigDecimal account) {
		this.account = account;
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
	public String getQuerymobile() {
		return querymobile;
	}
	public void setQuerymobile(String querymobile) {
		this.querymobile = querymobile;
	}
	public String getQueryaddress() {
		return queryaddress;
	}
	public void setQueryaddress(String queryaddress) {
		this.queryaddress = queryaddress;
	}
	public Map<Integer, String> getAreamap() {
		return areamap;
	}
	public void setAreamap(Map<Integer, String> areamap) {
		this.areamap = areamap;
	}
	public Area getArea() {
		return area;
	}
	public void setArea(Area area) {
		this.area = area;
	}
	public Server getServer() {
		return server;
	}
	public void setServer(Server server) {
		this.server = server;
	}
	public Map<Integer, String> getServermap() {
		return servermap;
	}
	public void setServermap(Map<Integer, String> servermap) {
		this.servermap = servermap;
	}
	public String getBusinesstype() {
		return businesstype;
	}
	public void setBusinesstype(String businesstype) {
		this.businesstype = businesstype;
	}
	public List<Userstb> getUserstblist() {
		return userstblist;
	}
	public void setUserstblist(List<Userstb> userstblist) {
		this.userstblist = userstblist;
	}
	public List<Usercard> getUsercardlist() {
		return usercardlist;
	}
	public void setUsercardlist(List<Usercard> usercardlist) {
		this.usercardlist = usercardlist;
	}
	public List<Userproduct> getUserproductlist() {
		return userproductlist;
	}
	public void setUserproductlist(List<Userproduct> userproductlist) {
		this.userproductlist = userproductlist;
	}
	public String getQuerydocumentno() {
		return querydocumentno;
	}
	public void setQuerydocumentno(String querydocumentno) {
		this.querydocumentno = querydocumentno;
	}
	public String getQuerystbno() {
		return querystbno;
	}
	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}
	public String getQuerycardid() {
		return querycardid;
	}
	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}
	public String getQueryareacode() {
		return queryareacode;
	}
	public void setQueryareacode(String queryareacode) {
		this.queryareacode = queryareacode;
	}
	public String getBuyingstbno() {
		return buyingstbno;
	}
	public void setBuyingstbno(String buyingstbno) {
		this.buyingstbno = buyingstbno;
	}
	public List<Userstb> getBuyingstblist() {
		if(buyingstblist == null ){
			buyingstblist = new ArrayList<Userstb>();
		}
		return buyingstblist;
	}
	public void setBuyingstblist(List<Userstb> buyingstblist) {
		this.buyingstblist = buyingstblist;
	}
	public String getBuyingcardid() {
		return buyingcardid;
	}
	public void setBuyingcardid(String buyingcardid) {
		this.buyingcardid = buyingcardid;
	}
	public List<Usercard> getBuyingcardlist() {
		if(buyingcardlist == null ){
			buyingcardlist = new ArrayList<Usercard>();
		}
		return buyingcardlist;
	}
	public void setBuyingcardlist(List<Usercard> buyingcardlist) {
		this.buyingcardlist = buyingcardlist;
	}
	public String getBuyingproductid() {
		return buyingproductid;
	}
	public void setBuyingproductid(String buyingproductid) {
		this.buyingproductid = buyingproductid;
	}
	public List<Userproduct> getBuyingproductlist() {
		if(buyingproductlist == null ){
			buyingproductlist = new ArrayList<Userproduct>();
		}
		return buyingproductlist;
	}
	public void setBuyingproductlist(List<Userproduct> buyingproductlist) {
		this.buyingproductlist = buyingproductlist;
	}
	public String getBuyingbusinessid() {
		return buyingbusinessid;
	}
	public void setBuyingbusinessid(String buyingbusinessid) {
		this.buyingbusinessid = buyingbusinessid;
	}
	public List<Userbusiness> getBuyingbusinesslist() {
		if(buyingbusinesslist == null ){
			buyingbusinesslist = new ArrayList<Userbusiness>();
		}
		return buyingbusinesslist;
	}
	public void setBuyingbusinesslist(List<Userbusiness> buyingbusinesslist) {
		this.buyingbusinesslist = buyingbusinesslist;
	}
	public String getBuyingbusinessdetailid() {
		return buyingbusinessdetailid;
	}
	public void setBuyingbusinessdetailid(String buyingbusinessdetailid) {
		this.buyingbusinessdetailid = buyingbusinessdetailid;
	}
	public List<Userbusinessdetail> getBuyingbusinessdetaillist() {
		if(buyingbusinessdetaillist == null ){
			buyingbusinessdetaillist = new ArrayList<Userbusinessdetail>();
		}
		return buyingbusinessdetaillist;
	}
	public void setBuyingbusinessdetaillist(
			List<Userbusinessdetail> buyingbusinessdetaillist) {
		this.buyingbusinessdetaillist = buyingbusinessdetaillist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Userbusiness getBuyingbusiness() {
		if(buyingbusiness == null){
			buyingbusiness = new Userbusiness();
		}
		return buyingbusiness;
	}
	public void setBuyingbusiness(Userbusiness buyingbusiness) {
		this.buyingbusiness = buyingbusiness;
	}
	public String getTransferuserid() {
		return transferuserid;
	}
	public void setTransferuserid(String transferuserid) {
		this.transferuserid = transferuserid;
	}
	public User getTransferuser() {
		return transferuser;
	}
	public void setTransferuser(User transferuser) {
		this.transferuser = transferuser;
	}
	public Stb getReplacestb() {
		return replacestb;
	}
	public void setReplacestb(Stb replacestb) {
		this.replacestb = replacestb;
	}
	public Card getReplacecard() {
		return replacecard;
	}
	public void setReplacecard(Card replacecard) {
		this.replacecard = replacecard;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public BigDecimal getRechargemoney() {
		return rechargemoney;
	}
	public void setRechargemoney(BigDecimal rechargemoney) {
		this.rechargemoney = rechargemoney;
	}
	public String getPaypassword() {
		return paypassword;
	}
	public void setPaypassword(String paypassword) {
		this.paypassword = paypassword;
	}
	public String getTerminalid() {
		return terminalid;
	}
	public void setTerminalid(String terminalid) {
		this.terminalid = terminalid;
	}
	public String getTerminaltype() {
		return terminaltype;
	}
	public void setTerminaltype(String terminaltype) {
		this.terminaltype = terminaltype;
	}
	public Integer getUserproductid() {
		return userproductid;
	}
	public void setUserproductid(Integer userproductid) {
		this.userproductid = userproductid;
	}
	public String getUserstbsJson() {
		return userstbsJson;
	}
	public void setUserstbsJson(String userstbsJson) {
		this.userstbsJson = userstbsJson;
	}
	public String getUsercardsJson() {
		return usercardsJson;
	}
	public void setUsercardsJson(String usercardsJson) {
		this.usercardsJson = usercardsJson;
	}
	public String getSearchtype() {
		return searchtype;
	}
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	public String getGiftcardno() {
		return giftcardno;
	}
	public void setGiftcardno(String giftcardno) {
		this.giftcardno = giftcardno;
	}
	public String getStbcardpairflag() {
		return stbcardpairflag;
	}
	public void setStbcardpairflag(String stbcardpairflag) {
		this.stbcardpairflag = stbcardpairflag;
	}
	public String getQueryareacodevalid() {
		return Tools.getAreacodeValid(queryareacode);
	}
	public void setQueryareacodevalid(String queryareacodevalid) {
		this.queryareacodevalid = queryareacodevalid;
	}
	public String getPrinttaxpayerflag() {
		return printtaxpayerflag;
	}
	public void setPrinttaxpayerflag(String printtaxpayerflag) {
		this.printtaxpayerflag = printtaxpayerflag;
	}
	public List<Businesstype> getBuyingotherfeelist() {
		if(buyingotherfeelist == null ){
			buyingotherfeelist = new ArrayList<Businesstype>();
		}
		return buyingotherfeelist;
	}
	public void setBuyingotherfeelist(List<Businesstype> buyingotherfeelist) {
		this.buyingotherfeelist = buyingotherfeelist;
	}
	public Integer getUserlevelid() {
		return userlevelid;
	}
	public void setUserlevelid(Integer userlevelid) {
		this.userlevelid = userlevelid;
	}
	public String getQueryuserlevelid() {
		return queryuserlevelid;
	}
	public void setQueryuserlevelid(String queryuserlevelid) {
		this.queryuserlevelid = queryuserlevelid;
	}
	public Userlevel getUserlevel() {
		return userlevel;
	}
	public void setUserlevel(Userlevel userlevel) {
		this.userlevel = userlevel;
	}
	public String getQuerytelephone() {
		return querytelephone;
	}
	public void setQuerytelephone(String querytelephone) {
		this.querytelephone = querytelephone;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	
}
