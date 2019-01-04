<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link rel="stylesheet" href="main/plugin/ztree/css/metroStyle/metroStyle.css" />
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.system.role"/> &gt; <spring:message code="role.addrole"/></div>
		<form method="post" id="addForm" name="addForm">
			<div class="form-box">
				<div class="fb-tit"><spring:message code="role.addrole"/></div>
				<div class="fb-con" align="center">
					<table>
						
						<tr height="30px">
							<td align="right" height="30"><spring:message code="role.rolename"/>：</td>
							<td align="left">
								<input type="text" class="inp" name="rolename" id="rolename" maxlength="30" value="${role.rolename}"/>
							</td>
						</tr>

						<tr height="30px">
							<td align="right"><spring:message code="role.rolecode"/>：</td>
							<td align="left"><input type="text" class="inp" name="rolecode" id="rolecode" maxlength="5" value="${role.rolecode}"/></td>
						</tr>

						<tr height="40px">
							<td align="right"><spring:message code="role.config.authorize"/>：</td>
							<td width="200px">
								<div class="easyui-panel" style="padding:5px">
									<ul id="tt" class="easyui-tree" data-options="url:'role/getMenuTreeJson',method:'get',animate:true,checkbox:true"></ul>
								</div>
							</td>
						</tr>
				
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()"> 
						<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveRole();"/> 
						 --%>
						<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:saveRole();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red">${role.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="main/plugin/easyui/js/easyui.js"></script>
	<script type="text/javascript">
		function goBack() {
			$("#addForm").attr("action", "role/findByList").submit();
		}

		
		
		function saveRole() {
			var menuids = '';
			var nodes = $('#tt').tree('getChecked');
			for ( var i = 0; i < nodes.length; i++) {
				if (menuids != '')
					menuids += ',';
				menuids += nodes[i].id;
			}
			
			
			if ($('#rolecode').val() == '') {
			    $.dialog.tips('<spring:message code="role.rolecode.empty"/>', 1, 'alert.gif');
			    $('#rolecode').focus();
		      return;
		    }
		    
			if(menuids.length < 1){
				$.dialog.tips('<spring:message code="role.authorize.empty"/>', 1, 'alert.gif');
			return; 
			}
			$("#addForm").attr("action", "role/saveRole?menuids=" + menuids).submit();
		}

		$(function() {
			var returninfo = '${role.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

	</script>
</body>
</html>
