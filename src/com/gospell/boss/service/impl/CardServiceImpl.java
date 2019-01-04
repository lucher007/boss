package com.gospell.boss.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Card;
import com.gospell.boss.service.ICardService;

/**
 * @Title CardServiceImpl.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("cardService")
public class CardServiceImpl implements ICardService {
	@Autowired
	private ICardDao cardDao;
	@Autowired
	private IProviderDao providerDao;
	
	/**
	 * 根据智能卡号查询智能卡信息，包括规格型号
	 */
	public Card findCardInfoByCardidStr(String cardid) {
		//获取订户信息
		Card card = cardDao.findByCardidStr(cardid);
		if(card != null){
			Provider provider = providerDao.findById(card.getProviderid());
			card.setProvider(provider);
			card.setCompanyname(provider.getCompanyname());
			card.setModel(provider.getModel());
			card.setMainprice(provider.getMainprice());
			card.setSubprice(provider.getSubprice());
		}
		return card;
	}
	
	/**
	 * 根据配对机顶盒查询智能卡信息，包括规格型号，价格等
	 */
	public Card findCardInfoByStbnoStr(String stbno) {
		//获取订户信息
		Card card = cardDao.findByStbnoStr(stbno);
		if(card != null){
			Provider provider = providerDao.findById(card.getProviderid());
			card.setProvider(provider);
			card.setCompanyname(provider.getCompanyname());
			card.setModel(provider.getModel());
			card.setMainprice(provider.getMainprice());
			card.setSubprice(provider.getSubprice());
		}
		return card;
	}
	
	
}
