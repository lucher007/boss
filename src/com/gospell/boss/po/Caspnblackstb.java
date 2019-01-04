package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Caspnblackstb extends BaseField implements Serializable {

	private Integer id;    // ID主键
	private String stbno;  // 机顶盒号
	private String remark; // 备注
	private String cardids;//黑名单绑定的智能卡，多卡号已逗号隔开
	private Integer netid; //网络ID
	private String versiontype; //cas版本类型
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent;//条件内容
	private String expired_Time;//过期日期
	private String addtime;//添加日期
	private String send_now_flag;   //立即发送标识（取值说明：0：不立即发送   1：立即发送）
	
	private String  operatorType;	//操作类型，只使用后2个bit，前6bit保留置为1。添加删除（0：添加，2：删除）对应数字（添加：252，删除：255）
	
	private List<String> blackStbCardidList;
	private Map<Integer, String> networkmap;
	
	/****************** 数据库辅助字段 *************************/
	private Caspnblackstb caspnblackstb;
	private List<Caspnblackstb> caspnblackstblist;
	private String querystbno;
	private String querydate;
	private String unselectedcardids; //页面未选中的卡号
	private String queryversiontype;
	private String querynetid;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Caspnblackstb getCaspnblackstb() {
		return caspnblackstb;
	}
	public void setCaspnblackstb(Caspnblackstb caspnblackstb) {
		this.caspnblackstb = caspnblackstb;
	}
	public List<Caspnblackstb> getCaspnblackstblist() {
		return caspnblackstblist;
	}
	public void setCaspnblackstblist(List<Caspnblackstb> caspnblackstblist) {
		this.caspnblackstblist = caspnblackstblist;
	}
	public String getQuerystbno() {
		return querystbno;
	}
	public void setQuerystbno(String querystbno) {
		this.querystbno = querystbno;
	}
	public String getQuerydate() {
		return querydate;
	}
	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}
	public String getCardids() {
		return cardids;
	}
	public void setCardids(String cardids) {
		this.cardids = cardids;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
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
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
	public String getExpired_Time() {
		return expired_Time;
	}
	public void setExpired_Time(String expired_Time) {
		this.expired_Time = expired_Time;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getSend_now_flag() {
		return send_now_flag;
	}
	public void setSend_now_flag(String send_now_flag) {
		this.send_now_flag = send_now_flag;
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
	public String getUnselectedcardids() {
		return unselectedcardids;
	}
	public void setUnselectedcardids(String unselectedcardids) {
		this.unselectedcardids = unselectedcardids;
	}
	public String getQueryversiontype() {
		return queryversiontype;
	}
	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	


}
