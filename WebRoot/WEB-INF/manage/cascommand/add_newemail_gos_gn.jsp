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
		</div>   <!-- //end add condition -->

		<div style="margin:10px 0;"></div>
		
		
		<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden" name="versiontype" id="versiontype" value="${caspnnewemail.versiontype }"/>
			<input type="hidden"  name="conditioncontent" id="conditioncontent" />
			<input type="hidden"  name="conditioncount" id="conditioncount" />
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:100%">
				<table width="100%">
					
				<tr>
					<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
					<td width="25%">
						  <select id="netid" name="netid" class="select">
							<c:forEach items="${caspnnewemail.networkmap}" var="dataMap" varStatus="s">
							  <option value="${dataMap.key}" <c:if test="${dataMap.key == caspnnewemail.netid}">selected</c:if>>${dataMap.value}</option>
							</c:forEach>
						  </select>
					</td>
					<td height="30" width="15%" align="right">ID：</td>
					<td width="25%">
						<input type="text" class="inp w200" name="emailid" id="emailid" value="${caspnnewemail.emailid }" maxlength="9" onkeyup="value=value.replace(/[^0-9]/g,'')" >
						<span class="red">*</span>
					</td>
				</tr>
				
				<tr>
					<td align="right"><spring:message code="authorize.expiretime"/>：</td>
					<td><input type="text" id="expiredtime" name="expiredtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
						class="Wdate inp w150" readonly="readonly" value="${caspnnewemail.expiredtime}"/>
						<span class="red">*</span>
					</td>
					<td align="right"><spring:message code="email.casexpiredtime"/>：</td>
					<td><input type="text" id="casexpiredtime" name="casexpiredtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
						class="Wdate inp w150" readonly="readonly" value="${caspnnewemail.casexpiredtime}"/>
						<span class="red">*</span>
					</td>
				</tr>
					
				<tr>
					<td align="right"><spring:message code="authorize.osd.encodedmode"/>：</td>
					<td>
						<select  id="remark" name="remark" class="select">
							<option value="GB" <c:if test="${caspnnewemail.remark== 'GB'}">selected</c:if>>GB2312</option>
							<option value="BE" <c:if test="${caspnnewemail.remark== 'BE'}">selected</c:if>>UniCode-BE</option>
							<option value="LE" <c:if test="${caspnnewemail.remark== 'LE'}">selected</c:if>>UniCode-LE</option>
						</select>
					</td>
					<td align="right"><spring:message code="email.priority" />：</td>
					<td> 
						<select id="emailpriority" name="emailpriority" class="select" onchange="cardid_optionInit();">
			                <option value="0" <c:if test="${caspnnewemail.emailpriority== '0'}">selected</c:if>><spring:message code="email.common" /></option>
			                <option value="1" <c:if test="${caspnnewemail.emailpriority== '1'}">selected</c:if>><spring:message code="email.advanced" /></option>
			            	<option value="2" <c:if test="${caspnnewemail.emailpriority== '2'}">selected</c:if>><spring:message code="email.urgent" /></option>
			            	<option value="100" <c:if test="${caspnnewemail.emailpriority== '100'}">selected</c:if>><spring:message code="email.bill" /></option>
			            </select>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<td align="right"><spring:message code="authorize.emailtype" />：</td> -->
<!-- 					<td>  -->
<!-- 						<select id="emailpriority" name="emailpriority" class="select" onchange="cardid_optionInit();"> -->
<!-- 			                <option value="0"><spring:message code="authorize.emailpriority.0" /></option> -->
<!-- 			                <option value="1"><spring:message code="authorize.emailpriority.1" /></option> -->
<!-- 			            	<option value="2"><spring:message code="authorize.emailpriority.2" /></option> -->
<!-- 			            </select> -->
<!-- 					</td> -->
<!-- 					<td align="right"><spring:message code="authorize.sendername" />：</td> -->
<!-- 					<td> -->
<!-- 						<input type="text" class="inp w200" name="sendername" id="sendername" value="${caspnnewemail.sendername }"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr height="40px">
					<td align="right"><spring:message code="authorize.title" />：</td>
					<td>
						<input type="text" class="inp w200" name="emailtitle" id="emailtitle" value="${caspnnewemail.emailtitle }">
						<span class="red">*</span>
					</td>
					<td align="right"><spring:message code="authorize.sendername" />：</td>
					<td>
						<input type="text" class="inp w200" name="sendername" id="sendername" value="${caspnnewemail.sendername }">
					</td>
					
				</tr>
<!-- 				<tr height="40px"> -->
<!-- 					<td height="30" width="15%" align="right"><spring:message code="email.control"/>：</td> -->
<!-- 					<td width="25%"> -->
<!-- 						<select id="emailoper" name="emailoper" class="select"> -->
<!-- 							<option value="1"><spring:message code="page.add"/></option> -->
<!-- 							<option value="0"><spring:message code="page.delete"/></option> -->
<!-- 						</select> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr>
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan="4">
							<textarea id="emailcontent" name="emailcontent" style="width:75%; height:100px;" onKeyDown="checkLength('emailcontent',100)" onKeyUp="checkLength('emailcontent',100)">${caspnnewemail.emailcontent}</textarea> 
							<span class="red"><spring:message code="page.can.input" /> <span id="validNumemailcontent">100</span> <spring:message code="page.word" /></span>
						</td>
				</tr>
					
				<tr>
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
		function goSend() {
			if ($('#conditioncontent').val() == '') {
				$.dialog.tips('<spring:message code="authorize.conditioncontent.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				$('#cardid').focus();
				return;
			}
			if($('#emailid').val() == ''){
				$.dialog.tips('<spring:message code="email.id.empty"/>',1, 'alert.gif');
				$('#emailID').focus();
				return;
			}
			if ($('#emailtitle').val() == '') {
				$.dialog.tips('<spring:message code="authorize.title.empty"/>',1, 'alert.gif');
				$('#starttime').focus();
				return;
			}
			if ($('#casexpiredtime').val() == '') {
				$.dialog.tips('<spring:message code="email.casexpiredtime.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				return;
			}
			if ($('#expiredtime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				return;
			} 
			
			$("#paramForm").attr("action", "cascommand/send_newemail");
			$("#paramForm").submit();
		}
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_newemail_List");
			$("#paramForm", parent.document).submit();
		}

		$(function() {
			var returninfo = '${caspnnewemail.returninfo}';
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
	</script>
</body>
</html>