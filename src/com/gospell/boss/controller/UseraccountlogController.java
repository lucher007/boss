package com.gospell.boss.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.IBusinesstypeDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IUserbusinessDao;
import com.gospell.boss.dao.IUseraccountlogDao;
import com.gospell.boss.po.Businesstype;
import com.gospell.boss.po.Userbusiness;
import com.gospell.boss.po.Useraccountlog;

/**
 * 系统参数控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/useraccountlog")
@Transactional
public class UseraccountlogController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IUseraccountlogDao useraccountlogdetailDao; 
	@Autowired
	private IBusinesstypeDao businesstypeDao; 
	@Autowired
	private IOperatorDao operatorDao; 

	/**
	 * 查询系统参数信息
	 */
	@RequestMapping(value="/findUseraccountlogByList")
	public String findUseraccountlogByList(Useraccountlog form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(useraccountlogdetailDao.findByCount(form));
		
		List<Useraccountlog> useraccountloglist = useraccountlogdetailDao.findByList(form);
		for (Useraccountlog useraccountlog : useraccountloglist) {
			if("2".equals(useraccountlog.getSource())){
				useraccountlog.setOperator(operatorDao.findById(useraccountlog.getOperatorid()));
			}else{
				useraccountlog.setOperator(operatorDao.findById(useraccountlog.getOperatorid()));
			}
		}
		
		form.setUseraccountloglist(useraccountloglist);
		
		return "user/findUseraccountlogList";
	}
	
	
}
