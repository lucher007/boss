package com.gospell.boss.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserfeedbackDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userfeedback;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/userfeedback")
@Transactional
public class UserfeedbackController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IUserfeedbackDao userfeedbackDao; 
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IUserDao userDao; 
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Userfeedback form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userfeedbackDao.findByCount(form));
		List<Userfeedback> userfeedbacklist = userfeedbackDao.findByList(form);
		for (Userfeedback userfeedback : userfeedbacklist) {
			Network network = networkDao.findById(userfeedback.getNetid());
			if(network == null){
				network = new Network();
			}
			
			User user = userDao.findById(userfeedback.getUserid());
			if(user == null){
				user = new User();
			}
			userfeedback.setNetwork(network);
			userfeedback.setUser(user);
		}
	
		
		form.setUserfeedbacklist(userfeedbacklist);
		
		return "userfeedback/findUserfeedbackList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Userfeedback form) {
		// 构建StoreMap对象
		return "userfeedback/addUserfeedback";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Userfeedback form){
		userfeedbackDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Userfeedback form){
		
		form.setUserfeedback(userfeedbackDao.findById(form.getId()));
		
		return "userfeedback/updateUserfeedback";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Userfeedback form){
		
		Integer id = userfeedbackDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Userfeedback form) {

		//String netid = userfeedbackDao.findById(form.getId()).getNetid();
		// 删除
		userfeedbackDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
}
