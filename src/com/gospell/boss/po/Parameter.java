package com.gospell.boss.po;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
/**
 * 用户实体类
 */
public class Parameter extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//单价收费单位
	public static String UNIT_YEAR = "year";
	public static String UNIT_MONTH = "month";
	public static String UNIT_DAY = "day";
	public static String UNIT_WEEK = "week";
	public static String UNIT_HOUR = "hour";
	public static String UNIT_ONE = "one";
	
	//cas版本类型
	public static String cas_GOS_GN ="gos_gn"; //高斯贝尔高安CA
	public static String cas_GOS_PN ="gos_pn"; //高斯贝尔普安CA
	
	/** 
     * 获得指定服务器类型的版本类型 
     *  
     * @param servertype：cas
     * @return 
     */  
	public static HashMap<String,String>  getVersiontypeHashMap(String servertype){
		HashMap<String,String> versiontypeHp= new HashMap<String,String>();
		if("cas".equals(servertype)){//获取CA的版本类型
			versiontypeHp.put("gos_gn", "gos_gn");
			versiontypeHp.put("gos_pn", "gos_pn");
		}
		return versiontypeHp;
	}
	
}
