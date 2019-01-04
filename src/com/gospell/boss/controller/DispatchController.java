package com.gospell.boss.controller;

import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
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
import com.gospell.boss.po.User;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/dispatch")
@Transactional
public class DispatchController extends BaseController {
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IDispatchDao dispatchDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private IProblemcomplaintDao problemcomplaintDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IAreaDao areaDao;
	@Autowired
	private IOperatorDao operatorDao;

	/**
	 * 查询工单信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Dispatch form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(dispatchDao.findByCount(form));
		System.out.println("**********before*******90:" + form.getQuerystate());

		//查询工单界面，需要判断操作员类型，如果是维修人员，只能看到自己的工单
		if (form.getJumping().equals("findReturnDispatchList")) {
			Operator operator = (Operator)getSession().getAttribute("Operator");
			if("2".equals(operator.getOperatortype())){//施工人员
				form.setQuerydispatcherid(operator.getId());
			}
		}
		
		List<Dispatch> dispatchlist = dispatchDao.findByList(form);
		System.out.println("******************90:" + form.getQuerystate());

		for (Dispatch dispatch : dispatchlist) {
			dispatch.setUser(userDao.findById(dispatch.getUserid()));
			Network network = networkDao.findById(dispatch.getNetid());
			dispatch.setNetwork(network!=null?network:new Network());
			Area findarea = new Area();
			findarea.setAreacode(dispatch.getAreacode());
			findarea.setNetid(dispatch.getNetid());
			findarea = areaDao.findByAreacode(findarea);
			dispatch.setArea(findarea!=null?findarea:new Area());
			Operator worker = operatorDao.findById(dispatch.getDispatcherid());
			dispatch.setWorker(worker!=null?worker:new Operator());
		}
		form.setDispatchlist(dispatchlist);
		if (form.getJumping().equals("findDispatchListForAssign")) {
			return "dispatch/findDispatchListForAssign";
		} else if (form.getJumping().equals("findDispatchList")) {
			return "dispatch/findDispatchList";
		} else if (form.getJumping().equals("findReturnDispatchList")) {
			return "dispatch/findReturnDispatchList";
		} else if (form.getJumping().equals("findDispatchListForCheck")) {
			return "dispatch/findDispatchListForCheck";
		} else
			return null;
	}

	/**
	 * 添加信息初始化
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Dispatch form) {
		form.setJumping("findDispatchList");
		return "dispatch/addDispatch";
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Dispatch form) {
		Operator operator = (Operator)getSession().getAttribute("Operator");
		Dispatch oldDispatch = dispatchDao.findByComplaintid(form.getComplaintid());
		if (oldDispatch != null) {
			form.setReturninfo(getMessage("dispatch.complaintid.existed")); // complaint
			return addInit(form);
		}
		
		Problemcomplaint problemcomplaint = problemcomplaintDao.findById(form.getComplaintid());
		if(problemcomplaint == null){
			problemcomplaint = new Problemcomplaint();
		}
		User user = userDao.findById(problemcomplaint.getUserid());
		
		if(user == null ){
			user = new User();
		}
		
		form.setNetid(user.getNetid());
		form.setAreacode(user.getAreacode());
		form.setComplaintid(problemcomplaint.getId());
		form.setComplaintno(problemcomplaint.getComplaintno());
		form.setProblemtype(problemcomplaint.getProblemtype());
		form.setUserid(user.getId());
		form.setAdddate(Tools.getCurrentTime());
		form.setOperatorid(operator.getId());
		form.setState("0");
		dispatchDao.save(form);
		
		// 维护对应投诉单的状态为1：受理中
		problemcomplaint.setState("1");
		problemcomplaintDao.updateState(problemcomplaint);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Dispatch form) {
		form.setDispatch(dispatchDao.findById(form.getId()));
		form.setUser(userDao.findById(form.getDispatch().getUserid()));
		return "dispatch/updateDispatch";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Dispatch form) {
		
		Dispatch dispatch = dispatchDao.findById(form.getId());
		dispatch.setProblemtype(form.getProblemtype());
		dispatch.setContent(form.getContent());
		dispatch.setState("0");//修改工单内容就必须需要重新派单
		dispatch.setDispatcherid(null);
		dispatch.setDealdate(null);
		dispatch.setDealresult(null);
		dispatchDao.update(dispatch);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Dispatch form) {
		Dispatch dispatch = dispatchDao.findById(form.getId());
		Problemcomplaint correspondingComplaint = problemcomplaintDao.findById(dispatch.getComplaintid());
		if(correspondingComplaint !=null && correspondingComplaint.getId() !=null){
			correspondingComplaint.setState("0"); // 维护投诉单状态为0-未受理
			problemcomplaintDao.updateState(correspondingComplaint);
		}
		
		dispatchDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		form.setJumping("findDispatchList");
		return findByList(form);
	}

	/**
	 * 审核通过结单
	 */
	@RequestMapping(value = "/savePass")
	public String savePass(Dispatch form) {
		Dispatch dispatch = dispatchDao.findById(form.getId());
		dispatch.setState("5"); // 通过则结单设置state = 5-结单
		dispatchDao.updateState(dispatch);
		
		//查询此工单关联的问题投诉
		if(!StringUtils.isEmpty(dispatch.getComplaintid())){
			Problemcomplaint correspondingComplaint = problemcomplaintDao.findById(dispatch.getComplaintid());
		    if(correspondingComplaint != null && correspondingComplaint.getId() != null){
		    	correspondingComplaint.setState("3"); // 问题投诉单状态为已处理
		    	problemcomplaintDao.updateState(correspondingComplaint);
		    }
		}
		
		
		form.setReturninfo(getMessage("page.execution.success"));
		form.setJumping("findDispatchListForCheck");
		form.setQuerystate("34");// 设立Querystate标识，在工单审核页面只显示state=3(已处理)和4(处理失败)的工单
		return findByList(form);
	}

	/**
	 * 重新发送工单给营业员修改
	 */
	@RequestMapping(value = "/saveReturn")
	public String saveReturn(Dispatch form) {
		Dispatch dispatch = dispatchDao.findById(form.getId());
		dispatch.setState("0");  //通过则结单设置state = 0-未派单
		dispatch.setDispatcherid(null);
		dispatch.setDealdate(null);
		dispatch.setDealresult(null);
		dispatchDao.updateReturnInfo(dispatch);
		dispatchDao.saveAssign(dispatch);
		form.setReturninfo(getMessage("page.execution.success"));
		form.setJumping("findDispatchListForCheck");
		form.setQuerystate("34");// 设立Querystate标识，在工单审核页面只显示state=3(已处理)和4(处理失败)的工单
		return findByList(form);
	}

	/**
	 * 派单初始化
	 */
	@RequestMapping(value = "/assignInit")
	public String assignInit(Dispatch form) {
		form.setDispatch(dispatchDao.findById(form.getId()));
		form.setUser(userDao.findById(form.getDispatch().getUserid()));
		form.getDispatch().setJumping(form.getJumping());// 判断返回跳转
		return "dispatch/assignDispatch";
	}

	/**
	 * 派发工单
	 */
	@RequestMapping(value = "/saveAssign")
	public String saveAssign(Dispatch form) {
		form.setState("1");// 设置工单状态为1(已派单)
		
		dispatchDao.saveAssign(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return assignInit(form);
	}

	/**
	 * 回单状态更新初始化
	 */
	@RequestMapping(value = "/updateReturnInfoInit")
	public String updateReturnInfoInit(Dispatch form) {
		
		Dispatch disptch = dispatchDao.findById(form.getId());
		
		if(disptch == null){
			disptch = new Dispatch();
		}
		
		form.setDispatch(disptch);

		form.setUser(userDao.findById(form.getDispatch().getUserid()));
		form.setWorker(operatorDao.findById(disptch.getDispatcherid()));
		return "dispatch/updateReturnInfo";
	}

	/**
	 * 更新回单信息
	 */
	@RequestMapping(value = "/updateReturnInfo")
	public String updateReturnInfo(Dispatch form) {

		dispatchDao.updateReturnInfo(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateReturnInfoInit(form);
	}

	/**
	 * 获取问题单列表以生成工单
	 */
	@RequestMapping(value = "/findProblemcomplaintListForDialog")
	public String findProblemcomplaintListForDialog(Problemcomplaint form) {
		form.setPager_openset(5);
		form.setPager_count(problemcomplaintDao.findByCount(form));
		List<Problemcomplaint> problemcomplaintlist = problemcomplaintDao.findByList(form);
		for (Problemcomplaint problemcomplaint : problemcomplaintlist) {
			problemcomplaint.setUser(userDao.findById(problemcomplaint.getUserid()));
		}
		form.setProblemcomplaintlist(problemcomplaintlist);
		return "dispatch/findProblemcomplaintListForDialog";
	}

	/**
	 * 获取维修员列表以备选择
	 */
	@RequestMapping(value = "/findDispatcherListForDialog")
	public String findDispatcherListForDialog(Dispatch form) {
		return "dispatch/findDispatcherListForDialog";
	}

	/**
	 * 获取维修员列表以备选择
	 */
	@RequestMapping(value = "/saveAssignSelected")
	public String saveAssignSelected(Dispatch form, HttpServletRequest request) {
		String[] idArray = request.getParameterValues("ids");
		Integer dispatcherid = Integer.parseInt(request.getParameter("dispatcherSelected"));
		if (idArray == null || idArray.length < 1) {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Dispatch dispatch = dispatchDao.findById(Integer.parseInt(idArray[i]));
				dispatch.setState("1"); // 通过则结单设置state = 已经派单
				dispatch.setDispatcherid(dispatcherid);
				dispatchDao.saveAssign(dispatch);
			}
			form.setReturninfo(getMessage("page.execution.success"));
		}
		form.setJumping("findDispatchListForAssign");
		form.setQuerystate("0");// 设立Querystate标识，在工单审核页面只显示state=0(未派单)的工单
		return findByList(form);
	}

	/**
	 * 批量通过
	 */
	@RequestMapping(value = "/savePassSelected")
	public String savePassSelected(Dispatch form, HttpServletRequest request) {
		String[] idArray = request.getParameterValues("ids");
		if (idArray == null || idArray.length < 1) {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			for (int i = 0; i < idArray.length; i++) {
				Dispatch dispatch = dispatchDao.findById(Integer.parseInt(idArray[i]));
				dispatch.setState("5"); // 通过则结单设置state = 5-结单
				dispatchDao.updateState(dispatch);
				
				//查询此工单关联的问题投诉
				if(!StringUtils.isEmpty(dispatch.getComplaintid())){
					Problemcomplaint correspondingComplaint = problemcomplaintDao.findById(dispatch.getComplaintid());
				    if(correspondingComplaint != null && correspondingComplaint.getId() != null){
				    	correspondingComplaint.setState("3"); // 问题投诉单状态为已处理
				    	problemcomplaintDao.updateState(correspondingComplaint);
				    }
				}
			}
			form.setReturninfo(getMessage("page.execution.success"));
		}
		form.setJumping("findDispatchListForCheck");
		form.setQuerystate("34");// 设立Querystate标识，在工单审核页面只显示state=3(已处理)和4(处理失败)的工单
		return findByList(form);
	}

	public INetworkDao getNetworkDao() {
		return networkDao;
	}

	public void setNetworkDao(INetworkDao networkDao) {
		this.networkDao = networkDao;
	}

}
