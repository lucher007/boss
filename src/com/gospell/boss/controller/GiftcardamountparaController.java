package com.gospell.boss.controller;


import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.IGiftcardamountparaDao;
import com.gospell.boss.po.Giftcardamountpara;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/giftcardamountpara")
@Transactional
public class GiftcardamountparaController extends BaseController{
	
	@Autowired 
	private IGiftcardamountparaDao giftcardamountparaDao;
	@Autowired 
	private ServletContext servletContext;

	
	/**
	 * 查询礼品卡价格参数信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Giftcardamountpara form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(giftcardamountparaDao.findByCount(form));
		List<Giftcardamountpara> giftcardamountparalist = giftcardamountparaDao.findByList(form);
		form.setGiftcardamountparalist(giftcardamountparalist);
		return "giftcardamountpara/findGiftCardAmountParaList";
	}
	
	/**
	 * 添加信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Giftcardamountpara form) {
		
		return "giftcardamountpara/addGiftCardAmountPara";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Giftcardamountpara form){
		
		giftcardamountparaDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Giftcardamountpara form){
		form.setGiftcardamountpara(giftcardamountparaDao.findById(form.getId()));
		return "giftcardamountpara/updateGiftcardamountpara";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Giftcardamountpara form){
		//保存修改
		giftcardamountparaDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Giftcardamountpara form) {
		giftcardamountparaDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}

}
