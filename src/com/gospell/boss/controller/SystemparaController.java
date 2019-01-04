package com.gospell.boss.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Systempara;

/**
 * 系统参数控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/systempara")
@Transactional
public class SystemparaController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private ISystemparaDao systemparaDao; 

	/**
	 * 查询系统参数信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Systempara form) {
		form.setQuerystate("1");
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(systemparaDao.findByCount(form));
		
		List<Systempara> systemparalist = systemparaDao.findByList(form);
//		for (Systempara systempara : systemparalist) {
//			systempara.setStore(storeDao.findById(systempara.getStoreid()));
//		}
		form.setSystemparalist(systemparalist);
		
		return "systempara/findSystemparaList";
	}
	
	/**
	 * 添加系统参数信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Systempara form) {
		return "systempara/addSystempara";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Systempara form){
		if ("".equals(form.getCode())) {
			form.setReturninfo(getMessage("systempara.code.empty"));
			return addInit(form);
		} else {
			Systempara oldSystempara = systemparaDao.findByCode(form);
			if (oldSystempara != null) {
				form.setReturninfo(getMessage("systempara.code.existed"));
				return addInit(form);
			}
		}
		systemparaDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Systempara form){
		
		form.setSystempara(systemparaDao.findById(form.getId()));
	
		return "systempara/updateSystempara";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Systempara form){
		if ("".equals(form.getCode())) {
			form.setReturninfo(getMessage("systempara.code.empty"));
			return updateInit(form);
		} 
		
		Systempara oldSystempara = systemparaDao.findByCode(form);
		if (oldSystempara != null && !oldSystempara.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("systempara.code.existed"));
			return updateInit(form);
		}
       
      	//修改网络信息
		Integer id = systemparaDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Systempara form) {

		//String netid = systemparaDao.findById(form.getId()).getNetid();
		// 删除
		systemparaDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
}
