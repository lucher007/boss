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
<body>
	<div id="body">
		<form action="" method="post" id="forceosdForm" name="forceosdForm">
			<div class="easyui-panel" title="<spring:message code="authorize.condition"/>" style="width:750px">
				<table width="100%" cellpadding="5">
						<tr height="40px" id="Cardid">
						<td align="right"><spring:message code="authorize.startcardid"/>:</td>
						<td><input type="text" class="inp w200" name="startCardid" id="startCardid" value="${authorizeParamForPages.conditionaddr.startCardid}"></td>
						<td align="right"><spring:message code="authorize.endcardid"/>:</td>
						<td><input type="text" class="inp w200" name="endCardid" id="endCardid" value="${authorizeParamForPages.conditionaddr.endCardid}"></td>
					</tr>
					<tr height="40px" id="Areano">
						<td align="right"><spring:message code="authorize.startareano"/>:</td>
						<td><input type="text" class="inp w200" name="startAreano" id="startAreano" value="${authorizeParamForPages.conditionaddr.startAreano}"></td>
						<td align="right"><spring:message code="authorize.endareano"/>:</td>
						<td><input type="text" class="inp w200" name="endAreano" id="endAreano" value="${authorizeParamForPages.conditionaddr.endAreano}"></td>
					</tr>
				</table>
			</div>
			<div style="margin:20px 0;"></div>
			
			
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:750px">
				<table width="100%">
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="Expired_Time" name="Expired_Time" value="${authorizeParamForPages.emailorosdmsg.expired_Time}"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});"
							class="Wdate inp w150"
						/>
						</td>
						<td align="right"><spring:message code="authorize.title"/>：</td>
						<td><input type="text" class="inp w200" name="Email_Title_Name" id="Email_Title_Name" value="${authorizeParamForPages.emailorosdmsg.email_Title_Name}"></td>
					</tr>
					
					
					<tr height="130px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan=3><textarea id="MsgData" name="MsgData" value="${authorizeParamForPages.emailorosdmsg.msgData}" style="width:82%; height:100px;" onKeyDown="checkLength('MsgData',100)"
								onKeyUp="checkLength('MsgData',100)"
							></textarea> <span class="red"><spring:message code="page.can.input"/><span id="validNumMsgData">100</span><spring:message code="page.word"/></span></td>
					</tr>
				
					<tr height="40px">
						<td colspan="4" align="center"><a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
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
	<script type="text/javascript">
		function goSend() {
  		 if($("#Email_Title_Name").val() =="") {
		      $.dialog.tips('<spring:message code="authorize.title.empty"/>', 1, 'alert.gif');
		      $("#Email_Title_Name").focus();
		      return;
	    }

	    if($("#startCardid").val() == "" && $("#endCardid").val() == "" && $("#startAreano").val() == "" && $("#endAreano").val() == "") {
		      $.dialog.tips('<spring:message code="authorize.condition.empty"/>', 1, 'alert.gif');
		      $("#startCardid").focus();
		      return;
	    }
	    
	    if( ($("#startCardid").val() == "" && $("#endCardid").val() != "")||($("#startCardid").val() != "" && $("#endCardid").val() == "")||($("#startAreano").val() == "" && $("#endAreano").val() != "")||($("#startAreano").val() != "" && $("#endAreano").val() == "")   ){
	   		  $.dialog.tips('<spring:message code="authorize.condition.nocomplete"/>', 1, 'alert.gif');
		      $("#startCardid").focus();
		      return;
	    }
			$("#forceosdForm").attr("action", "authorize/saveMailForPN");
			$("#forceosdForm").submit();
		}

		function checkLength(object, maxlength) {
			var obj = $('#' + object), value = $.trim(obj.val());
			if (value.length > maxlength) {
				obj.val(value.substr(0, maxlength));
			} else {
				$('#validNum' + object).html(maxlength - value.length);
			}
		}
		
		$(function() {
			var returninfo = '${authorizeParamForPages.returninfo}';
	       if (returninfo != '') {
	        	$.dialog.tips(returninfo, 1, 'alert.gif');
	       }
		});
		
	</script>
</body>
</html>