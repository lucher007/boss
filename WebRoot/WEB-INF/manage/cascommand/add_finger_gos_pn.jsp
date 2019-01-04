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
<body style="padding:0px; width:99%; ">
	<div id="body">
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden" name="versiontype" id="versiontype" value="${emailOrOsdMsg.versiontype }"/>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
			<table width="100%">
				<tr>
					<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
					<td width="25%">
						  <select id="netid" name="netid" class="select">
							<c:forEach items="${emailOrOsdMsg.networkmap}" var="dataMap" varStatus="s">
							  <option value="${dataMap.key}" <c:if test="${dataMap.key == emailOrOsdMsg.netid}">selected</c:if>>${dataMap.value}</option>
							</c:forEach>
						  </select>
					</td>
				</tr>
				
				<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.showtimelen"/>：</td>
						<td><input name="duration" id="duration" class="easyui-numberspinner" value="${emailOrOsdMsg.duration==null?1:emailOrOsdMsg.duration }" data-options="min:1,increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
						class="Wdate inp w150" value="${emailOrOsdMsg.expiredtime}"/>
												<span class="red">*</span>
						
					</td>
					</tr>
				
				<tr>
					<td align="right"><spring:message code="authorize.card.target" />：</td>
					<td> 
						<select id="cardid_option" name="cardid_option" class="select" onchange="cardid_optionInit();">
			                   <option value="0" <c:if test="${emailOrOsdMsg.cardid_option == '0'}">selected</c:if>><spring:message code="authorize.card.target.0" /></option>
			                   <option value="1" <c:if test="${emailOrOsdMsg.cardid_option == '1'}">selected</c:if>><spring:message code="authorize.card.target.1" /></option>
			             </select>
					</td>
					<td class="cardid"align="right"><spring:message code="card.cardid" />：</td>
					<td class="cardid">
					             	<input type="text" class="inp" name="cardid" id="cardid" 
						             	maxlength="16"
						             	value="${emailOrOsdMsg.cardid }" 
						             	 onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
						             	onafterpaste="this.value=this.value.replace(/\D/g,'')">
					             	 <span class="red"> *</span>
					</td>
				</tr>
				
				<tr height="40px">
					<td colspan="2" align="right">
						<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="page.reback"/></a>
					</td>
					<td colspan="2" align="left">
							<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
					</td>
				</tr>
				
				</table>
			</div>
		</form>
	
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">

		function cardid_optionInit(){
			if($("#cardid_option").val() == "0"){
				if($("#cardid").val() == "ffffffff"){
					$("#cardid").val("");
				}
				$(".cardid").show();
			}else{
				$(".cardid").hide();
				$("#cardid").val("ffffffff");
			}
		}

		function goSend() {
			if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				$('#cardid').focus();
				return;
			}
			if ($('#duration').val() == '') {
				$.dialog.tips('<spring:message code="authorize.duration.empty"/>',1, 'alert.gif');
				
				$('#duration').next('span').find('input').focus();
				//$('#duration').focus();
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				$('#expiredtime').focus();
				return;
			}
			$("#paramForm").attr("action", "cascommand/send_finger");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_finger_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
			cardid_optionInit();
			var returninfo = '${emailOrOsdMsg.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		function checkLength(object, maxlength) {
			var obj = $('#' + object), value = $.trim(obj.val());
			if (value.length > maxlength) {
				obj.val(value.substr(0, maxlength));
			} else {
				$('#validNum' + object).html(maxlength - value.length);
			}
		}

	</script>
</body>
</html>