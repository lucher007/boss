package com.gospell.boss.service;

import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;

/**
 * 高安CA业务层接口
 */
public interface IGosgnCaService {
	
	/**
	 * 初始化机顶盒发卡命令 (commandtype=166，0xA6)
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public String getInitStbCommand(Userstb userstb);
	
	/**
	 * 激活机顶盒命令 (commandtype=165，0xA5)
	 * 
	 * @param userstb
	 * @return
	 */
	public String getActivateStbCommand(Userstb userstb);
	
	/**
	 * 购买产品授权 (commandtype=193，0xc1)
	 * @param userproduct
	 * @return
	 */
	public String  getBuyProductCommand(Userstb userstb);
	
	/**
	 * 终端状态控制 (commandtype=167，0xA7) 
	 * @param Userstb
	 */
	public String  getStopAndOnStbCommand(Userstb userstb,String commandType);
	
	/**
	 * 初始化机顶盒发卡命令 (commandtype=168，0xA8)
	 */
	public String  getRechargeWalletCommand(Userstb userstb);
}
