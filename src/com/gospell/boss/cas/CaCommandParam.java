package com.gospell.boss.cas;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gospell.boss.po.BaseField;
import com.gospell.boss.po.Caspnblackcard;
import com.gospell.boss.po.Caspnblackstb;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Caspnproductplay;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Userproduct;

/**
 * 授权指令参数表
 */
@SuppressWarnings("serial")
public class CaCommandParam extends BaseField implements Serializable {

	private Integer netid; // 网络ID
	private String areacode; // 区域号
	private String cardid; // 智能卡号
	private String stbno; // 机顶盒号
	private String versiontype; // 机顶盒版本类型(gos_gn,gos_pn)
	private String commandtype; // CA命令类型指令
	private String expired_Time; // CAS到期日期
	private Map<Integer, String> networkmap;

	// 产品授权（Command_Type ＝ 1）
	private List<Userproduct> userproductlist; // 授权包含的产品列表

	// OSD EMAIL（Command_Type ＝ 2 or 13 ）
	private EmailOrOsdMsg emailOrOsdMsg; // OSD和MAIL

	// 启动机卡对应（Command_Type ＝ 4）
	private String correspondCount; // 机卡对应个数

	// 启动指纹显示（Command_Type ＝ 6）
	private String duration; // 持续时间

	// 运营商发卡（Command_Type ＝ 10）
	private SendCardPara sendCardPara; // 运营商发卡对象

	// 开始/停止卡的使用（Command_Type ＝ 11）
	private String Send_Or_Not; // 是否发送
	private String Card_Status; // IC卡状态

	// 发送EMM（Command_Type ＝ 12）
	private String Emm_Len; // EMM 数据长度
	private String Emm_Data; // EMM 数据

	// 条件寻址（Command_Type ＝ 14）
	// private ConditionAddr conditionAddr; //条件寻址对象
	private CaCommandParam cndAddrPara; // 条件寻址命令对象内容

	// IPPV/NVOD金额点充值（Command_Type ＝ 16）
	private String chargePoint; // 充值点数
	private String Charge_Time; // 充值时间
	private String Use_Expired_Time; // 有效使用截止时间

	// 条件限播和取消条件限播（Command_Type ＝ 17 Or Command_Type ＝ 18）
	private String ProductNumber; // 产品号

	// 分区控制（Command_Type = 27）
	private List<AreaControlParam> areaControlList; // 分区控制List

	// 授权准播（Command_Type ＝ 31）
	private Caspnproductplay caspnproductplay;

	// 强制换台（Command_Type ＝ 32）
	private Caspnforcedcc caspnforcedcc;

	// 机卡绑定A(对机顶盒操作)（Command_Type ＝ 36）
	private String send_Now_Flag; // 立即发送标识
	private String pair_Type; // 绑定类型
	private List<String> stbBingCardidList; // 绑定卡List

	// PVR再授权指令(对机顶盒操作)（Command_Type ＝ 38）
	private PvrAuthEmm pvrAuthEmm;

	// 卡号黑名单添加,删除（Command_Type ＝ 44）
	private String operatorType; // 操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）对应数字（添加：252，删除：255）

	// 顶盒黑名单添加删除（Command_Type ＝ 46）
	private List<String> blackStbCardidList;
	private String send_now_flag; // 立即发送标识（取值说明：0：不立即发送 1：立即发送）

	// 设置节目号（Command_Type ＝ 47）
	private String serviceid; // 节目ID
	private String servicename; // 节目名称

	// 设置产品号（Command_Type ＝ 48）
	private String productid; // 产品ID
	private String productname; // 产品名称
	private List<String> serviceList; // 产品关联的节目List

	// 条件开启或者关闭机顶盒的PVR功能（Command_Type = 63）
	private String pvrStatus; // PVR功能使能，0为禁止，1为开启
	private String pvr_pay;//PVR付费方式
	private String pvr_price;//PVR计费价格
	private String pvr_free_watch_time;//PVR可以免费观看时间
	private String pvr_save_time;//PVR可以保留时间

	// 机顶盒默认开机信息(commandtype=34)
	private Stbdefaultmsg stbdefaultmsg; // 机顶盒默认开机信息

	// 新邮件指令(commandtype=35)
	private Caspnnewemail caspnnewemail; // 新邮件指令

	// 强制OSD(commandtype=29)
	private Caspnforcedosd caspnforcedosd; // 强制OSD

	// 新指纹显示(commandtype=60)
	private Caspnnewfinger caspnnewfinger; // 新指纹显示

	// 机顶盒黑名单(commandtype=46)
	private Caspnblackstb caspnblackstb; // 机顶盒黑名单
	// 机顶盒黑名单(commandtype=44)
	private Caspnblackcard caspnblackcard; // 智能卡黑名单

	// -----------------------------------------------------------------------------------------

	// 高安需要的单独条件如下：
	private String addressingmode; // 寻址方式：单播-0；多播-1；
	private String terminal_type; // 终端类型：0-无卡；1-有卡终端；2-所有类型终端
	private String startStbno; // 起始机顶盒号
	private String endStbno; // 结束机顶盒号
	private String startdate; // 开始时间
	private String enddate; // 结束时间
	private String conditioncontent; // 条件内容
	private String conditioncount; // 条件寻址段数

	// 电子邮件commandtype=185，0xb9)
	private GaoAnEmail gaoAnEmail; // 高安电子邮件对象

	// 重置PIN 码 （commandtype=162，0xA2)
	private String pin_code; // 重置PIN 码

	// 父母锁密码复位 （commandtype=174，0xAE）
	private String parentPassword; // 父母密码锁

	// 终端状态控制 (commandtype=167，0xA7)
	private String open_expired_time; // 终端开启到期日期
	private String terminal_status; // 终端状态终端状态，开启或关停标志。1 为启用；0 为停用。

	// 产品限播控制 (commandtype=169，0xA9) OR 产品准播控制 (commandtype=170，0xAA)
	@SuppressWarnings("rawtypes")
	private List<HashMap> productControlList; // 产品准播列表

	// 初始化机顶盒发卡命令 (commandtype=166，0xA6)
	private GaoAn_InitStb gaoAnInitStb; // 初始化机顶盒对象

	// OSD指令 (commandtype=178，0xb2)
	private GaoanOsdParam gaoanOsdParam; // OS对象

	// 高安指纹显示(commandtype=178，0xb2)
	private GaoanFingerPrintParam fingerPrintParam; // 指纹显示参数对象

	// 强制重启
	private Forcedrestart forcedrestart; // 强制重启

	// 重新搜索节目
	private Researchprogram researchprogram; // 重新搜索节目

	// 参数HashMap
	private HashMap<String, Object> casParaMap; // 存放CA指令各种参数

	// 同步产品信息
	private String start_flag; // 开始或结束标志位
	private Product product; // 产品信息
	// 总产品包数
	private String total_package_count; // 同步总产品包数
	// 产品列表信息
	private List<Product> productlist; // 产品信息列表

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getStbno() {
		return stbno;
	}

	public void setStbno(String stbno) {
		this.stbno = stbno;
	}

	public String getCommandtype() {
		return commandtype;
	}

	public void setCommandtype(String commandtype) {
		this.commandtype = commandtype;
	}

	public List<Userproduct> getUserproductlist() {
		return userproductlist;
	}

	public void setUserproductlist(List<Userproduct> userproductlist) {
		this.userproductlist = userproductlist;
	}

	public EmailOrOsdMsg getEmailOrOsdMsg() {
		return emailOrOsdMsg;
	}

	public void setEmailOrOsdMsg(EmailOrOsdMsg emailOrOsdMsg) {
		this.emailOrOsdMsg = emailOrOsdMsg;
	}

	public String getCorrespondCount() {
		return correspondCount;
	}

	public void setCorrespondCount(String correspondCount) {
		this.correspondCount = correspondCount;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public SendCardPara getSendCardPara() {
		return sendCardPara;
	}

	public void setSendCardPara(SendCardPara sendCardPara) {
		this.sendCardPara = sendCardPara;
	}

	public String getSend_Or_Not() {
		return Send_Or_Not;
	}

	public void setSend_Or_Not(String send_Or_Not) {
		Send_Or_Not = send_Or_Not;
	}

	public String getCard_Status() {
		return Card_Status;
	}

	public void setCard_Status(String card_Status) {
		Card_Status = card_Status;
	}

	public String getEmm_Len() {
		return Emm_Len;
	}

	public void setEmm_Len(String emm_Len) {
		Emm_Len = emm_Len;
	}

	public String getEmm_Data() {
		return Emm_Data;
	}

	public void setEmm_Data(String emm_Data) {
		Emm_Data = emm_Data;
	}

	// public ConditionAddr getConditionAddr() {
	// return conditionAddr;
	// }
	//
	// public void setConditionAddr(ConditionAddr conditionAddr) {
	// this.conditionAddr = conditionAddr;
	// }

	public String getChargePoint() {
		return chargePoint;
	}

	public void setChargePoint(String chargePoint) {
		this.chargePoint = chargePoint;
	}

	public String getCharge_Time() {
		return Charge_Time;
	}

	public void setCharge_Time(String charge_Time) {
		Charge_Time = charge_Time;
	}

	public String getUse_Expired_Time() {
		return Use_Expired_Time;
	}

	public void setUse_Expired_Time(String use_Expired_Time) {
		Use_Expired_Time = use_Expired_Time;
	}

	public String getProductNumber() {
		return ProductNumber;
	}

	public void setProductNumber(String productNumber) {
		ProductNumber = productNumber;
	}

	public List<AreaControlParam> getAreaControlList() {
		return areaControlList;
	}

	public void setAreaControlList(List<AreaControlParam> areaControlList) {
		this.areaControlList = areaControlList;
	}

	public CaCommandParam getCndAddrPara() {
		return cndAddrPara;
	}

	public void setCndAddrPara(CaCommandParam cndAddrPara) {
		this.cndAddrPara = cndAddrPara;
	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getSend_Now_Flag() {
		return send_Now_Flag;
	}

	public void setSend_Now_Flag(String send_Now_Flag) {
		this.send_Now_Flag = send_Now_Flag;
	}

	public String getPair_Type() {
		return pair_Type;
	}

	public void setPair_Type(String pair_Type) {
		this.pair_Type = pair_Type;
	}

	public List<String> getStbBingCardidList() {
		return stbBingCardidList;
	}

	public void setStbBingCardidList(List<String> stbBingCardidList) {
		this.stbBingCardidList = stbBingCardidList;
	}

	public PvrAuthEmm getPvrAuthEmm() {
		return pvrAuthEmm;
	}

	public void setPvrAuthEmm(PvrAuthEmm pvrAuthEmm) {
		this.pvrAuthEmm = pvrAuthEmm;
	}

	public String getOperatorType() {
		return operatorType;
	}

	public void setOperatorType(String operatorType) {
		this.operatorType = operatorType;
	}

	public List<String> getBlackStbCardidList() {
		return blackStbCardidList;
	}

	public void setBlackStbCardidList(List<String> blackStbCardidList) {
		this.blackStbCardidList = blackStbCardidList;
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

	public String getProductid() {
		return productid;
	}

	public void setProductid(String productid) {
		this.productid = productid;
	}

	public List<String> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<String> serviceList) {
		this.serviceList = serviceList;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getPvrStatus() {
		return pvrStatus;
	}

	public void setPvrStatus(String pvrStatus) {
		this.pvrStatus = pvrStatus;
	}

	public String getVersiontype() {
		return versiontype;
	}

	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}

	public GaoAnEmail getGaoAnEmail() {
		return gaoAnEmail;
	}

	public void setGaoAnEmail(GaoAnEmail gaoAnEmail) {
		this.gaoAnEmail = gaoAnEmail;
	}

	public String getPin_code() {
		return pin_code;
	}

	public void setPin_code(String pin_code) {
		this.pin_code = pin_code;
	}

	public String getParentPassword() {
		return parentPassword;
	}

	public void setParentPassword(String parentPassword) {
		this.parentPassword = parentPassword;
	}

	public String getTerminal_status() {
		return terminal_status;
	}

	public void setTerminal_status(String terminal_status) {
		this.terminal_status = terminal_status;
	}

	public List<HashMap> getProductControlList() {
		return productControlList;
	}

	public void setProductControlList(List<HashMap> productControlList) {
		this.productControlList = productControlList;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public GaoAn_InitStb getGaoAnInitStb() {
		return gaoAnInitStb;
	}

	public void setGaoAnInitStb(GaoAn_InitStb gaoAnInitStb) {
		this.gaoAnInitStb = gaoAnInitStb;
	}

	public GaoanOsdParam getGaoanOsdParam() {
		return gaoanOsdParam;
	}

	public void setGaoanOsdParam(GaoanOsdParam gaoanOsdParam) {
		this.gaoanOsdParam = gaoanOsdParam;
	}

	public GaoanFingerPrintParam getFingerPrintParam() {
		return fingerPrintParam;
	}

	public void setFingerPrintParam(GaoanFingerPrintParam fingerPrintParam) {
		this.fingerPrintParam = fingerPrintParam;
	}

	public String getOpen_expired_time() {
		return open_expired_time;
	}

	public void setOpen_expired_time(String open_expired_time) {
		this.open_expired_time = open_expired_time;
	}

	public HashMap<String, Object> getCasParaMap() {
		return casParaMap;
	}

	public void setCasParaMap(HashMap<String, Object> casParaMap) {
		this.casParaMap = casParaMap;
	}

	public String getExpired_Time() {
		return expired_Time;
	}

	public void setExpired_Time(String expired_Time) {
		this.expired_Time = expired_Time;
	}

	public Caspnnewemail getCaspnnewemail() {
		return caspnnewemail;
	}

	public void setCaspnnewemail(Caspnnewemail caspnnewemail) {
		this.caspnnewemail = caspnnewemail;
	}

	public Caspnforcedosd getCaspnforcedosd() {
		return caspnforcedosd;
	}

	public void setCaspnforcedosd(Caspnforcedosd caspnforcedosd) {
		this.caspnforcedosd = caspnforcedosd;
	}

	public Stbdefaultmsg getStbdefaultmsg() {
		return stbdefaultmsg;
	}

	public void setStbdefaultmsg(Stbdefaultmsg stbdefaultmsg) {
		this.stbdefaultmsg = stbdefaultmsg;
	}

	public Caspnnewfinger getCaspnnewfinger() {
		return caspnnewfinger;
	}

	public void setCaspnnewfinger(Caspnnewfinger caspnnewfinger) {
		this.caspnnewfinger = caspnnewfinger;
	}

	public Caspnforcedcc getCaspnforcedcc() {
		return caspnforcedcc;
	}

	public void setCaspnforcedcc(Caspnforcedcc caspnforcedcc) {
		this.caspnforcedcc = caspnforcedcc;
	}

	public String getSend_now_flag() {
		return send_now_flag;
	}

	public void setSend_now_flag(String send_now_flag) {
		this.send_now_flag = send_now_flag;
	}

	public String getTerminal_type() {
		return terminal_type;
	}

	public void setTerminal_type(String terminal_type) {
		this.terminal_type = terminal_type;
	}

	public String getConditioncontent() {
		return conditioncontent;
	}

	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}

	public String getStartStbno() {
		return startStbno;
	}

	public void setStartStbno(String startStbno) {
		this.startStbno = startStbno;
	}

	public String getEndStbno() {
		return endStbno;
	}

	public void setEndStbno(String endStbno) {
		this.endStbno = endStbno;
	}

	public String getAddressingmode() {
		return addressingmode;
	}

	public void setAddressingmode(String addressingmode) {
		this.addressingmode = addressingmode;
	}

	public String getConditioncount() {
		return conditioncount;
	}

	public void setConditioncount(String conditioncount) {
		this.conditioncount = conditioncount;
	}

	public Forcedrestart getForcedrestart() {
		return forcedrestart;
	}

	public void setForcedrestart(Forcedrestart forcedrestart) {
		this.forcedrestart = forcedrestart;
	}

	public Researchprogram getResearchprogram() {
		return researchprogram;
	}

	public void setResearchprogram(Researchprogram researchprogram) {
		this.researchprogram = researchprogram;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public Caspnblackstb getCaspnblackstb() {
		return caspnblackstb;
	}

	public void setCaspnblackstb(Caspnblackstb caspnblackstb) {
		this.caspnblackstb = caspnblackstb;
	}

	public Caspnblackcard getCaspnblackcard() {
		return caspnblackcard;
	}

	public void setCaspnblackcard(Caspnblackcard caspnblackcard) {
		this.caspnblackcard = caspnblackcard;
	}

	public List<Product> getProductlist() {
		return productlist;
	}

	public void setProductlist(List<Product> productlist) {
		this.productlist = productlist;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getTotal_package_count() {
		return total_package_count;
	}

	public void setTotal_package_count(String total_package_count) {
		this.total_package_count = total_package_count;
	}

	public String getStart_flag() {
		return start_flag;
	}

	public void setStart_flag(String start_flag) {
		this.start_flag = start_flag;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public Caspnproductplay getCaspnproductplay() {
		return caspnproductplay;
	}

	public void setCaspnproductplay(Caspnproductplay caspnproductplay) {
		this.caspnproductplay = caspnproductplay;
	}

	public String getPvr_pay() {
		return pvr_pay;
	}

	public void setPvr_pay(String pvr_pay) {
		this.pvr_pay = pvr_pay;
	}

	public String getPvr_price() {
		return pvr_price;
	}

	public void setPvr_price(String pvr_price) {
		this.pvr_price = pvr_price;
	}

	public String getPvr_free_watch_time() {
		return pvr_free_watch_time;
	}

	public void setPvr_free_watch_time(String pvr_free_watch_time) {
		this.pvr_free_watch_time = pvr_free_watch_time;
	}

	public String getPvr_save_time() {
		return pvr_save_time;
	}

	public void setPvr_save_time(String pvr_save_time) {
		this.pvr_save_time = pvr_save_time;
	}

}
