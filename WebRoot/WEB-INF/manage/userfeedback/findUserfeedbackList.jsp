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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.userfeedback"/> &gt; <spring:message code="userfeedback.userfeedbackquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="user.usercode"/>：</td>
					<td width="130px">
						<input type="text" class="inp w200"  name="queryuserid" id="queryuserid" value="${userfeedback.queryuserid}">
					</td>
					<td align="right" width="120px"><spring:message code="userfeedback.type"/>：</td>
					<td width="130px">
						 <select id="querytype" name="querytype" class="select">
							 <option value=""><spring:message code="page.select"/></option>
			                   <option value="1" <c:if test="${userfeedback.querytype == '1' }">selected</c:if>><spring:message code="userfeedback.type.1"/></option>
			                   <option value="2" <c:if test="${userfeedback.querytype == '2' }">selected</c:if>><spring:message code="userfeedback.type.2"/></option>
			             </select>
					</td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryUserfeedback();"/>
						 --%>
						<a href="javascript:queryUserfeedback();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="user.usercode"/></td>
          		<td><spring:message code="user.username"/></td>
          		<td><spring:message code="userfeedback.mobile"/></td>
	          	<td><spring:message code="userfeedback.type"/></td>
	          	<td><spring:message code="userfeedback.content"/></td>
        	</tr>
        	<c:forEach items="${userfeedback.userfeedbacklist }" var="dataList">
	        	<tr height="30"  class="lb-list">
	        		<td>${dataList.network.netname}&nbsp;</td>
	        		<td>${dataList.user.usercode}&nbsp;</td>
	        		<td>${dataList.user.username}&nbsp;</td>
	        		<td>${dataList.mobile}&nbsp;</td>
	        	    <td><spring:message code="userfeedback.type.${dataList.type}"/>&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.content }">${fn:substring(dataList.content, 0, 20)}&nbsp;</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="userfeedback/findByList"
			    items="${userfeedback.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querytype" value="${userfeedback.querytype}"/>
				<pg:index>
					<spring:message code="page.total"/>:${userfeedback.pager_count}
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
	function queryUserfeedback(){
		$("#searchForm").attr("action", "userfeedback/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addUserfeedback(){
		$("#searchForm").attr("action", "userfeedback/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateUserfeedback(id){
		$("#searchForm").attr("action", "userfeedback/updateInit?id="+id+"&pager_offset="+'${userfeedback.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteUserfeedback(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "userfeedback/delete?id="+id+"&pager_offset="+'${userfeedback.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${userfeedback.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function pushToMPS(){
 		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				//使同步按钮失效
				$("#pushToMPSButton").attr("disabled","true");
				
				$("#searchForm").attr("action", "userfeedback/pushAllUserfeedbackToMps");
   				$("#searchForm").submit();
			}, function(){
						});
   		
 	}
    
</script>
</body>
</html>

