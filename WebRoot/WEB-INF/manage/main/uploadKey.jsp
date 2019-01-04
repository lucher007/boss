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
<style></style>
</head>
<body>
	<div id="body">
		<form method="post" id="searchform" name="searchform" enctype="multipart/form-data">
			<div class="form-box">
				<div class="fb-tit"><spring:message code="authorize.upload" /></div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15%" align="right"><spring:message code="uploadify.filepath"/>：</td>
							<td height="30" width="65%">
								<input type="text" id="txt" name="txt" readonly="readonly" style="width: 230px" class="inp"/> 
								<input type="button" style="width:70px;height:23px;" name="selectbutton" id="selectbutton" value="<spring:message code="page.select" />"  onclick="uploadfile.click()"/> 
								<input type="file" name="uploadfile" id="uploadfile" onchange="txt.value=this.value" style="position:absolute;width:100px;height:23px;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;margin-left:-103px;"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
					<span><input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveOperator();" />
					</span> </cite> <span class="red">${operator.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
		function saveOperator() {
			$("#searchform").attr("action", "operator/uploadAuthorizeKey").submit();
		}

		$(function() {
			var returninfo = '${operator.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

	</script>
</body>
</html>
