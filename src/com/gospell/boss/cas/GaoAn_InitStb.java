package com.gospell.boss.cas;

import java.util.ArrayList;

public class GaoAn_InitStb {
	private String area_id;               //区域号
	private String previewinterval;       //预览时间间隔
	private String operatorinterval;      //运营商定期激活周期
	private String user_vip_class;        //用户级别
	private String maturity_rating;       //成人级别
	private String terminal_type;         //终端类型 0 - 主机；1 - 子机
	private String operatorinfo;
	private String activeflag;            //是否需要本地定期激活标志
	private String activeinterval;        //本地定期周期
	private String currencycode;          //货币代码
	private String condenominator;        //货币转换因子之分母
	private String conversion_numerator;  //货币转换因子之分子
	
	private String net_id;               //网络号
	private String bouquet_id;           //信束号
	
	private ArrayList<String> stbList;    //子机或者母机列表
	
	public String getArea_id() {
		return area_id;
	}
	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}
	public String getPreviewinterval() {
		return previewinterval;
	}
	public void setPreviewinterval(String previewinterval) {
		this.previewinterval = previewinterval;
	}
	public String getOperatorinterval() {
		return operatorinterval;
	}
	public void setOperatorinterval(String operatorinterval) {
		this.operatorinterval = operatorinterval;
	}
	public String getUser_vip_class() {
		return user_vip_class;
	}
	public void setUser_vip_class(String user_vip_class) {
		this.user_vip_class = user_vip_class;
	}
	public String getMaturity_rating() {
		return maturity_rating;
	}
	public void setMaturity_rating(String maturity_rating) {
		this.maturity_rating = maturity_rating;
	}
	public String getTerminal_type() {
		return terminal_type;
	}
	public void setTerminal_type(String terminal_type) {
		this.terminal_type = terminal_type;
	}
	public String getOperatorinfo() {
		return operatorinfo;
	}
	public void setOperatorinfo(String operatorinfo) {
		this.operatorinfo = operatorinfo;
	}
	public String getActiveflag() {
		return activeflag;
	}
	public void setActiveflag(String activeflag) {
		this.activeflag = activeflag;
	}
	public String getActiveinterval() {
		return activeinterval;
	}
	public void setActiveinterval(String activeinterval) {
		this.activeinterval = activeinterval;
	}
	public String getCurrencycode() {
		return currencycode;
	}
	public void setCurrencycode(String currencycode) {
		this.currencycode = currencycode;
	}
	public String getCondenominator() {
		return condenominator;
	}
	public void setCondenominator(String condenominator) {
		this.condenominator = condenominator;
	}
	public String getConversion_numerator() {
		return conversion_numerator;
	}
	public void setConversion_numerator(String conversion_numerator) {
		this.conversion_numerator = conversion_numerator;
	}
	public ArrayList<String> getStbList() {
		if(stbList == null ){
			stbList = new ArrayList<String>();
		}
		return stbList;
	}
	public void setStbList(ArrayList<String> stbList) {
		this.stbList = stbList;
	}
	public String getNet_id() {
		return net_id;
	}
	public void setNet_id(String net_id) {
		this.net_id = net_id;
	}
	public String getBouquet_id() {
		return bouquet_id;
	}
	public void setBouquet_id(String bouquet_id) {
		this.bouquet_id = bouquet_id;
	}
	

	

}
