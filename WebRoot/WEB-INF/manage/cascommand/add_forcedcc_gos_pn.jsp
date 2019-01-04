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
		
		<div style="margin:20px 0;"></div>
		
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

		<div style="margin:20px 0;"></div>

		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnforcedcc.versiontype }"/>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caspnforcedcc.networkmap}" var="dataMap" varStatus="s">
								  	<option value="${dataMap.key}" <c:if test="${dataMap.key == caspnforcedcc.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
					</tr>
				
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime" value="${starttime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',maxDate:'#F{$dp.$D(\'expiredtime\');}'});"
							class="Wdate inp w150" value="${caspnforcedcc.starttime}" />
						</td>
						
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime" value="${expiredtime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'starttime\');}'});"
							class="Wdate inp w150" value="${caspnforcedcc.expiredtime}"/>
						</td>
					
						<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${caspnforcedcc.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${caspnforcedcc.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
					</tr>
				 
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.forcedcc.stbtype"/>：</td>
						<td>
							<select id="stbtype" name="stbtype" class="select" style="width:157px;" onchange="initStbtype();">
									<option value="00" <c:if test="${caspnforcedcc.stbtype== '00'}">selected</c:if>><spring:message code="DVB-C"/></option>
									<option value="01" <c:if test="${caspnforcedcc.stbtype== '01'}">selected</c:if>><spring:message code="DVB-S"/></option>
 							</select>
						</td>

						<td align="right"><spring:message code="authorize.forcedcc.serviceid"/>：</td>
						<td>
					          <input type="text" class="inp" name="serviceid" id="serviceid" value="" maxlength="5" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
						</td>
						<td align="right"><spring:message code="authorize.forcedcc.pcrpid"/>：</td>
						<td>
							<input name="pcrpid" id="pcrpid" class="easyui-numberspinner" value="${stbdefaultmsg.pcrpid }" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
				</tr>
				
				</table>
			</div>
		
			<div style="margin:20px 0;"></div>
		
	<div class="easyui-panel" title="<spring:message code="authorize.forcedcc.addstream"/>" style="width:100%">
				<table width="100%">
					<tr height="25px">
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.streamcontent"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.comptype"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.compid"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.ecmpid"/></td>
					</tr>
					
					<tr height="25px">
						<td align="center">
							<select name="streamcontent">
									<option value="02"><spring:message code="AUDIO"/></option>
							</select>
						</td>
						
						<td align="center">
							<select name="comptype">
									<option value="01"><spring:message code="MPEG-1_LAYER_2_AUDIO"/></option>
							</select>
						</td>
						
						<td align="center">
 							<input name="compid" id="audio_compid" class="easyui-numberspinner" value="0" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
						
						<td align="center">
 						 	<input name="ecmpid" id="audio_ecmpid" class="easyui-numberspinner" value="0" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
					</tr>
					
					<tr height="25px">
						<td align="center">
							<select name="streamcontent">
									<option value="01"><spring:message code="VIDEO"/></option>
							</select>
						</td>
						
						<td align="center">
							<select name="comptype">
									<option value="01"><spring:message code="MPEG1_VIDEO_STREAM"/></option>
		 							<!-- 	
		 									<option value="02"><spring:message code="MPEG2_VIDEO_STREAM"/></option>
											<option value="03"><spring:message code="MPEG1_AUDIO_STREAM"/></option>
											<option value="04"><spring:message code="MPEG2_AUDIO_STREAM"/></option>
											<option value="06"><spring:message code="PRIVATE_DATA_STREAM"/></option>
											<option value="0f"><spring:message code="MPEG_ADTS_AAC_STREAM"/></option>
											<option value="10"><spring:message code="MPEG4_VIDEO_STREAM"/></option>
											<option value="11"><spring:message code="MPEG_AAC_STREAM"/></option>
											<option value="1b"><spring:message code="H264_VIDEO_STREAM"/></option>
											<option value="80"><spring:message code="DC_II_VIDEO_STREAM"/></option>
											<option value="81"><spring:message code="AC3_AUDIO_STREAM"/></option>
										--> 
							</select>
						</td>
						
						<td align="center">
					 		<input name="compid" id="video_compid" class="easyui-numberspinner" value="0" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
						
						<td align="center">
 							<input name="ecmpid" id="video_ecmpid" class="easyui-numberspinner" value="0" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
					</tr>
				</table>
				
				<!-- 	<div style="text-align:center;padding:5px">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addComponent()"><spring:message code="authorize.forcedcc.addstream"/></a> 
						</div> -->
			</div>
		

			<div style="margin:20px 0;"></div>
			<div id="dvb-c">
				<div class="easyui-panel" title="<spring:message code="DVB-C"/>" style="width:100%">
				<table width="100%">
						<tr height="25px">
	 					  	<td align="right"><spring:message code="authorize.forcedcc.frequency" />(MHZ 0~9999.9999)：</td>
							<td>
								<input name="frequency_c" id="frequency_c" class="easyui-numberspinner" value="0" data-options="precision:4,min:0,max:9999.9999,increment:0.0001" style="width:157px;"></input>
							</td>
							<td align="right"><spring:message code="authorize.forcedcc.fecouter" />：</td>
							<td>
								<select id="fecouter_c" name="fecouter_c" class="select" style="width:157px;">
										<option value="0000"><spring:message code="authorize.forcedcc.fecouter.0000"/></option>
										<option value="0001"><spring:message code="authorize.forcedcc.fecouter.0001"/></option>
										<option value="0010"><spring:message code="RS(204/188)"/></option>
	 							</select>
						 	</td>
						</tr>
						
						<tr height="25px">
							<td align="right"><spring:message code="authorize.forcedcc.modulation" />：</td>
							<td>
								<select id="modulation_c" name="modulation_c" class="select" style="width:157px;">
										<option value="00"><spring:message code="authorize.forcedcc.fecouter.0000"/></option>
										<option value="01"><spring:message code="16QAM"/></option>
										<option value="02"><spring:message code="32QAM"/></option>
										<option value="03"><spring:message code="64QAM"/></option>
										<option value="04"><spring:message code="128QAM"/></option>
										<option value="05"><spring:message code="256QAM"/></option>
	 							</select>
							</td>
							<td align="right"><spring:message code="authorize.forcedcc.symbolrate" /> (M Baud 0~999.9999)：</td>
							<td>
								<input name="symbolrate_c" id="symbolrate_c" class="easyui-numberspinner" value="0" data-options="precision:4,min:0,max:999.9999,increment:0.0001" style="width:157px;"></input>
							</td>
						</tr>
						
						<tr height="25px">
							<td align="right"><spring:message code="authorize.forcedcc.fecinner" />：</td>
							<td>
									<select id="fecinner_c" name="fecinner_c" class="select" style="width:157px;">
											<option value="0000" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.undefined"/></option>
											<option value="0001" <c:if test="${caspnforcedcc.stbtype== '1'}">selected</c:if>><spring:message code="authorize.forcedcc.convolutional_rate"/>1/2</option>
											<option value="0010" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.convolutional_rate"/>2/3</option>
											<option value="0011" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.convolutional_rate"/>3/4</option>
											<option value="0100" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.convolutional_rate"/>5/6</option>
											<option value="0101" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.convolutional_rate"/>7/8</option>
											<option value="1111" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="authorize.forcedcc.non_convolutional_rate"/></option>
		 							</select>
							</td>
						</tr>
						
					</table>
				</div>
			</div>
			
			<div id="dvb-s">
				<div class="easyui-panel" title="<spring:message code="DVB-S"/>" style="width:100%">
				<table width="100%">
						<tr height="25px">
							<!-- 
							<td align="right"><spring:message code="reserved_dvbs" />：</td>
							 -->
							<td align="right"><spring:message code="authorize.forcedcc.frequency" /> (GHz 0~999.99999)：</td>
							<td>
								<input name="frequency_s" id="frequency_s" class="easyui-numberspinner" value="0" data-options="precision:5,min:0,max:999.99999,increment:0.00001" style="width:157px;"></input>
							</td>
							<td align="right"><spring:message code="authorize.forcedcc.orbitalposition"/>：</td>
							<td>
								<input name="orbital_position" id="orbital_position" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
							</td>
						</tr>
						
						<tr height="25px">
							<td align="right"><spring:message code="authorize.forcedcc.westeastflag"/>：</td>
							<td>
								<select id="west_east_flag" name="west_east_flag" class="select" style="width:157px;">
										<option value="0"><spring:message code="western position"/></option>
										<option value="1"><spring:message code="eastern position"/></option>
	 							</select>
							</td>
							<td align="right"><spring:message code="authorize.forcedcc.polarization"/>：</td>
							<td>
								<select id="polarization" name="polarization" class="select" style="width:157px;">
										<option value="00"><spring:message code="Linear - horizontal"/></option>
										<option value="01"><spring:message code="Linear - vertical"/></option>
										<option value="10"><spring:message code="Circular - left"/></option>
										<option value="11"><spring:message code="Circular - right"/></option>
	 							</select>
							</td>
						</tr>
						
						<tr height="25px">
							<td align="right"><spring:message code="authorize.forcedcc.modulation" />：</td>
							<td>
								<select id="modulation_s" name="modulation_s" class="select" style="width:157px;">
										<option value="00"><spring:message code="Auto"/></option>
										<option value="01"><spring:message code="QPSK"/></option>
										<option value="10"><spring:message code="8PSK"/></option>
										<option value="11"><spring:message code="16-QAM"/></option>
	 							</select>
							</td>
							<td align="right"><spring:message code="authorize.forcedcc.symbolrate" />：</td>
							<td>
								<input name="symbolrate_s" id="symbolrate_s" class="easyui-numberspinner" value="0" data-options="increment:1" style="width:157px;"></input>
							</td>
						</tr>
						
						<tr height="25px">
							<td align="right"><spring:message code="authorize.forcedcc.fecinner" />：</td>
							<td>
									<select id="fecinner_s" name="fecinner_s" class="select" style="width:157px;">
											<option value="0000" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="未定义"/></option>
											<option value="0001" <c:if test="${caspnforcedcc.stbtype== '1'}">selected</c:if>><spring:message code="卷积码率1/2"/></option>
											<option value="0010" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="卷积码率2/3"/></option>
											<option value="0011" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="卷积码率3/4"/></option>
											<option value="0100" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="卷积码率5/6"/></option>
											<option value="0101" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="卷积码率7/8"/></option>
											<option value="1111" <c:if test="${caspnforcedcc.stbtype== '0'}">selected</c:if>><spring:message code="无卷积编码"/></option>
		 							</select>
							</td>
						</tr>
					</table>
				</div>
			</div>
				
		<%-- 	<div style="margin:20px 0;"></div>
			<div class="easyui-panel" title="<spring:message code="authorize.forcedcc.addstream"/>" style="width:950px">
				<table width="100%">
					<tr height="25px">
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.streamcontent"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.comptype"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.compid"/></td>
							<td align="center" width="25%"><spring:message code="authorize.forcedcc.ecmpid"/></td>
					</tr>
					
					<tr height="25px">
						<td align="center">
						<select id="add_streamcontent">
									<option value="1"><spring:message code="VIDEO"/></option>
									<option value="2"><spring:message code="AUDIO"/></option>
							</select>
						</td>
						
						<td align="center">
							<select id="add_comptype">
									<option value="01"><spring:message code="MPEG1_VIDEO_STREAM"/></option>
									<option value="02"><spring:message code="MPEG2_VIDEO_STREAM"/></option>
									<option value="03"><spring:message code="MPEG1_AUDIO_STREAM"/></option>
									<option value="04"><spring:message code="MPEG2_AUDIO_STREAM"/></option>
									<option value="06"><spring:message code="PRIVATE_DATA_STREAM"/></option>
									<option value="0f"><spring:message code="MPEG_ADTS_AAC_STREAM"/></option>
									<option value="10"><spring:message code="MPEG4_VIDEO_STREAM"/></option>
									<option value="11"><spring:message code="MPEG_AAC_STREAM"/></option>
									<option value="1b"><spring:message code="H264_VIDEO_STREAM"/></option>
									<option value="80"><spring:message code="DC_II_VIDEO_STREAM"/></option>
									<option value="81"><spring:message code="AC3_AUDIO_STREAM"/></option>
							</select>
						</td>
						
						<td align="center">
								<input type="text" class="inp w200" name="add_compid" id="add_compid" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
						</td>
						
						<td align="center">
								<input type="text" class="inp w200" name="add_ecmpid" id="add_ecmpid" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
						</td>
					
					</tr>
				</table>
				
				<div style="text-align:center;padding:5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addComponent()"><spring:message code="authorize.forcedcc.addstream"/></a> 
				</div>
			
			</div>
		
			<div style="margin:20px 0;"></div>
			
			<div class="easyui-panel" title="<spring:message code="authorize.forcedcc.streaminfo"/>" style="width:950px; text-align:center">
					<table width="100%" id="appendComponent">
					<tr height="25px">
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.streamcontent"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.comptype"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.compid"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.ecmpid"/></td>
							<td align="center" width="20%"><spring:message code="page.operate"/></td>
					</tr>
					</table>
			</div>    <!--  //end condition cmd -->			 --%>
			
			<div style="margin:20px 0;"></div>
			<div align="center">
				<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="page.goback"/></a>
				<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
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
	    function initStbtype() {
			if ($("#stbtype").val() == 0) {
				$("#dvb-c").show();
				$("#dvb-s").hide();
			} else {
				$("#dvb-s").show();
				$("#dvb-c").hide();
			}
		}

		var componentFlag = 0;
		function addComponent() {
			/******************* 条件检查 *******************/
			if ($('#add_compid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.compid.empty"/>',1, 'alert.gif');
				$('#add_compid').focus();
				return;
			}
			if ($('#add_ecmpid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.ecmpid.empty"/>',1, 'alert.gif');
				$('#add_ecmpid').focus();
				return;
			}
			
			/******************* 拼接命令 *******************/
			var add_streamcontent = $("#add_streamcontent").find("option:selected").text();
			var add_comptype = $("#add_comptype").find("option:selected").text();
			var add_compid = $("#add_compid").val();
			var add_ecmpid = $("#add_ecmpid").val();
			
			var streamcontent_val = $("#add_streamcontent").val();
			var comptype_val = $("#add_comptype").val();
			var compid_val = $("#add_compid").val();
			var ecmpid_val = $("#add_ecmpid").val();
			
			var componentToAppend = '<tr height="25px"><td align="center">'
					+ add_streamcontent
					+ '<input type="hidden" name="streamcontent" value="'  + streamcontent_val +   '"></td><td align="center">'
					+ add_comptype
					+ '<input type="hidden" name="comptype" value="'  + comptype_val +   '"></td><td align="center">'
					+ add_compid
					+ '<input type="hidden" name="compid" value="'  + compid_val +   '"></td><td align="center">'
					+ add_ecmpid
					+ '<input type="hidden" name="ecmpid" value="'  + ecmpid_val +   '"></td><td align="center"><a class="red" href="javascript:void(0);" onclick="deleteComponent(this)"><spring:message code="page.delete"/></a></td></tr>';
			$('#appendComponent').append(componentToAppend);
			componentFlag++;
		}

		function deleteComponent(delObj) {
			$(delObj).parents('tr').remove();
			componentFlag--;
		}

		function goSend() {
		 	if ($('#conditioncontent').val() == '') {
				$.dialog.tips('<spring:message code="authorize.conditioncontent.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#starttime').val() == '') {
					$.dialog.tips(
							'<spring:message code="authorize.starttime.empty"/>',
							1, 'alert.gif');
					$('#starttime').focus();
					return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips(
						'<spring:message code="authorize.endtime.empty"/>', 1,
						'alert.gif');
				$('#expiredtime').focus();
				return;
			}
			if ($('#serviceid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.serviceid.empty"/>', 1,
						'alert.gif');
				$('#serviceid').focus();
				return;
			}
			if ($('#pcrpid').val() == '') {
				$.dialog.tips('<spring:message code="authorize.pcrpid.empty"/>', 1,
						'alert.gif');
				$('#pcrpid').focus();
				return;
			}
			if ($('#audio_compid').val() == '') {
		$.dialog.tips('<spring:message code="authorize.compid.empty"/>',1, 'alert.gif');
		$('#audio_compid').focus();
		return;
		}
		if ($('#video_compid').val() == '') {
		$.dialog.tips('<spring:message code="authorize.compid.empty"/>',1, 'alert.gif');
		$('#video_compid').focus();
		return;
		}	
		if ($('#video_ecmpid').val() == '') {
		$.dialog.tips('<spring:message code="authorize.ecmpid.empty"/>',1, 'alert.gif');
		$('#video_ecmpid').focus();
		return;
		}	
		if ($('#audio_ecmpid').val() == '') {
		$.dialog.tips('<spring:message code="authorize.ecmpid.empty"/>',1, 'alert.gif');
		$('#audio_ecmpid').focus();
		return;
		}
			$("#paramForm").attr("action", "cascommand/send_forcedcc");
			$("#paramForm").submit();
		}

		function goBack() {
			$("#paramForm", parent.document).attr("action", "cascommand/find_forcedcc_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
			initStbtype();
			var returninfo = '${caspnforcedcc.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

		function addCondition() {
			/******************* 条件检查 *******************/
			if ($('#objectcode').val() == '') {
				$.dialog
						.tips(
								'<spring:message code="authorize.seekingobject.empty"/>',
								1, 'alert.gif');
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
	</script>
</body>
</html>