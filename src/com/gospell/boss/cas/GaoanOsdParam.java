package com.gospell.boss.cas;

import java.util.List;

public class GaoanOsdParam {
	private String cas_exptime;
	private Integer osd_control; // osd_control 1 uimsbf -OSD控制模式
	private Integer reserved = -1; // 7 uimsbf
	// osd_control = 0x01------------------------------------------{
	private Integer osdid;
	private String start_time;
	// private Integer end_time;
	private String exp_time;
	/**
	 * display_para {
	 */
	private Integer display_style; // 3 uimsbf 显示风格
	private Integer key_lock; // 1 uimsbf 锁屏开关
	private Integer priority; // 4 uimsbf 优先级
	private Integer font; // 16 uimsbf 字体
	private Integer size; // 8 uimsbf 字号
	private Integer foreground_color;// 32 uimsbf 前景色
	private Integer background_color;// 32 uimsbf 背景色
	// display_style==0-----------------------------------------{
	private Integer scroll_direction;// 4 uimsbf 滚动方向
	private Integer display_frequency;// 12 uimsbf 滚动频率
	private Integer position_x; // 16 uimsbf 位置横坐标
	private Integer position_y; // 16 uimsbf 位置纵坐标
	private Integer bar_height; // 8 uimsbf
	// display_style==0-----------------------------------------}
	// display_stype==1-----------------------------------------{
	private Integer screen_coverage_percentage; // 8 uimsbf 占屏比
	private Integer ds_reserved = -1; // 48 uimsbf
	// display_style==1-----------------------------------------}
	/**
	 * display_para }
	 */
	// --------------------------------------------------------------
	/**
	 * content_para() {
	 */
	private Integer card_id_display_flag; // 1 uimsbf 是否包含卡号
	private Integer terminal_id_display_flag; // 1 uimsbf 是否包含终端ID
	private Integer operator_id_display_flag; // 1 uimsbf 是否包含运营商ID
	private Integer private_content_flag; // 1 uimsbf 是否包含私有文本
	private Integer cp_reserved = -1; // 4 uimsbf
	// private_content_flag==1--------------------------{
	private Integer content_len; // 16 uimsbf 私有文本长度
	private List<String> content; // 8 uimsbf 私有文本字节
	// private_content_flag==1--------------------------}
	/**
	 * content_para() }
	 */
	// osd_control = 0x01------------------------------------------}
	// osd_control = 0x00------------------------------------------{
	private Integer osd_id; // 32 uimsbf 要取消的OSD的ID

	// osd_control = 0x00------------------------------------------}
	public String getCas_exptime() {
		return cas_exptime;
	}

	public void setCas_exptime(String cas_exptime) {
		this.cas_exptime = cas_exptime;
	}

	public Integer getOsd_control() {
		return osd_control;
	}

	public void setOsd_control(Integer osd_control) {
		this.osd_control = osd_control;
	}

	public Integer getReserved() {
		return reserved;
	}

	public void setReserved(Integer reserved) {
		this.reserved = reserved;
	}

	public Integer getOsdid() {
		return osdid;
	}

	public void setOsdid(Integer osdid) {
		this.osdid = osdid;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getExp_time() {
		return exp_time;
	}

	public void setExp_time(String exp_time) {
		this.exp_time = exp_time;
	}

	public Integer getDisplay_style() {
		return display_style;
	}

	public void setDisplay_style(Integer display_style) {
		this.display_style = display_style;
	}

	public Integer getKey_lock() {
		return key_lock;
	}

	public void setKey_lock(Integer key_lock) {
		this.key_lock = key_lock;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Integer getFont() {
		return font;
	}

	public void setFont(Integer font) {
		this.font = font;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Integer getForeground_color() {
		return foreground_color;
	}

	public void setForeground_color(Integer foreground_color) {
		this.foreground_color = foreground_color;
	}

	public Integer getBackground_color() {
		return background_color;
	}

	public void setBackground_color(Integer background_color) {
		this.background_color = background_color;
	}

	public Integer getScroll_direction() {
		return scroll_direction;
	}

	public void setScroll_direction(Integer scroll_direction) {
		this.scroll_direction = scroll_direction;
	}

	public Integer getDisplay_frequency() {
		return display_frequency;
	}

	public void setDisplay_frequency(Integer display_frequency) {
		this.display_frequency = display_frequency;
	}

	public Integer getPosition_x() {
		return position_x;
	}

	public void setPosition_x(Integer position_x) {
		this.position_x = position_x;
	}

	public Integer getPosition_y() {
		return position_y;
	}

	public void setPosition_y(Integer position_y) {
		this.position_y = position_y;
	}

	public Integer getBar_height() {
		return bar_height;
	}

	public void setBar_height(Integer bar_height) {
		this.bar_height = bar_height;
	}

	public Integer getScreen_coverage_percentage() {
		return screen_coverage_percentage;
	}

	public void setScreen_coverage_percentage(Integer screen_coverage_percentage) {
		this.screen_coverage_percentage = screen_coverage_percentage;
	}

	public Integer getDs_reserved() {
		return ds_reserved;
	}

	public void setDs_reserved(Integer ds_reserved) {
		this.ds_reserved = ds_reserved;
	}

	public Integer getCard_id_display_flag() {
		return card_id_display_flag;
	}

	public void setCard_id_display_flag(Integer card_id_display_flag) {
		this.card_id_display_flag = card_id_display_flag;
	}

	public Integer getTerminal_id_display_flag() {
		return terminal_id_display_flag;
	}

	public void setTerminal_id_display_flag(Integer terminal_id_display_flag) {
		this.terminal_id_display_flag = terminal_id_display_flag;
	}

	public Integer getOperator_id_display_flag() {
		return operator_id_display_flag;
	}

	public void setOperator_id_display_flag(Integer operator_id_display_flag) {
		this.operator_id_display_flag = operator_id_display_flag;
	}

	public Integer getPrivate_content_flag() {
		return private_content_flag;
	}

	public void setPrivate_content_flag(Integer private_content_flag) {
		this.private_content_flag = private_content_flag;
	}

	public Integer getCp_reserved() {
		return cp_reserved;
	}

	public void setCp_reserved(Integer cp_reserved) {
		this.cp_reserved = cp_reserved;
	}

	public Integer getContent_len() {
		return content_len;
	}

	public void setContent_len(Integer content_len) {
		this.content_len = content_len;
	}

	public List<String> getContent() {
		return content;
	}

	public void setContent(List<String> content) {
		this.content = content;
	}

	public Integer getOsd_id() {
		return osd_id;
	}

	public void setOsd_id(Integer osd_id) {
		this.osd_id = osd_id;
	}

}
