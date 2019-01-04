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
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
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
		<div style="margin:10px 0;"></div>
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<input type="hidden" name="versiontype" id="versiontype" value="${stbdefaultmsg.versiontype }"/>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:950px">
				<table width="100%">
				<tr height="25px">
					<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
					<%-- <td width="25%">
						  <select id="netid" name="netid" class="select">
							<c:forEach items="${stbdefaultmsg.networkmap}" var="dataMap" varStatus="s">
							  	<option value="${dataMap.key}" <c:if test="${dataMap.key == stbdefaultmsg.netid}">selected</c:if>>${dataMap.value}</option>
							</c:forEach>
						  </select>
					</td> --%>
					<td align="left" width="25%">
						 <input id="netid" name="netid" style="width: 157px;">
					</td>
					<td align="right" width="120px"><spring:message code="user.terminaltype"/>：</td>
					<td>
						<select id="card_or_stb_tag" name="card_or_stb_tag" class="select" style="width:157px;" onchange="InitCard_or_stb_tag();">
								<option value="00" <c:if test="${stbdefaultmsg.card_or_stb_tag== '00'}">selected</c:if>><spring:message code="user.terminaltype.1"/></option>
								<option value="01" <c:if test="${stbdefaultmsg.card_or_stb_tag== '01'}">selected</c:if>><spring:message code="user.terminaltype.0"/></option>
							</select>
					</td>
				</tr>
				
				<tr id="card" height="25px">
						<td align="right"><spring:message code="authorize.card.target" />：</td>
						<td> 
							<select id="cardid_option" name="cardid_option" class="select" onchange="cardid_optionInit();">
				                   <option value="0"><spring:message code="authorize.card.target.0" /></option>
				                   <option value="1"><spring:message code="authorize.card.target.1" /></option>
				             </select>
						</td>
						<td align="right" class="inputcard"><spring:message code="card.cardid" />：</td>
						<td class="inputcard">
							<input type="text" class="inp w200" name="cardid" id="cardid" value="${stbdefaultmsg.cardid }" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
						</td>
				</tr>
				
				<tr id="stb" height="25px">
						<td align="right"><spring:message code="authorize.stb.target" />：</td>
						<td> 
							<select id="stbno_option" name="stbno_option" class="select" onchange="stbno_optionInit();">
				                   <option value="0"><spring:message code="authorize.stb.target.0" /></option>
				                   <option value="1"><spring:message code="authorize.stb.target.1" /></option>
				             </select>
						</td>
						<td align="right" class="inputstb"><spring:message code="stb.stbno" />：</td>
						<td class="inputstb">
							<input type="text" class="inp w200" name="stbno" id="stbno" value="${stbdefaultmsg.stbno }" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')">
						</td>
				</tr>

				<tr id="area" height="25px">
						<td align="right"><spring:message code="authorize.area.target"/>：</td>
						<td> 
							<select id="areacode_option" name="areacode_option" onchange="areacode_optionInit();" class="select">
				                   <option value="0"><spring:message code="authorize.area.target.0" /></option>
				                   <option value="1"><spring:message code="authorize.area.target.1" /></option>
				             </select>
						</td>
					
						<td align="right" class="inputarea"><spring:message code="area.areacode" />：</td>
						<td colspan="2" class="inputarea">
							<input id="areano" name="areano" style="width: 157px;">
							<%-- <input type="text" class="inp w200" name="areano" id="areano" value="${stbdefaultmsg.areano }"  maxlength="5"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" > --%>
<%-- 							<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseArea();">
 --%>						
                      </td>
					</tr>
					
					<tr height="25px">
						<td align="right"><spring:message code="authorize.osd.exptime"/>：</td>
						<td>
							<input type="text" id="expiredtime" name="expiredtime" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});" class="Wdate inp w150" value="${stbdefaultmsg.expiredtime}"/>
						</td>
					
						<td align="right" width="120px"><spring:message code="authorize.osd.keylock"/>：</td>
						<td>
							<select id="lockscreen" name="lockscreen" class="select" style="width:157px;">
									<option value="0" <c:if test="${stbdefaultmsg.lockscreen== '0'}">selected</c:if>><spring:message code="authorize.osd.keylock.0"/></option>
									<option value="1" <c:if test="${stbdefaultmsg.lockscreen== '1'}">selected</c:if>><spring:message code="authorize.osd.keylock.1"/></option>
							</select>
						</td>
					</tr>
				 
				 
					<tr height="25px">
						<td align="right" width="120px"><spring:message code="authorize.forcedcc.stbtype"/>：</td>
						<td>
							<select id="stbtype" name="stbtype" class="select" style="width:157px;" onchange="initStbtype();">
									<option value="00" <c:if test="${stbdefaultmsg.stbtype== '00'}">selected</c:if>><spring:message code="DVB-C"/></option>
									<option value="01" <c:if test="${stbdefaultmsg.stbtype== '01'}">selected</c:if>><spring:message code="DVB-S"/></option>
 							</select>
						</td>

						<td align="right"><spring:message code="authorize.forcedcc.serviceid"/>：</td>
						<td>
					          <input type="text" class="inp" name="serviceid" id="serviceid" value="${stbdefaultmsg.serviceid }" maxlength="5" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" /> 
						</td>
						<td align="right"><spring:message code="authorize.forcedcc.pcrpid"/>：</td>
						<td>
					 		<input name="pcrpid" id="pcrpid" class="easyui-numberspinner" value="${stbdefaultmsg.pcrpid }" data-options="min:0,max:65535,increment:1" style="width:157px;"></input>
						</td>
				</tr>
				
				</table>
			</div>
					<div style="margin:20px 0;"></div>
		
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
							<select name="streamcontent">
									<option value="02"><spring:message code="AUDIO"/></option>
							</select>
						</td>
						
						<td align="center">
							<select name="comptype">
									<option value="02"><spring:message code="MPEG-1_LAYER_2_AUDIO"/></option>
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
		<%-- 	<div class="easyui-panel" title="<spring:message code="Component"/>" style="width:950px; text-align:center">
					<table width="100%" id="appendComponent">
					<tr height="25px">
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.streamcontent"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.comptype"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.compid"/></td>
							<td align="center" width="20%"><spring:message code="authorize.forcedcc.ecmpid"/></td>
							<td align="center" width="20%"><spring:message code="page.operate"/></td>
					</tr>
					</table>
			</div>    <!--  //end condition cmd -->			
			
			<div style="margin:20px 0;"></div> --%>

			<div style="margin:20px 0;"></div>
			<div id="dvb-c">
				<div class="easyui-panel" title="<spring:message code="dvb-c"/>" style="width:950px">
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
				<div class="easyui-panel" title="<spring:message code="dvb-s"/>" style="width:950px">
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
										<option value="00"><spring:message code="authorize.forcedcc.fecouter.0000"/></option>
										<option value="01"><spring:message code="16QAM"/></option>
										<option value="02"><spring:message code="32QAM"/></option>
										<option value="03"><spring:message code="64QAM"/></option>
										<option value="04"><spring:message code="128QAM"/></option>
										<option value="05"><spring:message code="256QAM"/></option>
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
			<div style="margin:20px 0;"></div>
			<div align="center">
				<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
			</div>
		</form>
	
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
	    function InitCard_or_stb_tag(){
			if ($("#card_or_stb_tag").val() == "00") {
				$("#card").show();
				$("#stb").hide();
			} else if($("#card_or_stb_tag").val() == "01"){
				$("#stb").show();
				$("#card").hide();
			}
		}
	
		function initStbtype() {
			if ($("#stbtype").val() == 0) {
				$("#dvb-c").show();
				$("#dvb-s").hide();
			} else {
				$("#dvb-s").show();
				$("#dvb-c").hide();
			}
		}

		function cardid_optionInit() {
			if ($("#cardid_option").val() == "0") {
				$(".inputcard").show();
				$("#cardid").val("");
			} else {
				$("#cardid").val("ffffffff");
				$(".inputcard").hide();
			//	alert("cardid:" + $("#cardid").val());
			}
		};
		
			function stbno_optionInit() {
			if ($("#stbno_option").val() == "0") {
				$(".inputstb").show();
				$("#stbno").val("");
			} else {
				$("#stbno").val("ffffffff");
				$(".inputstb").hide();
			//	alert("stb:" + $("#stbno").val());
			}
		};

		function areacode_optionInit() {
			if ($("#areacode_option").val() == "0") {
				$(".inputarea").show();
				$("#areano").val("");
			} else {
				$("#areano").val("ffffffff");
				$(".inputarea").hide();
			//	alert("areacode:" + $("#areacode").val());
				$('#areano').combotree('setValue', '');
			}
		};


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
		if($('#card_or_stb_tag').val() == '00' && $('#cardid').val() == ''){
			$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
			$('#cardid').focus();
			return;
		}
		
		if($('#card_or_stb_tag').val() == '01' && $('#stbno').val() == ''){
			$.dialog.tips('<spring:message code="stb.stbno.empty"/>',1, 'alert.gif');
			$('#stbno').focus();
			return;
		}
		
		if ($('#areano').combotree("getValue") == '') {
			$.dialog.tips('<spring:message code="area.areacode.empty"/>',1, 'alert.gif');
			$('#areano').focus();
			return;
		} 
			
		if ($('#expiredtime').val() == '') {
			$.dialog.tips('<spring:message code="authorize.endtime.empty"/>', 1,'alert.gif');
			$('#expiredtime').focus();
			return;
		}
		if ($('#serviceid').val() == '') {
			$.dialog.tips('<spring:message code="authorize.serviceid.empty"/>', 1,'alert.gif');
			$('#serviceid').focus();
			return;
		}
		if ($('#pcrpid').val() == '') {
			$.dialog.tips('<spring:message code="authorize.pcrpid.empty"/>', 1,'alert.gif');
			$('#pcrpid').focus();
			return;
		}
/* 		if (componentFlag <= 0) {
			$.dialog.tips('<spring:message code="authorize.component.empty"/>', 1,'alert.gif');
			return;
		} */
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
		
		
		$("#paramForm").attr("action", "cascommand/send_stbdefaultmsg");
		$("#paramForm").submit();
	}

		$(function() {
			initNetwork();
			InitCard_or_stb_tag();
			initStbtype();
			var returninfo = '${stbdefaultmsg.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

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
			$("#areano").val(areacode);
		}
		
		function initNetwork(){
		   $('#netid').combobox({    
				url:'user/initNetworkJson?rid='+Math.random(),
			    valueField:'id',    
			    //limitToList:true,
			    editable:false,
			    textField:'netname',
		        onSelect: function(rec){    
	               initArea(rec.id);//默认加载区域
	        	},
			    onLoadSuccess:function(node, data){
				    	//初始化营业厅列表框的默认选择值
				    	if('${Operator.netid}' != '' && '${Operator.netid}' != null){
						  	  $(this).combobox('select',parseInt('${Operator.netid}'));
						}else{//默认选择第一个
							var val = $('#netid').combobox("getData");  
		                    for (var item in val[0]) {  
		                        if (item == "id") {  
		                            $(this).combobox("select", val[0][item]);  
		                        }  
		                     }  	
						} 
				    }
			});  
	    }
	    
	    function initArea(netid) {
		  $('#areano').combotree({   
			    url:'user/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
			    //数据执行之后才加载
			    onLoadSuccess:function(node, data){
			    	if('${Operator.areacode}' != '' && '${Operator.areacode}' != null){
					  	  var node = $('#areano').combotree('tree').tree('find', '${Operator.areacode}');
					  	  if(node != null){
					  	  	$('#areano').combotree('setValue', node.id);
					  	  }else{
					  	  	$('#areano').combotree('setValue', '');
					  	  }
				     }else{
				     	$('#areano').combotree('setValue', '');
				     }
			    },
			    //选择之前运行
			    onBeforeSelect : function(node) {
			         //返回树对象  
			        var tree = $(this).tree;  
			        //选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
			        var isLeaf = tree('isLeaf', node.target);  
			        if (!isLeaf) {  
			            //清除选中  
			           //$("#queryareacode").treegrid("unselect");
			        }  
				    //if (node.children != undefined) {
				    // 	$("#areacode").treegrid("unselect");
				    //}
				},
			    //绑定onchanger事件
			    onChange:function(){  
	            }
		  }); 
	  }
	</script>
</body>
</html>