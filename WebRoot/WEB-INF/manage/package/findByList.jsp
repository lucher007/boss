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
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css" />
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.package"/>  &gt; <spring:message code="package.querypackage"/></div>
        <form action="" method="post" id="searchForm" name="searchForm">
    		<div class="seh-box">
				<table width="100%">
					<tr>
						<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
						<td>
							 <select id="querynetid" name="querynetid" class="select" onchange="queryPackage();">
							 	 <option value=""><spring:message code="page.select"/></option>
								 <c:forEach items="${package.networklist}" var="networklist" varStatus="s">
				                   <option value="${networklist.id}" <c:if test="${package.querynetid == networklist.id }">selected</c:if>>${networklist.netname}</option>
				                </c:forEach>
				             </select>
						</td>
						<td align="right"><spring:message code="package.name"/>：</td>
						<td>
							<input type="text" class="inp w200"  name="queryname" id="queryname" style="width: 200px;" value="${package.queryname}">
						</td>	
						<td align="center">
							<a href="javascript:queryPackage();" iconCls="icon-search" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.query"/></a> 
<!-- 							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryPackage();" /> -->
						</td>
						<td align="center">
							<a href="javascript:addPackageInit();" iconCls="icon-add" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.add"/></a> 
<!-- 							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addPackageInit();" /> -->
						</td>
					</tr>
				</table>
			</div>
    
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
    			<td><spring:message code="package.name"/></td>
	          	<td><spring:message code="package.type"/></td>
	          	<!-- 	
	          	<td><spring:message code="package.customer.type"/></td>
	          	 -->
	          	<td><spring:message code="package.totalmoney"/></td>
	            <td><spring:message code="package.starttime"/></td>
	          	<td><spring:message code="package.endtime"/></td>
	          	<td><spring:message code="operator.addtime"/></td>  
		        <td><spring:message code="page.operate"/></td>	       
        	</tr>

        	<c:forEach items="${package.packageList }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td title="${dataList.network.netname}">${fn:substring(dataList.network.netname, 0, 30)}</td>
	        		<td title="${dataList.name}">${fn:substring(dataList.name, 0, 30)}</td>
	        		<td><spring:message code= "package.type.${dataList.type}"/></td>
	        		<%--
	        		<td><spring:message code= "package.customer.type.${dataList.usertype}"/></td>
	         		--%>
	         		<td>${dataList.totalmoney}</td>
	         		<td>${fn:substring(dataList.starttime, 0, 10)}</td>
	        		<td>${fn:substring(dataList.endtime, 0, 10)}</td> 
	        		<td>${fn:substring(dataList.addtime, 0, 10)}</td>
	        		<td>
	        		    <!--
	        			<a class="btn-up" href="javascript:buyPackage('${dataList.id}');"><spring:message code="package.buy"/></a>
	        			  -->
	        			<a class="btn-update" href="javascript:updatePackage(${dataList.id });" ><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deletePackage(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="package/findByList"
			    items="${package.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
            	<pg:param name="querynetid" value="${package.querynetid}"/>
            	<pg:param name="queryname" value="${package.queryname}"/>
				<pg:index>
					<spring:message code="page.total"/>:${package.pager_count}
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
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
    //查询操作员
	function queryPackage(){
	    $("#searchForm").attr("action", "package/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addPackageInit(){
		$("#searchForm").attr("action", "package/addPackageInit");
		$("#searchForm").submit();
	}	
	
	//删除
	function deletePackage(id) {
			$.dialog.confirmMultiLanguage(
					'<spring:message code="page.confirm.execution"/>?',
					'<spring:message code="page.confirm"/>',
					'<spring:message code="page.cancel"/>', function() {
						$("#searchForm").attr(
								"action",
								"package/delete?id=" + id
										+ "&pager_offset="
										+ '${package.pager_offset}'
										+ "&rid=" + Math.random());
						$("#searchForm").submit();
					}, function() {
					});
	}    
		
	function buyPackage(id){
		$("#searchForm").attr("action", "package/buyPackageInit?id="+id);
		$("#searchForm").submit();
	}
    
	$(function () {
       var returninfo = '${package.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
	
	//全选
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () {
	      if (!$(this).attr('checked')) {
	        checked = false;
	      }
	    });
	    $('#checkall').attr('checked', checked);
	}
	
	/**
	*编辑
	*/
	function updatePackage(id){
		$("#searchForm").attr("action", "package/updateInit?id="+id+"&pager_offset="+'${package.pager_offset}');
		$("#searchForm").submit();
	}
	
</script>
</body>
</html>

