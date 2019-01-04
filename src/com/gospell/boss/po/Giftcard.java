package com.gospell.boss.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Giftcard extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private String giftcardno;        //充值卡号
	private String password;	       //充值卡密码
	private String batchno;		   //批次号
	private String serialno;       //序列号(当天递增，默认开始位000001)
	private BigDecimal amount;            //面额
	private String amountpara;           //面额参数
	private BigDecimal price;              //价格
	private String state;               //状态（0-无效；1-有效）
	private String printflag;           //印刷标志（0-否；1-是）
	private String usedflag;            //使用标志（0-否；1-是）
	private String addtime;             //生成时间
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Giftcard giftcard;
	private List<Giftcard> giftcardlist;
	private List<Giftcardamountpara> amountparalist;
	
	private Integer number; //生成卡数量
	
	//封装导出充值卡EXCEL内容
	private Map<String, String> excelMap;
	
	private String querygiftcardno;
	private String querybatchno;
	private String querystate;
	private String queryamountpara;
	private String queryusedflag;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGiftcardno() {
		return giftcardno;
	}
	public void setGiftcardno(String giftcardno) {
		this.giftcardno = giftcardno;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBatchno() {
		return batchno;
	}
	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}
	public String getSerialno() {
		return serialno;
	}
	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public String getAmountpara() {
		return amountpara;
	}
	public void setAmountpara(String amountpara) {
		this.amountpara = amountpara;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPrintflag() {
		return printflag;
	}
	public void setPrintflag(String printflag) {
		this.printflag = printflag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Giftcard getGiftcard() {
		return giftcard;
	}
	public void setGiftcard(Giftcard giftcard) {
		this.giftcard = giftcard;
	}
	public List<Giftcard> getGiftcardlist() {
		return giftcardlist;
	}
	public void setGiftcardlist(List<Giftcard> giftcardlist) {
		this.giftcardlist = giftcardlist;
	}
	public String getQuerygiftcardno() {
		return querygiftcardno;
	}
	public void setQuerygiftcardno(String querygiftcardno) {
		this.querygiftcardno = querygiftcardno;
	}
	public String getQuerybatchno() {
		return querybatchno;
	}
	public void setQuerybatchno(String querybatchno) {
		this.querybatchno = querybatchno;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public List<Giftcardamountpara> getAmountparalist() {
		return amountparalist;
	}
	public void setAmountparalist(List<Giftcardamountpara> amountparalist) {
		this.amountparalist = amountparalist;
	}
	public String getQuerystate() {
		return querystate;
	}
	public void setQuerystate(String querystate) {
		this.querystate = querystate;
	}
	public String getQueryamountpara() {
		return queryamountpara;
	}
	public void setQueryamountpara(String queryamountpara) {
		this.queryamountpara = queryamountpara;
	}
	public Map<String, String> getExcelMap() {
		return excelMap;
	}
	public void setExcelMap(Map<String, String> excelMap) {
		this.excelMap = excelMap;
	}
	public String getUsedflag() {
		return usedflag;
	}
	public void setUsedflag(String usedflag) {
		this.usedflag = usedflag;
	}
	public String getQueryusedflag() {
		return queryusedflag;
	}
	public void setQueryusedflag(String queryusedflag) {
		this.queryusedflag = queryusedflag;
	}
	
	
}
