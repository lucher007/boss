package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Caspnforcedosd extends BaseField implements Serializable {

	/****************** 普安强制OSD *************************/
	private Integer id; // OSD标识
	private String cardid; // 智能卡号
	private String conditioncontent; // 条件内容
	private String expiredtime; // 过期时间
	private String starttime; // 开始时间
	private String endtime;   // 结束时间
	private String iscontrol; // 1：启动，0：取消
	private String lockscreen; // 锁定用
	private String duration; // 显示时间长度
	private String showtimes; // 显示次数
	private String showfreq; // 显示频率
	private String priority; // 优先级
	private String style; // 显示方式
	private String stylevalue; // 显示参数，根据Style有不同解释
	private String fontsize; // 字号, 目前版本不支持
	private String fontcolor; // 字体颜色RGBA，
	private String backgroundcolor; // 背景色RGB
	private String backgroundtransparency; // 背景色透明度
	private String reserved; // 保留字节0xFFFFFFFF
	private String content; // 显示内容
	private String addtime; // 添加时间
	private String remark; // 编码方式 BE:Unicode-BE(utf-16be) LE:Unicode-LE(utf-16le) GB:GB2312
	private String scroll_direction; //滚动方向
	private String scalerelativetoscreen; //占屏比
	private Map<Integer, String> networkmap;

	
	/****************** 高安OSD *************************/
	private String display_style;//显示方式。000 - 滚动显示；001 – 弹窗显示；其他 – 预留将来使用
	private String font; // 字体
	private String foregroundcolor; //前景色RGB
	private String foregroundtransparency;//前景透明度
	private String scrolldirection; //滚动方向
	private String displayfrequency;//滚动频率
	private String positionx;       //位置横坐标
	private String positiony;       //位置纵坐标
	private String barheight;       //滚动条高度
	private String screencoveragepercentage; //占屏比
	private String cardiddisplayflag; //是否显示卡号（0-不显示；1-显示）
	private String terminaliddisplayflag; //是否显示终端号（0-不显示；1-显示）
	private String operatoriddisplayflag; //是否显示运营商号（0-不显示；1-显示）
	private String privatecontentflag;    //是否显示私有内容（0-不显示；1-显示）
	private Long osdid; //OSDID
	private String displayperiod; //显示周期
	private String displaydurationtime; //单次显示持续时间
	private String serviceid; //OSD显示节目号
	private String areaiddisplayflag; //是否包含区域ID
	
	/****************** 新增加的字段 *************************/
	private String versiontype;   // cas版本类型
	private String stbno;         //机顶盒号
	private String addressingmode;//寻址方式：单播-0；多播-1；
	private String conditioncount;//寻址段数
	private Integer netid;        //网络ID
	
	
	/****************** 数据库辅助字段 *************************/
	private Caspnforcedosd caspnforcedosd;
	private List<Caspnforcedosd> caspnforcedosdlist;
	private String querycardid;
	private String querydate;
	private String queryversiontype;
	private String querynetid;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}



	public String getExpiredtime() {
		return expiredtime;
	}

	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
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

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getStylevalue() {
		return stylevalue;
	}

	public void setStylevalue(String stylevalue) {
		this.stylevalue = stylevalue;
	}

	public String getFontsize() {
		return fontsize;
	}

	public void setFontsize(String fontsize) {
		this.fontsize = fontsize;
	}

	public String getFontcolor() {
		return fontcolor;
	}

	public void setFontcolor(String fontcolor) {
		this.fontcolor = fontcolor;
	}

	public String getBackgroundcolor() {
		return backgroundcolor;
	}

	public void setBackgroundcolor(String backgroundcolor) {
		this.backgroundcolor = backgroundcolor;
	}

	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
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

	public Caspnforcedosd getCaspnforcedosd() {
		return caspnforcedosd;
	}

	public void setCaspnforcedosd(Caspnforcedosd caspnforcedosd) {
		this.caspnforcedosd = caspnforcedosd;
	}

	public List<Caspnforcedosd> getCaspnforcedosdlist() {
		return caspnforcedosdlist;
	}

	public void setCaspnforcedosdlist(List<Caspnforcedosd> caspnforcedosdlist) {
		this.caspnforcedosdlist = caspnforcedosdlist;
	}

	public String getQuerycardid() {
		return querycardid;
	}

	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getConditioncontent() {
		return conditioncontent;
	}

	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}

	public String getLockscreen() {
		return lockscreen;
	}

	public void setLockscreen(String lockscreen) {
		this.lockscreen = lockscreen;
	}

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getFont() {
		return font;
	}

	public void setFont(String font) {
		this.font = font;
	}

	public String getForegroundcolor() {
		return foregroundcolor;
	}

	public void setForegroundcolor(String foregroundcolor) {
		this.foregroundcolor = foregroundcolor;
	}

	public String getScrolldirection() {
		return scrolldirection;
	}

	public void setScrolldirection(String scrolldirection) {
		this.scrolldirection = scrolldirection;
	}

	public String getDisplayfrequency() {
		if(StringUtils.isEmpty(displayfrequency)){
			displayfrequency = "0";
		}
		return displayfrequency;
	}

	public void setDisplayfrequency(String displayfrequency) {
		this.displayfrequency = displayfrequency;
	}

	public String getPositionx() {
		if(StringUtils.isEmpty(positionx)){
			positionx = "0";
		}
		return positionx;
	}

	public void setPositionx(String positionx) {
		this.positionx = positionx;
	}

	public String getPositiony() {
		if(StringUtils.isEmpty(positiony)){
			positiony = "0";
		}
		return positiony;
	}

	public void setPositiony(String positiony) {
		this.positiony = positiony;
	}

	public String getBarheight() {
		if(StringUtils.isEmpty(barheight)){
			barheight = "0";
		}
		return barheight;
	}

	public void setBarheight(String barheight) {
		this.barheight = barheight;
	}

	public String getScreencoveragepercentage() {
		return screencoveragepercentage;
	}

	public void setScreencoveragepercentage(String screencoveragepercentage) {
		this.screencoveragepercentage = screencoveragepercentage;
	}

	public String getCardiddisplayflag() {
		return cardiddisplayflag;
	}

	public void setCardiddisplayflag(String cardiddisplayflag) {
		this.cardiddisplayflag = cardiddisplayflag;
	}

	public String getTerminaliddisplayflag() {
		return terminaliddisplayflag;
	}

	public void setTerminaliddisplayflag(String terminaliddisplayflag) {
		this.terminaliddisplayflag = terminaliddisplayflag;
	}

	public String getOperatoriddisplayflag() {
		return operatoriddisplayflag;
	}

	public void setOperatoriddisplayflag(String operatoriddisplayflag) {
		this.operatoriddisplayflag = operatoriddisplayflag;
	}

	public String getPrivatecontentflag() {
		return privatecontentflag;
	}

	public void setPrivatecontentflag(String privatecontentflag) {
		this.privatecontentflag = privatecontentflag;
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

	public String getDisplay_style() {
		return display_style;
	}

	public void setDisplay_style(String display_style) {
		this.display_style = display_style;
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

	public String getBackgroundtransparency() {
		return backgroundtransparency;
	}

	public void setBackgroundtransparency(String backgroundtransparency) {
		this.backgroundtransparency = backgroundtransparency;
	}

	public String getForegroundtransparency() {
		return foregroundtransparency;
	}

	public void setForegroundtransparency(String foregroundtransparency) {
		this.foregroundtransparency = foregroundtransparency;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public String getScroll_direction() {
		return scroll_direction;
	}

	public void setScroll_direction(String scroll_direction) {
		this.scroll_direction = scroll_direction;
	}

	public String getScalerelativetoscreen() {
		return scalerelativetoscreen;
	}

	public void setScalerelativetoscreen(String scalerelativetoscreen) {
		this.scalerelativetoscreen = scalerelativetoscreen;
	}

	public Long getOsdid() {
		return osdid;
	}

	public void setOsdid(Long osdid) {
		this.osdid = osdid;
	}

	public String getDisplayperiod() {
		return displayperiod;
	}

	public void setDisplayperiod(String displayperiod) {
		this.displayperiod = displayperiod;
	}

	public String getDisplaydurationtime() {
		return displaydurationtime;
	}

	public void setDisplaydurationtime(String displaydurationtime) {
		this.displaydurationtime = displaydurationtime;
	}

	public String getServiceid() {
		return serviceid;
	}

	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}

	public String getAreaiddisplayflag() {
		return areaiddisplayflag;
	}

	public void setAreaiddisplayflag(String areaiddisplayflag) {
		this.areaiddisplayflag = areaiddisplayflag;
	}

}
