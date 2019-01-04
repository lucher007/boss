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
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
<link rel="stylesheet" href="colorpicker/css/colorpicker.css" type="text/css" />
<style type="text/css">
    .form-box table tr td {
      white-space: nowrap;
      height: 30px;
      font-size: 12px;
    }
    .readonly {
      background-color: #eeeeee;
    }
</style>
</head>
<body style="padding:0px; width:99%; ">
	<div id="body"  class="form-box">
		<div style="margin:10px 0;"></div>
		<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:98%; text-align:center">
			<table id="appendtr" width="100%" cellpadding="5">
				<tr height="20px">
					<td align="center"><spring:message code="authorize.startstbno"/></td>
					<td align="center"><spring:message code="authorize.endstbno"/></td>
					<td align="center"><spring:message code="page.operate"/></td>
				</tr>
			</table>
		</div>
		<div style="margin:10px 0;"></div>
		<div class="easyui-panel" title="<spring:message code="authorize.add.condition"/>" style="width:100%">
				<table width="100%">
					<tr>
						<td align="center" width="20%"><spring:message code="authorize.startstbno"/></td>
						<td align="center" width="20%"><spring:message code="authorize.endstbno"/></td>
					</tr>
					<tr>
						<td align="center">
							<input type="text" class="inp w200" name="startstbno" id="startstbno" value="" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')" />
						</td>
						<td align="center">
							<input type="text" class="inp w200" name="endstbno" id="endstbno" value="" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')" />
						</td>
					</tr>
				</table>
			<div style="text-align:center;padding:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addCondition()"><spring:message code="authorize.add.condition"/></a> 
			</div>
		</div>   <!-- //end add condition -->

		<div style="margin:10px 0;"></div>
		
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnnewfinger.versiontype }"/>
			<input type="hidden"  name="conditioncontent" id="conditioncontent" />
			<input type="hidden"  name="conditioncount" id="conditioncount" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caspnnewfinger.networkmap}" var="dataMap" varStatus="s">
								  	<option value="${dataMap.key}" <c:if test="${dataMap.key == caspnnewfinger.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${caspnnewfinger.expiredtime}"/>
						</td>
					</tr>
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" value="${caspnnewfinger.starttime}" />
						</td>
						<td align="right"><spring:message code="authorize.osd.showtimelen"/>(ms)：</td>
						<td>
							<input name="duration" id="duration" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
					<tr>
						<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
						<td align="right" width="120px"><spring:message code="authorize.finger.encryptflag"/>：</td>
						<td>
							<select id="encryptflag" name="encryptflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.encryptflag== '0'}">selected</c:if>><spring:message code="authorize.finger.encryptflag.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.encryptflag== '1'}">selected</c:if>><spring:message code="authorize.finger.encryptflag.1"/></option>
							</select>
						</td>
					</tr>
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.osd.cardiddisplayflag"/>：</td>
						<td>
							<select id="cardiddisplayflag" name="cardiddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.cardiddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.cardiddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.cardiddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.cardiddisplayflag.1"/></option>
 							</select>
						</td>
						
						<td align="right" width="120px"><spring:message code="authorize.osd.terminaliddisplayflag"/>：</td>
						<td >
							<select id="terminaliddisplayflag" name="terminaliddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.terminaliddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.terminaliddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.terminaliddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.terminaliddisplayflag.1"/></option>
 							</select>
						</td>
					</tr>
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.osd.operatoriddisplayflag"/>：</td>
						<td>
							<select id="operatoriddisplayflag" name="operatoriddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.operatoriddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.operatoriddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.operatoriddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.operatoriddisplayflag.1"/></option>
 							</select>
						</td>
						<td align="right" width="120px"><spring:message code="authorize.osd.privatecontentflag"/>：</td>
						<td >
							<select id="privatecontentflag" name="privatecontentflag" class="select" style="width:157px;" onchange="displayContentFlag();">
								<option value="1" <c:if test="${caspnnewfinger.privatecontentflag== '1'}">selected</c:if>><spring:message code="authorize.osd.privatecontentflag.1"/></option>
								<option value="0" <c:if test="${caspnnewfinger.privatecontentflag== '0'}">selected</c:if>><spring:message code="authorize.osd.privatecontentflag.0"/></option>
 							</select>
						</td>
					</tr>
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.finger.hideflag"/>：</td>
						<td>
							<select id="hideflag" name="hideflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnnewfinger.hideflag== '0'}">selected</c:if>><spring:message code="authorize.finger.hideflag.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.hideflag== '1'}">selected</c:if>><spring:message code="authorize.finger.hideflag.1"/></option>
 							</select>
						</td>
						<td align="right" width="120px"><spring:message code="authorize.finger.ramdompositionflag"/>：</td>
						<td >
							<select id="ramdompositionflag" name="ramdompositionflag" class="select" style="width:157px;" onchange="initRamdompositionflag();">
								<option value="1" <c:if test="${caspnnewfinger.ramdompositionflag== '1'}">selected</c:if>><spring:message code="authorize.finger.ramdompositionflag.1"/></option>
								<option value="0" <c:if test="${caspnnewfinger.ramdompositionflag== '0'}">selected</c:if>><spring:message code="authorize.finger.ramdompositionflag.0"/></option>
 							</select>
						</td>
					</tr>
					<tr class="pos" height= "40px">
						<td align="right"><spring:message code="authorize.osd.positionx"/>：</td>
						<td>
							<input name="posx" id="posx" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.osd.positiony"/>：</td>
						<td>
							<input name="posy" id="posy" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.finger.fingerheight"/>：</td>
						<td>
							<input name="fingerheight" id="fingerheight" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					 </tr>
				    <tr height="25px">
						<td align="right"><spring:message code="authorize.osd.foregroundcolor"/>：</td>
						<td>
							<input type="text" id="foregroundcolordisplay" style="width:70px;background-color:#0000ff" class="inp foregroundcolorCss"/>
							<input type="text" id="foregroundcolor" name="foregroundcolor" value="0000ff" style="width:70px;" class="inp foregroundcolorCss"/>
						</td>
						<td align="right"><spring:message code="authorize.osd.foregroundtransparency"/>：</td>
						<td>
							<input name="foregroundtransparency" id="foregroundtransparency" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:0" value="${caspnnewfinger.foregroundtransparency}">
						</td>
					</tr>
				    <tr height="40px">
						<td align="right"><spring:message code="authorize.osd.backgroundcolor"/>：</td>
						<td>
							<input type="text" id="backgroundcolordisplay" style="width:70px;background-color:#0000ff" class="inp backgroundcolorCss"/>
							<input type="text" id="backgroundcolor" name="backgroundcolor" value="0000ff" style="width:70px;" class="inp backgroundcolorCss"/>
						</td>
						<td align="right"><spring:message code="authorize.osd.backgroundtransparency"/>：</td>
						<td >
							<input name="backgroundtransparency" id="backgroundtransparency" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:0" value="${caspnnewfinger.backgroundtransparency}">
						</td>
					</tr>
					
				    <tr height="25px" class="display_content_1">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="content" name="content" style="width:75%; height:30px;" onKeyDown="checkLength('content',100)" onKeyUp="checkLength('content',100)">${caspnnewfinger.content}</textarea> 
							<span class="red"><spring:message code="page.can.input" /> <span id="validNumcontent">100</span> <spring:message code="page.word" />
						</span></td>
					</tr>
					
					<tr height="25px">
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
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
		function goSend() {
			if ($('#conditioncontent').val() == '') {
				$.dialog.tips('<spring:message code="authorize.conditioncontent.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.endtime.empty"/>',1, 'alert.gif');
				$('#expiredtime').focus();
				return;
			}
			if ($('#starttime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.starttime.empty"/>',1, 'alert.gif');
				$('#starttime').focus();
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
			initRamdompositionflag();
			displayContentFlag();
			var returninfo = '${caspnnewfinger.returninfo}';
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
		
		function addCondition() {
			/******************* 条件检查 *******************/
			if ($('#startstbno').val() == '') {
				$.dialog.tips('<spring:message code="authorize.seekingobject.empty"/>',1, 'alert.gif');
				$('#startstbno').focus();
				return;
			}
			
			if ($('#endstbno').val() == '') {
				$.dialog.tips('<spring:message code="authorize.seekingobject.empty"/>',1, 'alert.gif');
				$('#endstbno').focus();
				return;
			}
			/******************* 拼接命令 *******************/
			// var checkText=$("#operation").find("option:selected").text(); //获取Select选择的Text 
			//alert(checkText + ": " + $("#operation").val());
			
			var startstbno = LPAD($("#startstbno").val(), 8);
			var endstbno = LPAD($("#endstbno").val(), 8);
			var conditionToAppend = '<tr height="20px" class="commandpart"><td align="center">'
					+ startstbno
					+ '<input type="hidden" class="cndpara" value="'  + startstbno +   '"></td><td align="center">'
					+ endstbno
					+ '<input type="hidden" class="cndpara" value="'  + endstbno +   '"></td><td align="center"><a class="red" href="javascript:void(0);" onclick="deleteTr(this)"><spring:message code="page.delete"/></a></td></tr>';
			$('#appendtr').append(conditionToAppend);
			updateFinalCommand();
		}
		
		function updateFinalCommand() {
			var final_cmd = "";//条件寻址内容
			var conditioncount = 0;//条件寻址段数
			
			$(".commandpart").each(function() {
				conditioncount++;//循环一次，条件段数就加1
				var dataarray = $(this).find(".cndpara");
				var cmd = "";
				dataarray.each(function() {
					cmd = cmd + $(this).val();
				});
				final_cmd = final_cmd + cmd;
			});
			$("#conditioncontent").val(final_cmd);
			$("#conditioncount").val(conditioncount);
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
		
		$('#colorSelector').ColorPicker({
			color: '#0000ff',
			onShow: function (colpkr) {
				$(colpkr).fadeIn(500);
				return false;
			},
			onHide: function (colpkr) {
				$(colpkr).fadeOut(500);
				return false;
			},
			onChange: function (hsb, hex, rgb) {
				$('#colorSelector div').css('backgroundColor', '#' + hex);
				$('#foregroundcolor').val(hex);
			}
		});
		
		$('.foregroundcolorCss').ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			},
			onChange: function (hsb, hex, rgb) {
				$('#foregroundcolordisplay').css('backgroundColor', '#' + hex);
				$('#foregroundcolor').val(hex);
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});
		
		$('.backgroundcolorCss').ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			},
			onChange: function (hsb, hex, rgb) {
				$('#backgroundcolordisplay').css('backgroundColor', '#' + hex);//显示RGB颜色
				$('#backgroundcolor').val(hex);//显示RGB数值
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});
		
		//显示指纹位置改变
		function initRamdompositionflag(){
			if($("#ramdompositionflag").val() == "0"){
				$(".pos").show();
			}else{
				$(".pos").hide();
			}
		}
		function displayContentFlag() {
			if ($("#privatecontentflag").val() == '1') {
				$(".display_content_1").show();
			} else {
				$(".display_content_1").hide();
			}
		}
	</script>
</body>
</html>