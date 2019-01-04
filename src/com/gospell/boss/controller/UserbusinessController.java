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
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.po.Businesstype;
import com.gospell.boss.po.Userbusiness;
import com.gospell.boss.po.Userbusinessdetail;

/**
 * 系统参数控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/userbusiness")
@Transactional
public class UserbusinessController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IUserbusinessdetailDao userbusinessdetailDao; 
	@Autowired
	private IBusinesstypeDao businesstypeDao; 
	@Autowired
	private IOperatorDao operatorDao; 

	/**
	 * 查询系统参数信息
	 */
	@RequestMapping(value="/findBusinessdetailByList")
	public String findBusinessdetailByList(Userbusinessdetail form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userbusinessdetailDao.findByCount(form));
		
		List<Userbusinessdetail> userbusinessdetaillist = userbusinessdetailDao.findByList(form);
		for (Userbusinessdetail userbusinessdetail : userbusinessdetaillist) {
			userbusinessdetail.setOperator(operatorDao.findById(userbusinessdetail.getOperatorid()));
			userbusinessdetail.setBusinesstype(businesstypeDao.findByTypekeyStr(userbusinessdetail.getBusinesstypekey()));
		}
		
		form.setUserbusinessdetaillist(userbusinessdetaillist);
		
		return "user/findUserbusinessdetailList";
	}
	
	/**
	 * 查询系统参数信息
	 */
	@RequestMapping(value="/cancelfeeUint")
	public String cancelfeeUint(Userbusinessdetail form) {
		
		//只查询产品授权费用
		form.setBusinesstypekey("buyproduct");
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userbusinessdetailDao.findByCount(form));
		
		List<Userbusinessdetail> userbusinessdetaillist = userbusinessdetailDao.findByList(form);
		for (Userbusinessdetail userbusinessdetail : userbusinessdetaillist) {
			userbusinessdetail.setOperator(operatorDao.findById(userbusinessdetail.getOperatorid()));
			userbusinessdetail.setBusinesstype(businesstypeDao.findByTypekeyStr(userbusinessdetail.getBusinesstypekey()));
		}
		
		form.setUserbusinessdetaillist(userbusinessdetaillist);
		
		return "user/cancelfeeDetail";
	}
	
}
