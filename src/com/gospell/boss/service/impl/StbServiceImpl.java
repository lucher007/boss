package com.gospell.boss.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Stb;
import com.gospell.boss.service.IStbService;

/**
 * @Title StbServiceImpl.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("stbService")
public class StbServiceImpl implements IStbService {
	@Autowired
	private IStbDao stbDao;
	@Autowired
	private IProviderDao providerDao;
	
	/**
	 * 机顶盒购买业务
	 */
	public Stb findStbInfoByStbnoStr(String stbno) {
		//获取订户信息
		Stb stb = stbDao.findByStbnoStr(stbno);
		if(stb != null){
			Provider provider = providerDao.findById(stb.getProviderid());
			stb.setProvider(provider);
			stb.setCompanyname(provider.getCompanyname());
			stb.setModel(provider.getModel());
			stb.setMainprice(provider.getMainprice());
			stb.setSubprice(provider.getSubprice());
		}
		return stb;
	}
}
