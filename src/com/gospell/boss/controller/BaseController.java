package com.gospell.boss.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

public class BaseController {
	
	public HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	}
	public HttpSession getSession(){
		getRequest().getSession().setMaxInactiveInterval(14400);//单位秒，设置Session连接时间,4个小时
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession();
	}
	
	public String getMessage(String name){
		RequestContext requestContext = new RequestContext(getRequest());
		return requestContext.getMessage(name);
	}
}
