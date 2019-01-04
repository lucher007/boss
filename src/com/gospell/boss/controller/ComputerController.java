package com.gospell.boss.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.dao.IComputerDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.po.Computer;
import com.gospell.boss.po.Store;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/computer")
@Transactional
public class ComputerController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IComputerDao computerDao; 
	@Autowired
	private IStoreDao storeDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Computer form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(computerDao.findByCount(form));
		
		List<Computer> computerlist = computerDao.findByList(form);
		for (Computer computer : computerlist) {
			computer.setStore(storeDao.findById(computer.getStoreid()));
		}
		form.setComputerlist(computerlist);
		
		// 构建StoreMap对象
		List<Store> list = storeDao.queryByList(new Store());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			map.put(store.getId(), store.getStorename());
		}
		form.setStoremap(map);
		
		return "computer/findComputerList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Computer form) {
		// 构建StoreMap对象
		List<Store> list = storeDao.queryByList(new Store());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			map.put(store.getId(), store.getStorename());
		}
		form.setStoremap(map);
		
		return "computer/addComputer";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Computer form){
		if ("".equals(form.getMacaddress())) {
			form.setReturninfo(getMessage("computer.macaddress.empty"));
			return addInit(form);
		} else {
			Computer oldComputer = computerDao.findByMacaddress(form);
			if (oldComputer != null) {
				form.setReturninfo(getMessage("computer.macaddress.existed"));
				return addInit(form);
			}
		}
		//设置所属网络
		if(form.getStoreid() != null){
			Store store = storeDao.findById(form.getStoreid());
			form.setNetid(store.getNetid());
		}
		
		computerDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Computer form){
		
		form.setComputer(computerDao.findById(form.getId()));
		
		// 构建StoreMap对象
		List<Store> list = storeDao.queryByList(new Store());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Store store = (Store) iterator.next();
			map.put(store.getId(), store.getStorename());
		}
		form.setStoremap(map);
		
		return "computer/updateComputer";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Computer form){
		if ("".equals(form.getMacaddress())) {
			form.setReturninfo(getMessage("computer.macaddress.empty"));
			return updateInit(form);
		} 
		
		Computer oldComputer = computerDao.findByMacaddress(form);
		if (oldComputer != null && !oldComputer.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("computer.macaddress.existed"));
			return updateInit(form);
		}
		
        oldComputer = computerDao.findById(form.getId());
       
       //设置所属网络
  		if(form.getStoreid() != null){
  			Store store = storeDao.findById(form.getStoreid());
  			form.setNetid(store.getNetid());
  		}
	 
      	//修改网络信息
		Integer id = computerDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Computer form) {

		//String netid = computerDao.findById(form.getId()).getNetid();
		// 删除
		computerDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
}
