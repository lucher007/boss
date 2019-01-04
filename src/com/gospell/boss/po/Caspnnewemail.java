package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 用户实体类
 */
public class Caspnnewemail extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;           // 数据库ID
	private Integer netid;        //网络ID
	private Long emailid;         //邮件ID
	private String cardid;        // 
	private String conditioncontent; // 条件内容
	private String emailtype;     // Email类型（0：普通 1：重要）
	private String addtime;       // 写信时间
	private String emailtitle;    // Email的标题
	private String emailcontent;  // Email 的内容
	private String expiredtime;   // 过期时间
	private String casexpiredtime;//CAS过期时间
	private String remark;        // 编码方式 BE:Unicode-BE(utf-16be) LE:Unicode-LE(utf-16le) GB:GB2312
	private String versiontype;   // cas版本类型
	private String sendername;    // 发送者名称
	private String emailpriority; //邮件优先级(0：低级 1：普通 2：高级)
	private String emailoper;     // 0:添加 1：删除
	private String stbno;         //机顶盒号
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数

	
	/****************** 数据库辅助字段 *************************/
	private Caspnnewemail casemail;
	private List<Caspnnewemail> casemaillist;
	private String querycardid;
	private String queryemailtitle;
	private String querydate;
	private String queryversiontype;
	private String querynetid;
	private Map<Integer, String> networkmap;

	private String cardid_option; //页面条件需要
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmailtype() {
		return emailtype;
	}
	public void setEmailtype(String emailtype) {
		this.emailtype = emailtype;
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
	public String getExpiredtime() {
		return expiredtime;
	}
	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Caspnnewemail getCasemail() {
		return casemail;
	}
	public void setCasemail(Caspnnewemail casemail) {
		this.casemail = casemail;
	}
	public List<Caspnnewemail> getCasemaillist() {
		return casemaillist;
	}
	public void setCasemaillist(List<Caspnnewemail> casemaillist) {
		this.casemaillist = casemaillist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getQuerycardid() {
		return querycardid;
	}
	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}
	public String getEmailoper() {
		return emailoper;
	}
	public void setEmailoper(String emailoper) {
		this.emailoper = emailoper;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
	public String getQueryemailtitle() {
		return queryemailtitle;
	}
	public void setQueryemailtitle(String queryemailtitle) {
		this.queryemailtitle = queryemailtitle;
	}
	public String getQuerydate() {
		return querydate;
	}
	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}
	public String getVersiontype() {
		return versiontype;
	}
	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}
	public String getQueryversiontype() {
		return queryversiontype;
	}
	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}
	public String getSendername() {
		return sendername;
	}
	public void setSendername(String sendername) {
		this.sendername = sendername;
	}
	public String getEmailpriority() {
		return emailpriority;
	}
	public void setEmailpriority(String emailpriority) {
		this.emailpriority = emailpriority;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getQuerynetid() {
		return querynetid;
	}
	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}
	public String getStbno() {
		return stbno;
	}
	public Long getEmailid() {
		return emailid;
	}
	public void setEmailid(Long emailid) {
		this.emailid = emailid;
	}
	public void setStbno(String stbno) {
		this.stbno = stbno;
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
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public String getCardid_option() {
		return cardid_option;
	}
	public void setCardid_option(String cardid_option) {
		this.cardid_option = cardid_option;
	}
	public String getCasexpiredtime() {
		return casexpiredtime;
	}
	public void setCasexpiredtime(String casexpiredtime) {
		this.casexpiredtime = casexpiredtime;
	}


}
