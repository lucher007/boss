package com.gospell.boss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.dao.IBusinesstypeDao;
import com.gospell.boss.po.Businesstype;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/businesstype")
@Transactional
public class BusinesstypeController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IBusinesstypeDao businesstypeDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Businesstype form) {
		
		form.setQuerystate("1");//只查询需要设置业务费用的业务类型
		
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(businesstypeDao.findByCount(form));
		form.setBusinesstypelist(businesstypeDao.findByList(form));
		return "businesstype/findBusinesstypeList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Businesstype form) {
		return "businesstype/addBusinesstype";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Businesstype form){
		if ("".equals(form.getTypekey())) {
			form.setReturninfo(getMessage("业务类型KEY不能为空"));
			return addInit(form);
		} else {
			Businesstype oldBusinesstype = businesstypeDao.findByTypekeyStr(form.getTypekey());
			if (oldBusinesstype != null) {
				form.setReturninfo(getMessage("业务类型KEY已经存在"));
				return addInit(form);
			}
		}
		
		form.setDefinedflag("1");//自定义业务类型
		form.setState("1");
		
		businesstypeDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Businesstype form){
		
		form.setBusinesstype(businesstypeDao.findById(form.getId()));
		
		return "businesstype/updateBusinesstype";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Businesstype form){
		
		Businesstype businesstype = businesstypeDao.findById(form.getId());
		
		businesstype.setPrice(form.getPrice());
		
        //修改网络信息
	    businesstypeDao.update(businesstype);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Businesstype form) {

		//String netid = businesstypeDao.findById(form.getId()).getNetid();
		// 删除网络
		businesstypeDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
     * 获取其他业务类型的下拉列表框值JSON
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initOtherbusinesstypeJson")
    public List<HashMap<String, Object>> initOtherbusinesstypeJson(Businesstype form) {
		//封装返回给页面的json对象
		List<HashMap<String, Object>> objectJSON = new ArrayList<HashMap<String, Object>>();
		
		//封装默认的请选择行数据()
		HashMap<String,Object> selectedoperatorMap = new HashMap<String, Object>();
		selectedoperatorMap.put("id", "");
		selectedoperatorMap.put("name", getMessage("page.select"));
		selectedoperatorMap.put("price", "0");
		objectJSON.add(selectedoperatorMap);
	    
		form.setQuerydefinedflag("1");//其他(自定义)业务类型
		List<Businesstype> businesstypelist = businesstypeDao.queryByList(form);
 		for (Businesstype businesstype : businesstypelist) {
 			HashMap<String,Object> objectMap = new HashMap<String, Object>();
 			objectMap.put("id", businesstype.getTypekey());
 			objectMap.put("name", businesstype.getTypename());
 			objectMap.put("price", businesstype.getPrice());
 			objectMap.put("feename", businesstype.getFeename());
 			objectJSON.add(objectMap);
        }
		
 		return objectJSON;
	}
	
}
