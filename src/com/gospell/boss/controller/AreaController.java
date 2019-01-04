package com.gospell.boss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IAreaDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.User;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/area")
@Transactional
public class AreaController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IAreaDao areaDao; 
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IServerDao serverDao; 
	@Autowired
	private IUserDao userDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Area form) {
		
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		if(form.getNetid() == null){//第一次查询的时候，默认操作员所在区域
			Operator operator = (Operator)getSession().getAttribute("Operator");
			form.setNetid(operator.getNetid());
		}
		
		return "area/findAreaList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Area form) {
		
		String threeAreaCode = Tools.getThreeAreaCode(form.getAreacode());
		form.setAreacode_12(form.getAreacode());//临时保存，用于页面显示
		form.setAreacode(threeAreaCode);
		if(form.getPid()==null){//属于顶层区域增加
			Network network = networkDao.findById(form.getNetid());
			form.setNetwork(network);
			
		}else if(form.getPid() != null){
			Area parentarea = areaDao.findById(form.getPid());
			Network network = networkDao.findById(parentarea.getNetid());
			form.setNetwork(network);
				//判断只能添加四层区域
				int conut = 0;
				List<String> codeList = new ArrayList<String>();
				for (int i = 0; i < 12;i += 3) {
					String strcode = StringUtils.substring(parentarea.getAreacode(), i,i+3);
					codeList.add(strcode);
				}
				for (String code : codeList) {
					if("000".equals(code)){
						conut++;
					}
				}
				if(conut == 0){
					form.setReturninfo(getMessage("area.areacode.notadd"));
					return "area/addArea";
				}
			form.setParentarea(parentarea);
		}
		
		return "area/addArea";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Area form){
		if ("".equals(form.getAreacode())) {
			form.setReturninfo(getMessage("area.areacode.empty"));
			return addInit(form);
		} 
//		else {
//			Area oldArea = areaDao.findByAreacode(form);
//			if (oldArea != null) {
//				form.setReturninfo(getMessage("area.areacode.existed"));
//				return addInit(form);
//			}
//		}
		
		// 设置网络的areacode
		if (form.getPid() == null) {// 属于顶级区域，编码就是areacode
			//保证是3位
			String leftCode = StringUtils.leftPad(form.getAreacode().toString(), 3, "0");
			//补全12位
			String areacode = StringUtils.rightPad(leftCode, 12, "0");
			form.setAreacode(areacode);
			form.setCode(areacode);
			
		} else {// 不属于顶级区域,它的编码既为父区域的编码+"-"+该区域的areacode
			Area parentArea = areaDao.findById(form.getPid());
			String parentCode = Tools.getAreacodeValid(parentArea.getAreacode());
			//保证是3位
			String leftCode = StringUtils.leftPad(form.getAreacode(), 3, "0");
			//补全12位
			String areacode = StringUtils.rightPad(parentCode+leftCode, 12, "0");
			form.setAreacode(areacode);
			form.setCode(areacode);
		}
		
		//判断区域编号是否存在
		Area oldArea = areaDao.findByAreacode(form);
		if (oldArea != null) {
			form.setReturninfo(getMessage("area.areacode.existed"));
			return addInit(form);
		}
		
		areaDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		form.setFlag("1");//保存成功
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Area form){
		
		Area area = areaDao.findById(form.getId());
		if(area==null){
			area = new Area();
		}
		String threeAreaCode = Tools.getThreeAreaCode(area.getAreacode());
		//以ip形式显示
		String ipAreacode = Tools.getIpAreacode(area.getCode());
		area.setCode(ipAreacode);
		area.setAreacode_12(area.getAreacode());//临时保存，用于页面显示
		area.setAreacode(threeAreaCode);
		Area parentArea = areaDao.findById(area.getPid());
		Network network = networkDao.findById(area.getNetid());
		form.setNetwork(network);
		form.setArea(area);
		form.setParentarea(parentArea);
		
		return "area/updateArea";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Area form){
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("area.areacode.empty"));
			return updateInit(form);
		} 
		
		//本身旧区域信息
        Area oldArea = areaDao.findById(form.getId());
        
        //判断是否修改了区域编号
        if(Integer.parseInt(Tools.getThreeAreaCode(oldArea.getAreacode())) != Integer.parseInt(form.getAreacode())){
        	//查询该区域下有没有订户
    		User userForm = new User();
    		userForm.setQuerynetid(String.valueOf(oldArea.getNetid()));
    		userForm.setQueryareacode(oldArea.getAreacode());
    		List<User> userList = userDao.queryByList(userForm);
    		if(userList != null && userList.size() > 0){
    			form.setReturninfo(getMessage("area.user.notempty"));
    			return updateInit(form);
    		}
        	
    		//是否为根节点
    		//查询区域的子节点列表
            List<Area> childAreaList = areaDao.findByPid(oldArea.getId());
    		if(childAreaList != null && childAreaList.size() > 0){//有根节点
    			form.setReturninfo(getMessage("area.areacode.updatefailed"));
    			return updateInit(form);
    		}
    		
        }
        
        //封装完整的12位区域编号
        if(oldArea.getPid() == null){
        	//页面输入的区域编码，不足3位自动补齐3位
        	String areacode = StringUtils.leftPad(form.getAreacode(), 3, "0");
        	//末尾自动补齐12位编码
        	areacode = StringUtils.rightPad(areacode, 12, "0");
        	form.setAreacode(areacode);
        }else{//如果不是顶层的区域
        	//找出父亲的区域
        	 Area parentArea = areaDao.findById(oldArea.getPid());
        	 String parentAreacodeValid = Tools.getAreacodeValid(parentArea.getAreacode());
        	 //页面输入的区域编码，不足3位自动补齐3位
         	 String areacode = StringUtils.leftPad(form.getAreacode(), 3, "0");
         	 //区域号等于父亲有效区域号+页面输入的3位区域号+末尾自动补齐12位
         	 areacode = StringUtils.rightPad((parentAreacodeValid + areacode),12, "0");
         	form.setAreacode(areacode);
        }
        
        //验证新的区域编号是否在数据库中存在
        Area oldAreaForm = areaDao.findByAreacode(form);
		if (oldAreaForm != null && !oldAreaForm.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("area.areacode.existed"));
			return updateInit(form);
		}
		//验证cas分区号是否在数据库中存在
//		Area ipAreaForm = areaDao.findByRemark(form);
//		if (ipAreaForm != null && !ipAreaForm.getId().equals(form.getId())) {
//			form.setReturninfo(getMessage("area.casareacode.existed"));
//			return updateInit(form);
//		}
		//把ip形式的CAS分区号复原
		String casCode = Tools.getCASCode(form.getCode());
		form.setCode(casCode);
        //修改网络信息
		Integer id = areaDao.update(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		
		form.setFlag("1");//保存成功
		
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Area form) {
        //得到将要删除的区域
		Area area = areaDao.findById(form.getId());
		//查询该区下所有的子区域
		List<Area> areaList = areaDao.queryListByPid(area);
		
		if(areaList != null && areaList.size() > 0){
			form.setReturninfo(getMessage("area.sub.notempty"));
			return findByList(form);
		}
		
		//查询该区域下有没有订户
		User userForm = new User();
		userForm.setQuerynetid(String.valueOf(area.getNetid()));
		userForm.setQueryareacode(area.getAreacode());
		List<User> userList = userDao.queryByList(userForm);
		
		if(userList != null && userList.size() > 0){
			form.setReturninfo(getMessage("area.user.notempty"));
			return findByList(form);
		}
		
		
		// 删除
		areaDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
	 * 批量删除
	 */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/deleteBatchByCode")
	public Map<String,Object> deleteBatchByCode(Area form) {
		//封装返回给页面的json对象
		HashMap<String,Object> areaJson = new HashMap<String,Object>();
		
		Area area = areaDao.findById(form.getId());
		area.setPid(area.getId());
		//查询该区下所有的子区域
		List<Area> areaList = areaDao.queryListByPid(area);
		
		if(areaList != null && areaList.size() > 0){
			areaJson.put("deleteflag", false);
			areaJson.put("info", getMessage("area.sub.notempty"));
			return areaJson;
		}
		
		//查询该区域下有没有订户
		User userForm = new User();
		userForm.setQuerynetid(String.valueOf(area.getNetid()));
		userForm.setQueryareacode(area.getAreacode());
		List<User> userList = userDao.queryByList(userForm);
		
		if(userList != null && userList.size() > 0){
			areaJson.put("deleteflag", false);
			areaJson.put("info", getMessage("area.user.notempty"));
			return areaJson;
		}
		
		//批量删除
		areaDao.deleteBatchByCode(area);
		
		areaJson.put("deleteflag", true);
		areaJson.put("info", getMessage("page.execution.success"));
		
		return areaJson;
	}
	
	/**
     * 初始化area的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initAreaJson")
    public Map<String,Object> initAreaJson(Area form) {
		//封装返回给页面的json对象
		HashMap<String,Object> areaJson = new HashMap<String,Object>();
        
        // 构建网络Map对象
 		List<Area> arealist = areaDao.queryByList(form);
 		
 		for (Iterator iterator = arealist.iterator(); iterator.hasNext();) {
 			Area area = (Area) iterator.next();
 			areaJson.put(area.getAreacode(), area.getAreaname());
 		}
 		return areaJson;
    }
	
	
	/**
     * 初始化area树形结构
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getTreeArea")
    public List<Map<String,Object>> getTreeArea(Area form) {
		//封装返回给页面的json对象
		List<Map<String, Object>> areaJSON = new ArrayList<Map<String, Object>>();
		
        //封装顶层网络信息
		form.setNetid(form.getNetid());
		Network network = networkDao.findById(form.getNetid());
		if(network != null){
	        // 构建网络Map对象
	 		List<Area> arealist = areaDao.queryListByPid(form);
	 		for (Area area : arealist) {
	 			HashMap<String,Object> areaMap = new HashMap<String, Object>();
	 			areaMap.put("id", area.getId());
	 			areaMap.put("pId", area.getPid());
	 			areaMap.put("name", area.getAreaname()+"("+area.getAreacode()+")");
	 			areaMap.put("path", "area/updateInit?id="+area.getId());
	 			
	 			Area areaform = new Area();
	 			areaform.setNetid(area.getNetid());
	 			areaform.setPid(area.getId());
	 			List<Area> areaChildList = areaDao.queryListByPid(areaform);
	 			if(areaChildList != null && areaChildList.size() > 0){
	 				areaMap.put("isParent", true);
	 			}else{
	 				areaMap.put("isParent", false);
	 			}
	 			
	 			areaMap.put("type", "2");
	 			areaJSON.add(areaMap);
	        }
		}
		
 		
 		return areaJSON;
    }
	
	/**
     * 初始化area的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getNextMenu")
    public List<Map<String,Object>> getNextMenu(Area form) {
		//封装返回给页面的json对象
		List<Map<String, Object>> areaJSON = new ArrayList<Map<String, Object>>();
		
		Area dmpArea = areaDao.findById(form.getId());
		Area areaForm = new Area();
		if(dmpArea !=null && dmpArea.getId() != null){
			areaForm.setNetid(dmpArea.getNetid());
			areaForm.setPid(dmpArea.getId());
		}
		
        // 构建网络Map对象
 		List<Area> arealist = areaDao.queryListByPid(areaForm);
 		for (Area area : arealist) {
 			HashMap<String,Object> areaMap = new HashMap<String, Object>();
 			areaMap.put("id", area.getId());
 			areaMap.put("pId", area.getPid());
 			areaMap.put("name", area.getAreaname()+"("+area.getAreacode()+")");
 			areaMap.put("path", "area/updateInit?id="+area.getId());
 			Area areaform = new Area();
 			areaform.setNetid(area.getNetid());
 			areaform.setPid(area.getId());
 			List<Area> areaChildList = areaDao.queryListByPid(areaform);
 			if(areaChildList != null && areaChildList.size() > 0){
 				areaMap.put("isParent", true);
 			}else{
 				areaMap.put("isParent", false);
 			}
 			areaMap.put("type", "2");
 			areaJSON.add(areaMap);
        }
 		return areaJSON;
    }
	
	
	/** 
	 * 构建区域树型菜单json数据 
	 */  
	public List<Map<String, Object>> buildNode(int pid,List<Area> areaList){  
	    List<Map<String, Object>> areaTreeJSON = new ArrayList<Map<String, Object>>();
	    for(Area area:areaList){  
	    	 HashMap<String,Object> areaMap = new HashMap<String, Object>();
	        if(null != area.getPid() && area.getPid().equals(pid)){  
	        	areaMap.put("id", area.getAreacode());
	    	    areaMap.put("text", area.getAreaname()+"("+area.getAreacode()+")");
	    	    List<Map<String, Object>> children = buildNode(area.getId(),areaList);  
	            if(null != children && 0 < children.size()){ 
	            	areaMap.put("state", "closed");
	            	areaMap.put("children", children);
	            }  
	            areaTreeJSON.add(areaMap);   
	        }  
	    }  
	    return areaTreeJSON;  
	} 
	
	/**
     * 获取area的树形下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/getAreaTreeJson")
	public List<Map<String,Object>> getAreaTreeJson(Area form) {  
	    //区域对象
		List<Map<String, Object>> areaTreeJSON = new ArrayList<Map<String, Object>>();
	    //添加请选择项-默认为空，查询所有
	    HashMap<String,Object> selectMap = new HashMap<String, Object>();
	    selectMap.put("id", "");
	    selectMap.put("text", getMessage("page.select"));
	    areaTreeJSON.add(selectMap);
	    
	    //先判断网络有没有选择
	    if(StringUtils.isNotEmpty(form.getQuerynetid())){
	    	List<Area> areaList = areaDao.queryByList(form);
		    //封装区域属性结构信息
		    for(Area area:areaList){  
		    	if(null == area.getPid()){ 
		    	    HashMap<String,Object> areaMap = new HashMap<String, Object>();
		    	    areaMap.put("id", area.getAreacode());
		    	    areaMap.put("text", area.getAreaname()+"("+area.getAreacode()+")");
		    	    
		    	    List<Map<String, Object>> children = buildNode(area.getId(),areaList);  
		    	    if(null != children && 0 < children.size()){ 
		            	areaMap.put("state", "closed");
		            	areaMap.put("children", children);
		            }  
		            areaTreeJSON.add(areaMap);  
		    	}
		    }  
	    }
	    
	   return areaTreeJSON;
	}  
}
