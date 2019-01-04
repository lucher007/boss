package com.gospell.boss.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAuthorizeDao;
import com.gospell.boss.dao.IAuthorizehistoryDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Authorize;
import com.gospell.boss.po.Authorizehistory;
import com.gospell.boss.po.Server;
import com.gospell.boss.socketmanage.CommonSocket;
import com.gospell.boss.socketmanage.SocketKeep;

@Controller
@Scope("prototype")
@Transactional
public class ServerSocketInitController extends BaseController {

	@Autowired
	private IServerDao serverDao;
	
	public void serverSocketInit() throws Exception {
		
		Server serverForm = new Server();
		serverForm.setQueryservertype("cas");
		List<Server> serverlist = serverDao.queryByList(serverForm);
		
		if(serverlist != null && serverlist.size() > 0){
			//初始化CAS服务器socket连接信息
			SocketKeep.initSocketKeep(serverlist); 
		}
	}
	
	
}
