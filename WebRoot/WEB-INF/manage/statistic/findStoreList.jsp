<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.storereport" /></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
           <input type="hidden" id="storeid" name="storeid" value = '${store.querystate}'/>
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td width="130px">
						 <select id="querynetid" name="querynetid" class="select" onchange="queryStore();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${store.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${store.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					
					<td align="right" width="120px"><spring:message code="store.state"/>：</td>
					<td width="130px">
						 <select id="querystate" name="querystate" class="select" onchange="queryStore();">
						 	 <option value=""><spring:message code="page.select"/></option>
			                   <option value="1" <c:if test="${store.querystate == '1'}">selected</c:if>><spring:message code="store.state.1"/></option>
			                   <option value="0" <c:if test="${store.querystate == '0'}">selected</c:if>><spring:message code="store.state.0"/></option>
			             </select>
					</td>
					<td align="right"><input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryStore();"/></td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="store.storecode"/></td>
	          	<td><spring:message code="store.storename"/></td>
	          	<td><spring:message code="store.address"/></td>
	          	<td><spring:message code="store.state"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${store.storelist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.network.netname }&nbsp;</td>
	        		<td >${dataList.storecode }&nbsp;</td>
	        		<td >${dataList.storename }&nbsp;</td>
	        		<td >${dataList.address }&nbsp;</td>
	        		<td >
	        			<c:if test="${dataList.state == '0' }"><spring:message code="store.state.0"/></c:if>
	        			<c:if test="${dataList.state == '1' }"><spring:message code="store.state.1"/></c:if>
	        		</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:operationReport(${dataList.id },'${dataList.storename }');"><spring:message code="statistic.report" /></a> 
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="statistic/findStoreList"
			    items="${store.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${store.querynetid}"/>
				<pg:param name="querystate" value="${store.querystate}"/>
				<pg:index>
					<spring:message code="page.total"/>:${store.pager_count}
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
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryStore(){
		$("#searchForm").attr("action", "statistic/findStoreList");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${store.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });

     var operatrionForDialog;
	 function operationReport(id,storename) {
	    	operatrionForDialog = $.dialog({
		    	title: '<spring:message code="statistic.servicereport" />('+storename+')',
		    	lock: true,
		    	width: 900,
		    	height: 530,
		    	top: 0,
		    	drag: true,
		    	resize: false,
		    	max: false,
		    	min: false,
		    	content: 'url:statistic/storeReportForDialog?storeid='+id+'&storename='+storename+"&rid="+Math.random()
				});
	 }
</script>
</body>
</html>

