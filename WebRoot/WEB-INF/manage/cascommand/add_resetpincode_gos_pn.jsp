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
					<td align="right"><spring:message code="authorize.card.target" />：</td>
					<td align="left">	              
						<select id="cardid_option" name="cardid_option" class="select" onchange="cardid_optionInit();">
			                   <option value="0"><spring:message code="authorize.card.target.0" /></option>
			                   <option value="1"><spring:message code="authorize.card.target.1" /></option>
			             </select>
					</td>
				</tr>

				<tr height="40px" id="card">
					<td align="right"><spring:message code="card.cardid" />：</td>
					<td align="left">	              
						<input type="text" class="inp w200" name="cardid" id="cardid" value="${caCommandParam.cardid }" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
												  <span class="red"> *</span>
					</td>
				</tr>
					
				<tr height="40px">
					<td align="right"><spring:message code="authorize.expiretime" />：</td>
					<td align="left">	              
						<input type="text" id="expired_Time" name="expired_Time" readonly="readonly" value="${caCommandParam.expired_Time }" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
												  <span class="red"> *</span>
					</td>
				</tr>
							
				<tr height="40px">
					<td colspan="2" align="center">
							<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
					</td>
				</tr>
				
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">

		$(function() {
			cardid_optionInit();
			var returninfo = '${caCommandParam.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});
		
		function goSend() {
			if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#expired_Time').val() == '') {
				$.dialog.tips(
						'<spring:message code="authorize.expiredtime.empty"/>',
						1, 'alert.gif');
				return;
			}
			$("#paramForm").attr("action", "cascommand/send_resetpincode");
			$("#paramForm").submit();
		}
		
		function cardid_optionInit() {
			if ($("#cardid_option").val() == "0") {
				$("#card").show();
				$("#cardid").val("");
			} else {
				$("#cardid").val("ffffffff");
				$("#card").hide();
			}
		};

	</script>
</body>
</html>