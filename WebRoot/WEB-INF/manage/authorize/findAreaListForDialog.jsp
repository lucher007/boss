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
</head>
<body>
	<div id="body">
		<div class="lst-box">
			<table id="treetable" class="treetable" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td width="60">
						<spring:message code="page.select" />
					</td>
					<td>
						<spring:message code="network.netname" />
					</td>
					<td>
						<spring:message code="area.areacode" />
					</td>
					<td>
						<spring:message code="area.areaname" />
					</td>
				</tr>
				
				<c:forEach items="${area.arealist}" var="dataList">
					<tr height="30" class="lb-list">
						<td width="" height="30">
							<input type="radio" name="singleselect" value="${dataList.areacode }">
						</td>
						<td>${dataList.network.netname }</td>
						<td>${dataList.areacode}</td>
						<td>${dataList.areaname }</td>
					</tr>
				</c:forEach>
			
			</table>
		</div>
		<div class="page">
			<cite> <pg:pager url="authorize/findAreaListForDialog" items="${area.pager_count}" index="center" maxPageItems="10" maxIndexPages="5"
					isOffset="<%= true %>" export="offset,currentPageNumber=pageNumber" scope="request"
				>
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:index>
								<spring:message code="page.total"/>:${area.pager_count}
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
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
		//查询操作员
		function queryUser() {
			$("#searchForm").attr("action",
					"problemcomplaint/findUserListForDialog");
			$("#searchForm").submit();
		}

		$(function() {
			var returninfo = '${stb.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		$(".lb-list").click(function() {
			var areacode = $(this).find("input[type=radio]").val();
			$(this).find("input[type=radio]").attr('checked', 'true');
			parent.closeDialog(areacode);
		});
	</script>
</body>
</html>
