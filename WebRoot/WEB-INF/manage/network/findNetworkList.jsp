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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.network"/> &gt; <spring:message code="network.networkquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td width="130px"><input type="text" class="inp w200" name="querynetname" id="querynetname" value="${network.querynetname}"/></td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryNetwork();"/>
						 --%>
						<a href="javascript:queryNetwork();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					<td width="130px">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addNetwork();"/>
						 --%>
						<a href="javascript:addNetwork();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="network.netid"/></td>
	          	<td><spring:message code="network.nettype"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${network.networklist }" var="dataList">
	        	<tr height="30" data-tt-id="${dataList.id }" data-tt-parent-id="${dataList.pid }" class="lb-list">
	        		<td>${dataList.netname }&nbsp;</td>
	        		<td >${dataList.netid }&nbsp;</td>
	        		<td>
	        			<c:if test="${dataList.nettype == 0 }"><spring:message code="network.nettype.0"/></c:if>
	            		<c:if test="${dataList.nettype == 1 }"><spring:message code="network.nettype.1"/></c:if>
	            	</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateNetwork('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<!-- 
	           			<a class="btn-del" href="javascript:deleteNetwork(${dataList.id });" ><spring:message code="page.delete"/></a>
	      				 -->
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="network/findByList"
			    items="${network.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetname" value="${network.querynetname}"/>
				<pg:index>
					<spring:message code="page.total"/>:${network.pager_count}
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
	
	$(function() {
		var options = {
			expandable: true,
			clickableNodeNames: true,
			indent: 10,
			initialState: "expanded",
			stringCollapse: "收起",
			stringExpand: "展开"
		};
		$("#treetable").treetable(options);
	});


    //查询操作员
	function queryNetwork(){
		$("#searchForm").attr("action", "network/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addNetwork(){
		$("#searchForm").attr("action", "network/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateNetwork(id){
		$("#searchForm").attr("action", "network/updateInit?id="+id+"&pager_offset="+'${network.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteNetwork(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "network/delete?id="+id+"&pager_offset="+'${network.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${network.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

