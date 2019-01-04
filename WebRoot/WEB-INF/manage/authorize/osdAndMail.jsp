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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">

</head>

<body>
	<div style="margin:20px 0;"></div>
	<div class="easyui-tabs" data-options="tabWidth:200"  style="width:1020px;height:630px">
		<div title="<spring:message code="server.versiontype.gos_gn"/>" data-options="fit:true,plain:true" style="padding:10px;">
				<div class="easyui-tabs" tabPosition="left" data-options="fit:true,plain:true">
						<div title="OSD" style="padding:10px;overflow:hidden">
							<iframe scrolling="auto" frameborder="0"  src="authorize/osdForGN" style="width:100%;height:100%;"></iframe>
						</div>
						<div title="Mail" style="padding:10px;overflow:hidden">
				 			<iframe scrolling="auto" frameborder="0"  src="authorize/mailForGN" style="width:100%;height:100%;"></iframe>
						</div>
				</div>
		</div>
		
		<div title="<spring:message code="server.versiontype.gos_pn"/>" data-options="fit:true,plain:true" style="padding:10px;">
 					<div class="easyui-tabs" tabPosition="left" data-options="fit:true,plain:true">
							<div title="条件OSD" style="padding:10px;overflow:hidden">
								<iframe scrolling="auto" frameborder="0"  src="authorize/conditionOsdForPN" style="width:100%;height:100%;"></iframe>
							</div>
						<!-- 	<div title="强制OSD" style="padding:10px;overflow:hidden">
								<iframe scrolling="auto" frameborder="0"  src="authorize/forceOsdForPN" style="width:100%;height:100%;"></iframe>
							</div> -->
							<div title="条件Mail" style="padding:10px;overflow:hidden">
								<iframe scrolling="auto" frameborder="0"  src="authorize/mailForPN" style="width:100%;height:100%;"></iframe>
							</div>
 					</div>
		</div>
	</div>
 
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>

<script type="text/javascript">
	//查询操作员
	function queryRecord(){
		$("#searchForm").attr("action", "authorize/findByList");
		$("#searchForm").submit();
	}	

	$(function () {
       var returninfo = '${area.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });

</script>
</body>
</html>