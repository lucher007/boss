package com.gospell.boss.service;

import com.gospell.boss.po.Stb;


/**
 * CA业务层接口
 */
public interface IStbService {
	
	/**
	 * 根据机顶盒号查询机顶盒信息，包括规格型号
	 * 
	 * @param Userstb
	 * @return
	 */
	public Stb findStbInfoByStbnoStr(String stbno);
	
	
	
}
