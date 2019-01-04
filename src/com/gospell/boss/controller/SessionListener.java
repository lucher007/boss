package com.gospell.boss.controller;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.gospell.boss.po.Operator;

public class SessionListener implements HttpSessionListener {

	private static Hashtable<String, HttpSession> hOperatorName = new Hashtable<String, HttpSession>();

	public void sessionCreated(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		System.out.println("已创建新用户session -- " + arg0);
	}

	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub

		if (arg0.getSession().getAttribute("Operator") != null) {
			Operator operator = (Operator) arg0.getSession().getAttribute(
					"Operator");
			String sLoginName=operator.getLoginname();
			deleteOperatorName(arg0.getSession(), sLoginName);
		}
		hOperatorName.remove(arg0.getSession());
		System.out.println("删除操作员session -- " + arg0);
	}

	public synchronized static boolean deleteOperatorName(HttpSession session,
			String sOperatorName) {
		System.out.println("删除操作员 - " + sOperatorName + " || session - " + session);
		hOperatorName.remove(sOperatorName); // 删除用户
		return true;
	}
    
	/**
	 * 操作员登录
	 */
	public synchronized static boolean isLogined(HttpSession session,
			String sOperatorName) {
		boolean flag = false;
		if (hOperatorName.containsKey(sOperatorName)) {
			flag = true;
			HttpSession vsession = (HttpSession) hOperatorName.get(sOperatorName);
			try {
				if(session != vsession){//不是同一个Session
					vsession.invalidate();
					System.out.println("用户 - " + sOperatorName + " || session 已存在 - " + session);
					System.out.println("已设置 - " + sOperatorName + " || session 失效并移除");
				}
			} catch (Exception ex) {
			}
		} else {
			flag = false;

		}
		//删除旧操作员sesssion
		hOperatorName.remove(sOperatorName);
		//创建新的操作员sesssion
		hOperatorName.put(sOperatorName, session);
		System.out.println("创建操作员 - " + sOperatorName + " || session - " + session);

		return flag;
	}
    
	/**
	 * 判断操作员是否在线
	 */
	public synchronized static boolean isOnline(HttpSession session,
			String sUserName) {
		boolean flag = false;
		HttpSession vsession = null;
		try {
			vsession = (HttpSession) hOperatorName.get(sUserName);
		} catch (Exception e) {

		}
		if (vsession != null) {
			if (session.getId().equals(vsession.getId())) {
				flag = true;
			} else {
				flag = false;
			}
		}
		return flag;

	}
}
