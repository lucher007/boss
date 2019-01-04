package com.gospell.boss.common;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 判断登录界面session失效
 */
public class BaseInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		if (request.getRequestURI() == null) {
			request.getRequestDispatcher("/boss/").forward(request, response);
			return false;
		}
		if (("/boss/").equals(request.getRequestURI())) {
			response.sendRedirect(request.getContextPath() + "/operator/initLogin?rid="+new Date().getTime());
			return false;
		}

		if (!(request.getRequestURI().endsWith("/boss/operator/initLogin")
				|| request.getRequestURI().endsWith("/boss/operator/login")
				|| request.getRequestURI().endsWith("/boss/operator/logout")
				|| request.getRequestURI().endsWith("/boss/operator/changeLanguage")
				|| request.getRequestURI().endsWith("/boss/operator/noPermission")
				|| request.getRequestURI().indexOf("boss/httpForMps") > -1
				|| request.getRequestURI().indexOf("boss/js") > -1
				|| request.getRequestURI().indexOf("boss/style") > -1
				|| request.getRequestURI().indexOf("boss/images") > -1
				|| request.getRequestURI().indexOf("boss/authorize") > -1
				|| request.getRequestURI().indexOf("boss/operator/createAuthorizeKey") > -1
				|| request.getRequestURI().indexOf("boss/operator/uploadAuthorizeKeyInit") > -1
				|| request.getRequestURI().indexOf("boss/operator/uploadAuthorizeKey") > -1
				|| request.getRequestURI().indexOf("material") > -1
				|| request.getRequestURI().indexOf("codearea") > -1)) {
			
			if (request.getSession().getAttribute("Operator") == null) {
				response.sendRedirect(request.getContextPath()+"/operator/noPermission"); 
				return false;
			}
		}
		return super.preHandle(request, response, handler);
	}
}
