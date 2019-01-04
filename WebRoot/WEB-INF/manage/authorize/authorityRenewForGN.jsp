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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.authorize.authorizerefresh"/>  &gt; <spring:message code="server.versiontype.gos_gn"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
				<table width="100%">
					<tr>
						<td align="right" width="120px">用户编号：</td>
						<td><input type="text" class="inp w200"  name="queryusercode" id="queryusercode" value="${problemcomplaint.queryname}"></td>										
						<td align="right">用户卡号：</td>
						<td><input type="text" class="inp w200"  name="queryusercardid" id="queryusercardid" value="${problemcomplaint.queryname}"></td>										
						<td><input type="button" class="btn-sch" value="搜索" onclick="123queryProblemcomplaint();" /></td>
					</tr>
					<tr>
								<td align="right"><spring:message code="statistic.userproduct.querystarttime"/>：</td>
								<td>
			                 		<input type="text" id="querystarttime" name="querystarttime"  onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
								</td>
								<td align="right"><spring:message code="statistic.userproduct.queryendtime"/>：</td>
								<td>
			                 		<input type="text" id="queryendtime" name="queryendtime"  onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
								</td>
								<td width="130px"><input type="button" class="btn-add" value="刷新授权" onclick="123addProblemcomplaint();" /></td>
					</tr>
				</table>
			    <div class="lst-box">
			    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
			    		<tr class="lb-tit">
			    			<td>用户卡号</td>
			    			<td>产品号</td>
				          	<td>发送日期</td>
				          	<td>开始日期</td>
				          	<td>授权截止日期</td>
					        <td style="white-space: nowrap;width: 51px"> 
					        	<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						        <label for="checkall"><spring:message code="page.select.all"/></label>
						    </td>
			        	</tr>
			        	
			        	<c:forEach items="${problemcomplaint.problemcomplaintlist }" var="dataList">
				        	<tr height="30"class="lb-list">
				        		<td >${dataList.network.netname }</td>
				        		<td >${dataList.complaintcode}</td>
				        		<td >${dataList.username }</td>
				        		<td >${dataList.operatorname }</td>
				        		<td ><spring:message code="problemcomplaint.type.${dataList.type}"/></td>
				      			<td>  
				            	    <input type="checkbox" class="checkbox" name="ids" value="${dataList.id}"
					                     onclick="checkbox();"
					                     style="vertical-align: middle;">
					            </td>
				        	</tr>
			        	</c:forEach>
			    	</table>
			    </div>
			    <div class="page">
			    	<cite>
			        	<pg:pager
						    url="problemcomplaint/findByList"
						    items="${problemcomplaint.pager_count}"
						    index="center"
						    maxPageItems="10"
						    maxIndexPages="5"
						    isOffset="<%= true %>"
						    export="offset,currentPageNumber=pageNumber"
						    scope="request">	
							<pg:param name="index"/>
							<pg:param name="maxPageItems"/>
							<pg:param name="maxIndexPages"/>
							<pg:param name="querynetid" value="${problemcomplaint.querynetid}"/>
							<pg:param name="querytype" value="${problemcomplaint.querytype}"/>
							<pg:param name="queryuserid" value="${problemcomplaint.queryuserid}"/>
						
							<pg:index>
								<spring:message code="page.total"/>:${problemcomplaint.pager_count}
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
    	</form>
    </div>
</div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">
    //查询操作员
	function queryProblemcomplaint(){
		$("#searchForm").attr("action", "problemcomplaint/findByList");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${problemcomplaint.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       };
    });

	//全选
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () { if (!$(this).attr('checked')) {checked = false;}});
	    $('#checkall').attr('checked', checked);
	};
    
</script>
</body>
</html>

