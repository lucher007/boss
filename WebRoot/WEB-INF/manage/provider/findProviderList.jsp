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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.provider"/> &gt; <spring:message code="provider.providerquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="provider.companyname"/>：</td>
					<td width="130px"><input type="text" class="inp w200" name="querycompanyname" id="querycompanyname" value="${provider.querycompanyname}"/></td>
					<td align="right" width="120px"><spring:message code="provider.model"/>：</td>
					<td width="130px"><input type="text" class="inp w200" name="querymodel" id="querymodel" value="${provider.querymodel}"/></td>
					<td align="right">
						<%-- <input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryProvider();"/> --%>
						<a href="javascript:queryProvider();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					<td width="130px">
						<%-- <input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addProvider();"/> --%>
						<a href="javascript:addProvider();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="provider.companyname"/></td>
    			<td><spring:message code="provider.model"/></td>
    			<td><spring:message code="provider.type"/></td>
    			<td><spring:message code="provider.mainprice"/></td>
    			<td><spring:message code="provider.subprice"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${provider.providerlist }" var="dataList">
	        	<tr height="30" class="lb-list">
	        		<td class="remarkClass" title="${dataList.companyname }">${fn:substring(dataList.companyname, 0, 30)}</td>
	        		<td class="remarkClass" title="${dataList.model }">${fn:substring(dataList.model, 0, 30)}</td>
	        		<td><spring:message code="provider.type.${dataList.type }"/></td>
	        		<td>${dataList.mainprice }</td>
	        		<td>${dataList.subprice }</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateProvider('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deleteProvider(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="provider/findByList"
			    items="${provider.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querycompanyname" value="${provider.querycompanyname}"/>
				<pg:param name="querymodel" value="${provider.querymodel}"/>
				<pg:index>
					<spring:message code="page.total"/>:${provider.pager_count}
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
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

    //查询
	function queryProvider(){
		$("#querycompanyname").val($.trim($("#querycompanyname").val()));
		$("#querymodel").val($.trim($("#querymodel").val()));
		$("#searchForm").attr("action", "provider/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addProvider(){
		$("#searchForm").attr("action", "provider/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateProvider(id){
		$("#searchForm").attr("action", "provider/updateInit?id="+id+"&pager_offset="+'${provider.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteProvider(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>', 
			function(){ 
				$("#searchForm").attr("action", "provider/delete?id="+id+"&pager_offset="+'${provider.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${provider.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

