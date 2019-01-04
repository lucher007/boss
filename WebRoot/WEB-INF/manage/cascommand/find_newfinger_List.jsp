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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.newshowfinger"/></div>
		<div class="seh-box">
			<form action="" method="post" id="searchForm" name="searchForm">
				<table width="100%">
					<tr>
						<td align="right" width="120px"><spring:message code="server.versiontype"/>：</td>
						<td width="130px">
							<select name="queryversiontype" id="queryversiontype" class="select">
				                <option value=""><spring:message code="page.select"/></option>
				                <option value="gos_pn" <c:if test="${caspnnewfinger.queryversiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
				                <option value="gos_gn" <c:if test="${caspnnewfinger.queryversiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
				            </select>
						</td>
						<td width="130px" colspan="3" align="right">
							<%-- 
							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="add();" />
							 --%>
							<a href="javascript:add();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
						</td>
					</tr>
					<tr>
						  <td align="right"><spring:message code="authorize.querybyaddtime" />：</td>
						  <td><input type="text" id="querydate" name="querydate" value="${caspnnewfinger.querydate}" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" /></td>
						  <td align="right">
						  	<%-- 
						  	<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="query();" />
						  	 --%>
						  	<a href="javascript:query();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
						  </td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td><spring:message code="id"/></td>
					<td><spring:message code="server.versiontype"/></td>
					<td><spring:message code="problemcomplaint.addtime"/></td>
					<td><spring:message code="page.operate"/></td>
				</tr>
				
				<c:forEach items="${caspnnewfinger.caspnnewfingerlist }" var="dataList">
					<tr height="30" class="lb-list">
						<c:if test="${dataList.versiontype eq 'gos_pn'}">
							<td>${dataList.id}</td>
						</c:if>
						<c:if test="${dataList.versiontype eq 'gos_gn'}">
							<td>${dataList.fingerid}</td>
						</c:if>
						<td><spring:message code="server.versiontype.${dataList.versiontype}"/></td>
						<td>${fn:substring(dataList.addtime, 0, 19)}</td>
						<td>
								<a class="btn-scal" href="javascript:cancelById('${dataList.id}');"><spring:message code="authorize.osd.cancel"/></a>
<!-- 							<c:if test="${dataList.versiontype eq 'gos_pn'}"> -->
<!-- 							</c:if> -->
<%-- 							<a class="btn-del" href="javascript:deleteById(${dataList.id});"><spring:message code="page.delete"/></a>
 --%>						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="page">
    	<cite>
        	<pg:pager
			    url="cascommand/find_newfinger_List"
			    items="${caspnnewfinger.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="queryversiontype" value="${caspnnewfinger.queryversiontype}"/>
				<pg:param name="querydate" value="${caspnnewfinger.querydate}"/>
				<pg:index>
					<spring:message code="page.total"/>:${caspnnewfinger.pager_count}
					<pg:first unless="current">
						<a href="<%=pageUrl %>"><spring:message code="pape.firstpage"/></a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
				  		<a href="<%= prevPageUrl %>"><spring:message code="page.prevpage"/></a>
					</pg:prev>
					<pg:pages>
	   					<%if (pageNumber == currentPageNumber) { 
				    	%><span style="font:bold 16px arial;"><%= pageNumber %></span><%
				  		} else {
				    	%><a href="<%= pageUrl %>"><%= pageNumber %></a><%
				   		}
						%>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
				  		<a href="<%= nextPageUrl %>"><spring:message code="page.nextpage"/></a>
					</pg:next>
					<pg:last>
						<a href="<%=pageUrl %>"><spring:message code="page.lastpage"/></a>
					</pg:last>
				</pg:index>
			</pg:pager>
    	</cite>
    </div>
	</div>
	
	<script type="text/javascript"  src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript"  src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		
		function deleteById(id){
			$.dialog.confirmMultiLanguage(
					'<spring:message code="page.confirm.execution"/>?',
					'<spring:message code="page.confirm"/>',
					'<spring:message code="page.cancel"/>', function() {
						$("#searchForm").attr(
								"action",
								"cascommand/delete_newfinger?id=" + id
										+ "&pager_offset="
										+ '${caspnnewfinger.pager_offset}'
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
								"cascommand/send_cancel_newfinger?id=" + id 
										+ "&pager_offset="
										+ '${caspnnewfinger.pager_offset}'
										+ "&rid=" + Math.random());
						$("#searchForm").submit();
					}, function() {
					});
		}
		
		
		function query() {
			$("#searchForm").attr("action", "cascommand/find_newfinger_List");
			$("#searchForm").submit();
		}

		function add() {
			$("#searchForm").attr("action", "cascommand/add_newfinger_Init");
			$("#searchForm").submit();
		}

		$(function() {
			var returninfo = '${caspnnewfinger.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});
	</script>
</body>
</html>
