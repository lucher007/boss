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
<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.manage"/> &gt; <spring:message code="menu.system.databaserestore"/></div>		
<form method="post" id="searchform" name="searchform" enctype="multipart/form-data">
			<div class="form-box">
				<div class="fb-tit"><spring:message code="menu.system.databaserestore"/></div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="20%" align="right">
								<img src="images/frame/Warning.png">
							</td>
							<td height="30" width="70%" font-weight: bold;">
								<span class="red"><strong><spring:message code="databaserestore.warning"/><br><spring:message code="databaserestore.warning1"/></strong></span>
							</td>
						</tr>
						<tr>
							<td width="20%" align="right"><spring:message code="uploadify.filepath"/>：</td>
							<td height="30" width="70%">
							<input type="text" id="txt" name="txt" readonly="readonly" style="width: 230px" class="inp"/> 
							<%-- 
							<input type="button" style="width:70px;height:23px;" name="selectbutton" id="selectbutton" value="<spring:message code="page.select" />"  onclick="uploadfile.click()"/> 
							 --%>
							<a href="javascript:uploadfile.click();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.select"/></a>
							<input type="file" name="uploadfile" id="uploadfile" onchange="txt.value=this.value" style="position:absolute;width:100px;height:23px;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;margin-left:-103px;"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="fb-bom">
					<cite>
						<span>
							<%-- 
							<input type="button" class="btn-save" value="<spring:message code="databaserestore.restore"/>" onclick="saveDatabaserestore();" /> 
							 --%>
							<a href="javascript:saveDatabaserestore();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
						</span> 
					</cite> 
					<span class="red">${card.returninfo}</span>
					<span class="red">${returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		function saveDatabaserestore() {
			$.dialog({
			    title: '<spring:message code="menu.system.databaserestore"/>',
			    lock: true,
			    background: '#000', /* 背景色 */
			    opacity: 0.5,       /* 透明度 */
			    content: '<spring:message code="databaserestore.warning"/><br><spring:message code="databaserestore.warning1"/>',
			    icon: 'alert.gif',
			    ok: function () {
			    	$("#searchform").attr("action", "databaserestore/saveDatabaserestore"+"?rid="+Math.random());
 					$("#searchform").submit();
			        /* 这里要注意多层锁屏一定要加parent参数 */
			        $.dialog({
			        	lock: true,
			            title: '<spring:message code="databaserestore.restoreing"/>',
			        	content: '<spring:message code="databaserestore.restoreing.waiting"/>', 
			        	max: false,
					    min: false,
					    cancel:false,
			        	icon: 'loading.gif',
			        });
			        return false;
			    },
			    okVal: '<spring:message code="page.confirm"/>',
			    cancel: true,
			    cancelVal:'<spring:message code="page.cancel"/>'
			});
		
// 			$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
// 				'<spring:message code="page.confirm"/>',
// 				'<spring:message code="page.cancel"/>',
// 				function(){ 
// 					$("#searchform").attr("action", "databaserestore/saveDatabaserestore"+"?rid="+Math.random());
// 					$("#searchform").submit();
// 				}, function(){
// 							});
			
		}

		$(function() {
			var returninfo = '${returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

	</script>
</body>
</html>
