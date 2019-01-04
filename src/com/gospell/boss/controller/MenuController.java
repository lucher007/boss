package com.gospell.boss.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IMenuDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IOperatorrolerefDao;
import com.gospell.boss.dao.IRoleDao;
import com.gospell.boss.dao.IStoreDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Operatorroleref;
import com.gospell.boss.po.Role;
import com.gospell.boss.po.Store;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/menu")
@Transactional
public class MenuController extends BaseController {
	@Autowired
	private IOperatorDao operatorDao;
	@Autowired
	private IStoreDao storeDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IRoleDao roleDao;
	@Autowired
	private IOperatorrolerefDao operatorrolerefDao;

	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateInit")
	public String updateInit(Operator form, HttpSession session) {
		Operator nowOperator = (Operator) session.getAttribute("Operator");
		form.setOperator(nowOperator);
		form.setNetwork(networkDao.findById(nowOperator.getNetid()));
		Area areaForm = new Area();
		areaForm.setNetid(nowOperator.getNetid());
		areaForm.setAreacode(nowOperator.getAreacode());
		form.setArea(areaDao.findByAreacode(areaForm));
		form.setStore(storeDao.findById(nowOperator.getStoreid()));
		//form.setRoleid(operatorrolerefDao.findByOperatorid(nowOperator.getId()).getRoleid());
//		// 构建网络Map对象
//		List<Network> networklist = networkDao.queryByList(new Network());
//		Map<Integer, String> networkmap = new HashMap<Integer, String>();
//		for (Iterator iterator = networklist.iterator(); iterator.hasNext();) {
//			Network network = (Network) iterator.next();
//			networkmap.put(network.getId(), network.getNetname());
//		}
//		form.setNetworkmap(networkmap);
/*		// 构建Role对象
		List<Role> roleList = roleDao.queryByList(new Role());
		Map<Integer, String> roleMap = new HashMap<Integer, String>();
		for (Role role : roleList) {
			roleMap.put(role.getId(), getMessage(role.getRolename()));
		}
		form.setRolemap(roleMap);*/
		// 构建StoreMap对象
//		List<Store> storelist = storeDao.queryByList(new Store());
//		Map<Integer, String> storemap = new HashMap<Integer, String>();
//		for (Iterator iterator = storelist.iterator(); iterator.hasNext();) {
//			Store store = (Store) iterator.next();
//			storemap.put(store.getId(), store.getStorename());
//		}
//		form.setStoremap(storemap);
		
		
		return "main/updateOperator";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Operator form, HttpSession session) {
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("operator.operatorcode.empty"));
			return updateInit(form, session);
		}
		if ("".equals(form.getLoginname())) {
			form.setReturninfo(getMessage("operator.loginname.empty"));
			return updateInit(form, session);
		} else {
			Operator oldOperator = operatorDao.findByLoginname(form);
			if (oldOperator != null) {
				form.setReturninfo(getMessage("operator.loginname.existed"));
				return updateInit(form, session);
			}
		}
		// 此操作员选择了营业厅
		if (form.getStoreid() != null) {
			Store store = storeDao.findById(form.getStoreid());
			if (store != null) {
				form.setNetid(store.getNetid());
			}
		}
		/*Operatorroleref orref = operatorrolerefDao.findByOperatorid(form.getId());
		orref.setOperatorid(form.getId());
		orref.setRoleid(form.getRoleid());
		operatorrolerefDao.update(orref);*/

		// 修改网络信息
		Operator beforeOperator = (Operator) session.getAttribute("Operator");
		form.setOperatortype(beforeOperator.getOperatortype());//保持原TYPE。因为MENU页面的修改不允许修改操作员类型
		operatorDao.update(form);
		form.setLoginname(beforeOperator.getLoginname());
		session.setAttribute("Operator", operatorDao.findByLoginname(form));
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form, session);
	}

	/**
	 * 密码修改初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updatePasswordInit")
	public String updatePasswordInit(Operator form) {
		form.setOperator(operatorDao.findById(form.getId()));
		return "main/updatePassword";
	}

	/**
	 * 密码修改
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updatePassword")
	public String updatePassword(Operator form) {
		Operator oldOperator = operatorDao.findById(form.getId());
		String oldpassword = oldOperator.getPassword();
		if (oldpassword != null) {
			if (!oldpassword.equals(getRequest().getParameter("oldPassword"))) {
				form.setReturninfo(getMessage("operator.oldpassword.error"));
				return updatePasswordInit(form);
			}
		}
		form.setPassword(getRequest().getParameter("password"));
		Integer updateFlag = operatorDao.updatePassword(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updatePasswordInit(form);
	}
}
