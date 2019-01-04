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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.activityinfo"/> &gt;  <spring:message code="activityinfo.file.query"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="querytitle" id="querytitle" value="${activityinfo.querytitle }"/>
		    <input type="hidden" name="pager_offset" id="pager_offset" value="${activityinfo.pager_offset }"/>
            <table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="activityinfo.title" />：</td>
					<td>
						<input type="text" readonly="readonly" style="background:#eeeeee;width: 250px;" class="inp" name="title" id="title" value="${activityinfo.activityinfo.title }">
					</td>
		    		<td width="200px" align="right">
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
	          	<td><spring:message code="activityinfo.filename"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${activityinfo.activityinfopiclist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.filename}</td>
	        		<td>
	        		    <a class="btn-look"  target="_blank" href="activityinfo/getExtendFileStream?id=${dataList.id}" ><spring:message code="page.look"/></a>
	      				<a class="btn-del" href="javascript:deleteExtendInfo(${dataList.id });" ><spring:message code="page.delete"/></a>
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
	
	/**
	*删除
	*/
	function deleteExtendInfo(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				$("#searchForm").attr("action", "activityinfo/deleteActivityinfopic?id="+id+"&pager_offset="+'${activityinfo.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	function goBack() {
	      $("#searchForm").attr("action", "activityinfo/findByList");
	      $("#searchForm").submit();
	  }
	
	$(function () {
       var returninfo = '${activityinfo.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 2, 'alert.gif');
       }
    });
    
</script>
</body>
</html>

