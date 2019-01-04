package com.gospell.boss.service;

import com.gospell.boss.po.Card;

/**
 * CA业务层接口
 */
public interface ICardService {
	
	/**
	 * 根据智能卡号查询智能卡信息，包括规格型号
	 * 
	 * @param cardid
	 * @return
	 */
	public Card findCardInfoByCardidStr(String cardid);
	
	/**
	 * 根据配对机顶盒查询智能卡信息，包括规格型号，价格等
	 * 
	 * @param stbno
	 * @return
	 */
	public Card findCardInfoByStbnoStr(String stbno);
	
}
