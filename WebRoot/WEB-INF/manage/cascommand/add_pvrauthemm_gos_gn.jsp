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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" href="colorpicker/css/colorpicker.css" type="text/css" />
<style type="text/css">
/*     .form-box table tr td {
      white-space: nowrap;
      height: 30px;
      font-size: 12px;
    }
    .readonly {
      background-color: #eeeeee;
    } */
</style>
</head>
<body  style="padding:0px; width:99%; ">
	<div id="body">
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
				<input type="hidden" name="versiontype" id="versiontype" value="${pvrAuthEmm.versiontype }"/>
				<table>

					<tr height="40px">
						<td align="right"><spring:message code="network.netname"/>：</td>
						<td align="left">
				              <select id="netid" name="netid" class="select">
					                <c:forEach items="${pvrAuthEmm.networkmap}" var="dataMap" varStatus="s">
					                  <option value="${dataMap.key}" <c:if test="${dataMap.key == pvrAuthEmm.netid}">selected</c:if>>${dataMap.value}</option>
					                </c:forEach>
				              </select>
			            </td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime"/>：</td>
						<td><input type="text" id="expiredTime" name="expiredTime" value="${expiredTime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'expiredTime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${pvrAuthEmm.expiredTime}"/>
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="stb.stbno" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="teminalid" id="teminalid" 
							value="${pvrAuthEmm.teminalid }" maxlength="8" onkeyup="value=value.replace(/[^0-9a-fA-F]/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="pvr.pvrid" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="pvrid" id="pvrid" 
							maxlength="8"
							value="${pvrAuthEmm.pvrid }" 
							maxlength="9" onkeyup="value=value.replace(/[^0-9]/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
						
					<tr height="40px">
						<td align="right"><spring:message code="pvr.service.id" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="serviceid" id="serviceid" 
							value="${pvrAuthEmm.serviceid }" maxlength="5" 
							onkeyup="value=value.replace(/[^0-9]/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="problemcomplaint.operatorid"/>：</td>
						<td align="left">
							<input type="text" class="inp w200" name="opratorid" id="opratorid" 
							maxlength="8"
							value="${pvrAuthEmm.opratorid }" 
							onkeyup="value=value.replace(/[^0-9]/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.starttime"/>：</td>
						<td><input type="text" id="starttime" name="starttime" value="${starttime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',maxDate:'#F{$dp.$D(\'starttime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${pvrAuthEmm.starttime}" />
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.osd.endtime"/>：</td>
						<td>
							<input type="text" id="endtime" name="endtime" value="${endtime }"
							onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss',minDate:'#F{$dp.$D(\'endtime\');}'});"
							class="Wdate inp w150" readonly="readonly" value="${pvrAuthEmm.endtime}"/>
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
							<td colspan="2" align="center" width="130px">
								<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
							</td>
					</tr>
				
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript">
	    $(function() {
			var returninfo = '${pvrAuthEmm.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});

		function goSend() {
		
			if ($('#expiredTime').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				$('#expiredTime').focus();
				return;
			}

			if ($('#teminalid').val() == '') {
				$.dialog.tips('<spring:message code="stb.stbno.empty"/>',1, 'alert.gif');
				$('#teminalid').focus();
				return;
			}
			
			if ($('#pvrid').val() == '') {
				$.dialog.tips('<spring:message code="pvr.pvrid.empty"/>',1, 'alert.gif');
				$('#pvrid').focus();
				return;
			}
			
			if ($('#serviceid').val() < 1 || $('#serviceID').val() > 65535) {
				$.dialog.tips('<spring:message code="forcedcc.serviceid.range"/>',1, 'alert.gif');
				$('#serviceid').focus();
				return;
			}
			
			if ($('#opratorid').val() < 1 || $('#opratorid').val() > 65535) {
				$.dialog.tips('<spring:message code="pvr.operatorid.range"/>',1, 'alert.gif');
				$('#opratorid').focus();
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
			
			$("#paramForm").attr("action", "cascommand/send_pvrauthemm");
			$("#paramForm").submit();
		}


		var serviceDialog;
		function chooseProduct() {
		    
		    var netid = $("#netid").val();
		    
			serviceDialog = $.dialog({
				title : '<spring:message code="service.servicequery"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:cascommand/findServiceListForDialog?rid='+Math.random()+'&querynetid='+netid
			});
		}

		function closeDialog(serviceid) {
				serviceDialog.close();
				$("#serviceID").val(serviceid);
			}
		
	</script>
</body>
</html>