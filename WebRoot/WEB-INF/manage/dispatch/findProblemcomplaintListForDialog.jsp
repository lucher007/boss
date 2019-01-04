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
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.complaintquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden"  name="querystate" id="querystate" value="${problemcomplaint.querystate }">
            <table width="100%">
				<tr>
					<td align="right"><spring:message code="problemcomplaint.complaintcode"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryid" id="queryid" value="${problemcomplaint.queryid }">
					</td>
					<td align="right"><spring:message code="user.username"/>：</td>
					<td>
						 <input type="text"  class="inp" name="queryusername" id="queryusername" value="${problemcomplaint.queryusername }">
					</td>
					<td align="center">
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryComplaint();"/>
		    		</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="dispatch.problemtype"/>：</td>		
					<td><select id="queryproblemtype" name="queryproblemtype" class="select" onchange="queryComplaint();">
								<option value=""><spring:message code="page.select" /></option>
								<option value="0" <c:if test="${problemcomplaint.queryproblemtype == '0'}">selected</c:if>>
									<spring:message code="problemcomplaint.problemtype.0" />
								</option>
								<option value="1"<c:if test="${problemcomplaint.queryproblemtype == '1'}">selected</c:if>>
									<spring:message code="problemcomplaint.problemtype.1" />
								</option>
								<option value="2"<c:if test="${problemcomplaint.queryproblemtype == '2'}">selected</c:if>>
									<spring:message code="problemcomplaint.problemtype.2" />
								</option>						
						</select></td>
					<td>
					</td>
				</tr>
				
				<tr>
					
				</tr>
				
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td width="60"><spring:message code="page.select"/></td>
    			<td><spring:message code="problemcomplaint.complaintcode"/></td>
    			<td><spring:message code="user.username"/></td>
    			<td><spring:message code="user.userid"/></td>  		
	          	<td><spring:message code="dispatch.problemtype"/></td>
	          	<td><spring:message code="dispatch.state"/></td>
	          	<td><spring:message code="problemcomplaint.content" />
        	</tr>
        	<c:forEach items="${problemcomplaint.problemcomplaintlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td width="" height="30">
	        	    		<input type="radio"  name="_selKey"   value="${dataList.id }+${dataList.userid }+${dataList.user.username }+${dataList.user.netid }+${dataList.user.areacode }+${dataList.problemtype }+${dataList.complaintcode }+${dataList.content }"/>	
	        	    </td>
	        		<td >${dataList.complaintcode}</td>
	        		<td title="${dataList.user.username }">${fn:substring(dataList.user.username, 0, 20)}</td>
	        		<td >${dataList.userid }</td>
	        		<td ><spring:message code="problemcomplaint.problemtype.${dataList.problemtype}"/></td>
	        		<td ><spring:message code="problemcomplaint.state.${dataList.state }"/></td>
	        		<td class="remarkClass" title="${dataList.content }">${fn:substring(dataList.content, 0, 9)}&nbsp;</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="dispatch/findProblemcomplaintListForDialog"
			    items="${problemcomplaint.pager_count}"
			    index="center"
			    maxPageItems="5"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${problemcomplaint.queryuserid}"/>
				<pg:param name="queryusername" value="${problemcomplaint.queryusername}"/>
				<pg:param name="querydocumentno" value="${problemcomplaint.queryid}"/>
				<pg:param name="querystate" value="${problemcomplaint.querystate}"/>
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
</div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryComplaint(){
		$("#searchForm").attr("action", "dispatch/findProblemcomplaintListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
  $(".lb-list").click(function(){
	var data =$(this).find("input[type=radio]").val();
    var dataArray = data.split("+");
	parent.closeDialog(dataArray);
  });
  
</script>
</body>
</html>

