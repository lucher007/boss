package com.gospell.boss.cas;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class EmailOrOsdMsg extends BaseField implements Serializable {
   
	//OSD
	private String expiredtime; // 过期时间
	private String starttime; // 开始时间
	private String endtime;   // 结束时间
	private String iscontrol; // 1：启动，0：取消
	private String duration; // 显示时间长度
	private String showtimes; // 显示次数
	private String showfreq; // 显示频率
	private String priority; // 优先级
	private String addtime; // 添加时间
	private String content; //显示内容
	
	//邮件
	private String emailtitle;    // Email的标题
	private String emailcontent;  // Email 的内容
	
	//文件的编码方式
	private String remark;
	private String cardid_option; //页面条件需要
	
	/****************** 数据库辅助字段 *************************/
	private String versiontype;   // cas版本类型
	private String stbno;         //机顶盒号
	private String cardid;         //智能卡号
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private String conditioncontent; // 条件内容
	private Integer netid;        //网络ID
	
	/****************** 数据库辅助字段 *************************/
	private EmailOrOsdMsg emailOrOsdMsg;
	private List<EmailOrOsdMsg> emailOrOsdMsglist;
	private String querycardid;
	private String querydate;
	private String queryversiontype;
	private String querynetid;
	private Map<Integer, String> networkmap;
	
	public String getExpiredtime() {
		return expiredtime;
	}
	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
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
	public String getIscontrol() {
		return iscontrol;
	}
	public void setIscontrol(String iscontrol) {
		this.iscontrol = iscontrol;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getShowtimes() {
		return showtimes;
	}
	public void setShowtimes(String showtimes) {
		this.showtimes = showtimes;
	}
	public String getShowfreq() {
		return showfreq;
	}
	public void setShowfreq(String showfreq) {
		this.showfreq = showfreq;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getEmailtitle() {
		return emailtitle;
	}
	public void setEmailtitle(String emailtitle) {
		this.emailtitle = emailtitle;
	}
	public String getEmailcontent() {
		return emailcontent;
	}
	public void setEmailcontent(String emailcontent) {
		this.emailcontent = emailcontent;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}
	public String getStbno() {
		return stbno;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
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
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public EmailOrOsdMsg getEmailOrOsdMsg() {
		return emailOrOsdMsg;
	}
	public void setEmailOrOsdMsg(EmailOrOsdMsg emailOrOsdMsg) {
		this.emailOrOsdMsg = emailOrOsdMsg;
	}
	public List<EmailOrOsdMsg> getEmailOrOsdMsglist() {
		return emailOrOsdMsglist;
	}
	public void setEmailOrOsdMsglist(List<EmailOrOsdMsg> emailOrOsdMsglist) {
		this.emailOrOsdMsglist = emailOrOsdMsglist;
	}
	public String getQuerycardid() {
		return querycardid;
	}
	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}
	public String getQuerydate() {
		return querydate;
	}
	public void setQuerydate(String querydate) {
		this.querydate = querydate;
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
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCardid_option() {
		return cardid_option;
	}
	public void setCardid_option(String cardid_option) {
		this.cardid_option = cardid_option;
	}

}
