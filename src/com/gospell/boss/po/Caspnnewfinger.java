package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.gospell.boss.po.BaseField;

@SuppressWarnings("serial")
public class Caspnnewfinger extends BaseField implements Serializable {

	private Integer id; // OSD标识
	private Integer netid; //网络ID
	private String cardid; // 智能卡号
	private String conditioncontent; // 条件内容
	private String expiredtime; // 过期时间
	private String reservedfutureuse; // 0xFFFFFFFF
	private String iscontrol; // 1：启动，0：取消
	private String starttime; // 开始时间
	private String endtime; //结束时间
	private String lockscreen; // 锁定用
	private String duration; // 显示时间长度
	private String intervaltime; // 间隔时间
	private String showtimes; // 显示次数
	private String fontsize; // 字体大小
	private String fontcolor; // 字体颜色RGBA
	private String backgroundcolor; // 背景色RGBA
	private String postype; // 显示的位置模式
	private String posx; // 显示坐标X，PosType为1时有效
	private String posy; // 显示坐标Y，PosType为1时有效
	private String channelids; // 需要显示FP的频道号，多个以逗号(,)隔开
	private String showfreq; // 显示频率
	private String showtype; // 显示类型
	private String idtype; // ID类型
	private String content; // 内容(8到16个字符)
	private String addtime;
	private String remark; // 备注
	private Map<Integer, String> networkmap;

	
	//-----高安需要用的字段
	private String versiontype; //版本类型
	private String stbno;     //机顶盒号
	private String addressingmode; //寻址方式：单播-0；多播-1；
	private String conditioncount; //寻址段数
	private String foregroundcolor; //前景色RGA
	private String foregroundtransparency;//前景透明度
	private String backgroundtransparency;//背景透明度
	private String fingerheight; //指纹高度
	private String encryptflag; //是否加密(0-不加密；1-加密）
	private String cardiddisplayflag; //是否显示卡号（0-不显示；1-显示）
	private String terminaliddisplayflag; //是否显示终端号（0-不显示；1-显示）
	private String operatoriddisplayflag; //是否显示运营商号（0-不显示；1-显示）
	private String privatecontentflag;    //是否显示私有内容（0-不显示；1-显示）
	private String hideflag; //是否隐藏（0-不隐藏；1-隐藏）
	private String ramdompositionflag; //指纹显示方式(0-指定位置显示；1-随机显示）
	private Long fingerid; //指纹ID
	private String areaiddisplayflag; //是否包含区域ID
	private String displayfrequency; //显示频率
	private String displaydurationtime; //单次显示持续时间
	private String layout; //显示的布局(0-水平;1-垂直)
	private String fonttype; //字体类型
	

	/****************** 数据库辅助字段 *************************/
	private Caspnnewfinger caspnnewfinger;
	private List<Caspnnewfinger> caspnnewfingerlist;
	private String querycardid;
	private String querydate;
	private String queryversiontype;
	private String querynetid;

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

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

	public String getConditioncontent() {
		return conditioncontent;
	}

	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}

	public String getExpiredtime() {
		return expiredtime;
	}

	public void setExpiredtime(String expiredtime) {
		this.expiredtime = expiredtime;
	}

	public String getReservedfutureuse() {
		return reservedfutureuse;
	}

	public void setReservedfutureuse(String reservedfutureuse) {
		this.reservedfutureuse = reservedfutureuse;
	}

	public String getIscontrol() {
		return iscontrol;
	}

	public void setIscontrol(String iscontrol) {
		this.iscontrol = iscontrol;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getLockscreen() {
		return lockscreen;
	}

	public void setLockscreen(String lockscreen) {
		this.lockscreen = lockscreen;
	}

	public String getDuration() {
		if(StringUtils.isEmpty(duration)){
			duration = "0";
		}
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

	public String getPostype() {
		return postype;
	}

	public void setPostype(String postype) {
		this.postype = postype;
	}

	public String getPosx() {
		if(StringUtils.isEmpty(posx)){
			posx = "0";
		}
		return posx;
	}

	public void setPosx(String posx) {
		this.posx = posx;
	}

	public String getPosy() {
		if(StringUtils.isEmpty(posy)){
			posy = "0";
		}
		return posy;
	}

	public void setPosy(String posy) {
		this.posy = posy;
	}

	public String getShowfreq() {
		return showfreq;
	}

	public void setShowfreq(String showfreq) {
		this.showfreq = showfreq;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Caspnnewfinger getCaspnnewfinger() {
		return caspnnewfinger;
	}

	public void setCaspnnewfinger(Caspnnewfinger caspnnewfinger) {
		this.caspnnewfinger = caspnnewfinger;
	}

	public List<Caspnnewfinger> getCaspnnewfingerlist() {
		return caspnnewfingerlist;
	}

	public void setCaspnnewfingerlist(List<Caspnnewfinger> caspnnewfingerlist) {
		this.caspnnewfingerlist = caspnnewfingerlist;
	}

	public String getQuerycardid() {
		return querycardid;
	}

	public void setQuerycardid(String querycardid) {
		this.querycardid = querycardid;
	}

	public String getChannelids() {
		return channelids;
	}

	public void setChannelids(String channelids) {
		this.channelids = channelids;
	}

	public String getShowtype() {
		return showtype;
	}

	public void setShowtype(String showtype) {
		this.showtype = showtype;
	}

	public String getIdtype() {
		return idtype;
	}

	public void setIdtype(String idtype) {
		this.idtype = idtype;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIntervaltime() {
		return intervaltime;
	}

	public void setIntervaltime(String intervaltime) {
		this.intervaltime = intervaltime;
	}

	public String getQuerydate() {
		return querydate;
	}

	public void setQuerydate(String querydate) {
		this.querydate = querydate;
	}

	public Integer getNetid() {
		return netid;
	}

	public void setNetid(Integer netid) {
		this.netid = netid;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
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

	public String getForegroundcolor() {
		return foregroundcolor;
	}

	public void setForegroundcolor(String foregroundcolor) {
		this.foregroundcolor = foregroundcolor;
	}

	public String getForegroundtransparency() {
		return foregroundtransparency;
	}

	public void setForegroundtransparency(String foregroundtransparency) {
		this.foregroundtransparency = foregroundtransparency;
	}

	public String getBackgroundtransparency() {
		return backgroundtransparency;
	}

	public void setBackgroundtransparency(String backgroundtransparency) {
		this.backgroundtransparency = backgroundtransparency;
	}

	public String getFingerheight() {
		if(StringUtils.isEmpty(fingerheight)){
			fingerheight = "0";
		}
		return fingerheight;
	}

	public void setFingerheight(String fingerheight) {
		this.fingerheight = fingerheight;
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

	public String getRamdompositionflag() {
		return ramdompositionflag;
	}

	public void setRamdompositionflag(String ramdompositionflag) {
		this.ramdompositionflag = ramdompositionflag;
	}

	public String getEncryptflag() {
		return encryptflag;
	}

	public void setEncryptflag(String encryptflag) {
		this.encryptflag = encryptflag;
	}

	public String getHideflag() {
		return hideflag;
	}

	public void setHideflag(String hideflag) {
		this.hideflag = hideflag;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public Long getFingerid() {
		return fingerid;
	}

	public void setFingerid(Long fingerid) {
		this.fingerid = fingerid;
	}

	public String getAreaiddisplayflag() {
		return areaiddisplayflag;
	}

	public void setAreaiddisplayflag(String areaiddisplayflag) {
		this.areaiddisplayflag = areaiddisplayflag;
	}

	public String getDisplayfrequency() {
		return displayfrequency;
	}

	public void setDisplayfrequency(String displayfrequency) {
		this.displayfrequency = displayfrequency;
	}

	public String getDisplaydurationtime() {
		return displaydurationtime;
	}

	public void setDisplaydurationtime(String displaydurationtime) {
		this.displaydurationtime = displaydurationtime;
	}

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public String getFonttype() {
		return fonttype;
	}

	public void setFonttype(String fonttype) {
		this.fonttype = fonttype;
	}

}
