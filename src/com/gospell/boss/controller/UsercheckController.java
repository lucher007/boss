package com.gospell.boss.controller;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.User;

/**
 * 系统参数控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/usercheck")
@Transactional
public class UsercheckController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IUserDao userDao; 
	@Autowired
	private INetworkDao networkDao; 

	/**
	 * 查询系统参数信息
	 */
	@RequestMapping(value="/findUncheckUserByList")
	public String findUncheckUser(User form) {
		form.setQuerystate("3");
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userDao.findByCount(form));
		List<User> userlist = userDao.findByList(form);
		for (User user : userlist) {
			user.setNetwork(networkDao.findById(user.getNetid()));
		}
		form.setUserlist(userlist);
		
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "user/findUncheckUserByList";
	}
	

	
}
