package com.gospell.boss.cas;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * 授权准播（Command_Type ＝ 31）
 */
public class BroadcastParam {
	private int AccreditPlay_ID;              //BOSS生成的授权准播指令标识
	private String Reserved;                  //0xFFFF（第一个字节的最高位bit：是否立即发送标识）
	private int IsControl;                    //1：启动，0：取消
	private int ProductAmount;                //授权产品个数
	/**
	 * tapingctrl    是否可以录像
	 * productnum    产品号
	 * starttime     开始时间
	 * endtime       结束时间
	 */
	@SuppressWarnings("rawtypes")
	private ArrayList<HashMap> productList;
	
	
	
	public int getAccreditPlay_ID() {
		return AccreditPlay_ID;
	}
	public void setAccreditPlay_ID(int accreditPlay_ID) {
		AccreditPlay_ID = accreditPlay_ID;
	}
	public String getReserved() {
		return Reserved;
	}
	public void setReserved(String reserved) {
		Reserved = reserved;
	}
	public int getIsControl() {
		return IsControl;
	}
	public void setIsControl(int isControl) {
		IsControl = isControl;
	}
	public int getProductAmount() {
		return ProductAmount;
	}
	public void setProductAmount(int productAmount) {
		ProductAmount = productAmount;
	}
	public ArrayList<HashMap> getProductList() {
		return productList;
	}
	public void setProductList(ArrayList<HashMap> productList) {
		this.productList = productList;
	}
	
}
