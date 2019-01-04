package com.gospell.boss.service;

import com.gospell.boss.po.Card;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;

/**
 * 高安CA业务层接口
 */
public interface IGospnCaService {
	
	/**
	 * 运营商发卡命令 (commandtype=10)
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public String getInitCardCommand(Usercard usercard);
	
	/**
	 * 激活机智能卡命令 (commandtype=11)
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public String getActivateCardCommand(Usercard usercard);
	
	/**
	 * 购买产品命令 (commandtype=1)
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public String getBuyProductCommand(Usercard usercard);
	
	/**
	 * 终端状态控制 (commandtype=11) 
	 */
	public String getStopAndOnCardCommand(Usercard usercard,String commandType);
	
	/**
	 * 机卡绑定A(对机顶盒操作)（Command_Type ＝ 36）
	 */
	public String  getStbBingCardCommand(Userstb userStb);
	
	/**
	 * 电子钱包充值 (commandtype=16)
	 */
	public String  getRechargeWalletCommand(Usercard usercard);
	
	/**
	 * 批量发卡命令 (commandtype=10)
	 */
	public String  getBatchsendcardCommand(Card card,String userareacode);
}
