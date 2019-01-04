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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css" />
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.service"/> &gt;  <spring:message code="menu.product.serviceextend"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td>
						 <select id="querynetid" name="querynetid" class="select" onchange="queryService();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${service.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${service.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<td align="right" width="120px"><spring:message code="service.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" onchange="queryService();">
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${service.querystate == '0'}">selected</c:if>><spring:message code="service.state.0"/></option>
			                   <option value="1" <c:if test="${service.querystate == '1'}">selected</c:if>><spring:message code="service.state.1"/></option>
			             </select>
					</td>
	
				</tr>
				<tr>
					<td align="right"><spring:message code="service.serviceid"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryserviceid" id="queryserviceid" value="${service.queryserviceid }">
					</td>
					<td align="right"><spring:message code="service.servicename"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryservicename" id="queryservicename" value="${service.queryservicename }">
					</td>
					<td>
						<a href="javascript:queryService();" iconCls="icon-search" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.query"/></a> 
<!-- 		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryService();"/> -->
		    		</td>
				</tr>
    	    </table>
    
    
        </form>
    
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="service.serviceid"/></td>
	          	<td><spring:message code="service.servicename"/></td>
	          	<!--
	          	<td><spring:message code="service.chargetype"/></td>
	          	<td><spring:message code="service.pricepermonth"/>(/<spring:message code="para.unit.month"/>)</td>
	          	  -->
	          	<td><spring:message code="service.state"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${service.servicelist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td title="${dataList.network.netname}">${fn:substring(dataList.network.netname, 0, 20)}</td>
	        		<td >${dataList.serviceid }</td>
	        		<td title="${dataList.servicename}">${fn:substring(dataList.servicename, 0, 20)}</td>
	        		<!--
	        		<td >
	        			<spring:message code="service.chargetype.${dataList.chargetype}"/>
	        		</td>
	        		<td >
	        		  <c:if test="${dataList.chargetype == '1'}">
	        		  	 ${dataList.pricepermonth}
	        		  </c:if>
	        		</td>
	        		-->
	        		<td >
	        			<spring:message code="service.state.${dataList.state}"/>
	        		</td>
	        		<td>
	        			<a class="btn-look" href="javascript:queryextendInfo(${dataList.id });" ><spring:message code="promotion.promotionquery"/></a>
	      				<a class="btn-add" href="javascript:addextendInfo(${dataList.id });" ><spring:message code="promotion.promotionadd"/></a>
	      			</td>
	      		
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="service/servicePromotion"
			    items="${service.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${service.querynetid}"/>
				<pg:param name="querystate" value="${service.querystate}"/>
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
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function queryService(){
		$("#searchForm").attr("action", "service/servicePromotion");
		$("#searchForm").submit();
	}	
    
    function addextendInfo(id){
   		$("#searchForm").attr("action", "service/saveExtendInfoInit?id="+id+"&pager_offset="+'${service.pager_offset}');
   		$("#searchForm").submit();
    }
    
    function queryextendInfo(id){
   		$("#searchForm").attr("action", "service/queryExtendInfo?id="+id+"&pager_offset="+'${service.pager_offset}');
   		$("#searchForm").submit();
    }
	
	$(function () {
       var returninfo = '${serivce.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
</script>
</body>
</html>

