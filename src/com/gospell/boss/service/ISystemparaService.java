package com.gospell.boss.service;

/**
 * CA业务层接口
 */
public interface ISystemparaService {
	
	/**
	 * 智能卡批量发卡操作
	 */
	public String  findSystemParaByCodeStr(String paracode);
	
}
