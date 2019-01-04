<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<style>
.fb-con table tr {
	height: 30px;
}
</style>
</head>
<body>
	<div id="body">
<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.manage"/> &gt; <spring:message code="menu.system.exportdata"/></div>		
		<form method="post" id="searchform" name="searchform" enctype="multipart/form-data">
			<div class="form-box">
				<div class="fb-tit"><spring:message code="menu.system.databasestore"/></div>
				<div class="fb-bom">
					<span>
						<%-- 
						<input type="button" class="btn-print" value="<spring:message code="statistic.exportexcel"/>" onclick="saveDownloadEventFile();" /> 
						 --%>
						<a href="javascript:saveDownloadEventFile();" class="easyui-linkbutton" style="width:80px" iconCls="icon-print"><spring:message code="statistic.exportexcel"/></a>
					</span>
				</div>
			</div>
		</form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					$("#searchform").attr("action", "backupdata/exportData");
					$("#searchform").submit();
 				}, function(){
 							});
	}

	</script>
</body>
</html>
