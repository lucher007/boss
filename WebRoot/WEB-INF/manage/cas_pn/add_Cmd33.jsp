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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" /> &gt; <spring:message code="menu.authorize.forcerestartstb" />(普安)</div>
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<table>
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
						<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td>
							<input type="text" id="expired_Time" name="expired_Time" value="${caCommandParam.expired_Time }" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
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
					</tr>

					<tr height="40px" id="card">
						<td align="right"><spring:message code="card.cardid" />：</td>
						<td>
							<input type="text" class="inp w200" name="cardid" id="cardid" value="${caCommandParam.cardid }">
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.area.target"/>：</td>
						<td> 
							<select id="areacode_option" name="areacode_option" onchange="areacode_optionInit();" class="select">
				                   <option value="0"><spring:message code="authorize.area.target.0" /></option>
				                   <option value="1" ><spring:message code="authorize.area.target.1" /></option>
				             </select>
						</td>
					</tr>
					
					<tr height="40px" id="area">
						<td align="right"><spring:message code="area.areacode" />：</td>
						<td>
							<input type="text" class="inp w200" name="areacode" id="areacode" readonly="readonly" style="background:#eeeeee;" value="${caCommandParam.areacode }">
							<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseArea();">
						</td>
					</tr>
				
					<tr height="40px">
							<td colspan="2" align="center" width="130px"><input type="button" class="btn-save" value="<spring:message code="authorize.force.restart"/>" onclick="goSend();" /></td>
					</tr>
				
				</table>
				
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">

		$(function() {
			initNetwork();
			cardid_optionInit();
			areacode_optionInit();
			var returninfo = '${caCommandParam.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});
		
		function goSend() {
	
		 	if ($('#expired_Time').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				return;
			} 
		 	
		 	if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				$('#cardid').focus();
				return;
			} 
			
			if ($('#areacode').val() == '') {
				$.dialog.tips('<spring:message code="area.areacode.empty"/>',1, 'alert.gif');
				$('#areacode').focus();
				return;
			} 
		
			$("#paramForm").attr("action", "cas_pn/send_Cmd33");
			$("#paramForm").submit();
		}

		function cardid_optionInit() {
			if ($("#cardid_option").val() == "0") {
				$("#card").show();
				$("#cardid").val("");

			} else {
				$("#cardid").val("ffffffff");
				$("#card").hide();
			//	alert("cardid:" + $("#cardid").val());
			}
		};

		function areacode_optionInit() {
			if ($("#areacode_option").val() == "0") {
				$("#area").show();
				$("#areacode").val("");
			} else {
				$("#areacode").val("ffffffff");
				$("#area").hide();
				//alert("areacode:" + $("#areacode").val());
			}
		};
		
		var areaDialog;
		function chooseArea() {
			areaDialog = $.dialog({
				title : '<spring:message code="authorize.area.choose"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:authorize/findAreaListForDialog'
			});
		}

		function closeDialog(areacode) {
			areaDialog.close();
			$("#areacode").val(areacode);
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
