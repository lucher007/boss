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
						<td align="right"><spring:message code="stb.stbno" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="stbno" id="stbno" 
							maxlength="8"
							value="${pvrAuthEmm.stbno }" 
							onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)"
							onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
							
					<tr height="40px">
						<td align="right"><spring:message code="service.serviceid" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="serviceID" id="serviceID" value="${pvrAuthEmm.serviceID }" maxlength="5" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
							<%-- 
							<input type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseProduct();">
							 --%>
							<a href="javascript:chooseProduct();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.pvr.entitledays" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="entitle_Days" id="entitle_Days"
							 value="${pvrAuthEmm.entitle_Days }" maxlength="5"
							onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
							 onafterpaste="this.value=this.value.replace(/\D/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.pvr.createtime" />：</td>
						<td align="left">
							<input type="text" id="timeInFileID" name="timeInFileID" value="${timeInFileID }"
							readonly="readonly"
							onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'expired_Time\');}'});"
							class="Wdate inp w150" value="${pvrAuthEmm.timeInFileID }" />
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td align="left">
							<input type="text" id="expired_Time" name="expired_Time" value="${expired_Time }"
							readonly="readonly"
							onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'timeInFileID\');}'});"
							 class="Wdate inp w150" value="${pvrAuthEmm.expired_Time }" />
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

			if ($('#stbno').val() == '') {
				$.dialog.tips('<spring:message code="stb.stbno.empty"/>',1, 'alert.gif');
				$('#stbno').focus();
				return;
			}
			
			if ($('#serviceID').val() == '') {
				$.dialog.tips('<spring:message code="product.productid.empty"/>',1, 'alert.gif');
				$('#serviceID').focus();
				return;
			}
			
			if ($('#entitle_Days').val() == '') {
				$.dialog.tips('<spring:message code="authorize.entitledays.empty"/>',1, 'alert.gif');
				$('#entitle_Days').focus();
				return;
			}
			
			if ($('#timeInFileID').val() == '') {
				$.dialog.tips('<spring:message code="authorize.pvrcreatetime.empty"/>',1, 'alert.gif');
				$('#timeInFileID').focus();
				return;
			}
			
			if ($('#expired_Time').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				$('#expired_Time').focus();
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