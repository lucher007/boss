package com.gospell.boss.socketmanage;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

/** 
 * @说明 被重新定义的连接对象，增加了名字这个属性，重写了关闭的方法 
 * @author lucher 
 * @version 1.0 
 * @since 
 */  
public class SocketCui extends Socket{    
    /** 
     * 为对象增加名称属性 
     */  
    private Integer id;      
    public SocketCui() {  
    }     
    public SocketCui(String ip,int port) throws UnknownHostException, IOException{  
        super(ip, port);  
    }     
    /** 
     * 覆盖关闭的方法 
     */  
    @Override  
    public synchronized void close() throws IOException {  
        SocketKeep.socketIsLock.put(this.id, "0");  
    }
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}  
    
    
}  
