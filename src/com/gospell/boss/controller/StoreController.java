package com.gospell.boss.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.dao.IMenuDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Store;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/store")
@Transactional
public class StoreController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IStoreDao storeDao; 
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IMenuDao menuDao; 
	@Autowired
	private IOperatorDao operatorDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Store form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(storeDao.findByCount(form));
		List<Store> storelist = storeDao.findByList(form);
		for (Store store : storelist) {
			store.setNetwork(networkDao.findById(store.getNetid()));
		}
		form.setStorelist(storelist);
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "store/findStoreList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Store form) {
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "store/addStore";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Store form){
		if ("".equals(form.getStorecode())) {
			form.setReturninfo(getMessage("store.storecode.empty"));
			return addInit(form);
		} else {
			Store oldStore = storeDao.findByStorecode(form);
			if (oldStore != null) {
				form.setReturninfo(getMessage("store.storecode.existed"));
				return addInit(form);
			}
		}
		
		//state默认设为1-有效
		form.setState("1");
		storeDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Store form){
		
		form.setStore(storeDao.findById(form.getId()));
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "store/updateStore";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Store form){
		if ("".equals(form.getStorecode())) {
			form.setReturninfo(getMessage("store.storecode.empty"));
			return updateInit(form);
		} 
		
		Store oldStore = storeDao.findByStorecode(form);
		if (oldStore != null && !oldStore.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("store.storecode.existed"));
			return updateInit(form);
		}

        oldStore = storeDao.findById(form.getId());
        //修改网络信息
		Integer id = storeDao.update(form);
		
		//将营业厅修改成失效，该营业厅下所有操作员都修改失效
		if("0".equals(form.getState())){
			Operator operator = new Operator();
			operator.setQuerystoreid(String.valueOf(form.getId()));
			List<Operator> operatorlist = operatorDao.queryByList(operator);
			for (Operator operator2 : operatorlist) {
				operator2.setState("0");
				operator2.setStoreid(null);
				operatorDao.update(operator2);
			}
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Store form) {
		// 删除网络，实际上就是修改state为0-无效
		Store storedmp = storeDao.findById(form.getId());
		storedmp.setState("0");
		storeDao.update(storedmp);
		
		//该营业厅下所有操作员都修改失效
		Operator operator = new Operator();
		operator.setQuerystoreid(String.valueOf(form.getId()));
		List<Operator> operatorlist = operatorDao.queryByList(operator);
		for (Operator operator2 : operatorlist) {
			operator2.setState("0");
			operator2.setStoreid(null);
			operatorDao.update(operator2);
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getStore")
    public List<HashMap<String, Object>> getStore(Store form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> storesJSON = new ArrayList<HashMap<String, Object>>();
		
		Operator operator = (Operator)getSession().getAttribute("Operator");
		Integer storeid = operator.getStoreid();
		
		if(storeid == null){
			//封装默认的请选择行数据()
			HashMap<String,Object> selectedstoreMap = new HashMap<String, Object>();
			selectedstoreMap.put("id", "");
			selectedstoreMap.put("netid", "");
			selectedstoreMap.put("storename", getMessage("page.select"));
			storesJSON.add(selectedstoreMap);
			
			//先判断网络有没有选择
		    if(StringUtils.isNotEmpty(form.getQuerynetid())){
		    	List<Store> stores = storeDao.queryByList(form);
		 		for (Store store : stores) {
		 			HashMap<String,Object> storeMap = new HashMap<String, Object>();
		 			storeMap.put("id", store.getId());
		 			storeMap.put("netid", store.getNetid());
		 			storeMap.put("storename", store.getStorename());
		 			storesJSON.add(storeMap);
		        }
		    }
		}else{
			Store store = storeDao.findById(storeid);
			if(store == null){
				store = new Store();
			}
			
			HashMap<String,Object> storeMap = new HashMap<String, Object>();
 			storeMap.put("id", store.getId());
 			storeMap.put("netid", store.getNetid());
 			storeMap.put("storename", store.getStorename());
 			storesJSON.add(storeMap);
		}
		
 		return storesJSON;
	}
	
	
	
}
