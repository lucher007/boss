<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />


<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>
<body>
	<div id="body">
		<form method="post" id="editForm" name="editForm">
			<input type="hidden" name="rolecode" id="rolecode" value="${role.rolecode}" /> 
			<input type="hidden"  name="id" id="id" value="${role.id}"/>
			<input type="hidden"  name="type" id="type" value="${role.type}"/>
			<div class="form-box">
				<div class="fb-tit">
					<spring:message code="role.roleedit" />
				</div>
				<div class="fb-con" align="center">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
						<tr height="40px" align="center">
							<td align="right" height="30"><spring:message code="role.rolename"/>：</td>
							<td align="left">
								<c:choose>
							   		<c:when test="${role.rolecode=='00000001'}">
							   			<input type="text" class="inp" name="rolename" id="rolename" maxlength="30" value="<spring:message code='role.rolecode.${role.rolecode}'/>" />
							   		</c:when>
							   		<c:otherwise>
								    	<input type="text" class="inp" name="rolename" id="rolename" maxlength="30" value="${role.rolename}" />
								    </c:otherwise>  
							   </c:choose>
							</td>
						</tr>
						<tr height="170px" align="center">
							<td align="right"><spring:message code="role.config.authorize" />：</td>
							<td align="left">
								<div class="easyui-panel" style="width:250px;padding:10px;">
									<ul id="tt" class="easyui-tree"></ul>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="closeDialog()"> 
						<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveRole();"/> 
						 --%>
						<a href="javascript:closeDialog();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:saveRole();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red">${role.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="main/plugin/easyui/js/easyui.js"></script>
	<script type="text/javascript">
		function queryRole() {
			$("#searchForm").attr("action", "role/findByList");
			$("#searchForm").submit();
		}

		$(function() {
			initTree();
			var returninfo = '${role.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		function initTree() {
			$('#tt').tree({
				url : 'role/getMenuTreeJson?roleid=${role.id}' + '&rid='+Math.random(),
				method : 'get',
				animate : true,
				checkbox : true,
			});
		}

		function saveRole() {
			var menuids = '';
			var nodes = $('#tt').tree('getChecked');
			for ( var i = 0; i < nodes.length; i++) {
				if (menuids != '')
					menuids += ',';
				menuids += nodes[i].id;
			}
			if (menuids.length < 1) {
				$.dialog.tips('<spring:message code="role.authorize.empty"/>',1, 'alert.gif');
				return;
			}
			$("#editForm").attr("action", "role/updateRole?menuids=" + menuids).submit();
		}

		function closeDialog() {
			parent.closeDialog("editRoleDialog");
		}
	</script>
</body>
</html>
