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
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.service"/> &gt;  <spring:message code="menu.product.serviceextend"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="id" id="id" value="${service.id }"/>
        	<input type="hidden" name="querynetid" id="querynetid" value="${service.querynetid }"/>
		    <input type="hidden" name="querystate" id="querystate" value="${service.querystate }"/>
		    <input type="hidden" name="queryserviceid" id="queryserviceid" value="${service.queryserviceid }"/>
		    <input type="hidden" name="queryservicename" id="queryservicename" value="${service.queryservicename }"/>
		    <input type="hidden" name="pager_offset" id="pager_offset" value="${service.pager_offset }"/>
            <table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="network.netid" />：</td>
					<td><input type="text" readonly="readonly" style="background:#eeeeee;" class="inp" name="netid" id="netid" value="${service.network.netid }">
					</td>
					<td align="right"><spring:message code="network.netname" />：</td>
					<td><input type="text" readonly="readonly" style="background:#eeeeee;" class="inp" name="netname" id="netname" value="${service.network.netname }">
					</td>
				<%-- 	<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryServiceetend();"/>
		    		</td> --%>
				</tr>
				<tr height="30px">
					<td align="right"><spring:message code="service.serviceid" />：</td>
					<td>
						<input type="text" readonly="readonly" style="background:#eeeeee;" class="inp" name="serviceid" id="serviceid" value="${service.service.serviceid }">
					</td>
					<td align="right"><spring:message code="service.servicename" />：</td>
					<td>
						<input type="text" readonly="readonly" style="background:#eeeeee;" class="inp" name="servicename" id="servicename" value="${service.service.servicename }">
					</td>
		    		<td>
		    			<%-- 
		    			<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack();" />
		    			 --%>
		    			<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
		    		</td>
				</tr>
    	    </table>
    
    
        </form>
    
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		<!--
    			<td><spring:message code="promotion.webflag"/></td>
          		<td><spring:message code="promotion.rank"/></td>
              -->
             	<td><spring:message code="promotion.type"/></td>
	          	<td><spring:message code="promotion.description"/></td>
	          	<td><spring:message code="promotion.filename"/></td>
	          	<!-- 
	          	<td><spring:message code="promotion.preserveurl"/></td>
	          	 -->
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${service.serviceextendlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<!--
	        		<td ><spring:message code="promotion.webflag.${dataList.webflag}"/></td>
	        		<td >${dataList.rank }</td>
	        	      -->
	        	    <td >
	        			<spring:message code="promotion.type.${dataList.type}"/>
	        		</td>
	        		<td class="remarkClass" title="${dataList.description }">${fn:substring(dataList.description, 0, 9)}&nbsp;</td>
	        		<td >${dataList.filename}</td>
	        		<!-- 
	        		<td >${dataList.preserveurl}</td>
	        		 -->
	        		<td>
	        		    <a class="btn-look"  target="_blank" href="service/getExtendFileStream?id=${dataList.id}" ><spring:message code="page.look"/></a>
	      				<a class="btn-del" href="javascript:deleteExtendInfo(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	      		
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
 </div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function queryServiceetend(){
		$("#searchForm").attr("action", "service/queryExtendInfo");
		$("#searchForm").submit();
	}	
    
    function getExtendFileStream(id){
   		$("#searchForm").attr("action", "service/getExtendFileStream?id="+id);
   		$("#searchForm").submit();
    }
	
	/**
	*删除
	*/
	function deleteExtendInfo(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				$("#searchForm").attr("action", "service/deleteExtendInfo?serviceetendid="+id+"&pager_offset="+'${service.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	function goBack() {
	      $("#searchForm").attr("action", "service/servicePromotion");
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

