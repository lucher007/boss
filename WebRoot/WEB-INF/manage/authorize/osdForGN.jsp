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
		<form action="" method="post" id="paramForm" name="paramForm">
			<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:750px">
				<table width="100%" cellpadding="5">
					<tr height="40px">
						<%-- <td align="right">CA object:</td>
						<td><select class="select" name="caobject" id="caobject">
								<option value="4" <c:if test="${authorizeParamForPages.caobject== '4'}">selected</c:if>>gospell高安</option>
								<option value="5" <c:if test="${authorizeParamForPages.caobject== '5'}">selected</c:if>>gospell普安</option>
								<option value="6" <c:if test="${authorizeParamForPages.caobject== '6'}">selected</c:if>>NVOD服务器安</option>
								<option value="7" <c:if test="${authorizeParamForPages.caobject== '7'}">selected</c:if>>MPS服务器</option>
						</select></td> --%>
						<td align="right"><spring:message code="authorize.addressingmode"/>：</td>
						<td><select id="addressing_mode" name="addressing_mode" class="select" onchange="setAddressing();">
								<option value="0" <c:if test="${authorizeParamForPages.addressing_mode== '0'}">selected</c:if>><spring:message code="authorize.addressingmode.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.addressing_mode== '1'}">selected</c:if>><spring:message code="authorize.addressingmode.1"/></option>
						</select></td>
					</tr>
					<tr id="singletag" height="40px">
						<td align="right"><spring:message code="stb.stbno"/>：</td>
						<td><input type="text" class="inp w200" name="stbno" id="stbno" value="${authorizeParamForPages.stbno}">
						</td>
					</tr>
					<tr id="rangetag" height="40px">
						<td align="right"><spring:message code="authorize.startstbno"/>：</td>
						<td><input type="text" class="inp w200" name="startstbno" id="startstbno" value="${authorizeParamForPages.startstbno}">
						</td>
						<td align="right"><spring:message code="authorize.endstbno"/>：</td>
						<td><input type="text" class="inp w200" name="endstbno" id="endstbno" value="${authorizeParamForPages.endstbno}">
						</td>
					</tr>
				</table>
			</div>
			<div style="margin:20px 0;"></div>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:750px">
				<table width="100%">
					<tr height="40px">
						<%-- <td align="right">cas_exptime：</td>
						<td><input type="text" id="cas_exptime" name="cas_exptime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${authorizeParamForPages.gaoanosdparam.cas_exptime}"
						/></td> --%>
						<td align="right" width="120px"><spring:message code="authorize.osdcontrol"/>：</td>
						<td><select id="osd_control" name="osd_control" class="select" onchange="param_form_setting();">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.osd_control== '0'}">selected</c:if>><spring:message code="authorize.osdcontrol.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.osd_control== '1'}">selected</c:if>><spring:message code="authorize.osdcontrol.1"/></option>
						</select></td>
					</tr>
					<tr height="40px" class="osd_control_mode_0">
						<td align="right"><spring:message code="authorize.canceltarget"/>：</td>
						<td><select id="cancel_control" name="cancel_control" class="select" onchange="param_form_setting();">
								<option value="0" <c:if test="${authorizeParamForPages.cancel_control== '0'}">selected</c:if>><spring:message code="authorize.canceltarget.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.cancel_control== '1'}">selected</c:if>><spring:message code="authorize.canceltarget.1"/></option>
						</select></td>
						<td class="single_cancel" align="right"><spring:message code="authorize.cancel.osdid"/>：</td>
						<td class="single_cancel"><input type="text" class="inp w200" name="osd_id" id="osd_id"
							value="${authorizeParamForPages.gaoanosdparam.osd_id}"
						></td>
					</tr>
					<tr class="osd_control_mode_1" height="40px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="start_time" name="start_time"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${authorizeParamForPages.gaoanosdparam.start_time}"
						/>
						</td>
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td><input type="text" id="exp_time" name="exp_time"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${authorizeParamForPages.gaoanosdparam.exp_time}"
						/>
						</td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right"><spring:message code="authorize.new.osdid"/>：</td>
						<td><input type="text" class="inp w200" name="osdid" id="osdid" value="${authorizeParamForPages.gaoanosdparam.osdid}"></td>
						<td align="right"><spring:message code="authorize.priority"/>:</td>
						<td><select name="priority" id="priority" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.priority== '0'}">selected</c:if>><spring:message code="authorize.priority.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.priority== '1'}">selected</c:if>><spring:message code="authorize.priority.1"/></option>
								<option value="2" <c:if test="${authorizeParamForPages.gaoanosdparam.priority== '2'}">selected</c:if>><spring:message code="authorize.priority.2"/></option>
						</select></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right"><spring:message code="authorize.osd.font"/>:</td>
						<td><select name="font" id="font" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.font== '0'}">selected</c:if>>宋体</option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.font== '1'}">selected</c:if>>2体</option>
								<option value="2" <c:if test="${authorizeParamForPages.gaoanosdparam.font== '2'}">selected</c:if>>3体</option>
						</select></td>
						<td align="right"><spring:message code="authorize.osd.fontsize"/>：</td>
						<td><input name="size" id="size" class="easyui-numberspinner" value="15" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right" width="120px"><spring:message code="authorize.osd.foregroundcolor"/>：</td>
						<td><select id="foreground_color" name="foreground_color" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.foreground_color== '0'}">selected</c:if>>红</option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.foreground_color== '1'}">selected</c:if>>黄</option>
								<option value="2" <c:if test="${authorizeParamForPages.gaoanosdparam.foreground_color== '2'}">selected</c:if>>蓝</option>
						</select></td>
						<td align="right" width="120px"><spring:message code="authorize.osd.backgroundcolor"/>：</td>
						<td><select id="background_color" name="background_color" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.background_color== '0'}">selected</c:if>>红</option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.background_color== '1'}">selected</c:if>>黄</option>
								<option value="2" <c:if test="${authorizeParamForPages.gaoanosdparam.background_color== '2'}">selected</c:if>>蓝</option>
						</select></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right" width="120px"><spring:message code="authorize.osd.displaystyle"/>：</td>
						<td><select id="display_style" name="display_style" class="select" onchange="param_form_setting();">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.display_style== '0'}">selected</c:if>><spring:message code="authorize.osd.displaystyle.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.display_style== '1'}">selected</c:if>><spring:message code="authorize.osd.displaystyle.1"/></option>
								<option value="2" <c:if test="${authorizeParamForPages.gaoanosdparam.display_style== '2'}">selected</c:if>><spring:message code="authorize.osd.displaystyle.2"/></option>
						</select></td>
						<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td><select id="key_lock" name="key_lock" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.key_lock== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.key_lock== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
						</select></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1 display_style_mode_0">
						<td align="right" width="120px"><spring:message code="authorize.osd.scrolldirection"/>：</td>
						<td><select id="scroll_direction" name="scroll_direction" class="select">
								<option value="0000" <c:if test="${authorizeParamForPages.gaoanosdparam.scroll_direction== '0000'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0000"/></option>
								<option value="0001" <c:if test="${authorizeParamForPages.gaoanosdparam.scroll_direction== '0001'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0001"/></option>
								<option value="0010" <c:if test="${authorizeParamForPages.gaoanosdparam.scroll_direction== '0010'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0010"/></option>
								<option value="0011" <c:if test="${authorizeParamForPages.gaoanosdparam.scroll_direction== '0011'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0011"/></option>
								<option value="1111" <c:if test="${authorizeParamForPages.gaoanosdparam.scroll_direction== '1111'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.1111"/></option>
						</select></td>
						<td align="right"><spring:message code="authorize.osd.displayfrequency"/>：</td>
						<td><input name="display_frequency" id="display_frequency" class="easyui-numberspinner" value="5" data-options="increment:1"
							style="width:157px;"
						/></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1 display_style_mode_0">
						<td align="right"><spring:message code="authorize.osd.positionx"/>：</td>
						<td><input name="position_x" id="position_x" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.osd.positiony"/>：</td>
						<td><input name="position_y" id="position_y" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
					<tr height="40px" class="osd_control_mode_1 display_style_mode_0">
						<td align="right"><spring:message code="authorize.osd.barheight"/>：</td>
						<td><input name="bar_height" id="bar_height" class="easyui-numberspinner" value="15" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
					<tr height="40px" class="osd_control_mode_1 display_style_mode_1">
						<td align="right"><spring:message code="authorize.osd.coveragepercent"/>：</td>
						<td><input name="screen_coverage_percentage" id="screen_coverage_percentage" value="80" class="easyui-slider" style="width:157px"
							data-options="showTip:true"
						/></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right" width="120px"><spring:message code="authorize.osd.cardiddisplayflag"/>：</td>
						<td><select id="card_id_display_flag" name="card_id_display_flag" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.card_id_display_flag== '0'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.card_id_display_flag== '1'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.1"/></option>
						</select></td>
						<td align="right" width="120px"><spring:message code="authorize.osd.terminaliddisplayflag"/>：</td>
						<td><select id="terminal_id_display_flag" name="terminal_id_display_flag" class="select">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.terminal_id_display_flag== '0'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.terminal_id_display_flag== '1'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.1"/></option>
						</select></td>
					</tr>
					<tr height="40px" class="osd_control_mode_1">
						<td align="right" width="120px"><spring:message code="authorize.osd.operatoriddisplayflag"/>：</td>
						<td>
							<select id="operator_id_display_flag" name="operator_id_display_flag" class="select">
									<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.operator_id_display_flag== '0'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.0"/></option>
									<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.operator_id_display_flag== '1'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.1"/></option>
							</select>
						</td>
						<td align="right" width="120px"><spring:message code="authorize.osd.privatecontentflag"/>：</td>
						<td><select id="private_content_flag" name="private_content_flag" class="select" onchange="param_form_setting();">
								<option value="0" <c:if test="${authorizeParamForPages.gaoanosdparam.private_content_flag== '0'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.gaoanosdparam.private_content_flag== '1'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.1"/></option>
						</select></td>
					</tr>
					<tr class="osd_control_mode_1 private_content">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan=4><textarea id="content" name="content" style="width:80%; height:100px;" onKeyDown="checkLength('content',100)"
								onKeyUp="checkLength('content',100)" value="${authorizeParamForPages.gaoanosdparam.content[0]}"
							></textarea> <span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">100</span><spring:message code="page.word"/></span>
						</td>
					</tr>
					<tr height="40px">
						<td colspan="4" align="center"><a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a></td>
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
		function goSend() {
			if ($("#osd_control").val() == "1") {
				if ($("#osdid").val() == "") {
					$.dialog.tips('<spring:message code="authorize.newosd.empty"/>', 1, 'alert.gif');
					$("#osdid").focus();
					return;
				}
				if ($("#start_time").val() == "" || $("#exp_time").val() == "") {
					$.dialog.tips('<spring:message code="authorize.duration.empty"/>', 1, 'alert.gif');
					return;
				}
			}else{
				if ($("#osd_id").val() == "" &&  $("#cancel_control").val() == "0") {
						$.dialog.tips('<spring:message code="authorize.cancelosd.empty"/>', 1, 'alert.gif');
					$("#osd_id").focus();
						return;
				}
			}
			if ($("#addressing_mode").val() == "0" && $("#stbno").val() == "") {
				$.dialog.tips('<spring:message code="authorize.stbno.empty"/>', 1, 'alert.gif');
				$("#stbno").focus();
				return;
			} else if ($("#addressing_mode").val() == "1"
					&& ($("#startstbno").val() == "" || $("#endstbno").val() == "")) {
				$.dialog.tips('<spring:message code="authorize.addressingrange.empty"/>', 1, 'alert.gif');
				return;
			}
			$("#paramForm").attr("action", "authorize/saveOsdForGN");
			$("#paramForm").submit();
		}

		function setAddressing() {
			if ($("#addressing_mode").val() == "0") {
				$("#singletag").show();
				$("#rangetag").hide();
			} else {
				$("#rangetag").show();
				$("#singletag").hide();
			}
		}

		function param_form_setting() {
			if ($("#osd_control").val() == "0") {
				$(".osd_control_mode_0").show();
				$(".osd_control_mode_1").hide();
				if ($("#cancel_control").val() == "0") {
					$(".single_cancel").hide();
				} else {
					$(".single_cancel").show();
				}
			} else if ($("#osd_control").val() == "1") {
				$(".osd_control_mode_0").hide();
				$(".osd_control_mode_1").show();
				if ($("#display_style").val() == "0") {
					$(".display_style_mode_0").show();
					$(".display_style_mode_1").hide();
				} else {
					$(".display_style_mode_0").hide();
					$(".display_style_mode_1").show();
				}
				if ($("#private_content_flag").val() == "0") {
					$(".private_content").hide();
				} else {
					$(".private_content").show();
				}
			}
		}

		$(function() {
			setAddressing();
			param_form_setting();
			var returninfo = '${authorizeParamForPages.returninfo}';
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