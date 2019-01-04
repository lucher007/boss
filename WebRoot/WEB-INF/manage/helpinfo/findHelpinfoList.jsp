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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.helpinfo"/> &gt; <spring:message code="helpinfo.helpinfoquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="helpinfo.type"/>：</td>
					<td width="130px">
						 <select id="querytype" name="querytype" class="select">
							 <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${helpinfo.querytype == '0' }">selected</c:if>><spring:message code="helpinfo.type.0"/></option>
			                   <option value="1" <c:if test="${helpinfo.querytype == '1' }">selected</c:if>><spring:message code="helpinfo.type.1"/></option>
			             </select>
					</td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryHelpinfo();"/>
						 --%>
						<a href="javascript:queryHelpinfo();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					<td width="130px">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addHelpinfo();"/>
						 --%>
						<a href="javascript:addHelpinfo();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
					<c:if test="${helpinfo.remark == '1'}">
						<td width="130px">
							<%-- 
							<input type="button" id="pushToMPSButton" value="<spring:message code="page.pushtomps"/>" onclick="pushToMPS();"/>
							 --%>
							<a href="javascript:pushToMPS();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.pushtomps"/></a>
						</td>
					</c:if>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="helpinfo.type"/></td>
          		<td><spring:message code="helpinfo.question"/></td>
	          	<td><spring:message code="helpinfo.answer"/></td>
	          	<td><spring:message code="page.operate"/></td>	
        	</tr>
        	<c:forEach items="${helpinfo.helpinfolist }" var="dataList">
	        	<tr height="30"  class="lb-list">
	        		<td><spring:message code="helpinfo.type.${dataList.type}"/>&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.question }">${fn:substring(dataList.question, 0, 20)}&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.answer }">${fn:substring(dataList.answer, 0, 20)}&nbsp;</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateHelpinfo('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deleteHelpinfo(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="helpinfo/findByList"
			    items="${helpinfo.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querytype" value="${helpinfo.querytype}"/>
				<pg:index>
					<spring:message code="page.total"/>:${helpinfo.pager_count}
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
	function queryHelpinfo(){
		$("#searchForm").attr("action", "helpinfo/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addHelpinfo(){
		$("#searchForm").attr("action", "helpinfo/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateHelpinfo(id){
		$("#searchForm").attr("action", "helpinfo/updateInit?id="+id+"&pager_offset="+'${helpinfo.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteHelpinfo(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "helpinfo/delete?id="+id+"&pager_offset="+'${helpinfo.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${helpinfo.returninfo}';
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
				
				$("#searchForm").attr("action", "helpinfo/pushAllHelpinfoToMps");
   				$("#searchForm").submit();
			}, function(){
						});
   		
 	}
    
</script>
</body>
</html>

