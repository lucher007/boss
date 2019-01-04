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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.service"/> &gt; <spring:message code="service.servicequery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
           <input type="hidden" name="querynetid" id="querynetid" value="${service.querynetid }"/>
            <table width="100%">
				<tr>
			
					<td align="right"><spring:message code="service.serviceid"/>：</td>
					<td>
						 <input type="text" class="inp w200" name="queryserviceid" id="queryserviceid" value="${service.queryserviceid }">
					</td>
					<td colspan="2" align="center">
		    			<%-- 
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryService();"/>
		    			 --%>
		    			<a href="javascript:queryService();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    		</td>
				
				</tr>
				<tr>
					<td align="right"><spring:message code="service.servicename"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryservicename" id="queryservicename" value="${service.queryservicename }">
					</td>
				
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		    <td width="60"><spring:message code="page.select"/></td>
    		    <td><spring:message code="network.netname"/></td>
          		<td><spring:message code="service.serviceid"/></td>
	          	<td><spring:message code="service.servicename"/></td>
        	</tr>
        	<c:forEach items="${service.servicelist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.serviceid }">
	        	    </td>
	        	    <td >${dataList.network.netname }</td>
	        		<td >${dataList.serviceid }</td>
	        		<td >${dataList.servicename }</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="cascommand/findServiceListForDialog"
			    items="${service.pager_count}"
			    index="center"
			    maxPageItems="5"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${service.querynetid}"/>
				<pg:param name="queryserviceid" value="${service.queryserviceid}"/>
				<pg:param name="queryservicename" value="${service.queryservicename}"/>
				<pg:index>
					<spring:message code="page.total"/>:${service.pager_count}
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
<script type="text/javascript"  src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript"  src="js/form.js"></script>
<script type="text/javascript"  src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
    //查询产品
	function queryService(){
		$("#searchForm").attr("action", "cascommand/findServiceListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${service.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
  
  $(".lb-list").click(function(){
        var serviceid = $(this).find("input[type=radio]").val();
        $(this).find("input[type=radio]").attr('checked', 'true');
        parent.closeDialog(serviceid);
    });

	
	
	

</script>
</body>
</html>

