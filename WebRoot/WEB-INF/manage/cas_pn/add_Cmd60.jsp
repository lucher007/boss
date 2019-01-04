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
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.newshowfinger"/>(<spring:message code="server.versiontype.gos_pn" />)</div>
				<div style="margin:20px 0;"></div>
				<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:1000px; text-align:center">
					<table id="appendtr" width="100%" cellpadding="5">
					<tr height="40px">
						<td colspan="4" align="center">
								<spring:message code="authorize.condition"/>
						</td>
						<td align="center">
								<spring:message code="page.operate"/>
						</td>
					</tr>
						</table>
				</div>    <!--  //end condition cmd -->
		
		<div style="margin:20px 0;"></div>
		
		<div class="easyui-panel" title="<spring:message code="authorize.add.condition"/>" style="width:1000px">
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
			<!-- 	页面上转换好的16进制CONDITION命令 -->			
 			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:1000px">
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
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td>
							<input type="text" id="starttime" name="starttime" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});" class="Wdate inp w150" value="${caspnforcedosd.starttime}" />
						</td>
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td>
							<input type="text" id="expiredtime" name="expiredtime" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});" class="Wdate inp w150" value="${caspnforcedosd.expiredtime}"/>
						</td>
					</tr>
					
					<tr height="40px">
					  	<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedosd.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${caspnforcedosd.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
					  </tr>
					  
				  <tr height="40px">
						<td align="right"><spring:message code="authorize.osd.showtimelen"/>：</td>
						<td>
							<input name="duration" id="duration" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						<td align="right"><spring:message code="authorize.osd.showtimes"/>：</td>
						<td>
							<input name="showtimes" id="showtimes" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
				  </tr>
					  
				  <tr height="40px">
				 		<td align="right"><spring:message code="authorize.interval"/>：</td>
						<td>
							<input name="intervaltime" id="intervaltime" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
						
						<td align="right"><spring:message code="authorize.showfreq"/>：</td>
						<td>
							<input name="showfreq" id="showfreq" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
				  </tr>
					  
				  <tr height="40px">
					  	<td align="right"><spring:message code="authorize.osd.fontsize"/>：</td>
						<td>
							<input name="fontsize" id="fontsize" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
						</td>
					  	<td align="right" width="120px"><spring:message code="authorize.fontcolor"/>：</td>
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
						<td align="right" width="120px"><spring:message code="authorize.osd.backgroundcolor"/>：</td>
						<td>
							<input type="text" id="backgroundcolordisplay" style="width:70px;background-color:#0000ff" class="inp backgroundcolorCss"/>
							<input type="text" id="backgroundcolor" name="backgroundcolor" value="0000ff" style="width:70px;" class="inp backgroundcolorCss"/>
						</td>
						<td align="right"><spring:message code="authorize.osd.backgroundtransparency"/>：</td>
						<td >
							<input name="backgroundtransparency" id="backgroundtransparency" class="easyui-slider" style="width:157px;" data-options="showTip:true, min:0" value="${caspnforcedosd.backgroundtransparency}">
						</td>
					
						<td align="right"><spring:message code="authorize.postype"/>：</td>
						<td>
							<select id="postype" name="postype" class="select" onchange="initPosType()">
									<option value="0" <c:if test="${caspnnewfinger.postype== '0'}">selected</c:if>><spring:message code="authorize.postype.0"/></option>
									<option value="1" <c:if test="${caspnnewfinger.postype== '1'}">selected</c:if>><spring:message code="authorize.postype.1"/></option>
									<option value="2" <c:if test="${caspnnewfinger.postype== '2'}">selected</c:if>><spring:message code="authorize.postype.2"/></option>
							</select>
						</td>
					</tr>
					
					<tr class="pos" height= "40px">
						<td align="right"><spring:message code="authorize.osd.positionx"/>：</td>
						<td><input name="posx" id="posx" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input></td>
						<td align="right"><spring:message code="authorize.osd.positiony"/>：</td>
						<td><input name="posy" id="posy" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input></td>
					 </tr>
					  
					<tr height="40px">
						  	<td align="right"><spring:message code="authorize.showtype"/>：</td>
							<td>
								<select id="showtype" name="showtype" class="select">
										<option value="00" <c:if test="${caspnnewfinger.showtype== '00'}">selected</c:if>><spring:message code="authorize.showtype.00"/></option>
										<option value="01" <c:if test="${caspnnewfinger.showtype== '01'}">selected</c:if>><spring:message code="authorize.showtype.01"/></option>
										<option value="03" <c:if test="${caspnnewfinger.showtype== '03'}">selected</c:if>><spring:message code="authorize.showtype.03"/></option>
								</select>
							</td>
							<td align="right"><spring:message code="authorize.idtype"/>：</td>
							<td>
								<select id="idtype" name="idtype" class="select">
										<option value="00" <c:if test="${caspnnewfinger.idtype== '00'}">selected</c:if>><spring:message code="authorize.idtype.00"/></option>
										<option value="01" <c:if test="${caspnnewfinger.idtype== '01'}">selected</c:if>><spring:message code="authorize.idtype.01"/></option>
										<option value="02" <c:if test="${caspnnewfinger.idtype== '02'}">selected</c:if>><spring:message code="authorize.idtype.02"/></option>
										<option value="03" <c:if test="${caspnnewfinger.idtype== '03'}">selected</c:if>><spring:message code="authorize.idtype.03"/></option>
										<option value="04" <c:if test="${caspnnewfinger.idtype== '04'}">selected</c:if>><spring:message code="authorize.idtype.04"/></option>
										<option value="05" <c:if test="${caspnnewfinger.idtype== '05'}">selected</c:if>><spring:message code="authorize.idtype.05"/></option>
								</select>
							</td>
					</tr>
					<tr height="25px" class="display_content_1">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="content" name="content" style="width:75%; height:30px;" onKeyDown="checkLength('content',16)" onKeyUp="checkLength('content',16)">${caspnforcedosd.content}</textarea> 
							<span class="red"><spring:message code="page.can.input" /> <span id="validNumcontent">16</span> <spring:message code="page.word" />
						</span></td>
					</tr>
					<tr height="40px">
						<td align="right"><spring:message code="authorize.channelids"/>：</td>
						<td>
								<input name="channelid" id="channelid" class="inp" style="float:left" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" ></input>
								<a href="javascript:void(0)" style="float:right" class="easyui-linkbutton" onclick="addChannel()"><spring:message code="authorize.addchannel"/></a>
						</td>
				
						<td>
								<input type="hidden" name="channelids" id="channelids" readonly="readonly" class="inp"></input>
						</td>
					</tr>
				</table>
				
				<table id="appendchannel" width="75%" cellpadding="2">
						<tr height="40px">
							<td align="center" width="80%"><spring:message code="authorize.channelids"/></td>
							<td align="center" width="20%"><spring:message code="page.operate"/></td>
						</tr>
				</table>
				
				<div align="center">
					<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="page.goback"/></a>
					<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
				</div>
			
			</div>
		</form>
	
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript">
	
		function addChannel(){
			if ($('#channelid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.channelid.empty"/>',1, 'alert.gif');
				$('#channelid').focus();
				return;
			}
			var channelid = $('#channelid').val();
			var channelidToAppend = '<tr><td class="channels" align="center">'
					+ channelid +   '</td><td align="center"><a class="red" href="javascript:void(0);" onclick="deleteChannel(this)"><spring:message code="page.delete"/></a></td></tr>';
			$('#appendchannel').append(channelidToAppend);
			updateChannelids();
		}
		
		function updateChannelids(){
			var channelids = "";
			$(".channels").each(function(i) {
					if(i==0){
						channelids = channelids + $(this).text();
					}else{
						channelids = channelids +  "," + $(this).text();
					}
				});
			$("#channelids").val(channelids);
			//alert($("#channelids").val());
		}

		function initPosType(){
			if($("#postype").val() == "1"){
			$(".pos").show();
			}else{
			$(".pos").hide();
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
			if ($('#channelids').val() == '') {
				$.dialog.tips('<spring:message code="authorize.endtime.empty"/>',1, 'alert.gif');
				$('#channelid').focus();
				return;
			}
			$("#paramForm").attr("action", "cas_pn/send_Cmd60");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm").attr("action", "cas_pn/find_Cmd60_List");
			$("#paramForm").submit();
		}

		$(function() {
		initNetwork();
			initPosType();
			var returninfo = '${caspnnewfinger.returninfo}';
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
		
		
		function deleteChannel(delObj){
		$(delObj).parents('tr').remove();
		updateChannelids();
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
		
		// 颜色设置函数
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