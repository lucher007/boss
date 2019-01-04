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
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.forceosd"/>(<spring:message code="server.versiontype.gos_pn" />)</div>
				<div style="margin:20px 0;"></div>
				<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:950px; text-align:center">
						<table id="appendtr" width="100%" cellpadding="5">
							<tr height="40px">
								<td colspan="4" align="center"><spring:message code="authorize.condition"/></td>
								<td align="center">
										<spring:message code="page.operate"/>
								</td>
							</tr>
						</table>
				</div>    <!--  //end condition cmd -->
		
		<div style="margin:20px 0;"></div>
		
		<div class="easyui-panel" title="<spring:message code="authorize.add.condition"/>" style="width:950px">
				<table width="100%">
					<tr height="40px">
							<td align="center" width="20%"><spring:message code="authorize.seeking.object"/></td>
							<td align="center" width="20%"><spring:message code="authorize.operator"/></td>
							<td align="center" width="40%"><spring:message code="authorize.condition.content"/></td>
							<td align="center" width="20%"><spring:message code="authorize.condition.teamlogic"/></td>
					</tr>
					
					<tr height="40px">
						<td align="center">
								<select id="addressseeking">
										<option value="23"><spring:message code="card.cardid"/></option>
										<option value="24"><spring:message code="area.areacode"/></option>
								</select>
						</td>
						<td align="center">
								<select  id="operation">
										<option value="13"><</option>
										<option value="14"><=</option>
										<option value="15">></option>
										<option value="16">>=</option>
										<option value="17">=</option>
										<option value="18">!=</option>
								</select>
						</td>
						
						<td align="center">
								<input type="text" class="inp w200" name="objectcode" id="objectcode" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 

						</td>
						<td align="center">
									<select  id="teamlogic">
										<option value="1c">AND</option>
										<option value="1d">OR</option>
										<!-- 										
										<option value="">NONE</option>
										 -->								
 								</select>
						</td>
					</tr>
				</table>
				
			<div style="text-align:center;padding:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addCondition()"><spring:message code="authorize.add.condition"/></a> 
			</div>
		</div>   <!-- //end add condition -->

		<div style="margin:20px 0;"></div>

		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:950px">
				<table width="100%">
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${caspnforcedosd.starttime}" />
						</td>
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${caspnforcedosd.expiredtime}"/>
						</td>
					</tr>
				
					<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.showtimelen"/>：</td>
						<td><input name="duration" id="duration" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.osd.showtimes"/>：</td>
						<td><input name="showtimes" id="showtimes" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
				 
					<tr height="40px">
					
					<td align="right" width="15%"><spring:message code="network.netname" />：</td>
					<td width="25%">
						<select id="netid" name="netid" class="select">
								<c:forEach items="${card.networkmap}" var="networkMap" varStatus="s">
									<option value="${networkMap.key}" <c:if test="${card.netid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
								</c:forEach>
						</select>
					</td>	
				
					<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
						
						
					</tr>
				
				<tr height="40px">
					<td align="right" width="120px"><spring:message code="authorize.osd.displaystyle"/>：</td>
						<td>
							<select id="style" name="style" class="select" style="width:157px;" onchange="initStyleValue()">
									<option value="0" <c:if test="${caspnforcedosd.style== '0'}">selected</c:if>><spring:message code="authorize.forceosd.displaystyle.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.style== '1'}">selected</c:if>><spring:message code="authorize.forceosd.displaystyle.1"/></option>
									<!-- 		暂没用到							
									<option value="2"><spring:message code="authorize.forceosd.displaystyle.2"/></option>
									 -->							
 							</select>
						</td>
				
					<td  class="sytle0_value" align="right" width="120px"><spring:message code="authorize.osd.scrolldirection"/>：</td>
						<td  class="sytle0_value">
							<select id="scroll_direction" name="scroll_direction" class="select">
									<option value="1" <c:if test="${caspnforcedosd.stylevalue== '1'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0010"/></option>
									<option value="2" <c:if test="${caspnforcedosd.stylevalue== '2'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0000"/></option>
									<option value="3" <c:if test="${caspnforcedosd.stylevalue== '3'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.3"/></option>
							</select>
						</td>
						
						<td class="sytle1_value" align="right"><spring:message code="authorize.osd.coveragepercent"/>：</td>
						<td class="sytle1_value">
							<input name="scalerelativetoscreen" id="scalerelativetoscreen" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:10" value="${caspnforcedosd.stylevalue}">
						</td>
				</tr>
				
					<!-- 		
						普安暂不支持
						<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.backgroundcolor"/>：</td>
						<td><input type="text" class="inp w200" name="BackGroundColor" id="BackGroundColor">
						</td>
						<td align="right">FontColor：</td>
						<td><input type="text" class="inp w200" name="FontColor" id="FontColor" />
						</td>
					</tr> 
					-->
			
				<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
						<textarea id="content" name="content" style="width:75%; height:100px;" onKeyDown="checkLength('content',100)" onKeyUp="checkLength('content',100)">${caspnforcedosd.content}</textarea> 
						<span class="red"><spring:message code="page.can.input" /> <span id="validNumcontent">100</span> <spring:message code="page.word" />
						</span></td>
					</tr>
					
					<tr height="40px">
							<td colspan="2" align="right">
								<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="goback"/></a>
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
	
		function initStyleValue() {
			if ($("#style").val() == 0) {
				$(".sytle0_value").show();
				$(".sytle1_value").hide();
			} else {
				$(".sytle1_value").show();
				$(".sytle0_value").hide();
			}
		}

		function goSend() {
			if ($('#conditioncontent').val() == '') {
				$.dialog.tips('<spring:message code="authorize.conditioncontent.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#starttime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.starttime.empty"/>',1, 'alert.gif');
				$('#starttime').focus();
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.endtime.empty"/>',1, 'alert.gif');
				$('#expiredtime').focus();
				return;
			}
			
			$("#paramForm").attr("action", "cas_pn/send_Cmd29");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm").attr("action", "cas_pn/find_Cmd29_List");
			$("#paramForm").submit();
		}

		$(function() {
			initNetwork();
			initStyleValue();
			var returninfo = '${caspnforcedosd.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		function addCondition() {
			/******************* 条件检查 *******************/
			if ($('#objectcode').val() == '') {
				$.dialog.tips('<spring:message code="authorize.seekingobject.empty"/>',1, 'alert.gif');
				$('#objectcode').focus();
				return;
			}
			/******************* 拼接命令 *******************/
			// var checkText=$("#operation").find("option:selected").text(); //获取Select选择的Text 
			//alert(checkText + ": " + $("#operation").val());
			var target = $("#addressseeking").find("option:selected").text();
			var operation = $("#operation").find("option:selected").text();
			var objectcode = $("#objectcode").val();
			var teamlogic = $("#teamlogic").find("option:selected").text();
			var target_val = $("#addressseeking").val();
			var operation_val = $("#operation").val();
			var temp_num = new Number($("#objectcode").val());
			var objectcode_val = LPAD(temp_num.toString(16), 8);
			//alert(objectcode_val.toString(16));
			var teamlogic_val = $("#teamlogic").val();
			var conditionToAppend = '<tr height="25px" class="commandpart"><td align="center">'
					+ target
					+ '<input type="hidden" class="cndpara" value="'  + target_val +   '"></td><td align="center">'
					+ operation
					+ '<input type="hidden" class="cndpara" value="'  + operation_val +   '"></td><td align="center">'
					+ objectcode
					+ '<input type="hidden" class="cndpara" value="'  + objectcode_val +   '"></td><td align="center">'
					+ teamlogic
					+ '<input type="hidden" class="cndpara" value="'  + teamlogic_val +   '"></td><td align="center"><a class="red" href="javascript:void(0);" onclick="deleteTr(this)"><spring:message code="page.delete"/></a></td></tr>';
			$('#appendtr').append(conditionToAppend);
			updateFinalCommand();
		}

		function updateFinalCommand() {
			var final_cmd = "";
			$(".commandpart").each(function() {
				var dataarray = $(this).find(".cndpara");
				var cmd = "";
				dataarray.each(function() {
					cmd = cmd + $(this).val();
				});
				final_cmd = final_cmd + cmd;
			});
			$("#conditioncontent").val(final_cmd);
			//alert($("#conditioncontent").val());
		}

		function deleteTr(delObj) {
			$(delObj).parents('tr').remove();
			updateFinalCommand();
		}

		function LPAD(num, n) {
			if ((num + "").length >= n)
				return num;
			return LPAD("0" + num, n);
		}

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