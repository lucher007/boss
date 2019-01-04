<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>
<body>
	<div id="body">
		<form action="" method="post" id="searchForm" name="searchForm">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.device.giftcardamount" /> &gt; <spring:message code="giftcardamountpara.giftcardamountparaquery"/></div>
		<div class="seh-box">
				<table width="100%">
					<tr>
						<td align="right" width="120px"><spring:message code="giftcardamountpara.state" />：</td>
						<td>
							<select id="querystate" name="querystate" class="select">
								<option value=""><spring:message code="page.select" /></option>
								<option value="0" <c:if test="${giftcardamountpara.querystate == '0'}">selected</c:if>><spring:message code="giftcardamountpara.state.0" /></option>
								<option value="1" <c:if test="${giftcardamountpara.querystate == '1'}">selected</c:if>><spring:message code="giftcardamountpara.state.1" /></option>
							</select>
						</td>
						<td align="right">
							<%-- 
							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="javascript:queryGiftcardamountpara();" />
							 --%>
							<a href="javascript:queryGiftcardamountpara();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
						</td>
					</tr>
				</table>
		</div>
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td><spring:message code="giftcardamountpara.giftcardamountparaparakey" />
					</td>
					<td><spring:message code="giftcardamountpara.giftcardamountparaamount" />
					</td>
					<td><spring:message code="giftcardamountpara.state" />
					</td>
					<td><spring:message code="page.operate" />
					</td>
				</tr>
				<c:forEach items="${giftcardamountpara.giftcardamountparalist }" var="dataList">
					<tr height="30" class="lb-list">
						<td>${dataList.parakey }</td>
						<td>${dataList.amount }</td>
						<td><spring:message code="giftcardamountpara.state.${dataList.state }" /></td>
						<td>
	           				<a class="btn-edit" href="javascript:updateGiftcardamountpara('${dataList.id}')" ><spring:message code="page.update"/></a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="page">
			<cite> <pg:pager url="giftcardamountpara/findByList" items="${giftcardamountpara.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%= true %>" export="offset,currentPageNumber=pageNumber" scope="request"
				>
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="querystate" value="${giftcardamountpara.querystate}"/>
					<pg:index>
				<spring:message code="page.total"/>:${giftcardamountpara.pager_count}
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
	<script type="text/javascript"  src="js/common/jquery.js"></script>
	<script type="text/javascript"  src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript"  src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
	
	function queryGiftcardamountpara(){
		$("#searchForm").attr("action","giftcardamountpara/findByList");
		$("#searchForm").submit();
	}
	
	
	function updateGiftcardamountpara(id){
		$("#searchForm").attr("action", "giftcardamountpara/updateInit?id="+id+"&pager_offset="+'${giftcardamountpara.pager_offset}');
		$("#searchForm").submit();
	}
	
	$(function () {
       var returninfo = '${giftcardamountpara.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
	
	</script>
</body>
</html>
