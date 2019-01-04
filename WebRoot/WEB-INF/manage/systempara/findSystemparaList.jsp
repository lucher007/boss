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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.systempara"/> &gt; <spring:message code="systempara.systemparaquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="systempara.code"/>：</td>
					<td width="130px">
						<input type="text"  class="inp w200" name="querycode" id="querycode" value="${systempara.querycode }">
					</td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="querySystempara();"/>
						 --%>
						<a href="javascript:querySystempara();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					<!-- 
					<td width="130px"><input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addSystempara();"/></td>
					 -->
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="systempara.code"/></td>
    			<td><spring:message code="systempara.name"/></td>
	          	<td><spring:message code="systempara.value"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${systempara.systemparalist }" var="dataList">
	        	<tr height="30"  class="lb-list">
	        		<td>${dataList.code }&nbsp;</td>
	        		<td>
	        			<spring:message code="systempara.code.${dataList.code}"/>&nbsp;</td>
	        		<td>
	        		　<c:choose>  
	        			<c:when test="${dataList.code eq 'mps_extend_flag' || dataList.code eq 'client_auth_flag'}">   
	        				<spring:message code="systempara.code.${dataList.code}.${dataList.value}"/>
					    </c:when>  
					    <c:when test="${dataList.code eq 'currency_code'}">   
	        				<spring:message code="systempara.code.${dataList.code}.${dataList.value}"/>(${dataList.value})
					    </c:when>  
					    <c:when test="${dataList.code eq 'sub_hold_main_flag' || dataList.code eq 'send_stbcardpair_flag'}">   
	        				<spring:message code="systempara.code.${dataList.code}.${dataList.value}"/>
					    </c:when> 
					    <c:when test="${dataList.code eq 'only_sell_card_flag' || dataList.code eq 'print_taxpayer_flag' || dataList.code eq 'auto_add_installation_workorder' }" >   
	        				<spring:message code="systempara.code.${dataList.code}.${dataList.value}"/>
					    </c:when> 
					    <c:otherwise>
					    	${dataList.value}
					    </c:otherwise>  
					  </c:choose>
	        		</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateSystempara('${dataList.id}');"><spring:message code="page.update"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="systempara/findByList"
			    items="${systempara.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querycode" value="${systempara.querycode}"/>
				<pg:index>
					<spring:message code="page.total"/>:${systempara.pager_count}
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
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">

    //查询
	function querySystempara(){
		$("#searchForm").attr("action", "systempara/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addSystempara(){
		$("#searchForm").attr("action", "systempara/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateSystempara(id){
		$("#searchForm").attr("action", "systempara/updateInit?id="+id+"&pager_offset="+'${systempara.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteSystempara(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "systempara/delete?id="+id+"&pager_offset="+'${systempara.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${systempara.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

