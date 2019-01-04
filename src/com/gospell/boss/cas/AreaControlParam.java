package com.gospell.boss.cas;

import java.io.Serializable;

import com.gospell.boss.po.BaseField;

/**
 * 授权指令参数表
 */
@SuppressWarnings("serial")
public class AreaControlParam extends BaseField implements Serializable {
	
    private String Areano;	                //区域号，（0xFFFF表示所有分区，此时N只能为1）
    private String IsControl;               //开启/关闭（ 00 开启，01 取消）
	private String Set_command_Time;        //设置时间，以此命令判断矛盾命令的先后,后命令有效
	private String Reserved;                //保留字节(0xFF)
	
	
	public String getAreano() {
		return Areano;
	}
	public void setAreano(String areano) {
		Areano = areano;
	}
	public String getIsControl() {
		return IsControl;
	}
	public void setIsControl(String isControl) {
		IsControl = isControl;
	}
	public String getSet_command_Time() {
		return Set_command_Time;
	}
	public void setSet_command_Time(String set_command_Time) {
		Set_command_Time = set_command_Time;
	}
	public String getReserved() {
		return Reserved;
	}
	public void setReserved(String reserved) {
		Reserved = reserved;
	}
	
}

	
	
	
	


