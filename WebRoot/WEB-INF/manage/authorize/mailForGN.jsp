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
					<tr height="40px">
						<%-- 	<td align="right">CA object:</td>
						<td>
							<select class="select" name="caobject" id="caobject">
									<option value="4" <c:if test="${authorizeParamForPages.caobject== '4'}">selected</c:if>>gospell高安</option>
									<option value="5" <c:if test="${authorizeParamForPages.caobject== '5'}">selected</c:if>>gospell普安</option>
									<option value="6" <c:if test="${authorizeParamForPages.caobject== '6'}">selected</c:if>>NVOD服务器安</option>
									<option value="7" <c:if test="${authorizeParamForPages.caobject== '7'}">selected</c:if>>MPS服务器</option>
							</select>
						</td> --%>
					
						<td align="right"><spring:message code="authorize.addressingmode"/>：</td>
								<td><select id="addressing_mode" name="addressing_mode" class="select" onchange="setAddressing();">
								<option value="0" <c:if test="${authorizeParamForPages.addressing_mode== '0'}">selected</c:if>><spring:message code="authorize.addressingmode.0"/></option>
								<option value="1" <c:if test="${authorizeParamForPages.addressing_mode== '1'}">selected</c:if>><spring:message code="authorize.addressingmode.1"/></option>
						</select></td>
					</tr>
			
					<tr id = "singletag"  height="40px">
							<td align="right"><spring:message code="stb.stbno"/>：</td>
							<td><input type="text" class="inp w200"  name="stbno" id="stbno" value="${authorizeParamForPages.stbno}"></td>										
					</tr>
				
				
					<tr id = "rangetag"  height="40px">
						<td align="right"><spring:message code="authorize.startstbno"/>：</td>
						<td><input type="text" class="inp w200" name="startstbno" id="startstbno" value="${authorizeParamForPages.startstbno}"></td>
						<td align="right"><spring:message code="authorize.endstbno"/>：</td>
						<td><input type="text" class="inp w200" name="endstbno" id="endstbno" value="${authorizeParamForPages.endstbno}">
						</td>
					</tr>
				</table>
			</div>
			
			<div style="margin:20px 0;"></div>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:750px">
				<table width="100%">
					<tr height="40px">
						<td align="right"><spring:message code="authorize.priority"/>:</td>
						<td class="osd_control1">
							<select name="priority" id="priority" class="select">
									    <option value="0" <c:if test="${authorizeParamForPages.gaoanemail.priority== '0'}">selected</c:if>><spring:message code="authorize.priority.0"/></option>
									    <option value="1" <c:if test="${authorizeParamForPages.gaoanemail.priority== '1'}">selected</c:if>><spring:message code="authorize.priority.1"/></option>
										<option value="2" <c:if test="${authorizeParamForPages.gaoanemail.priority== '2'}">selected</c:if>><spring:message code="authorize.priority.2"/></option>
							</select>
						</td>
					</tr>
					
					<tr height="40px">
						<td align="right"><spring:message code="authorize.title"/>：</td>
						<td><input type="text" class="inp w200" name="title" id="title" value="${authorizeParamForPages.gaoanemail.title}"></td>
						<td align="right"><spring:message code="authorize.sendername"/>：</td>
						<td><input type="text" class="inp w200" name="sendName" id="sendName" value="${authorizeParamForPages.gaoanemail.sendName}"></td>
					</tr>
					
					<tr height="135px">
						<td align="right"><spring:message code="authorize.osd.content"/>：</td>
						<td align="left" colspan=4>
							<textarea id="content" name="content" value="${authorizeParamForPages.gaoanemail.content}" style="width:80%; height:100px;" onKeyDown="checkLength('osdcontent',100)" onKeyUp="checkLength('osdcontent',100)"></textarea> 
							<span class="red"><spring:message code="page.can.input"/><span id="validNumosdcontent">1000</span><spring:message code="page.word"/></span>
						</td>
					</tr>
						<tr height="40px">
						<td colspan="4" align="center"><a href="javascript:goSend();" class="easyui-linkbutton"><spring:message code="authorize.sendcommand"/></a></td>
					</tr>
					
				</table>
			</div>
			<div style="margin:20px 0;"></div>
	
		</form>
	
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript">
		function goSend() {

		   	if($("#addressing_mode").val() == "0" && $("#stbno").val() == "" ){
				   $.dialog.tips('<spring:message code="authorize.stbno.empty"/>', 1, 'alert.gif');
				   $("#cardid").focus();
				   return;
			}else if($("#addressing_mode").val() == "1"&& ( $("#startstbno").val() == ""|| $("#endstbno").val() == "")){
					$.dialog.tips('<spring:message code="authorize.addressingrange.empty"/>', 1, 'alert.gif');
					return;
			}
			$("#forceosdForm").attr("action", "authorize/saveMailForGN");
			$("#forceosdForm").submit();
		}
		
		function setAddressing(){
			if($("#addressing_mode").val()=="0"){
			    $("#singletag").show();
			    $("#rangetag").hide();
			}else{
			    $("#rangetag").show();
			    $("#singletag").hide();
			}
		}
		
		$(function() {
				setAddressing();
				var returninfo = '${authorizeParamForPages.returninfo}';
		        if (returninfo != '') {
		        	 $.dialog.tips(returninfo, 1, 'alert.gif');
		        }
		});

	</script>
</body>
</html>