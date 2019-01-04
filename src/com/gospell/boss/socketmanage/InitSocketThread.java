package com.gospell.boss.socketmanage;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gospell.boss.po.Server;
/**
 * @说明 初始化新建或者修修改服务器的socket连接
 * @author lucher
 * @version 1.0
 * @since
 */
public class InitSocketThread implements Runnable{	
	private static Log logger = LogFactory.getLog(InitSocketThread.class);	
	
	private Server server = null;	
	
	public InitSocketThread(Server server){
		this.setServer(server);
		
	}
	public void run() {
		SocketCui socket = null;
    	if(server != null){//新建连接
    		 try {  
    			 logger.warn("******初始化新修改服务器的socket连接,服务器名称：" + server.getServername());
                 socket = new SocketCui(server.getIp(),Integer.valueOf(server.getPort()));  
                 socket.setSoTimeout(0);  
                 socket.setKeepAlive(true);  
                 socket.setId(server.getId());  
             } catch (Exception e) {  
            	 logger.error("初始化某个连接时错误！错误的服务器名称：" + server.getServername());  
                 socket = null;  
             }  
    		 //将新建的连接放入到Map中
    		 SocketKeep.socketMap.put(server.getId(), socket); 
    		 //设为未锁定
    		 SocketKeep.socketIsLock.put(server.getId(), "0"); 
    	}
         
		
	}
	
	public Server getServer() {
		return server;
	}
	public void setServer(Server server) {
		this.server = server;
	}
}