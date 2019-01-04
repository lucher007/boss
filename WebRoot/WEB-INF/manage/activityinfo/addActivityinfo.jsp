<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link type="text/css" rel="stylesheet" href="<%=basePath%>main/plugin/uploadify/uploadify.css" />
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos">
			<spring:message code="page.currentlocation" />：<spring:message code="menu.system.activityinfo" />&gt;<spring:message code="activityinfo.activityinfoadd" />
		</div>
		<form method="post" enctype="multipart/form-data" id="addForm" name="addForm">
			<div class="form-box">
				<div class="fb-tit">
					<spring:message code="activityinfo.activityinfoadd" />
				</div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr height="auto">
							<td align=center>
								<div class="easyui-panel" title="<spring:message code="menu.system.activityinfo"/>" style="width:750px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr height="30px">
											<td align="right"><spring:message code="activityinfo.title" />：</td>
											<td>
												<input type="text" class="inp" name="title" style="width: 250px;" id="title" value="${activityinfo.title }"
													maxlength="50"
												>
											</td>
										</tr>
										<tr height="30px">
											<td align="right"><spring:message code="activityinfo.type" />：</td>
											<td>
												<select id="type" name="type" class="select" style="width: 200px;">
													<option value="1">
														<spring:message code="activityinfo.type.1" />
													</option>
												</select>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack();" /> 
						<input type="button" class="btn-save uploadfiles" value="<spring:message code="page.save"/>" onclick="uploadifybutton();"/> 
						 --%>
						<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:saveActivityinfo();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red" id="resultinfo"></span>
				</div>
			
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>main/plugin/uploadify/jquery.uploadify.js"></script>
	<script type="text/javascript">
  	  
	  function goBack() {
	      $("#addForm").attr("action", "activityinfo/findByList");
	      $("#addForm").submit();
	  }
	  
	  function saveActivityinfo(){
		  if ($('#title').val() == '') {
		      $.dialog.tips('<spring:message code="activityinfo.title.empty"/>', 2, 'alert.gif');
		      $('#title').focus();
		      return;
		    }
		    
		    $("#addForm").attr("action", "activityinfo/save");
		    $("#addForm").submit();
  	  }
	  
	  $(function () {
	       var returninfo = '${activityinfo.returninfo}';
	       if (returninfo != '') {
	        	$.dialog.tips(returninfo, 2, 'alert.gif');
	       }
	  });
  
</script>
</body>
</html>
