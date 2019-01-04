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
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" />&gt;<spring:message code="menu.stat.userstatequery" /></div>
		<div class="seh-box">
			<form action="" method="post" id="searchForm" name="searchForm">
				<input type="hidden" id="operatorid" name="operatorid" value="${businessReport.operatorid}" />
				<table width="100%">
					<tr>
						<td align="right"><spring:message code="user.state" />：</td>
						<td>
							<select id="querystate" name="querystate" class="select" onchange="queryState();">
									<option value=""  <c:if test="${user.querystate == ''}">selected</c:if>><spring:message code="page.select" /></option>
									<option value="0"<c:if test="${user.querystate == '0'}">selected</c:if>><spring:message code="user.state.0"/></option>
									<option value="1"<c:if test="${user.querystate == '1'}">selected</c:if>><spring:message code="user.state.1" /></option>
							</select>
						</td>
						
						<td colspan="6" align="center">
							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryState();" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td><spring:message code="network.netname" />
					</td>
					<td><spring:message code="area.areacode" />
					</td>
					<td><spring:message code="userproduct.state" />
					</td>
					<td><spring:message code="statistic.count" />
					</td>
				</tr>
				<c:forEach items="${user.userlist }" var="dataList">
					<tr class="lb-list" height="30" class="lb-list">
						<td>${dataList.network.netname }</td>
						<td>${dataList.areacode }</td>
						<td><c:if test="${dataList.state == '0' }">
								<spring:message code="user.state.0" />
							</c:if> <c:if test="${dataList.state == '1' }">
								<spring:message code="user.state.1" />
							</c:if></td>
						<td>${dataList.count}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="page">
			<cite> 
				<pg:pager 
				    url="statistic/findUserList" 
				    items="${user.pager_count}" 
				    index="center" 
				    maxPageItems="10" 
				    maxIndexPages="5"
					isOffset="<%= true %>" 
					export="offset,currentPageNumber=pageNumber" 
					scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="querystate" value="${user.querystate}" />
					<pg:index>
					<spring:message code="page.total"/>:${user.pager_count}
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
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript">
		function queryState() {
			$("#searchForm").attr("action", "statistic/findUserList");
			$("#searchForm").submit();
		}

		$(function() {
			var returninfo = '${stb.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});
	</script>
</body>
</html>
