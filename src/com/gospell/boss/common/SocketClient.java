package com.gospell.boss.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.Socket;

public class SocketClient {
  public String sendCommandTcp(String host, int port, String info) {
      try {
      
    	  Socket socket = new Socket(host, port);

	      PrintWriter writer = new PrintWriter(socket.getOutputStream());
	      writer.println(info);
	      writer.flush();
	
	      BufferedReader reader = new BufferedReader(
	        new InputStreamReader(socket
	        .getInputStream()));
	      String response = reader.readLine();
	
	      if (!socket.isClosed()) {
	        socket.close();
	      }
	      return response; 
	   } catch (Exception e) {
	   }
	    return null;
  }

  public void sendCommandUdp(String host, int port, String info) {
    try {
      InetAddress inetAddress = InetAddress.getByName(host);
      byte[] buf = info.getBytes();
      DatagramPacket datagramPacket = new DatagramPacket(buf, 
        buf.length, inetAddress, port);

      DatagramSocket datagramSocket = new DatagramSocket();
      datagramSocket.send(datagramPacket);

      if (!datagramSocket.isClosed()){
    	  datagramSocket.close();
      }
    } catch (Exception localException) {
    }
  }
}