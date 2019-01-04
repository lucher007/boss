package com.gospell.boss.service.impl;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Systempara;
import com.gospell.boss.service.ISystemparaService;

/**
 * @Title SystemparaServiceImpl.java
 * @version 1.0 高斯贝尔高安Ca实现类
 */
@Service("systemparaService")
public class SystemparaServiceImpl implements ISystemparaService {
	@Autowired
	private ISystemparaDao systemparaDao;
	
	/**
	 * 根据CODE查询系统参数值
	 */
	public String  findSystemParaByCodeStr(String paracode) {
		
		Systempara para = new Systempara();
		para.setCode(paracode);
		para = systemparaDao.findByCode(para);
		if(para != null && !"".equals(para.getValue())){
			return para.getValue();
		}else{
			return "";
		}
	}
}
