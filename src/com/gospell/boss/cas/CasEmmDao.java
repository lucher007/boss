package com.gospell.boss.cas;

/**
 * @Title CasEmmDao.java
 * @version 1.0 Boss-Ca实现类
 */
public class CasEmmDao  {
    
	//判断机顶盒CA类型，根据不同的CA类型调用不同的CA指令
	public static String getCaCommand(CaCommandParam caCommandPara){
		String caCommand = "";
		if("gos_pn".equals(caCommandPara.getVersiontype())){//高斯贝尔普安机顶盒
			caCommand = GospnCaDao.getCaCommand(caCommandPara);
		}else if("gos_gn".equals(caCommandPara.getVersiontype())){//高斯贝尔高安机顶盒
			caCommand = GosgnCaDao.getCaCommand(caCommandPara);
		}
		return caCommand;
	}
	
}
