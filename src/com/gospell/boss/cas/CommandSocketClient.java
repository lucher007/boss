package com.gospell.boss.cas;

import java.io.IOException;
import java.net.Socket;

import com.gospell.boss.controller.BaseController;

public class CommandSocketClient extends BaseController {
	private static Socket s = null;
	public synchronized Socket getSocket(String ip, String port) {
		try {
			s = new Socket(ip, Integer.valueOf(port));
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println("socket.connect.error");
		}
		return s;
	}

	public synchronized void closeSocket(Socket s) {
		if (s.isConnected())
			try {
				s.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}

}
