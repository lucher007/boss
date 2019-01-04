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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.computer"/> &gt; <spring:message code="computer.computerquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="store.storename"/>：</td>
					<td width="130px">
						 <select id="querystoreid" name="querystoreid" class="select" onchange="queryComputer();">
							 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${computer.storemap}" var="storemap" varStatus="s">
			                   <option value="${storemap.key}" <c:if test="${computer.querystoreid == storemap.key }">selected</c:if>>${storemap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<td align="right"><input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryComputer();"/></td>
					<td width="130px"><input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addComputer();"/></td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="computer.computercode"/></td>
          		<td><spring:message code="computer.ip"/></td>
	          	<td><spring:message code="computer.macaddress"/></td>
	          	<td><spring:message code="store.storename"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${computer.computerlist }" var="dataList">
	        	<tr height="30"  class="lb-list">
	        		<td>${dataList.computercode }&nbsp;</td>
	        		<td>${dataList.ip }&nbsp;</td>
	        		<td>${dataList.macaddress }&nbsp;</td>
	        		<td>${dataList.store.storename }&nbsp;</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateComputer('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deleteComputer(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="computer/findByList"
			    items="${computer.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querystoreid" value="${computer.querystoreid}"/>
				<pg:index>
					<spring:message code="page.total"/>:${computer.pager_count}
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

    //查询
	function queryComputer(){
		$("#searchForm").attr("action", "computer/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addComputer(){
		$("#searchForm").attr("action", "computer/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateComputer(id){
		$("#searchForm").attr("action", "computer/updateInit?id="+id+"&pager_offset="+'${computer.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteComputer(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "computer/delete?id="+id+"&pager_offset="+'${computer.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${computer.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

