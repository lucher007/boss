<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
</head>
<body>
	<div style="margin:20px 0;"></div>
	<div class="easyui-tabs" data-options="tabWidth:200" style="width:auto;height:630px">
		<div title="<spring:message code="server.versiontype.gos_gn"/>" data-options="fit:true,plain:true" style="padding:10px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0" src="authorize/authorityRenewForGN" style="width:100%;height:100%;"></iframe>
		</div>
		<div title="<spring:message code="server.versiontype.gos_pn"/>" data-options="fit:true,plain:true" style="padding:10px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0" src="authorize/authorityRenewForPN" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		//查询操作员
		function queryRecord() {
			$("#searchForm").attr("action", "authorize/findByList");
			$("#searchForm").submit();
		}
	</script>
</body>
</html>