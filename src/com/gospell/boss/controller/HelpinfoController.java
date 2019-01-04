package com.gospell.boss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.common.MpsApi;
import com.gospell.boss.dao.IHelpinfoDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Helpinfo;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Server;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/helpinfo")
@Transactional
public class HelpinfoController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IHelpinfoDao helpinfoDao; 
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IServerDao serverDao;
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Helpinfo form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(helpinfoDao.findByCount(form));
		List<Helpinfo> helpinfolist = helpinfoDao.findByList(form);
		form.setHelpinfolist(helpinfolist);
		
		form.setRemark(systemparaDao.findByCodeStr("mps_extend_flag").getValue());
		
		return "helpinfo/findHelpinfoList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Helpinfo form) {
		// 构建StoreMap对象
		return "helpinfo/addHelpinfo";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Helpinfo form){
		if (StringUtils.isEmpty(form.getQuestion())) {
			form.setReturninfo(getMessage("helpinfo.question.empty"));
			return addInit(form);
		} 
		if(StringUtils.isEmpty(form.getAnswer())){
			form.setReturninfo(getMessage("helpinfo.answer.empty"));
			return addInit(form);
		}
		helpinfoDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Helpinfo form){
		
		form.setHelpinfo(helpinfoDao.findById(form.getId()));
		
		return "helpinfo/updateHelpinfo";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Helpinfo form){
		if (StringUtils.isEmpty(form.getQuestion())) {
			form.setReturninfo(getMessage("helpinfo.question.empty"));
			return updateInit(form);
		} 
		
		if (StringUtils.isEmpty(form.getAnswer())) {
			form.setReturninfo(getMessage("helpinfo.answer.empty"));
			return updateInit(form);
		} 
		
      	//修改网络信息
		Integer id = helpinfoDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Helpinfo form) {

		//String netid = helpinfoDao.findById(form.getId()).getNetid();
		// 删除
		helpinfoDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
	 * 推送帮助信息给MPS
	 */
	@RequestMapping(value = "/pushAllHelpinfoToMps")
	public String pushAllProductToMps(Helpinfo form) {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> helpinfomaplist = new ArrayList<HashMap<String, Object>>();
		List<Helpinfo> helpinfolist = helpinfoDao.queryByList(form);
		for (Helpinfo helpinfo : helpinfolist) {
			HashMap<String, Object> helpinfoMap = new HashMap<String, Object>();
			helpinfoMap.put("type", helpinfo.getType());
			helpinfoMap.put("question", helpinfo.getQuestion());
			helpinfoMap.put("answer", helpinfo.getAnswer());
			helpinfomaplist.add(helpinfoMap);
		}
		
		dataMap.put("helpinfoList", helpinfomaplist);
		
		//获取MPS服务器信息
		String mpsIp = "127.0.0.1:8080";
		Server serverForm = new Server();
		serverForm.setQueryservertype("mps");
		List<Server> serverlist = serverDao.queryByList(serverForm);
		if(serverlist != null && serverlist.size()>0){
			Server server = serverlist.get(0);
			mpsIp = server.getIp() + ":" + server.getPort();
		}
		
		String apiUrl = "http://" + mpsIp + "/mps/rs/push/pushQuestion";

		try {
			String response = MpsApi.pushProductToMps(/*files, */dataMap, apiUrl);
			
			System.out.println("*******response="+response);
			
			if("1".equals(response)){
				form.setReturninfo(getMessage("page.execution.success"));
			}else{
				form.setReturninfo(getMessage("page.execution.failure"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
		}
		
		return findByList(form);
	}
	
}
