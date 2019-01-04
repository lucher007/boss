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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.product"/> &gt; <spring:message code="menu.product.productextend"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td>
						 <select id="querynetid" name="querynetid" class="select" onchange="queryProduct();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${product.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${product.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<td align="right" width="120px"><spring:message code="product.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" onchange="queryProduct();">
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${product.querystate == '0'}">selected</c:if>><spring:message code="product.state.0"/></option>
			                   <option value="1" <c:if test="${product.querystate == '1'}">selected</c:if>><spring:message code="product.state.1"/></option>
			             </select>
					</td>
				
					<c:if test="${product.remark == '1'}">
						<td width="130px">
							<%-- 
							<input type="button" id="pushToMPSButton" value="<spring:message code="page.pushtomps"/>" onclick="pushToMPS();"/>
							 --%>
							<a href="javascript:pushToMPS();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.pushtomps"/></a> 
						</td>
					</c:if>
					
					<%-- <td width="130px">
							<input type="button" id="pushToCASButton" value="<spring:message code="page.pushtocas"/>" onclick="pushToCAS();"/>
						</td> --%>
				</tr>
				<tr>
					<td align="right"><spring:message code="product.productid"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryproductid" id="queryproductid" value="${product.queryproductid }">
					</td>
					<td align="right"><spring:message code="product.productname"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryproductname" id="queryproductname" value="${product.queryproductname }">
					</td>
					<td>
						<a href="javascript:queryProduct();" iconCls="icon-search" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.query"/></a> 
<!-- 		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryProduct();"/> -->
		    		</td>
				</tr>
    	    </table>
    	 </form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="product.productid"/></td>
	          	<td><spring:message code="product.productname"/></td>
	          	<td><spring:message code="service.pricepermonth"/>(/<spring:message code="para.unit.month"/>)</td>
	          	<td><spring:message code="service.priceperday"/>(/<spring:message code="para.unit.day"/>)</td>
	          	<td><spring:message code="product.state"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${product.productlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td title="${dataList.network.netname}">${fn:substring(dataList.network.netname, 0, 20)}</td>
	        		<td >${dataList.productid }</td>
	        		<td title="${dataList.productname}">${fn:substring(dataList.productname, 0, 20)}</td>
	        		<td >${dataList.pricepermonth }</td>
	        		<td >${dataList.priceperday }</td>
	        		<td ><spring:message code="product.state.${dataList.state}"/></td>
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
			    url="product/productPromotion"
			    items="${product.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${product.querynetid}"/>
				<pg:param name="querystate" value="${product.querystate}"/>
				<pg:param name="queryproductid" value="${product.queryproductid}"/>
				<pg:param name="queryproductname" value="${product.queryproductname}"/>
				<pg:index>
					<spring:message code="page.total"/>:${product.pager_count}
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
	
	function queryProduct(){
		$("#searchForm").attr("action", "product/productPromotion");
		$("#searchForm").submit();
	}	
    
    function addextendInfo(id){
    		$("#searchForm").attr("action", "product/saveExtendInfoInit?id="+id+"&pager_offset="+'${product.pager_offset}');
    		$("#searchForm").submit();
    }
    
    function queryextendInfo(id){
   		$("#searchForm").attr("action", "product/queryExtendInfo?id="+id+"&pager_offset="+'${product.pager_offset}');
   		$("#searchForm").submit();
    }
 	
 	function pushToMPS(){
 		
 		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				
				//使同步按钮失效
				$("#pushToMPSButton").attr("disabled","true");
				
				$("#searchForm").attr("action", "product/pushAllProductToMps");
   				$("#searchForm").submit();
			}, function(){
						});
   		
 	}
 	
 	function pushToCAS(){
 		
 		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				//使同步按钮失效
				$("#pushToCASButton").attr("disabled","true");
				
				$("#searchForm").attr("action", "product/savePushAllProductToCas");
   				$("#searchForm").submit();
			}, function(){
						});
   		
 	}
	
	$(function () {
       var returninfo = '${product.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
</script>
</body>
</html>

