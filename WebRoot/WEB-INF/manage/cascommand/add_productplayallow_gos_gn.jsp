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
		
		
		<div class="easyui-panel" title="<spring:message code="productplay.productinfo"/>" style="width:100%; text-align:center">
				<table id="productInfo" width="100%" cellpadding="5">
					<tr height="20px">
						<td align="center"><spring:message code="product.productid"/></td>
						<td align="center"><spring:message code="authorize.osd.starttime"/></td>
						<td align="center"><spring:message code="authorize.osd.endtime"/></td>
						<td align="center"><spring:message code="page.operate"/></td>
					</tr>
				</table>
		</div>
		<div style="margin:10px 0;"></div>
		<div class="easyui-panel" title="<spring:message code="productplay.productinfo.add"/>" style="width:100%">
				<table width="100%">
					<tr>
						<td align="center" width="20%"><spring:message code="product.productid"/></td>
						<td align="center" width="20%"><spring:message code="authorize.osd.starttime"/></td>
						<td align="center" width="20%"><spring:message code="authorize.osd.endtime"/></td>
					</tr>
					<tr>
						<td align="center">
							<input type="text" class="inp w200" name="productid" id="productid" value="" maxlength="8" onkeyup="value=value.replace(/[^0-9]/g,'')" />
						</td>
						<td align="center">
							<input type="text" id="startTime" name="startTime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value=""/>
						</td>
						<td align="center">
							<input type="text" id="endTime" name="endTime"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value=""/>
						</td>
					</tr>
				</table>
				
			<div style="text-align:center;padding:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addProductInfo()"><spring:message code="productplay.productinfo.add"/></a> 
			</div>
		</div>   <!-- //end add condition -->

		<div style="margin:10px 0;"></div>
		
		
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnproductplay.versiontype }"/>
			<input type="hidden"  name="conditioncontent" id="conditioncontent" />
			<input type="hidden"  name="conditioncount" id="conditioncount" />
			<input type="hidden"  name="productinfo" id="productinfo" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					<tr>
						<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
						<td width="25%">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${caspnproductplay.networkmap}" var="dataMap" varStatus="s">
								  <option value="${dataMap.key}" <c:if test="${dataMap.key == caspnproductplay.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expiredtime" name="expiredtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150" readonly="readonly" value="${caspnproductplay.expiredtime}"/>
							<span class="red">*</span>
						</td>
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
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
		function goSend() {
			if ($('#productinfo').val() == '') {
				$.dialog.tips('<spring:message code="productplay.productinfo.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="email.casexpiredtime.empty"/>',1, 'alert.gif');
				return;
			}
			
			$("#paramForm").attr("action", "cascommand/send_productplayallow");
			$("#paramForm").submit();
		}

		//返回
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_productplayallow_List");
			$("#paramForm", parent.document).submit();
		}
		
		$(function() {
			var returninfo = '${caspnproductplay.returninfo}';
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

		function addProductInfo() {
			
			if ($('#productid').val() == '') {
				$.dialog.tips('<spring:message code="productplay.productinfo.empty"/>',1, 'alert.gif');
				$('#productid').focus();
				return;
			}
			if ($('#startTime').val() == '') {
				$.dialog.tips('<spring:message code="productplay.productinfo.empty"/>',1, 'alert.gif');
				$('#startTime').focus();
				return;
			}
			if ($('#endTime').val() == '') {
				$.dialog.tips('<spring:message code="productplay.productinfo.empty"/>',1, 'alert.gif');
				$('#endTime').focus();
				return;
			}
			
			var productID = $('#productid').val();
			var startTime = $('#startTime').val();
			var endTime = $('#endTime').val();
			var conditionToAppend = '<tr height="20px" class="commandpartproduct"><td align="center">'
					+ productID
					+ '<input type="hidden" class="cndpara" value="'  + productID +   '"></td><td align="center">'
					+ startTime
					+ '<input type="hidden" class="cndpara" value="'  + startTime +   '"></td><td align="center">'
					+ endTime
					+ '<input type="hidden" class="cndpara" value="'  + endTime +   '"></td><td align="center"><a class="red" href="javascript:void(0);" onclick="deleteTr(this)"><spring:message code="page.delete"/></a></td></tr>';
			$('#productInfo').append(conditionToAppend);
			updateFinalCommand1();
		}
		
		function updateFinalCommand1() {
			var final_cmd = "";//条件寻址内容
			
			$(".commandpartproduct").each(function() {
				var dataarray = $(this).find(".cndpara");
				var cmd = "";
				dataarray.each(function() {
					cmd = cmd + $(this).val()+",";
				});
				cmd=cmd.substring(0,cmd.length-1);
				final_cmd = final_cmd + cmd +";";
			});
			$("#productinfo").val(final_cmd);
		}
		
		function deleteTr(delObj) {
			$(delObj).parents('tr').remove();
			updateFinalCommand1();
		}
		
	</script>
</body>
</html>