package com.gospell.boss.common;

import java.io.*;  

import javax.servlet.ServletContextEvent;  
import javax.servlet.ServletContextListener;  

public class SocketListener  implements ServletContextListener {  
    Processor p = new Processor();  
      
    public void contextDestroyed(ServletContextEvent arg0) {  
        System.out.print("我反线程关闭标识置false!");  
    }  
    public void contextInitialized(ServletContextEvent arg0) {        
        p.start();    
    }  
}  

class Processor extends Thread {  
    public void run() {  
    	try {
			SocketServer.startLinster(1399);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }  
    
}  
