package com.gospell.boss.cas;

import java.util.List;

public class GaoanFingerPrintParam {
	private int keylock;                    //1      uimsbf      锁屏开关
	private int encrypt_flag;               //1      uimsbf      加密标志
	private int card_id_flag;               //1      uimsbf      是否包含卡号
	private int terminal_id_flag;           //1      uimsbf      是否包含终端ID
	private int operator_id_flag;           //1      uimsbf      是否包含运营商ID
	private int private_content_flag;       //1      uimsbf      是否包含私有文本
	private int ramdom_position_flag;       //1      uimsbf      位置随机化标志
	private int hide_flag;                  //1      uimsbf      隐藏显示标志
	private int foreground_color;           //32     uimsfb-4字节    前景色
	private int background_color;           //32     uimsfb-4字节    背景色
	private String start_time;              //32     uimsfb      开始时间
	private String duration_time;           //32     uimsfb      持续时间
	/**
	 * ramdom_position_flag=0
	 * ---------------------------------------------------------------
	 */
	private int position_x;                 //16     uimsbf      位置横坐标
	private int position_y;                 //16     uimsbf      位置纵坐标
	private int height;                     //8      uimsbf      高度
	/**
	 * private_content_flag=1
	 * ---------------------------------------------------------------
	 */
	private int content_length;             //8      uimsbf      私有文本长度
	private List<String> content;           //8      uimsbf      私有文本字节	
	
	public final int getKeylock() {
		return keylock;
	}
	public final int getEncrypt_flag() {
		return encrypt_flag;
	}
	public final int getCard_id_flag() {
		return card_id_flag;
	}
	public final int getTerminal_id_flag() {
		return terminal_id_flag;
	}
	public final int getOperator_id_flag() {
		return operator_id_flag;
	}
	public final int getPrivate_content_flag() {
		return private_content_flag;
	}
	public final int getRamdom_position_flag() {
		return ramdom_position_flag;
	}
	public final int getHide_flag() {
		return hide_flag;
	}
	public final int getForeground_color() {
		return foreground_color;
	}
	public final int getBackground_color() {
		return background_color;
	}
	public final String getStart_time() {
		return start_time;
	}
	public final String getDuration_time() {
		return duration_time;
	}
	public final int getPosition_x() {
		return position_x;
	}
	public final int getPosition_y() {
		return position_y;
	}
	public final int getHeight() {
		return height;
	}
	public final int getContent_length() {
		return content_length;
	}
	public final List<String> getContent() {
		return content;
	}
	public final void setKeylock(int keylock) {
		this.keylock = keylock;
	}
	public final void setEncrypt_flag(int encrypt_flag) {
		this.encrypt_flag = encrypt_flag;
	}
	public final void setCard_id_flag(int card_id_flag) {
		this.card_id_flag = card_id_flag;
	}
	public final void setTerminal_id_flag(int terminal_id_flag) {
		this.terminal_id_flag = terminal_id_flag;
	}
	public final void setOperator_id_flag(int operator_id_flag) {
		this.operator_id_flag = operator_id_flag;
	}
	public final void setPrivate_content_flag(int private_content_flag) {
		this.private_content_flag = private_content_flag;
	}
	public final void setRamdom_position_flag(int ramdom_position_flag) {
		this.ramdom_position_flag = ramdom_position_flag;
	}
	public final void setHide_flag(int hide_flag) {
		this.hide_flag = hide_flag;
	}
	public final void setForeground_color(int foreground_color) {
		this.foreground_color = foreground_color;
	}
	public final void setBackground_color(int background_color) {
		this.background_color = background_color;
	}
	public final void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public final void setDuration_time(String duration_time) {
		this.duration_time = duration_time;
	}
	public final void setPosition_x(int position_x) {
		this.position_x = position_x;
	}
	public final void setPosition_y(int position_y) {
		this.position_y = position_y;
	}
	public final void setHeight(int height) {
		this.height = height;
	}
	public final void setContent_length(int content_length) {
		this.content_length = content_length;
	}
	public final void setContent(List<String> content) {
		this.content = content;
	}
}
