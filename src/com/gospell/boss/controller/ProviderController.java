package com.gospell.boss.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.User;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/provider")
@Transactional
public class ProviderController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IProviderDao providerDao; 
	@Autowired
	private IStbDao stbDao; 
	@Autowired
	private ICardDao cardDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Provider form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(providerDao.findByCount(form));
		form.setProviderlist(providerDao.findByList(form));
		return "provider/findProviderList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Provider form) {
		return "provider/addProvider";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Provider form){
		if ("".equals(form.getModel())) {
			form.setReturninfo(getMessage("provider.model.empty"));
			return addInit(form);
		} else {
			Provider oldProvider = providerDao.findByModel(form);
			if (oldProvider != null) {
				form.setReturninfo(getMessage("provider.model.existed"));
				return addInit(form);
			}
		}
		
		providerDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Provider form){
		
		form.setProvider(providerDao.findById(form.getId()));
		
		return "provider/updateProvider";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Provider form){
		if ("".equals(form.getModel())) {
			form.setReturninfo(getMessage("provider.model.empty"));
			return updateInit(form);
		} 
		
		Provider oldProvider = providerDao.findByModel(form);
		if (oldProvider != null && !oldProvider.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("provider.model.existed"));
			return updateInit(form);
		}
		
        //修改网络信息
	    providerDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Provider form) {

		//查询该规格型号下存在机顶盒
		Stb stbForm = new Stb();
		stbForm.setQueryproviderid(String.valueOf(form.getId()));
		List<Stb> stbList = stbDao.queryByList(stbForm);
		if(stbList != null && stbList.size() > 0){
			form.setReturninfo(getMessage("provider.stb.notempty"));
			return findByList(form);
		}
		
		//查询该规格型号下存在机顶盒
		Card cardForm = new Card();
		cardForm.setQueryproviderid(String.valueOf(form.getId()));
		List<Card> cardList = cardDao.queryByList(cardForm);
		if(cardList != null && cardList.size() > 0){
			form.setReturninfo(getMessage("provider.card.notempty"));
			return findByList(form);
		}
		
		// 删除规格型号
		providerDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
}
