package com.gospell.boss.socketmanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gospell.boss.po.Server;

/** 
 * @说明 变量保持 
 * @author lucher
 * @version 1.0 
 * @since 
 */  
public class SocketKeep {  
    private static Log logger = LogFactory.getLog(SocketKeep.class);  
    /** 
     * 连接对象保持，只保持需要系统保持的连接 
     */  
    public static Map<Integer, SocketCui> socketMap = new LinkedHashMap<Integer, SocketCui>();  
    /** 
     * 连接对象是否锁定 1：锁定，其他未锁定 
     */  
    public static Map<Integer, String> socketIsLock = new LinkedHashMap<Integer, String>();  
   
    /** 
     * 初始化所有连接信息 
     */  
    public static void initSocketKeep(List<Server> serverlist) {  
        
        logger.warn("Start initializing cas connection！");  
        SocketCui socket = null;  
        for(Server server : serverlist){  
            if(null != server){
            	socket = socketMap.get(server.getId());
            	if(socket == null){//新建连接
            		 try {  
                         socket = new SocketCui(server.getIp(),Integer.valueOf(server.getPort()));  
                         socket.setSoTimeout(0);  
                         socket.setKeepAlive(true);  
                         socket.setId(server.getId());  
                     } catch (Exception e) {  
                         logger.error("Error initializing cas connection！servername：" + server.getServername());  
                         socket = null;  
                     }  
            		 //将新建的连接放入到Map中
            		 socketMap.put(server.getId(), socket); 
            		 //设为未锁定
                     socketIsLock.put(server.getId(), "0"); 
            	}else{//发送心跳包判断连接是否有效
            		try {
            			socket.sendUrgentData(0xFF);
            		} catch (Exception e) {
						System.out.println("Connection invalid,socket=" + socket.toString());
						//将此socket设置为无效
			   		 	SocketKeep.socketMap.put(server.getId(), null); 
					}
            	}
            } 
        }         
       
        logger.warn("End initializing cas connection！");  
    }  
}  