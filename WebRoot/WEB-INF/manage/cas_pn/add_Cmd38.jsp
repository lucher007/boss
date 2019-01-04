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
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" /> &gt; <spring:message code="menu.authorize.pvrentitle" />(普安)</div>
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
						<td align="right"><spring:message code="stb.stbno" />：</td>
						<td>
							<input type="text" class="inp w200" name="stbno" id="stbno" value="${caCommandParam.stbno }">
						</td>
					</tr>
							
					<tr height="40px">
						<td align="right"><spring:message code="product.productid" />：</td>
						<td>
							<input type="text" class="inp w200" name="serviceID" id="serviceID" readonly="readonly" style="background:#eeeeee;" value="${caCommandParam.pvrAuthEmm.serviceID }">
							<input type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseProduct();">
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.pvr.entitledays" />：</td>
						<td>
							<input type="text" class="inp w200" name="entitle_Days" id="entitle_Days" value="${caCommandParam.pvrAuthEmm.entitle_Days }">
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.pvr.createtime" />：</td>
						<td>
							<input type="text" id="timeInFileID" name="timeInFileID" value="${caCommandParam.pvrAuthEmm.timeInFileID }" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td>
							<input type="text" id="expired_Time" name="expired_Time" value="${caCommandParam.expired_Time }" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
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
			var returninfo = '${caCommandParam.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});

		function goSend() {
			if ($('#stbno').val() == '') {
				$.dialog.tips('<spring:message code="stb.stbno.empty"/>',1, 'alert.gif');
				$('#stbno').focus();
				return;
			}
			
			if ($('#serviceID').val() == '') {
				$.dialog.tips('<spring:message code="product.productid.empty"/>',1, 'alert.gif');
				$('#serviceID').focus();
				return;
			}
			
			if ($('#entitle_Days').val() == '') {
				$.dialog.tips('<spring:message code="authorize.entitledays.empty"/>',1, 'alert.gif');
				$('#entitle_Days').focus();
				return;
			}
			
			if ($('#timeInFileID').val() == '') {
				$.dialog.tips('<spring:message code="authorize.pvrcreatetime.empty"/>',1, 'alert.gif');
				//	$('#timeInFileID').focus();
				return;
			}
			
			if ($('#expired_Time').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				//	$('#timeInFileID').focus();
				return;
			}
			$("#paramForm").attr("action", "cas_pn/send_Cmd38");
			$("#paramForm").submit();
		}


		var productDialog;
		function chooseProduct() {
			productDialog = $.dialog({
				title : '<spring:message code="authorize.product.choose"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:authorize/findProductListForDialog'
			});
		}

		function closeDialog(productid) {
				productDialog.close();
				$("#serviceID").val(productid);
			}
			
		/* 	function initNetwork() {
				$.getJSON('network/initNetworkJson', null, function(networkJson) {
					var options = '';
					for ( var key in networkJson) {
						options += '<option value="' + key + '">'
								+ networkJson[key] + '</option>';
					}
					$('#netid').children().remove();
					$('#netid').append(options);
					$('#netid').val('$card.netid}');
				//	initServer();
				});
			} */
	</script>
</body>
</html>
