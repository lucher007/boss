package com.gospell.boss.socketmanage;

import java.net.Socket;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gospell.boss.po.Server;

/**
 * @说明 对外提供的方法
 * @author lucher
 * @version 1.0
 * @since 得到某个资源使用后必须释放，否则造成霸占使用
 */
public class CommonSocket {
	private static Log logger = LogFactory.getLog(CommonSocket.class);
	/**
	 * @说明 通过名字来获得某个连接对象
	 * @since 如果返回为空，你应该尝试反复调用，因为该对象可能被检测机制占用，或当前不可用
	 * @since 如果你通过该方法获得了连接对象，那么你应该在使用后显示的关闭该对象的使用，否则该对象会死锁
	 * @since 如果你尝试获得一个没有被定义的连接，那么会返回NULL
	 */
	public static Socket getSocketById(Integer id) {
		
		//获取连接对象
		SocketCui socket  = SocketKeep.socketMap.get(id);
	    if(socket !=null ){
	    	String isLock = SocketKeep.socketIsLock.get(id);
			// 如果当前未锁定
			if (null != isLock && !"1".equals(isLock)) {
				// 设置占用
				SocketKeep.socketIsLock.put(id, "1");
				
//				try {
//					// 发送一个心跳包
//					socket.sendUrgentData(0xFF);
//				} catch (Exception e) {
//					logger.error("得到资源后发现资源不可用！资源名称：" + name);
//					socket = null;
//				}
			} else {
				logger.warn("当前连接正被占用，请稍候尝试！资源id=：" + id);
			}
	    }
		
		return socket;
	}
	/**
	 * @说明 根据名称建立一个连接
	 * @since 需要被创建的连接必须已经加载了配置的信息
	 */
	public static Socket initSocketByServer(Server server) {
		
		SocketCui socket = null;  
		
		if (null != server) {
			try {
				socket = new SocketCui(server.getIp(), Integer.valueOf(server.getPort()));
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
		
		return socket;
	}
}
