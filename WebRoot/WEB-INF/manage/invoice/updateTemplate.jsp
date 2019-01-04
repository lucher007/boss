<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!doctype html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title></title>
  <link type="text/css" rel="stylesheet" href="style/user.css">
  <link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
  <link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
  <style>
    .fb-con table tr {
      height: 30px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.invoicetemplate"/> &gt; <spring:message code="print.template.update"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="print.template.update"/></div>
      <div class="fb-con" align = "center">
      <input type="hidden" name="value" id="value" readonly="readonly" value='${printtemplate.printtemplate.value}' />
      <input type="hidden" name="id" id="id" readonly="readonly" value='${printtemplate.printtemplate.id}' />
      <input type="hidden" name="code" id="code" readonly="readonly" value="${printtemplate.printtemplate.code}"/>
      <table>
			<tr height="50px">
				<td align="right"><spring:message code="print.template.name"/>：</td>
				<td align="left" colspan="2">
					<input type="text" class="inp" name="name" id="name" maxlength="10" value="${printtemplate.printtemplate.name}"/>
				</td>
			</tr>
			
			<tr height="50px">
		      	<td colspan="3" align="center">
				  	<a  class="btn-edit" href="javascript:loadTemplate();"><spring:message code="print.template.adjust"/></a>
	      		</td>
      		</tr>
       </table>
      </div>
      
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateTemplate();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:updateTemplate();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${printtemplate.returninfo}</span>
      </div>
    
    </div>
  </form>
</div>

<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lodop/LodopFuncs.js"></script>
<script type="text/javascript">

  var basepath = '<%=basePath%>';
  var LODOP; 
  var needupdate = '<spring:message code="print.plugin.update"/>';
  var needinstall = '<spring:message code="print.plugin.install"/>';
  var install =  '<spring:message code="print.plugin.excuteinstall"/>';
  var update =  '<spring:message code="print.plugin.excuteupdate"/>';
  var refresh =  '<spring:message code="print.plugin.refresh"/>';
  var notready = '<spring:message code="print.plugin.notready"/>';
  var error = '<spring:message code="print.plugin.error"/>';

function loadTemplate(){
	LODOP=getLodop(); 		
	eval($('#value').val()); 
	if (LODOP.CVERSION) LODOP.On_Return=function(TaskID,Value){ $('#value').val(Value);};	
	$('#value').val(LODOP.PRINT_DESIGN());	
} 

function updateTemplate() {
	if($('#name').val() == ''){
		$.dialog.tips('<spring:message code="print.templatename.empty"/>', 1, 'alert.gif');
				return;
	}
 	$("#addForm").attr("action", "print/update");
   	$("#addForm").submit(); 
}

function goBack() {
    $("#addForm").attr("action", "print/findByList");
    $("#addForm").submit(); 
	}
 
 $(function () {
      var returninfo = '${printtemplate.returninfo}';
      if (returninfo != '') {
       	$.dialog.tips(returninfo, 1, 'alert.gif');
      }
 });

function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
 }
  
 function checkLength(object, maxlength) {
   var obj = $('#' + object),
       value = $.trim(obj.val());
   if (value.length > maxlength) {
     obj.val(value.substr(0, maxlength));
   } else {
     $('#validNum' + object).html(maxlength - value.length);
   }
 }
  
</script>
</body>
</html>
