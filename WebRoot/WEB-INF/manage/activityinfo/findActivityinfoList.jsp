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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.activityinfo"/> &gt;  <spring:message code="activityinfo.activityinfoquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="activityinfo.title" />：</td>
					<td>
						<input type="text" class="inp" name="querytitle" id="querytitle" value="${activityinfo.querytitle }">
					</td>
		    		<td width="200px" align="right">
		    			<a href="javascript:queryActivityinfo();" iconCls="icon-search" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.query"/></a> 
		    			<a href="javascript:addActivityinfo();" iconCls="icon-add" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.add"/></a>
		    		</td>
				</tr>
    	    </table>
        </form>
    
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
             	<td><spring:message code="activityinfo.title"/></td>
             	<td><spring:message code="activityinfo.type"/></td>
             	<td><spring:message code="activityinfo.file"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${activityinfo.activityinfolist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.title }</td>
	        		<td >
	        			<spring:message code="activityinfo.type.${dataList.type}"/>
	        		</td>
	        		<td>
	        			<a class="btn-look" href="javascript:queryActivityinfopic(${dataList.id });" ><spring:message code="activityinfo.file.query"/></a>
	      				<a class="btn-add" href="javascript:addActivityinfopic(${dataList.id });" ><spring:message code="activityinfo.file.add"/></a>
	        		</td>
	        		<td>
	      				<a class="btn-del" href="javascript:deleteActivityInfo(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	      		
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
 </div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function queryActivityinfo(){
		$("#searchForm").attr("action", "activityinfo/findByList");
		$("#searchForm").submit();
	}	
    
    function getExtendFileStream(id){
   		$("#searchForm").attr("action", "activityinfo/getExtendFileStream?id="+id);
   		$("#searchForm").submit();
    }
	
	/**
	*删除
	*/
	function deleteActivityInfo(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				$("#searchForm").attr("action", "activityinfo/delete?id="+id+"&pager_offset="+'${activityinfo.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${activityinfo.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
	
	//添加
	function addActivityinfo(){
		$("#searchForm").attr("action", "activityinfo/addInit");
		$("#searchForm").submit();
	}	
	
	function queryActivityinfopic(id){
			$("#searchForm").attr("action", "activityinfo/queryActivityinfopic?id="+id+"&pager_offset="+'${activityinfo.pager_offset}');
			$("#searchForm").submit();
	}
	
	function addActivityinfopic(id){
		$("#searchForm").attr("action", "activityinfo/addActivityinfopicInit?id="+id+"&pager_offset="+'${activityinfo.pager_offset}');
		$("#searchForm").submit();
	}
</script>
</body>
</html>

