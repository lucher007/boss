<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
	<link type="text/css" rel="stylesheet" href="style/user.css">
<style type="text/css">
.fb-con table {
	width: 100%;
}

.fb-con table tr td:first-child {
	height: 30px;
	width: 40%;
	text-align: right;
}

.inp {
	width: 150px;
}
</style>
	</head>
	
	<body>
	<div id="body">
	  <form action="" method="post" id="searchform" name="searchform">
	     <div class="form-box">
	        <div class="fb-tit"><spring:message code="main.helpinfo.download"/></div>
	          <table width="100%">
	            <tr class="lb-tit">
		          	 <td width="80%"><spring:message code="main.helpinfo.filename"/></td>
		          	<td width="20%"><spring:message code="page.operate"/></td>
		        </tr>
		        <tr height="30">
			        <td align="center" width="80%">
			        	<spring:message code="main.helpinfo.stbfiletemplate"/>
			        </td>
			        <td align="center">
			        	<a href="<%=request.getContextPath()%>/operator/downloadHelpDocument?filetype=stbfiletemplate" class="btn-print"><spring:message code="page.download"/></a>
			        </td>
		        </tr>
		        <tr height="30">
			        <td align="center">
			        	<spring:message code="main.helpinfo.cardfiletemplate"/>
			        </td>
			        <td align="center">
			        	<a href="<%=request.getContextPath()%>/operator/downloadHelpDocument?filetype=cardfiletemplate" class="btn-print"><spring:message code="page.download"/></a>
			        </td>
		        </tr>
	          </table>
	      </div>
	    </form>
	</div>
	<script type="text/javascript" src="/js/common/jquery.js"></script>
  <script type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=iblue"></script>
	<script type="text/javascript">
	
		function updateUser(){
			$("#searchform").attr("action", "user!updateUserInfo.shtml").submit();
		}
		
		$(function(){
      $('.form-box table tr td:even').css({
        'text-align': 'right'
      });
      $('.form-box table tr td:odd').css({
        'text-align': 'left'
      });

			var usertype = ${requestScope.user.usertype };
			$("#usertype").val(usertype);
			if ("${returninfo }" != null && "${returninfo }" != "") {
				$.dialog.tips("${returninfo }", 1, "alert.gif");
			}
		});

		function closeDialog() {
			parent.userInfoDialog.close();
		}
		
	</script>   
	</body>
</html>
