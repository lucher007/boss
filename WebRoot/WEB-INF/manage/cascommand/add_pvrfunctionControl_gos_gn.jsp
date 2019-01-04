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
		</div>

		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden" name="versiontype" id="versiontype" value="${caCommandParam.versiontype }"/>
			<input type="hidden"  name="conditioncontent" id="conditioncontent" />
			<input type="hidden"  name="conditioncount" id="conditioncount" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr>
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caCommandParam.networkmap}" var="dataMap" varStatus="s">
								  <option value="${dataMap.key}" <c:if test="${dataMap.key == caCommandParam.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expired_Time" name="expired_Time" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caCommandParam.expired_Time}"/>
							<span class="red">*</span>
						</td>
					</tr>
					
					<tr>
						<td align="right"><spring:message code="pvr.functionControl"/>：</td>
						<td>
							<select id="pvrStatus" name="pvrStatus" class="select" style="width:157px;">
								<option value="1" <c:if test="${caCommandParam.pvrStatus== '1'}">selected</c:if>><spring:message code="productplay.control.1"/></option>
								<option value="0" <c:if test="${caCommandParam.pvrStatus== '0'}">selected</c:if>><spring:message code="productplay.control.0"/></option>
							</select>
						</td>
						<td align="right"><spring:message code="pvr.pay.type"/>：</td>
						<td>
							<select id="pvr_pay" name="pvr_pay" class="select" style="width:157px;">
								<option value="0" <c:if test="${caCommandParam.pvr_pay== '0'}">selected</c:if>><spring:message code="pvr.pay.type.0"/></option>
								<option value="1" <c:if test="${caCommandParam.pvr_pay== '1'}">selected</c:if>><spring:message code="pvr.pay.type.1"/></option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right"><spring:message code="pvr.price"/>：</td>
						<td><input type="text" id="pvr_price" name="pvr_price" class="inp w150" value="${caCommandParam.pvr_price}"/>
						</td>
						<td align="right"><spring:message code="pvr.freewatch.time"/>：</td>
						<td><input type="text" id="pvr_free_watch_time" name="pvr_free_watch_time" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caCommandParam.pvr_free_watch_time}"/>
							<span class="red">*</span>
						</td>
					</tr>
					<tr>
						<td align="right"><spring:message code="pvr.save.time"/>：</td>
						<td><input type="text" id="pvr_save_time" name="pvr_save_time" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caCommandParam.pvr_save_time}"/>
							<span class="red">*</span>
						</td>
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="startdate" name="startdate" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caCommandParam.startdate}"/>
							<span class="red">*</span>
						</td>
					</tr>
					<tr>
						<td align="right"><spring:message code="authorize.osd.endtime"/>：</td>
						<td><input type="text" id="enddate" name="enddate" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caCommandParam.enddate}"/>
							<span class="red">*</span>
						</td>
					</tr>
				</table>
				<div align="center">
					<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
				</div>
			</div>
		</form>
	
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
		function goSend() {
			if ($('#conditioncontent').val() == '') {
				$.dialog.tips('<spring:message code="authorize.conditioncontent.empty"/>',1, 'alert.gif');
				return;
			}
		
			if ($('#expired_Time').val() == '') {
				$.dialog.tips('<spring:message code="email.casexpiredtime.empty"/>',1, 'alert.gif');
				$('#expired_Time').focus();
				return;
			}
			
			if ($('#pvr_price').val() < 1 || $('#pvr_price').val() > 65535) {
				$.dialog.tips('<spring:message code="pvr.price.range"/>',1, 'alert.gif');
				$('#pvr_price').focus();
				return;
			}
			
			if ($('#pvr_free_watch_time').val() == '') {
				$.dialog.tips('<spring:message code="pvr.freewatch.time.empty"/>',1, 'alert.gif');
				return;
			}
			
			if ($('#pvr_save_time').val() == '') {
				$.dialog.tips('<spring:message code="pvr.save.time.empty"/>',1, 'alert.gif');
				return;
			}
			
			if ($('#startdate').val() == '') {
				$.dialog.tips('<spring:message code="authorize.starttime.empty"/>',1, 'alert.gif');
				return;
			}
			
			if ($('#enddate').val() == '') {
				$.dialog.tips('<spring:message code="authorize.endtime.empty"/>',1, 'alert.gif');
				return;
			}
			
			$("#paramForm").attr("action", "cascommand/send_pvrfunctionControl");
			$("#paramForm").submit();
		}

		$(function() {
			var returninfo = '${caCommandParam.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			}
		});

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
		
	</script>
</body>
</html>