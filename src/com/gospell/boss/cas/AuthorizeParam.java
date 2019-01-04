package com.gospell.boss.cas;

import java.util.Date;

/**
 * 授权指令参数表
 */
public class AuthorizeParam {
	
	
    private String card_id;	                //卡号
    private int ProductAmount;              //产品数量
	private String Send_Or_Not;             //是否立即发送
	private int  TapingCtrl;                //是否录像
	private int  ProductNumber;             //产品包编号
	private Date productBeginTime;          //开始日期
	private Date productEndTime;            //结束日期
	private String Desc_Len;                //长度
	private String Description;             //描述
	private String authType;                //授权标志
	
	
	public String getCard_id() {
		return card_id;
	}
	public void setCard_id(String card_id) {
		this.card_id = card_id;
	}
	public int getProductAmount() {
		return ProductAmount;
	}
	public void setProductAmount(int productAmount) {
		ProductAmount = productAmount;
	}
	public String getSend_Or_Not() {
		return Send_Or_Not;
	}
	public void setSend_Or_Not(String send_Or_Not) {
		Send_Or_Not = send_Or_Not;
	}
	public int getTapingCtrl() {
		return TapingCtrl;
	}
	public void setTapingCtrl(int tapingCtrl) {
		TapingCtrl = tapingCtrl;
	}
	public Date getProductBeginTime() {
		return productBeginTime;
	}
	public void setProductBeginTime(Date productBeginTime) {
		this.productBeginTime = productBeginTime;
	}
	public Date getProductEndTime() {
		return productEndTime;
	}
	public void setProductEndTime(Date productEndTime) {
		this.productEndTime = productEndTime;
	}
	public int getProductNumber() {
		return ProductNumber;
	}
	public void setProductNumber(int productNumber) {
		ProductNumber = productNumber;
	}

	public String getDesc_Len() {
		return Desc_Len;
	}
	public void setDesc_Len(String desc_Len) {
		Desc_Len = desc_Len;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getAuthType() {
		return authType;
	}
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	
	}

	
	
	
	


