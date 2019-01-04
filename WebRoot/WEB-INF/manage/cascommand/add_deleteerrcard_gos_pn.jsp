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
<link rel="stylesheet" href="colorpicker/css/colorpicker.css" type="text/css" />
<style type="text/css">
</style>
</head>
<body  style="padding:0px; width:99%; ">
	<div id="body">
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
				<input type="hidden" name="versiontype" id="versiontype" value="${caCommandParam.versiontype }"/>
				<table>
						<tr height="40px">
								<td align="right"><spring:message code="network.netname"/>：</td>
								<td align="left">
									  <select id="netid" name="netid" class="select">
										<c:forEach items="${caCommandParam.networkmap}" var="dataMap" varStatus="s">
										  <option value="${dataMap.key}" <c:if test="${dataMap.key == caCommandParam.netid}">selected</c:if>>${dataMap.value}</option>
										</c:forEach>
									  </select>
								</td>
						</tr>
				
						<tr height="40px">
							<td align="right"><spring:message code="card.cardid" />：</td>
							<td align="left">
								  <input type="text" class="inp w200" name="cardid" id="cardid" 
								  maxlength="16"
								  value="${caCommandParam.cardid }" 
								   onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
								  onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
								 <span class="red"> *</span>
							</td>
						</tr>
				</table>
				<%-- 
			    <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="goSend();" />
				 --%>
				<a href="javascript:goSend();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.save"/></a>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
	   $(function() {
				var returninfo = '${caCommandParam.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});

		function goSend() {
			if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				$('#cardid').focus();
				return;
			}
			$("#paramForm").attr("action", "cascommand/send_deleteerrcard");
			$("#paramForm").submit();
		}
		
				
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_deleteerrcard_List");
			$("#paramForm", parent.document).submit();
		}
	
	</script>
</body>
</html>