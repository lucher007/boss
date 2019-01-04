package com.gospell.boss.cas;


public class ConditionAddr {
	
    private String startCardid;	             //开始卡号
    private String endCardid;	             //结束卡号
    private String startAreano;	             //开始区域号
    private String endAreano;	             //结束区域号
    private String vip_Class;                //VIP订户（集团订户）
    
    private String conditioncontent ;        //条件内容
    private String Condition_Cmd_Type;       //需要条件寻址的命令类型
    private String Contition_Cmd_Content ;   //不同的命令有不同的格式 	需要条件寻址的命令内容
    
    
    
	public String getStartCardid() {
		return startCardid;
	}
	public void setStartCardid(String startCardid) {
		this.startCardid = startCardid;
	}
	public String getEndCardid() {
		return endCardid;
	}
	public void setEndCardid(String endCardid) {
		this.endCardid = endCardid;
	}
	public String getStartAreano() {
		return startAreano;
	}
	public void setStartAreano(String startAreano) {
		this.startAreano = startAreano;
	}
	public String getEndAreano() {
		return endAreano;
	}
	public void setEndAreano(String endAreano) {
		this.endAreano = endAreano;
	}
	public String getVip_Class() {
		return vip_Class;
	}
	public void setVip_Class(String vip_Class) {
		this.vip_Class = vip_Class;
	}

	
	public String getCondition_Cmd_Type() {
		return Condition_Cmd_Type;
	}
	public void setCondition_Cmd_Type(String condition_Cmd_Type) {
		Condition_Cmd_Type = condition_Cmd_Type;
	}
	public String getContition_Cmd_Content() {
		return Contition_Cmd_Content;
	}
	public void setContition_Cmd_Content(String contition_Cmd_Content) {
		Contition_Cmd_Content = contition_Cmd_Content;
	}
	public String getConditioncontent() {
		return conditioncontent;
	}
	public void setConditioncontent(String conditioncontent) {
		this.conditioncontent = conditioncontent;
	}
    
    
	
}
