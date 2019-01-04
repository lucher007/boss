package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IDispatchDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IProblemcomplaintDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Dispatch;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Problemcomplaint;
import com.gospell.boss.po.Problemcomplaintdetail;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productextend;
import com.gospell.boss.po.User;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/problemcomplaint")
@Transactional
public class ProblemcomplaintController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IProblemcomplaintDao problemcomplaintDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IOperatorDao operatorDao;
	@Autowired
	private IDispatchDao dispatchDao;

	/**
	 * 查询用户信息
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/findByList")
	public String findByList(Problemcomplaint form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(problemcomplaintDao.findByCount(form));
		List<Problemcomplaint> problemcomplaintlist = problemcomplaintDao.findByList(form);

		for (Problemcomplaint problemcomplaint : problemcomplaintlist) {
			//网络信息
			problemcomplaint.setNetwork(networkDao.findById(problemcomplaint.getNetid()));
			//区域信息
			Area area = new Area();
			area.setNetid(problemcomplaint.getNetid());
			area.setAreacode(problemcomplaint.getAreacode());
			area = areaDao.findByAreacode(area);
			problemcomplaint.setArea(area);
			// 放入订户信息
			problemcomplaint.setUser(userDao.findById(problemcomplaint.getUserid()));
		}
		form.setProblemcomplaintlist(problemcomplaintlist);
		
		return "problemcomplaint/findProblemcomplaintList";
	}

	/**
	 * 添加用户信息初始化
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addInit")
	public String addInit(Problemcomplaint form) {
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		return "problemcomplaint/addProblemcomplaint";
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Problemcomplaint form) {
		
		Operator operator = (Operator)getSession().getAttribute("Operator");
		
		User user = userDao.findById(form.getUserid());
		
		if(user == null){
			form.setReturninfo(getMessage("page.execution.failure"));
			return addInit(form);
		}
		form.setNetid(user.getNetid());
		form.setAreacode(user.getAreacode());
		form.setOperatorid(operator.getId());
		form.setAddtime(Tools.getCurrentTime());
		form.setState("0");
		form.setResource("0");
		problemcomplaintDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateInit")
	public String updateInit(Problemcomplaint form) {
		form.setProblemcomplaint(problemcomplaintDao.findById(form.getId()));
		// 取得所选投诉单的用户名
		form.setUsername(userDao.findById(form.getProblemcomplaint().getUserid()).getUsername());
		// 构建上级网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);

		return "problemcomplaint/updateProblemcomplaint";
	}

	@RequestMapping(value = "/findUserListForDialog")
	public String findUserListForDialog(User form) {
		form.setPager_openset(5);
		form.setPager_count(userDao.findByCount(form));
		List<User> userlist = userDao.findByList(form);
		for (User user : userlist) {
			user.setNetwork(networkDao.findById(user.getNetid()));
		}
		form.setUserlist(userlist);
		return "problemcomplaint/findUserListForDialog";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Problemcomplaint form) {

		Operator operator = (Operator)getSession().getAttribute("Operator");
		User user = userDao.findById(form.getUserid());
		if(user == null){
			form.setReturninfo(getMessage("page.execution.failure"));
			return addInit(form);
		}
		
		Problemcomplaint problemcomplaint = problemcomplaintDao.findById(form.getId());
		
		problemcomplaint.setNetid(user.getNetid());
		problemcomplaint.setAreacode(user.getAreacode());
		problemcomplaint.setUserid(form.getUserid());
		problemcomplaint.setOperatorid(operator.getId());
		problemcomplaint.setType(form.getType());
		problemcomplaint.setProblemtype(form.getProblemtype());
		problemcomplaint.setContent(form.getContent());
		problemcomplaint.setState(form.getState());
		
		problemcomplaintDao.update(problemcomplaint);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Problemcomplaint form) {
		problemcomplaintDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
    
	
	@RequestMapping(value = "/queryDetail")
	public String queryDetail(Problemcomplaint form) {
		
		Problemcomplaint problemcomplaint = problemcomplaintDao.findById(form.getId());
		if(problemcomplaint == null){
			problemcomplaint = new Problemcomplaint();
		}
		Network network = networkDao.findById(problemcomplaint.getNetid());
		if(network == null){
			network = new Network();
		}
		User user = userDao.findById(problemcomplaint.getUserid());
		if(user == null){
			user = new User();
		}
		form.setNetwork(network);
		form.setUser(user);
		form.setProblemcomplaint(problemcomplaint);
		
		form.setProblemcomplaintdetaillist(problemcomplaintDao.findDetailByComplaintid(form.getId()));
		
		return "problemcomplaint/findProblemcomplaintdetailList";
	}
	
	@RequestMapping(value = "/getDetailStream")
	public String getDetailStream(Problemcomplaintdetail form,HttpServletResponse response){
		Problemcomplaintdetail problemcomplaintdetail =  problemcomplaintDao.findDetailByDetailid(form.getId());
        
        try {
			File excelTemplate = new File(problemcomplaintdetail.getPreserveurl());
			response.reset();
			
			//图片文件，直接在页面显示图片
			if (Tools.isImage(excelTemplate)) {  
				response.setHeader("Accept-Ranges", "bytes");  
	            response.setHeader("Pragma", "no-cache");  
	            response.setHeader("Cache-Control", "no-cache");  
	            response.setDateHeader("Expires", 0);  
			}else{//非图片文件，先下载
				response.setContentType("application/octet-stream");
				response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
				response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(problemcomplaintdetail.getFilename(), "UTF-8"));
			}
			
			FileInputStream fis = new FileInputStream(excelTemplate);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer);
			}
			fis.close();
			toClient.flush();
			toClient.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
    }
}
