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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link rel="stylesheet" href="colorpicker/css/colorpicker.css" type="text/css" />
<style type="text/css">
</style>
</head>
<body  style="padding:0px; width:99%; ">
	<div id="body">
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
				<input type="hidden" name="versiontype" id="versiontype" value="${caspnblackcard.versiontype }"/>
				<table>
						<tr height="40px">
						<td align="right"><spring:message code="network.netname" />：</td>
						<td align="left">
							<select id="netid" name="netid" class="select">
									<c:forEach items="${card.networkmap}" var="networkMap" varStatus="s">
										<option value="${networkMap.key}" <c:if test="${card.netid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
									</c:forEach>
							</select>
						</td>	
				</tr>
				
					<tr height="40px">
						<td align="right"><spring:message code="card.cardid" />：</td>
						<td align="left">
							  <input type="text" class="inp w200" name="cardid" id="cardid" value="${caspnblackcard.cardid }"
							   maxlength="16"
							   onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
							   onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
							  <span class="red"> *</span>
						</td>
					</tr>
				</table>
				<%-- 
				<input type="button" class="btn-back" value="<spring:message code="page.reback"/>" onclick="goBack();" />
			    <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="goSend();" />
				 --%>
				<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	<a href="javascript:goSend();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
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
			initNetwork();
				var returninfo = '${caspnblackcard.returninfo}';
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
			$("#paramForm").attr("action", "cascommand/send_blackcard");
			$("#paramForm").submit();
		}
		
				
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_blackcard_List");
			$("#paramForm", parent.document).submit();
		}
	
		function initNetwork() {
			
			 var data = {
			    t: new Date().getTime()
		     };
			
			$.getJSON('network/initNetworkJson', data, function(networkJson) {
				var options = '';
				for ( var key in networkJson) {
					options += '<option value="' + networkJson[key].id + '">'
							+ networkJson[key].netname + '</option>';
				}
				$('#netid').children().remove();
				$('#netid').append(options);
				$('#netid').val('$card.netid}');
				//initServer();
			});
		}
	
	</script>
</body>
</html>