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
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.forcechangechannel"/>(<spring:message code="server.versiontype.gos_pn" />)</div>
		<div class="seh-box">
			<form action="" method="post" id="searchForm" name="searchForm">
				<table width="100%">
						<tr>
							<td width="130px" colspan="3" align="right"><input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="add();" /></td>
						</tr>
						<tr>
							  <td align="right"><spring:message code="authorize.querybyaddtime" />：</td>
							  <td><input type="text" id="querydate" name="querydate" value="${caspnforcedcc.querydate}" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" /></td>
							  <td align="right"><input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="query();" /></td>
						</tr>
				</table>
			</form>
		</div>
		
		<div class="lst-box">
			<table id="treetable" class="treetable" width="100%" border="0" cellspacing="0" cellpadding="0">
				
				<tr class="lb-tit">
					<td><spring:message code="authorize.forcedcc.id"/></td>
				
				<!-- 	<td><spring:message code="authorize.osd.keylock"/></td> -->
					<td><spring:message code="authorize.forcedcc.stbtype"/></td>
					<td><spring:message code="authorize.osd.starttime"/></td>
					<td><spring:message code="authorize.osd.exptime"/></td>
					<td><spring:message code="problemcomplaint.addtime"/></td>
					<td><spring:message code="page.operate"/></td>
				<!-- 	<td style="white-space: nowrap;width: 51px">
						<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						<label for="checkall"><spring:message code="page.select.all" /></label>
					</td> -->
				</tr>
				
				<c:forEach items="${caspnforcedcc.caspnforcedcclist }" var="dataList">
					<tr height="30" class="lb-list">
						<td>${dataList.id}</td>
						<%-- 	<td>${dataList.lockscreen}</td> --%>
						<td><spring:message code="authorize.forcedcc.stbtype.${dataList.stbtype}"/></td>
						<td>${fn:substring(dataList.starttime, 0, 19)}</td>
						<td>${fn:substring(dataList.expiredtime, 0, 19)}</td>
						<td>${fn:substring(dataList.addtime, 0, 19)}</td>
						<td>
							<a class="btn-scal" href="javascript:cancelById('${dataList.id}');"><spring:message code="authorize.osd.cancel"/></a>
							<a class="btn-del" href="javascript:deleteById(${dataList.id});"><spring:message code="page.delete"/></a>
						</td>
						<%-- 						
						<td><input type="checkbox" class="checkbox" name="ids" value="${dataList.id}" onclick="checkbox();" style="vertical-align: middle;"></td>
						 --%>				
					</tr>
				</c:forEach>
			
			</table>
		</div>
		<div class="page">
			<cite><pg:pager url="cas_pn/find_Cmd32_List" items="${caspnforcedcc.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%= true %>" export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
				<%-- 					
				<pg:param name="querynetid" value="${caspnforcedosd.querynetid}"/>
				 --%>					
 					<pg:index>
					<spring:message code="page.total"/>:${caspnforcedcc.pager_count}
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
	
	<script type="text/javascript"  src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript"  src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript">
		
		
		function deleteById(id){
			$.dialog.confirmMultiLanguage(
					'<spring:message code="page.confirm.execution"/>?',
					'<spring:message code="page.confirm"/>',
					'<spring:message code="page.cancel"/>', function() {
						$("#searchForm").attr(
								"action",
								"cas_pn/delete_Cmd32?id=" + id
										+ "&pager_offset="
										+ '${caspnforcedcc.pager_offset}'
										+ "&rid=" + Math.random());
						$("#searchForm").submit();
					}, function() {
					});
		}
		
			function cancelById(id){
			$.dialog.confirmMultiLanguage(
					'<spring:message code="page.confirm.execution"/>?',
					'<spring:message code="page.confirm"/>',
					'<spring:message code="page.cancel"/>', function() {
						$("#searchForm").attr(
								"action",
								"cas_pn/send_cancel_Cmd32?id=" + id 
										+ "&pager_offset="
										+ '${caspnforcedcc.pager_offset}'
										+ "&rid=" + Math.random());
						$("#searchForm").submit();
					}, function() {
					});
		}
		
		
		function query() {
			$("#searchForm").attr("action", "cas_pn/find_Cmd32_List");
			$("#searchForm").submit();
		}

		function add() {
			$("#searchForm").attr("action", "cas_pn/add_Cmd32_Init");
			$("#searchForm").submit();
		}

		$(function() {
			var returninfo = '${caspnforcedcc.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		function checkAll() {
			$(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
		}

		function checkbox() {
			var checked = true;
			$('.checkbox').each(function() {
				if (!$(this).attr('checked')) {
					checked = false;
				}
			});
			$('#checkall').attr('checked', checked);
		}
	</script>
</body>
</html>
