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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css" />
<style>
.fb-con table tr {
	height: 30px;
}
</style>
</head>
<body>
	<div id="body">
<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.product"/> &gt; <spring:message code="menu.service.fileimport"/></div>		

		<form method="post" id="searchform" name="searchform" enctype="multipart/form-data">
			<div class="form-box">
				<div class="fb-tit"><spring:message code="menu.service.fileimport"/></div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="right" width="15%"><spring:message code="network.netname" />：</td>
							<td width="25%"><select id="netid" name="netid" class="select">
									<c:forEach items="${product.networkmap}" var="networkMap" varStatus="s">
										<option value="${networkMap.key}" <c:if test="${product.netid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
									</c:forEach>
							</select></td>
						</tr>
						
						<tr>
							<td width="15%" align="right"><spring:message code="uploadify.filepath" />：</td>
							<td>
								<input type="text" id="txt" name="txt" readonly="readonly" style="width: 230px" class="inp"/> 
								<input type="button" style="width:70px;height:23px;" name="selectbutton" id="selectbutton" value="<spring:message code="page.select" />"  onclick="uploadfile.click()"/> 
								<input type="file" name="uploadfile" id="uploadfile" onchange="txt.value=this.value" style="position:absolute;width:100px;height:23px;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;margin-left:-103px;"/>
							</td>
						</tr>
					
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
					
					<span>
					<a href="product/downloadTemplate" class="btn-print"><spring:message code="uploadify.download.template"/></a>
					</span> 
					
					<span>
						<a href="javascript:goBack();" iconCls="icon-back" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.goback"/></a> 
<!-- 						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" /> -->
					</span> 
					<span>
						<a href="javascript:save();" iconCls="icon-save" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.save"/></a>
<!-- 						<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="save();" /> -->
					</span> 
					</cite> <span class="red">${product.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		function save() {
			$.dialog.confirmMultiLanguage('<spring:message code="fileimport.confirm.emptytable"/>',
					 '<spring:message code="page.confirm"/>',
					 '<spring:message code="page.cancel"/>',
					 function(){ 
					$("#searchform").attr("action", "product/saveByImportFile").submit();
					}, function(){
							});		
		}

		function goBack() {
			$("#searchform").attr("action", "product/findByList").submit();
		}

		$(function() {
			var returninfo = '${product.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});
	</script>
</body>
</html>
