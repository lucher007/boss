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
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" /> &gt; <spring:message code="menu.authorize.blackstb" />(普安)</div>
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<input type="hidden"  name="cardids" id="cardids"/>
				<input type="hidden"  name="unselectedcardids" id="unselectedcardids"/>
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
							<input type="text" class="inp w200" name="stbno" id="stbno" readonly="readonly" style="background:#eeeeee;" value="${caCommandParam.stbno }">
							<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseStb();">
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.flag.sendnow"/>：</td>
						<td> 
							<select id="send_now_flag" name="send_now_flag" class="select">
				                   <option value="0"><spring:message code="systempara.code.cas_send_auto.0"/></option>
				                   <option value="1"><spring:message code="systempara.code.cas_send_auto.1"/></option>
				             </select>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td>
							<input type="text" id="expired_Time" name="expired_Time" value="${caCommandParam.expired_Time }" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
						</td>
					</tr>
				</table>
				      
		      	 <div id="stbCardInfo"></div>
				<input type="button" class="btn-back" value="<spring:message code="page.reback"/>" onclick="goBack();" />
				<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="goSend();" />
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
			loadUserCardInfo();
			var returninfo = '${caspnblackstb.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});
		
		function goBack(){
			$("#paramForm").attr("action", "cas_pn/find_Cmd46_List");
			$("#paramForm").submit();
		}
		
		function goSend(){
			getSelectedCards();
			if ($('#stbno').val() == '') {
				$.dialog.tips('<spring:message code="stb.stbno.empty"/>', 1,
						'alert.gif');
				$('#stbno').focus();
				return;
			}

			if ($('#expired_Time').val() == '') {
				$.dialog.tips(
						'<spring:message code="authorize.expiredtime.empty"/>',
						1, 'alert.gif');
				return;
			}

			if ($('#cardids').val() == '') {
				$.dialog.tips('<spring:message code="authorize.selectone"/>', 1,
						'alert.gif');
				return;
			}

			$("#paramForm").attr("action", "cas_pn/send_Cmd46");
			$("#paramForm").submit();
		}

		function getSelectedCards() {
			$("#cardids").val("");
			$("#unselectedcardids").val("");
			var nameArray = document.getElementsByName("ids");
			for ( var i = 0; i < nameArray.length; i++) {
					var val = nameArray[i].value;
				if (nameArray[i].checked) {//得到
						
						if ($("#cardids").val() == "") {
							$("#cardids").val(val);
						} else {
							$("#cardids").val($("#cardids").val() + "," + val);
						}
						
				}else{
					
						if ($("#unselectedcardids").val() == "") {
							$("#unselectedcardids").val(val);
						} else {
							$("#unselectedcardids").val($("#unselectedcardids").val() + "," + val);
						}
				}
			}
		};

		function loadUserCardInfo() {
			var data = {
				stbno : $("#stbno").val(),
				tag : 'stbCardInfo'
			};
			var url = 'authorize/getStbCardInfo .' + data.tag;
			$('#stbCardInfo').load(url, data, function() {
			});
		}

		var stbDialog;
		function chooseStb() {
			stbDialog = $.dialog({
				title : '<spring:message code="authorize.userstb.choose"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:authorize/findUserstbListForDialog'
			});
		}

		function closeDialog(stbno) {
			stbDialog.close();
			$("#stbno").val(stbno);
			loadUserCardInfo();
		}

		//全选
		function checkAll() {
			$(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
		}

		function checkbox() {
			var checked = true;
			$('.checkbox').each(function() {
				if (!$(this).attr('checked')) {
					checked = false;
				}
			});
			$('#checkall').attr('checked', checked);
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
