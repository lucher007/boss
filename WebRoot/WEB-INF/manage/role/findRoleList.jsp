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
		<div class="cur-pos">
			<spring:message code="page.currentlocation" />：<spring:message code="menu.system.role" />&gt;<spring:message code="role.rolequery" />
		</div>
		
		<form action="" method="post" id="searchForm" name="searchForm">
			<div class="seh-box">
				<table width="100%">
					<tr>
						<td align="right" width="10%"><spring:message code="role.rolecode" />：</td>
						<td width="20%"><input type="text" class="inp" name="queryrolecode" id="queryrolecode" value="${role.queryrolecode }"></td>
						<td width="130px" align="right">
							<%-- 
							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryRole();" />
							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addRole();" />
							 --%>
							<a href="javascript:queryRole();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
							<a href="javascript:addRole();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
						</td>
					</tr>
					<!--
					<tr>
						<td align="right" width="10%"><spring:message code="role.rolename" />：</td>
						<td width="20%"><input type="text" class="inp" name="queryrolename" id="queryrolename" value="${role.queryrolename }"></td>
						<td align="right" width="130px"><input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addRole();" /></td>
					</tr>
					  -->
				</table>
			</div>
			<div class="lst-box">
				<table id="treetable" class="treetable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr class="lb-tit">
						<td><spring:message code="role.rolecode" /></td>
						<td><spring:message code="role.rolename" /></td>
						<td><spring:message code="role.type" /></td>
						<td><spring:message code="role.authorize" /></td>
						<td><spring:message code="page.operate"/></td>
						<!-- 
						<td style="white-space: nowrap;width: 51px"><input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
							<label for="checkall"><spring:message code="page.select.all" /> </label></td>
						 -->
					</tr>
					<c:forEach items="${role.rolelist }" var="dataList">
						<tr height="30" class="lb-list">
							<td>${dataList.rolecode}</td>
							<td>
							   　<c:choose>
							   		<c:when test="${dataList.rolecode=='00000001'}">
							   			<spring:message code='role.rolecode.${dataList.rolecode}'/>
							   		</c:when>
							   		<c:otherwise>
								    	<spring:message code='${dataList.rolename}'/>
								    </c:otherwise>  
							   </c:choose>
							   <c:if test="">
							   		
							   </c:if>
								
							</td>
							<td><spring:message code="role.type.${dataList.type }" />
							<td>
								<c:choose>
									<c:when test="${Operator.loginname != 'admin' && dataList.type == '0'}">
										<a class="btn-look" href="javascript:checkRole(${dataList.id},'<spring:message code='${dataList.rolename}'/>');"><spring:message code="page.query"/></a>
									</c:when>
									<c:otherwise>
										<a class="btn-edit" href="javascript:editRole(${dataList.id },'<spring:message code='${dataList.rolename}'/>');">
										<spring:message code="role.config.authorize"/>
										</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${dataList.type ne '0'}">
			          				<a class="btn-del" href="javascript:deleteRole(${dataList.id });" ><spring:message code="page.delete"/></a>
			          			</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="page">
				<cite> <pg:pager url="role/findByList" items="${role.pager_count}" index="center" maxPageItems="10" maxIndexPages="5"
						isOffset="<%= true %>" export="offset,currentPageNumber=pageNumber" scope="request"
					>
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="queryrolecode" value="${role.queryrolecode}" />
						<pg:param name="queryrolename" value="${role.queryrolename}" />
						<pg:index>
					<spring:message code="page.total"/>:${role.pager_count}
					<pg:first unless="current">
								<a href="<%=pageUrl%>"><spring:message code="pape.firstpage"/></a>
							</pg:first>
							<pg:prev export="prevPageUrl=pageUrl">
								<a href="<%=prevPageUrl%>"><spring:message code="page.prevpage"/></a>
							</pg:prev>
							<pg:pages>
								<%
									if (pageNumber == currentPageNumber) {
								%><span style="font:bold 16px arial;"><%=pageNumber%></span>
								<%
									} else {
								%><a href="<%=pageUrl%>"><%=pageNumber%></a>
								<%
									}
								%>
							</pg:pages>
							<pg:next export="nextPageUrl=pageUrl">
								<a href="<%=nextPageUrl%>"><spring:message code="page.nextpage"/></a>
							</pg:next>
							<pg:last>
								<a href="<%=pageUrl%>"><spring:message code="page.lastpage"/></a>
							</pg:last>
						</pg:index>
					</pg:pager> </cite>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="main/plugin/easyui/js/easyui.js"></script>
	<script type="text/javascript">
		function queryRole() {
			$("#searchForm").attr("action", "role/findByList");
			$("#searchForm").submit();
		}

		function addRole() {
			$("#searchForm").attr("action", "role/addRoleInit");
			$("#searchForm").submit();
		}

		$(function() {
			var returninfo = '${role.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		//全选
		function checkAll() {
			$(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
		}

		function deleteSelected() {
			var checked = false;
			$('.checkbox').each(function() {
				if ($(this).attr('checked')) {
					return checked = true;
				}
			});

			if (checked) {
				$.dialog.confirmMultiLanguage(
						'<spring:message code="page.confirm.execution"/>?',
						'<spring:message code="page.confirm"/>',
						'<spring:message code="page.cancel"/>', function() {
							$("#searchForm").attr(
									"action",
									"role/deleteSelected" + "?pager_offset="
											+ '${role.pager_offset}' + "&rid="
											+ Math.random());
							$("#searchForm").submit();
						}, function() {
						});
			} else {
				$.dialog.tips('<spring:message code="page.select.empty"/>', 1,
						'alert.gif');
			}

		}

		var editRoleDialog;
		function editRole(id,rolename) {
			editRoleDialog = $.dialog({
				title : '<spring:message code="role.roleedit"/>',
				lock : true,
				width : 850,
				height : 525,
				top : 0,
				drag : true,
				resize : true,
				max : false,
				min : false,
				lockScroll : true,
				content : 'url:role/editRole?id=' + id
			});
		}

		var checkRoleDialog;
		function checkRole(id, rolename) {
			checkRoleDialog = $.dialog({
				title : '<spring:message code="page.query"/>',
				lock : true,
				width : 850,
				height : 525,
				top : 0,
				drag : true,
				resize : true,
				max : false,
				min : false,
				lockScroll : true,
				content : 'url:role/checkRole?id=' + id
			});
		}

		function closeDialog(target) {
			if (target == "editRoleDialog") {
				editRoleDialog.close();

			} else if (target == "checkRoleDialog") {
				checkRoleDialog.close();
			}
		}
		
		/**
	*删除
	*/
	function deleteRole(id){
	   
	  $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>', 
			function(){ 
				$("#searchForm").attr("action", "role/delete?id="+id+"&pager_offset="+'${role.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
		
	</script>
</body>
</html>
