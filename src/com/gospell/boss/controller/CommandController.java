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

@Controller
@Scope("prototype")
@Transactional
public class CommandController extends BaseController {

	@Autowired
	private IAuthorizeDao authorizeDao;
	@Autowired
	private IServerDao serverDao;
	@Autowired
	private IAuthorizehistoryDao authorizehistoryDao;
	@Autowired
	private ISystemparaDao systemparaDao;
	
	//发送指令方法
	public void sendCommandInit() throws Exception {
		
		String auto_flag = "1";
		//auto_flag = systemparaDao.findByCodeStr("cas_send_auto").getValue();
		if (auto_flag.equals("1")) {
			Server serverForm = new Server();
			serverForm.setQueryservertype("cas");
			List<Server> serverlist = serverDao.queryByList(serverForm);
			if(serverlist != null && serverlist.size() > 0){
				for (Server server : serverlist) {
					sendCommand(server);
				}
			}
		}
	}
	
    
	private void sendCommand(Server server) {
		if(server == null){
			server = new Server();
		}
		
		//CommandSocketClient client = new CommandSocketClient();
		//Socket s = client.getSocket("192.168.3.212", "3039");
        
		//打印出CAS服务器信息
		//System.out.println("******CAS_SERVER*******"+server.getId()+"-"+server.getServername());
		
		Socket s = CommonSocket.getSocketById(server.getId());  
		if (s != null) {
			List<Authorize> authorize_list = findCommands(server);
			//打印出socket信息
			System.out.println(Tools.getCurrentTime() + " socket=" + s.toString());
			for (Authorize authorize : authorize_list) {
				try {
					/******* 发送指令 *******/
					byte[] bOut = new byte[256];
					String hexString = authorize.getCommand();
					bOut = Tools.HexString2Bytes(hexString);
					this.OutputStream(s, bOut); // 发送指令
					/*********** 超时设置 *********/
					s.setSoTimeout(10 * 1000);
					/******* 接受CAS回执 *******/
					byte[] bIn = new byte[20];
					bIn = this.InputStream(s); // 接受CAS回执
					if (bIn != null) {// 读取并处理回执
						StringBuffer outStrBuff = new StringBuffer();
						if ("gos_pn".equals(server.getVersiontype())) {
							for (int j = 6; j < 10; j++) {// 返回的验证消息有效位6-9
								outStrBuff.append(Tools.autoFillStr(Integer.toHexString(bIn[j] & 0xFF), 2, "0"));
							}
						} else if("gos_gn".equals(server.getVersiontype())) {
							for (int j = 8; j < 12; j++) {// 返回的验证消息有效位8-11
								outStrBuff.append(Tools.autoFillStr(Integer.toHexString(bIn[j] & 0xFF), 2, "0"));
							}
						}
						String cas_response = outStrBuff.toString();
						//	System.out.println("cas_response:" + cas_response);
						String cas_result = ("00000000".equals(cas_response)||"E0000003".equals(cas_response)) ? "send success" : "send fail";
						//System.out.println("*********************************");
						System.out.println("(" + server.getVersiontype() + "): " + cas_result);
						//System.out.println("*********************************");
						if ("00000000".equals(cas_response)||"E0000003".equals(cas_response)) {
							/****** 发送成功，删除authorize表项，插入history表项 *******/
							this.saveAuthorizeHistory(authorize);
							authorizeDao.delete(authorize.getId());
							//System.out.println("*********************************");
							System.out.println("send command success!" + ":" +hexString);
							//System.out.println("*********************************");
						} else if ("FFFFFFFF".equals(cas_response)){
							//do nothing
						}else {
							/****** 发送失败，更新authorize表中的state和result ******/
							//authorize.setState("1");
							//authorize.setResult(cas_response);
							//authorizeDao.update(authorize);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("*********************************");
					System.out.println("Connection timeout! try sending again next loop");
					System.out.println("*********************************");
					authorize.setResult("Connection timeout! try sending again next loop");
					authorizeDao.update(authorize);
					continue; //  继续下一个循环
				}
			} 
			//释放soceket资源
            try {
				s.close();//重新了此方法，相当于将该cocket状态设置为未占用
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}      
		} else {
			System.out.println(server.getVersiontype() + " " + " socket connect fail");
			
		}
	}

	private void saveAuthorizeHistory(Authorize authorize) {
		Authorizehistory authorizehistory = new Authorizehistory();
		authorizehistory.setNetid(authorize.getNetid());
		authorizehistory.setServerid(authorize.getServerid());
		authorizehistory.setAreacode(authorize.getAreacode());
		authorizehistory.setUserid(authorize.getUserid());
		authorizehistory.setTerminalid(authorize.getTerminalid());
		authorizehistory.setTerminaltype(authorize.getTerminaltype());
		authorizehistory.setCardid(authorize.getCardid());
		authorizehistory.setStbno(authorize.getStbno());
		authorizehistory.setAddtime(authorize.getAddtime());
		authorizehistory.setVersiontype(authorize.getVersiontype());
		authorizehistory.setCommandtype(authorize.getCommandtype());
		authorizehistory.setConditionaddr(authorize.getConditionaddr());
		authorizehistory.setCommand(authorize.getCommand());
		authorizehistory.setRemark(authorize.getRemark());
		authorizehistoryDao.save(authorizehistory);
	}

	private List<Authorize> findCommands(Server server) {
		List<Authorize> list = new ArrayList<Authorize>();
		Authorize query_authorize = new Authorize();
		//一次查询100条
		query_authorize.setPager_openset(Integer.valueOf(100));
		query_authorize.setQueryversiontype(server.getVersiontype());
		query_authorize.setQuerynetid(String.valueOf(server.getNetid()));
		query_authorize.setQuerystate("0"); // 未发送
		list = authorizeDao.findByList(query_authorize);
		return list;
	}

	private void OutputStream(Socket s, byte[] bOut) throws Exception {
		OutputStream out = null;
		out = s.getOutputStream();
		out.write(bOut);
	}

	private byte[] InputStream(Socket s) throws Exception {
		InputStream in = null;
		byte[] bIn = new byte[20];
		in = s.getInputStream();
		in.read(bIn);
		return bIn;
	}
	
}
