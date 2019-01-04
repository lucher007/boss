package com.gospell.boss.controller;

import java.net.Socket;
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

import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Server;
import com.gospell.boss.socketmanage.CommonSocket;
import com.gospell.boss.socketmanage.InitSocketThread;
import com.gospell.boss.socketmanage.SocketKeep;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/server")
@Transactional
public class ServerController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IServerDao serverDao; 
	@Autowired
	private INetworkDao networkDao; 
	@Autowired
	private IProviderDao providerDao; 

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Server form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(serverDao.findByCount(form));
		
		List<Server> serverlist = serverDao.findByList(form);
		for (Server server : serverlist) {
			server.setNetwork(networkDao.findById(server.getNetid()));
			server.setProvider(providerDao.findById(server.getProviderid()));
			if("cas".equals(server.getServertype())){//CAS服务器
				Socket socket = SocketKeep.socketMap.get(server.getId());
				if(socket != null){
					server.setSocketConnectState("1");
				}else{
					server.setSocketConnectState("0");
				}
			}
		}
		form.setServerlist(serverlist);
		
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		return "server/findServerList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/addInit")
	public String addInit(Server form) {
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		// 构建供应商Map对象
		List<Provider> providerlist = providerDao.queryByList(new Provider());
		Map<Integer, String> providermap = new HashMap<Integer, String>();
		for (Iterator iterator = providerlist.iterator(); iterator.hasNext();) {
			Provider provider = (Provider) iterator.next();
			providermap.put(provider.getId(), provider.getCompanyname());
		}
		form.setProvidermap(providermap);
		
		return "server/addServer";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Server form){
		if ("".equals(form.getNetid())) {
			form.setReturninfo(getMessage("server.servername.empty"));
			return addInit(form);
		} else {
			Server oldServer = serverDao.findByServername(form);
			if (oldServer != null) {
				form.setReturninfo(getMessage("server.servername.existed"));
				return addInit(form);
			}
		}
		
		//如果不是CAS服务器，servertype默认为NULL
		if(!"cas".equals(form.getServertype())){
			form.setNetid(null);
			form.setVersiontype(null);
		}
		//一个网络下同版本类型的CAS服务器只允许存在一个
		Server oldServer = serverDao.findByServertypeAndVersiontype(form);
		if (oldServer != null) {
			form.setReturninfo(getMessage("server.servertype.existed"));
			return addInit(form);
		}
		
		serverDao.save(form);
		
		//新建CAS服务器的Socket通信
		if(form.getId() != null && "cas".equals(form.getServertype())){
			//CommonSocket.initSocketByServer(form);
			//后台通过线程初始化socket连接
			InitSocketThread initS = new InitSocketThread(form);
			new Thread(initS).start();
		}
		
		
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/updateInit")
	public String updateInit(Server form){
		
		form.setServer(serverDao.findById(form.getId()));
		
		// 构建网络Map对象
		List<Network> list = networkDao.queryByList(new Network());
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Network network = (Network) iterator.next();
			map.put(network.getId(), network.getNetname());
		}
		form.setNetworkmap(map);
		
		// 构建供应商Map对象
		List<Provider> providerlist = providerDao.queryByList(new Provider());
		Map<Integer, String> providermap = new HashMap<Integer, String>();
		for (Iterator iterator = providerlist.iterator(); iterator.hasNext();) {
			Provider provider = (Provider) iterator.next();
			providermap.put(provider.getId(), provider.getCompanyname());
		}
		form.setProvidermap(providermap);
		
		return "server/updateServer";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Server form){
		if ("".equals(form.getServername())) {
			form.setReturninfo(getMessage("server.servername.empty"));
			return updateInit(form);
		} else{
			Server oldServer = serverDao.findByServername(form);
			if (oldServer != null && !oldServer.getId().equals(form.getId())) {
				form.setReturninfo(getMessage("server.servername.existed"));
				return updateInit(form);
			}
		}
		
		//如果不是CAS服务器，servertype默认为NULL
		if(!"cas".equals(form.getServertype())){
			form.setNetid(null);
			form.setVersiontype(null);
		}
		//一个网络下同版本类型的服务器只允许存在一个
		Server oldServer = serverDao.findByServertypeAndVersiontype(form);
		if (oldServer != null && !oldServer.getId().equals(form.getId())) {
			form.setReturninfo(getMessage("server.servertype.existed"));
			return updateInit(form);
		}

        //修改网络信息
		Integer id = serverDao.update(form);
		
		//新建CAS服务器的Socket通信
		if(id == 1 && "cas".equals(form.getServertype())){
			//CommonSocket.initSocketByServer(form);
			//后台通过线程初始化socket连接
			InitSocketThread initS = new InitSocketThread(form);
			new Thread(initS).start();
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Server form) {

		//String netid = serverDao.findById(form.getId()).getNetid();
		// 删除
		serverDao.delete(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
     * 初始化server的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initServerJson")
    public Map<String,Object> initServerJson(Server form) {
		//封装返回给页面的json对象
		HashMap<String,Object> serverJson = new HashMap<String,Object>();
        
        // 构建网络Map对象
 		List<Server> serverlist = serverDao.queryByList(form);
 		
 		for (Iterator iterator = serverlist.iterator(); iterator.hasNext();) {
 			Server server = (Server) iterator.next();
 			serverJson.put(server.getId().toString(), server.getServername());
 		}
 		return serverJson;
    }
	
	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/connectServerInit")
	public String connectServerInit(Server form){
		
		Server server = serverDao.findById(form.getId());
		if(server == null){
			server = new Server();
		}
		
		form.setServer(server);
		
		return "server/connectServer";
	}
	
}
