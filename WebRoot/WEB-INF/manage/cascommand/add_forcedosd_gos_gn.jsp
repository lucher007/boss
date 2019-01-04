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
		<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:100%; text-align:center">
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
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnforcedosd.versiontype }"/>
			<input type="hidden"  name="conditioncontent" id="conditioncontent" />
			<input type="hidden"  name="conditioncount" id="conditioncount" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caspnforcedosd.networkmap}" var="dataMap" varStatus="s">
								  	<option value="${dataMap.key}" <c:if test="${dataMap.key == caspnforcedosd.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
						<td align="right">ID：</td>
						<td >
							<input type="text" name="osdid" id="osdid" class="inp w200" value="${caspnforcedosd.osdid}" maxlength="9" onkeyup="value=value.replace(/[^0-9]/g,'')">
							<span class="red">*</span>
						</td>
					</tr>
					<tr height="25px">
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime" value="${expiredtime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'starttime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${caspnforcedosd.expiredtime}"/>
						</td>
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime" value="${starttime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',maxDate:'#F{$dp.$D(\'endtime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${caspnforcedosd.starttime}" />
						</td>
					</tr>
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.endtime"/>：</td>
						<td>
							<input type="text" id="endtime" name="endtime" value="${endtime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'starttime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${caspnforcedosd.endtime}"/>
						</td>
						<td align="right"><spring:message code="authorize.priority" />：</td>
						<td> 
							<select id="priority" name="priority" class="select">
				                <option value="0" <c:if test="${caspnforcedosd.priority== '0'}">selected</c:if>><spring:message code="authorize.priority.0" /></option>
				                <option value="1" <c:if test="${caspnforcedosd.priority== '1'}">selected</c:if>><spring:message code="authorize.priority.1" /></option>
				            	<option value="2" <c:if test="${caspnforcedosd.priority== '2'}">selected</c:if>><spring:message code="authorize.priority.2" /></option>
				            </select>
						</td>
					</tr>
				    <tr>
						<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
						<td align="right"><spring:message code="authorize.osd.font"/>：</td>
						<td><input name="font" id="font" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					</tr>
				    <tr height="25px">
						<td align="right"><spring:message code="authorize.osd.fontsize"/>：</td>
						<td><input name="fontsize" id="fontsize" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right" width="120px"><spring:message code="osd.display.cycle"/>：</td>
						<td >
							<input type="text" name="displayperiod" id="displayperiod" class="inp w200" value="${caspnforcedosd.displayperiod}" onkeyup="value=value.replace(/[^0-9]/g,'')">
						</td>
					</tr>
					<tr>
						<td align="right" width="120px"><spring:message code="osd.display.frequency"/>：</td>
						<td >
							<input type="text" name="displayfrequency" id="displayfrequency" class="inp w200" value="${caspnforcedosd.displayfrequency}" onkeyup="value=value.replace(/[^0-9]/g,'')">
						</td>
						<td align="right" width="120px"><spring:message code="osd.display.duration"/>：</td>
						<td >
							<input type="text" name="displaydurationtime" id="displaydurationtime" class="inp w200" value="${caspnforcedosd.displaydurationtime}" onkeyup="value=value.replace(/[^0-9]/g,'')">
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
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.forceosd.displaystyle"/>：</td>
						<td>
							<select id="display_style" name="display_style" class="select" style="width:157px;" onchange="initStyleValue()">
									<option value="000" <c:if test="${caspnforcedosd.display_style== '000'}">selected</c:if>><spring:message code="authorize.forceosd.display_style.000"/></option>
									<option value="001" <c:if test="${caspnforcedosd.display_style== '001'}">selected</c:if>><spring:message code="authorize.forceosd.display_style.001"/></option>
 							</select>
						</td>
						
<!-- 						<td  class="sytle0_value" align="right" width="120px"><spring:message code="authorize.osd.scrolldirection"/>：</td> -->
<!-- 						<td  class="sytle0_value"> -->
<!-- 							<select id="scrolldirection" name="scrolldirection" class="select"> -->
<!-- 									<option value="0000" <c:if test="${caspnforcedosd.stylevalue== '0000'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0000"/></option> -->
<!-- 									<option value="0001" <c:if test="${caspnforcedosd.stylevalue== '0001'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0001"/></option> -->
<!-- 									<option value="0010" <c:if test="${caspnforcedosd.stylevalue== '0010'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0010"/></option> -->
<!-- 									<option value="0011" <c:if test="${caspnforcedosd.stylevalue== '0011'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0011"/></option> -->
<!-- 							</select> -->
<!-- 						</td> -->
						<td class="sytle1_value" align="right"><spring:message code="authorize.osd.coveragepercent"/>：</td>
						<td class="sytle1_value">
							<input name="screencoveragepercentage" id="screencoveragepercentage" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:10" value="${caspnforcedosd.screencoveragepercentage}">
						</td>
					</tr>
				    <tr height="25px" class="sytle0_value">
					    	<td  class="sytle0_value" align="right" width="120px"><spring:message code="authorize.osd.scrolldirection"/>：</td>
							<td  class="sytle0_value">
								<select id="scrolldirection" name="scrolldirection" class="select">
										<option value="0" <c:if test="${caspnforcedosd.scrolldirection== '0'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0000"/></option>
										<option value="1" <c:if test="${caspnforcedosd.scrolldirection== '1'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0001"/></option>
										<option value="2" <c:if test="${caspnforcedosd.scrolldirection== '2'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0002"/></option>
										<option value="3" <c:if test="${caspnforcedosd.scrolldirection== '3'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0003"/></option>
										<option value="4" <c:if test="${caspnforcedosd.scrolldirection== '4'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0010"/></option>
										<option value="5" <c:if test="${caspnforcedosd.scrolldirection== '5'}">selected</c:if>><spring:message code="authorize.osd.scrolldirection.0011"/></option>
								</select>
							</td>
<!-- 		       		  	<td align="right"><spring:message code="authorize.osd.displayfrequency"/>：</td> -->
<!-- 						<td > -->
<!-- 							<input type="text" name="displayfrequency" id="displayfrequency" class="inp w200"  value="${caspnforcedosd.displayfrequency}"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"/> -->
<!-- 						</td> -->
<!-- 						<td align="right"><spring:message code="authorize.osd.positionx"/>：</td> -->
<!-- 						<td> -->
<!-- 							<input type="text" name="positionx" id="positionx" class="inp w200"  value="${caspnforcedosd.positionx}"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"/> -->
<!-- 						</td> -->
						<td align="right"><spring:message code="authorize.osd.barheight"/>：</td>
						<td>
							<input type="text" name="barheight" id="barheight" class="inp w200"  value="${caspnforcedosd.barheight}"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
						</td>
				    </tr>
<!-- 				   	<tr  height="25px" class="sytle0_value"> -->
<!-- 		       		  	<td align="right"><spring:message code="authorize.osd.positiony"/>：</td> -->
<!-- 						<td > -->
<!-- 							<input type="text" name="positiony" id="positiony" class="inp w200"  value="${caspnforcedosd.positiony}"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"/> -->
<!-- 						</td> -->
<!-- 						<td align="right"><spring:message code="authorize.osd.barheight"/>：</td> -->
<!-- 						<td> -->
<!-- 							<input type="text" name="barheight" id="barheight" class="inp w200"  value="${caspnforcedosd.barheight}"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"/> -->
<!-- 						</td> -->
<!-- 				    </tr> -->
				    <tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.osd.cardiddisplayflag"/>：</td>
						<td>
							<select id="cardiddisplayflag" name="cardiddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.cardiddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.cardiddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.cardiddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.cardiddisplayflag.1"/></option>
 							</select>
						</td>
						
						<td align="right" width="120px"><spring:message code="osd.areaiddisplayflag"/>：</td>
						<td >
							<select id="areaiddisplayflag" name="areaiddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.areaiddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.terminaliddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.areaiddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.terminaliddisplayflag.1"/></option>
 							</select>
						</td>
					</tr>
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.osd.operatoriddisplayflag"/>：</td>
						<td>
							<select id="operatoriddisplayflag" name="operatoriddisplayflag" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.operatoriddisplayflag== '0'}">selected</c:if>><spring:message code="authorize.osd.operatoriddisplayflag.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.operatoriddisplayflag== '1'}">selected</c:if>><spring:message code="authorize.osd.operatoriddisplayflag.1"/></option>
 							</select>
						</td>
						
						<td align="right" width="120px"><spring:message code="authorize.osd.privatecontentflag"/>：</td>
						<td >
							<select id="privatecontentflag" name="privatecontentflag" class="select" style="width:157px;" onchange="displayContentFlag();">
								<option value="1" <c:if test="${caspnforcedosd.privatecontentflag== '1'}">selected</c:if>><spring:message code="authorize.osd.privatecontentflag.1"/></option>
								<option value="0" <c:if test="${caspnforcedosd.privatecontentflag== '0'}">selected</c:if>><spring:message code="authorize.osd.privatecontentflag.0"/></option>
 							</select>
						</td>
					</tr>
					<tr height="25px">
						<td align="right"><spring:message code="osd.display.programID"/>：</td>
						<td>
							<input type="text" style="width: 400px;" name="serviceid" id="serviceid" class="inp w200"  value="${caspnforcedosd.serviceid}" placeholder="1,2,3...."/>
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
				    <tr height="25px" class="display_content_1">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="content" name="content" style="width:75%; height:100px;" onKeyDown="checkLength('content',100)" onKeyUp="checkLength('content',100)">${caspnforcedosd.content}</textarea> 
							<span class="red">
								<spring:message code="page.can.input" /> <span id="validNumcontent">100</span> <spring:message code="page.word" />
							</span>
						</td>
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
			
			if ($('#osdid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.newosd.empty"/>',1, 'alert.gif');
				$('#osdid').focus();
				return;
			}
			
			if ($('#font').val() < 1 || $('#font').val() > 255) {
				$.dialog.tips('<spring:message code="newfinger.diaplay.fonttype.range"/>',1, 'alert.gif');
				$('#font').focus();
				return;
			}
			
			if ($('#fontsize').val() < 1 || $('#fontsize').val() > 255) {
				$.dialog.tips('<spring:message code="newfinger.diaplay.fontsize.range"/>',1, 'alert.gif');
				$('#fontsize').focus();
				return;
			}
			
			if ($('#displayperiod').val() <10 || $('#displayperiod').val() > 86400) {
				$.dialog.tips('<spring:message code="osd.display.cycle.range"/>',1, 'alert.gif');
				$('#displayperiod').focus();
				return;
			}
			
			if ($('#displaydurationtime').val() <10 || $('#displaydurationtime').val() > 255) {
				$.dialog.tips('<spring:message code="osd.display.duration.range"/>',1, 'alert.gif');
				$('#displaydurationtime').focus();
				return;
			}
			
			if ($('#barheight').val() <10 || $('#barheight').val() > 255) {
				$.dialog.tips('<spring:message code="osd.display.barheight.range"/>',1, 'alert.gif');
				$('#barheight').focus();
				return;
			}
			
			if ($('#displayfrequency').val() == '') {
				$.dialog.tips('<spring:message code="osd.display.frequency.empty"/>',1, 'alert.gif');
				$('#displayfrequency').focus();
				return;
			}
			
			if ($('#displaydurationtime').val() == '') {
				$.dialog.tips('<spring:message code="osd.display.duration.empty"/>',1, 'alert.gif');
				$('#displaydurationtime').focus();
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
			if ($('#endtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.endtime.empty"/>',1, 'alert.gif');
				$('#endtime').focus();
				return;
			}
			
			var serviceids = $('#serviceid').val();
			if (serviceids!="") {
				var serviceArr = serviceids.split(',');
				for ( var int = 0; int < serviceArr.length; int++) {
					var ele = serviceArr[int];
					var reg = new RegExp("^[0-9]*$");
					if (!reg.test(ele) || ele > 65535) {
						$.dialog.tips('<spring:message code="osd.serviceid.format"/>',1, 'alert.gif');
						return;
					}
				}
			}
			
			$("#paramForm").attr("action", "cascommand/send_forcedosd");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_forcedosd_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
			initStyleValue();
			displayContentFlag();
			var returninfo = '${caspnforcedosd.returninfo}';
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
		
		function initStyleValue() {
			if ($("#display_style").val() == 0) {
				$(".sytle0_value").show();
				$(".sytle1_value").hide();
			} else {
				$(".sytle1_value").show();
				$(".sytle0_value").hide();
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