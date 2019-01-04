<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		/*========== 404 ==========*/
		 #bg404{ background:url(../images/login/logbglist.jpg); padding:0; width:99%;}
		.img404{ background:url(../images/frame/404bg.jpg) no-repeat center top; width:99%; height:100%;}
		.box404{ width:500px; margin:auto; overflow:hidden; padding-top:200px;}
		.bt-404{ width:500px; height:45px; line-height:45px; text-align:center; color:#FFF; text-shadow:1px 2px 2px #006600; filter: dropshadow(OffX=1, OffY=1, Color='#006600', Positive='true'); font-size:24px; font-weight:bold;}
		.bl-404{ width:500px; height:53px; padding-top:118px; text-align:center;}
		.bl-404 a{color:#FFF; text-shadow:1px 2px 2px #006600; filter: dropshadow(OffX=1, OffY=1, Color='#006600', Positive='true'); font-size:24px; font-weight:bold;}
		.bl-404 a.log404{ margin-left:50px;}
	</style>
	
	<script type="text/javascript">     
		function gologin(surl){     
		 	  window.top.location.href=surl;     
		}     
	</script> 
  </head>
  <body>
    <body id="bg404">
	<div>
    	<div class="box404">
        	<div class="bt-404">
        		<spring:message code="page.error" />
            </div>
            <div class="bl-404">
            	<a href="javascript:history.go(-1);"><spring:message code="page.goback" /></a>
                <a href="#" onclick="gologin('<%=request.getContextPath()%>/operator/initLogin');" class="log404"><spring:message code="page.gologin" /></a>
            </div>
        </div>
    </div>
  </body>
</html>
