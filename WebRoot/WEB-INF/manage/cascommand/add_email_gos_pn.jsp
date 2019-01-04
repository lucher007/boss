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
<body style="padding:0px; width:99%; ">
	<div id="body">
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<input type="hidden" name="versiontype" id="versiontype" value="${emailOrOsdMsg.versiontype }"/>
			
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
			
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
			<table width="100%">
				<tr>
					<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
					<td width="25%">
						  <select id="netid" name="netid" class="select">
							<c:forEach items="${emailOrOsdMsg.networkmap}" var="dataMap" varStatus="s">
							  <option value="${dataMap.key}" <c:if test="${dataMap.key == emailOrOsdMsg.netid}">selected</c:if>>${dataMap.value}</option>
							</c:forEach>
						  </select>
					</td>
					<td align="right"><spring:message code="authorize.expiretime"/>：</td>
					<td><input type="text" id="expiredtime" name="expiredtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
						class="Wdate inp w150" value="${emailOrOsdMsg.expiredtime}"/>
												<span class="red">*</span>
						
					</td>
				</tr>
				
				<tr>
					<td align="right"><spring:message code="authorize.title" />：</td>
					<td>
						<input type="text" class="inp w200" name="emailtitle" id="emailtitle" value="${emailOrOsdMsg.emailtitle }">
						<span class="red">*</span>
					</td>
					<td align="right"><spring:message code="authorize.osd.encodedmode" />：</td>
					<td>
						<select  id="remark" name="remark" class="select">
							<option value="GB">GB2312</option>
							<option value="BE">UniCode-BE</option>
							<option value="LE">UniCode-LE</option>
						</select>
					</td>
				</tr>
				<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="emailcontent" name="emailcontent" style="width:75%; height:100px;" onKeyDown="checkLength('emailcontent',100)" onKeyUp="checkLength('emailcontent',100)">${emailOrOsdMsg.emailcontent}</textarea> 
							<span class="red"><spring:message code="page.can.input" /> <span id="validNumemailcontent">100</span> <spring:message code="page.word" /></span>
						</td>
				</tr>
					
				<tr height="40px">
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
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">

		function cardid_optionInit(){
			if($("#cardid_option").val() == "0"){
				if($("#cardid").val() == "ffffffff"){
					$("#cardid").val("");
				}
				$(".cardid").show();
			}else{
				$(".cardid").hide();
				$("#cardid").val("ffffffff");
			}
		}

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
			
			if ($('#emailtitle').val() == '') {
				$.dialog.tips('<spring:message code="authorize.title.empty"/>',1, 'alert.gif');
				$('#starttime').focus();
				return;
			}
			
			$("#paramForm").attr("action", "cascommand/send_email");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_email_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
			//cardid_optionInit();
			var returninfo = '${emailOrOsdMsg.returninfo}';
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

	</script>
</body>
</html>