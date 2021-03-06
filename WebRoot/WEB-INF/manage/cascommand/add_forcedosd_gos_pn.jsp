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
<body  style="padding:0px; width:99%; ">
	<div id="body" class="form-box">
		<div style="margin:10px 0;"></div>
		<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:100%; text-align:center">
				<table id="appendtr" width="100%" cellpadding="5">
					<tr height="25px">
						<td colspan="4" align="center"><spring:message code="authorize.condition"/></td>
						<td align="center">
								<spring:message code="page.operate"/>
						</td>
					</tr>
				</table>
		</div>
		
		<div style="margin:10px 0;"></div>
		
		<div class="easyui-panel" title="<spring:message code="authorize.add.condition"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
							<td align="center" width="20%"><spring:message code="authorize.seeking.object"/></td>
							<td align="center" width="20%"><spring:message code="authorize.operator"/></td>
							<td align="center" width="40%"><spring:message code="authorize.condition.content"/></td>
							<td align="center" width="20%"><spring:message code="authorize.condition.teamlogic"/></td>
					</tr>
					
					<tr height="25px">
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
								<input type="text" class="inp w200" name="objectcode" id="objectcode" value="" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 

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

		<div style="margin:10px 0;"></div>

		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnforcedosd.versiontype }"/>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime" value="${caspnforcedosd.starttime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',maxDate:'#F{$dp.$D(\'expiredtime\');}'});"
							class="Wdate inp w150" value="${caspnforcedosd.starttime}" />
						</td>
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime"  value="${caspnforcedosd.expiredtime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'starttime\');}'});"
							class="Wdate inp w150" value="${caspnforcedosd.expiredtime}"/>
						</td>
					</tr>
				
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.showtimelen"/>：</td>
						<td><input name="duration" id="duration" class="easyui-numberspinner" value="${caspnforcedosd.duration==null?1:caspnforcedosd.duration }" data-options="min:1,increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.osd.showtimes"/>：</td>
						<td><input name="showtimes" id="showtimes" class="easyui-numberspinner" value="${caspnforcedosd.showtimes==null?1:caspnforcedosd.showtimes }" data-options="min:1,increment:1" style="width:157px;"></input>
						</td>
					</tr>
				 
					<tr height="25px">
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caspnforcedosd.networkmap}" var="dataMap" varStatus="s">
								  	<option value="${dataMap.key}" <c:if test="${dataMap.key == caspnforcedosd.netid}">selected</c:if>>${dataMap.value}</option>
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
				 <tr>
						<td align="right"><spring:message code="authorize.priority" />：</td>
						<td> 
							<select id="priority" name="priority" class="select">
				                <option value="0"><spring:message code="authorize.priority.0" /></option>
				                <option value="1"><spring:message code="authorize.priority.1" /></option>
				            	<option value="2"><spring:message code="authorize.priority.2" /></option>
				            	<option value="3"><spring:message code="authorize.priority.3" /></option>
				            </select>
						</td>
						<td align="right"><spring:message code="authorize.osd.showfreq"/>：</td>
						<td >
							<input name="showfreq" id="showfreq" class="easyui-numberspinner" value="${caspnforcedosd.showfreq==null?1:caspnforcedosd.showfreq}" data-options="min:1,increment:1" style="width:157px;"></input>
						</td>
				</tr>
				 <tr height="25px">
					    <td align="right" width="120px"><spring:message code="authorize.osd.displaystyle"/>：</td>
						<td>
							<select id="style" name="style" class="select" style="width:157px;" onchange="initStyleValue()">
									<option value="0" <c:if test="${caspnforcedosd.style== '0'}">selected</c:if>><spring:message code="authorize.forceosd.displaystyle.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.style== '1'}">selected</c:if>><spring:message code="authorize.forceosd.displaystyle.1"/></option>
									<option value="2" <c:if test="${caspnforcedosd.style== '2'}">selected</c:if>><spring:message code="authorize.forceosd.displaystyle.2"/></option>
 							</select>
						</td>
					   <td  class="sytle0_value" align="right" width="120px"><spring:message code="authorize.osd.scroll_direction"/>：</td>
					   <td  class="sytle0_value">
							<select id="scroll_direction" name="scroll_direction" class="select">
									<option value="1" <c:if test="${caspnforcedosd.scroll_direction== '1'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.1"/></option>
									<option value="2" <c:if test="${caspnforcedosd.scroll_direction== '2'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.2"/></option>
									<option value="3" <c:if test="${caspnforcedosd.scroll_direction== '3'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.3"/></option>
									<option value="4" <c:if test="${caspnforcedosd.scroll_direction== '4'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.4"/></option>
									<option value="5" <c:if test="${caspnforcedosd.scroll_direction== '5'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.5"/></option>
								    <option value="6" <c:if test="${caspnforcedosd.scroll_direction== '6'}">selected</c:if>><spring:message code="authorize.osd.scroll_direction.6"/></option>
							</select>
						</td>
						
						<td class="sytle1_value" align="right"><spring:message code="authorize.osd.coveragepercent"/>：</td>
						<td class="sytle1_value">
							<input name="scalerelativetoscreen" id="scalerelativetoscreen" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:10" value="${caspnforcedosd.scalerelativetoscreen}">
						</td>
				 </tr>
				<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.font"/>：</td>
						<td>
							<select id="font" name="font" class="select">
				                <option value="FF" <c:if test="${caspnforcedosd.font== 'FF'}">selected</c:if>><spring:message code="authorize.osd.font.FF" /></option>
				                <option value="00" <c:if test="${caspnforcedosd.font== '00'}">selected</c:if>><spring:message code="authorize.osd.font.00" /></option>
				            	<option value="01" <c:if test="${caspnforcedosd.font== '01'}">selected</c:if>><spring:message code="authorize.osd.font.01" /></option>
				            	<option value="02" <c:if test="${caspnforcedosd.font== '02'}">selected</c:if>><spring:message code="authorize.osd.font.02" /></option>
				            </select>
						</td>
						<td align="right"><spring:message code="authorize.osd.fontsize"/>：</td>
						<td><input name="fontsize" id="fontsize" class="easyui-numberspinner" value="${caspnforcedosd.fontsize==null?1:caspnforcedosd.fontsize}" data-options="min:0,increment:1" style="width:157px;"></input>
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
							<input name="foregroundtransparency" id="foregroundtransparency" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:0" value="${caspnforcedosd.foregroundtransparency}">
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
							<input name="backgroundtransparency" id="backgroundtransparency" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:0" value="${caspnforcedosd.backgroundtransparency}">
						</td>
				</tr>
				<tr height="40px">
					<td align="right"><spring:message code="authorize.osd.encodedmode"/>：</td>
					<td>
						<select  id="remark" name="remark" class="select">
							<option value="GB">GB2312</option>
							<option value="BE">UniCode-BE</option>
							<option value="LE">UniCode-LE</option>
						</select>
					</td>
				</tr>
				<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
						<textarea id="content" name="content" style="width:75%; height:100px;" onKeyDown="checkLength('content',100)" onKeyUp="checkLength('content',100)">${caspnforcedosd.content}</textarea> 
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
			
			if ($('#duration').val() == '') {
				$.dialog.tips('<spring:message code="authorize.duration.empty"/>',1, 'alert.gif');
				
				$('#duration').next('span').find('input').focus();
				//$('#duration').focus();
				return;
			}
			
			if ($('#showtimes').val() == '') {
				$.dialog.tips('<spring:message code="authorize.showtimes.empty"/>',1, 'alert.gif');
				$('#showtimes').next('span').find('input').focus();
				//$('#showtimes').focus();
				return;
			}
			
			if ($('#fontsize').val() == '') {
				$.dialog.tips('<spring:message code="authorize.fontsize.empty"/>',1, 'alert.gif');
				$('#fontsize').next('span').find('input').focus();
				//$('#fontsize').focus();
				return;
			}
			
			if ($('#showfreq').val() == '') {
				$.dialog.tips('<spring:message code="authorize.showfreq.empty"/>',1, 'alert.gif');
				$('#showfreq').next('span').find('input').focus();
				//$('#showfreq').focus();
				return;
			}
			
			var oldDuration = $("#duration").val();
			var oldShowtimes = $("#showtimes").val();
			$("#paramForm").attr("action", "cascommand/send_forcedosd");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_forcedosd_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
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
			//智能卡号长度大于10位,只取后10位有效位
			if(objectcode.length>10){
				objectcode = objectcode.substring(objectcode.length-10);
			}
			var temp_num = new Number(objectcode);
			//将智能卡号变成16进制，不足8位前面补0
			var objectcode_val = LPAD(temp_num.toString(16), 8);
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
	</script>
</body>
</html>