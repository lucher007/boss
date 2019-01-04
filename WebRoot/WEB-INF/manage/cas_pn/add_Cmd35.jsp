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
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.newemail"/>(<spring:message code="server.versiontype.gos_pn" />)</div>
				

		<div style="margin:20px 0;"></div>

		<form action="" method="post" id="paramForm" name="paramForm">
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:950px">
				<table width="100%">
					
						<tr height="40px">
						<td align="right" width="15%"><spring:message code="network.netname" />：</td>
						<td width="25%">
							<select id="netid" name="netid" class="select">
									<c:forEach items="${card.networkmap}" var="networkMap" varStatus="s">
										<option value="${networkMap.key}" <c:if test="${card.netid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
									</c:forEach>
							</select>
						</td>	
				</tr>
				
				
				<tr height="40px">
					<td align="right"><spring:message code="authorize.card.target" />：</td>
					<td> 
						<select id="cardid_option" name="cardid_option" class="select" onchange="cardid_optionInit();">
			                   <option value="0"><spring:message code="authorize.card.target.0" /></option>
			                   <option value="1"><spring:message code="authorize.card.target.1" /></option>
			             </select>
					</td>
					<td class="cardid"align="right"><spring:message code="card.cardid" />：</td>
					<td class="cardid">
						<input type="text" class="inp w200" name="cardid" id="cardid" value="${caspnnewemail.cardid }">
					</td>
				</tr>
				
				<tr>
					<td align="right"><spring:message code="authorize.title" />：</td>
					<td>
						<input type="text" class="inp w200" name="emailtitle" id="emailtitle" value="${caspnnewemail.emailtitle }">
					</td>
				
					<td align="right"><spring:message code="authorize.expiretime"/>：</td>
					<td><input type="text" id="expiredtime" name="expiredtime" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
						class="Wdate inp w150" value="${caspnnewemail.expiredtime}"/>
					</td>
				</tr>
					
				<tr height="40px">
					<td align="right"><spring:message code="authorize.emailtype" />：</td>
					<td> 
						<select id="emailtype" name="emailtype" class="select" onchange="cardid_optionInit();">
			                   <option value="0"><spring:message code="authorize.emailtype.0" /></option>
			                   <option value="1"><spring:message code="authorize.emailtype.1" /></option>
			             </select>
					</td>
				</tr>
			
				<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="emailcontent" name="emailcontent" style="width:75%; height:100px;" onKeyDown="checkLength('emailcontent',100)" onKeyUp="checkLength('emailcontent',100)">${caspnnewemail.emailcontent}</textarea> 
							<span class="red"><spring:message code="page.can.input" /> <span id="validNumemailcontent">100</span> <spring:message code="page.word" /></span>
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
			if ($('#emailtitle').val() == '') {
				$.dialog.tips('<spring:message code="authorize.title.empty"/>',1, 'alert.gif');
				$('#starttime').focus();
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				return;
			}
			$("#paramForm").attr("action", "cas_pn/send_Cmd35");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm").attr("action", "cas_pn/find_Cmd35_List");
			$("#paramForm").submit();
		}

		$(function() {
			initNetwork();
			cardid_optionInit();
			var returninfo = '${caspnnewemail.returninfo}';
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
		
				function initNetwork() {
			$.getJSON('network/initNetworkJson', null, function(networkJson) {
				var options = '';
				for ( var key in networkJson) {
					options += '<option value="' + key + '">'
							+ networkJson[key] + '</option>';
				}
				$('#netid').children().remove();
				$('#netid').append(options);
				$('#netid').val('$card.netid}');
				initServer();
			});
		}
	</script>
</body>
</html>