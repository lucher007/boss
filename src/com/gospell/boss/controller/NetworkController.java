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
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Store;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/network")
@Transactional
public class NetworkController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IMenuDao menuDao; 
    
	
	/**
     * 初始化network的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initNetworkJson")
    public List<Network> initNetworkJson(Network form) {
		//封装返回给页面的json对象
		HashMap<String,Object> networkJson = new HashMap<String,Object>();
        
        // 构建网络Map对象
		
 		List<Network> networklist = networkDao.queryByList(form);
 		
 		//networkJson.put("network", networklist);
 		
 		return networklist;
    }
	
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Network form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		
		form.setPager_count(networkDao.findByCount(form));
		form.setNetworklist(networkDao.findByTree(form));
		return "network/findNetworkList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Network form) {
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "network/addNetwork";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Network form){
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("network.netid.empty"));
			return addInit(form);
		} else {
			Network oldNetwork = networkDao.findByNetid(form);
			if (oldNetwork != null) {
				form.setReturninfo(getMessage("network.netid.existed"));
				return addInit(form);
			}
		}
		
		// 设置网络的CODE
		if (form.getPid() == null || "".equals(form.getPid())) {// 属于顶级网络，编码就是网络ID
			form.setCode(form.getNetid().toString());
		} else {// 不属于顶级网络,它的编码既为父网络的编码+"-"+该网络的网络ID
			Network network = new Network();
			network.setId(form.getPid());
			Network ParentNetwork = networkDao.findById(network.getId());
			form.setCode(ParentNetwork.getCode() + "-" + form.getNetid());
		}
		
		networkDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Network form){
		
		form.setNetwork(networkDao.findById(form.getId()));
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "network/updateNetwork";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Network form){
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("network.netid.empty"));
			return updateInit(form);
		} 
		
		Network oldNetwork = networkDao.findByNetid(form);
		if (oldNetwork != null && !oldNetwork.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("network.netid.existed"));
			return updateInit(form);
		}
		
		
		// 设置网络的新CODE
		if (form.getPid() == null) {// 属于顶级网络，编码就是网络ID
			form.setCode(form.getNetid().toString());
		} else {// 不属于顶级网络,它的编码既为父网络的编码+"-"+该网络的网络ID
			Network network = new Network();
			network.setId(form.getPid());
			Network parentNetwork = networkDao.findById(network.getId());
			form.setCode(parentNetwork.getCode() + "-" + form.getNetid());
		}

        oldNetwork = networkDao.findById(form.getId());
        //修改网络信息
		Integer id = networkDao.update(form);

		// 修改该网络下的所有的CODE
		form.setOldcode(oldNetwork.getCode());
		form.setNewcode(form.getCode());
		networkDao.updateCode(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Network form) {

		List<Network> childNetwork = networkDao.queryListByPid(form.getId());
		if (childNetwork != null && childNetwork.size() > 0) {
            form.setReturninfo(getMessage("network.children.existed"));
            return findByList(form);
		}

		String netid = networkDao.findById(form.getId()).getNetid();
		// 删除网络
		networkDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getNetwork")
    public List<HashMap<String, Object>> getNetwork(Network form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> networksJSON = new ArrayList<HashMap<String, Object>>();
		
		//封装默认的请选择行数据()
		HashMap<String,Object> selectednetworkMap = new HashMap<String, Object>();
		selectednetworkMap.put("id", "");
		selectednetworkMap.put("netid", "");
		selectednetworkMap.put("netname", getMessage("page.select"));
		networksJSON.add(selectednetworkMap);
		
    	List<Network> networkList = networkDao.queryByList(form);
 		for (Network network : networkList) {
 			HashMap<String,Object> networkMap = new HashMap<String, Object>();
 			networkMap.put("id", network.getId());
 			networkMap.put("netid", network.getNetid());
 			networkMap.put("netname", network.getNetname());
 			networksJSON.add(networkMap);
        }
	    
 		return networksJSON;
	}
	
}
