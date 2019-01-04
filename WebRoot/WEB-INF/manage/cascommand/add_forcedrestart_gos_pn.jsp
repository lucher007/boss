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
</style>
</head>
<body  style="padding:0px; width:99%; ">
	<div id="body">
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
			<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
			<input type="hidden" name="versiontype" id="versiontype" value="${forcedrestart.versiontype }"/>
				<table>
					<tr height="40px">
						<td align="right"><spring:message code="network.netname"/>：</td>
						<td align="left">
							  <select id="netid" name="netid" class="select">
								<c:forEach items="${forcedrestart.networkmap}" var="dataMap" varStatus="s">
								  	<option value="${dataMap.key}" <c:if test="${dataMap.key == forcedrestart.netid}">selected</c:if>>${dataMap.value}</option>
								</c:forEach>
							  </select>
						</td>
					</tr>
				
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td align="left">
							<input type="text" id="expired_Time" name="expired_Time" value="${forcedrestart.expired_Time }" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.card.target" />：</td>
						<td align="left">
							<select id="cardid_option" name="cardid_option" class="select" onchange="cardid_optionInit();">
				                   <option value="0"><spring:message code="authorize.card.target.0" /></option>
				                   <option value="1"><spring:message code="authorize.card.target.1" /></option>
				             </select>
						</td>
					</tr>

					<tr height="40px" id="card">
						<td align="right"><spring:message code="card.cardid" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="cardid" id="cardid" 
							maxlength="16"
							value="${forcedrestart.cardid }" 
							 onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
							onafterpaste="this.value=this.value.replace(/\D/g,'')">
							<span class="red"> *</span>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.area.target"/>：</td>
						<td align="left">
							<select id="areacode_option" name="areacode_option" onchange="areacode_optionInit();" class="select">
				                   <option value="0"><spring:message code="authorize.area.target.0" /></option>
				                   <option value="1" ><spring:message code="authorize.area.target.1" /></option>
				             </select>
						</td>
					</tr>
					
					<tr height="40px" id="area">
						<td align="right"><spring:message code="area.areacode" />：</td>
						<td align="left">
							<input type="text" class="inp w200" name="areacode" id="areacode" value="${forcedrestart.areacode }" maxlength="5"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
							<%-- 
							<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseArea();">
							 --%>
							<a href="javascript:chooseArea();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
						</td>
					</tr>
				    
					<tr height="40px">
							<td colspan="2" align="center" width="130px">
								<div style="margin:20px 0;"></div>
								<div align="center">
									<a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a>
								</div>
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
			cardid_optionInit();
			areacode_optionInit();
			var returninfo = '${forcedrestart.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});
		
		function goSend() {
	
		 	if ($('#expired_Time').val() == '') {
				$.dialog.tips('<spring:message code="authorize.expiredtime.empty"/>',1, 'alert.gif');
				$('#expired_Time').focus();
				return;
			} 
		 	
		 	if ($('#cardid').val() == '') {
				$.dialog.tips('<spring:message code="card.cardid.empty"/>',1, 'alert.gif');
				$('#cardid').focus();
				return;
			} 
			
			if ($('#areacode').val() == '') {
				$.dialog.tips('<spring:message code="area.areacode.empty"/>',1, 'alert.gif');
				$('#areacode').focus();
				return;
			} 
		
			$("#paramForm").attr("action", "cascommand/send_forcedrestart");
			$("#paramForm").submit();
		}

		function cardid_optionInit() {
			if ($("#cardid_option").val() == "0") {
				$("#card").show();
				$("#cardid").val("");
			} else {
				$("#cardid").val("ffffffff");
				$("#card").hide();
				//	alert("cardid:" + $("#cardid").val());
			}
		};

		function areacode_optionInit() {
			if ($("#areacode_option").val() == "0") {
				$("#area").show();
				$("#areacode").val("");
			} else {
				$("#areacode").val("ffffffff");
				$("#area").hide();
				//alert("areacode:" + $("#areacode").val());
			}
		};
		
		var areaDialog;
		function chooseArea() {
		    
		     var netid = $("#netid").val();
		
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
				content : 'url:authorize/findAreaListForDialog?rid='+Math.random()+'&querynetid='+netid
			});
		}

		function closeDialog(areacode) {
			areaDialog.close();
			$("#areacode").val(areacode);
		}
		
	</script>
</body>
</html>