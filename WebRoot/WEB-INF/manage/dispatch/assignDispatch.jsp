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
  <style></style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.assign"/></div>
  <form action="" method="post" id="assignform" name="assignform">
    <input type="hidden" name="id" id="id" value="${dispatch.dispatch.id}"/>
        <input type="hidden" name="complaintid" id="complaintid" value="${dispatch.dispatch.complaintid}"/>
    
    <input type="hidden" name="pager_offset" id="pager_offset" value="${dispatch.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="dispatch.assign"/></div>
      <div class="fb-con" align="center">
        <table border="0" cellpadding="0" cellspacing="0">
			<tr height="40px">
				<td align="right"><spring:message code="dispatch.dispatchcode"/>：</td>
				<td align="left"><input type="text" class="inp" name="id" id="id" readonly="readonly" style="background:#eeeeee;"  value = "${dispatch.dispatch.dispatchcode}" >
			    <input type="hidden"  name="operatorid" id="operatorid" value="${Operator.id}">
				</td>
			</tr>
			<tr height="40px">
				<td align="right"><spring:message code="user.username"/>：</td>
				<td align="left"><input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;"  value = "${dispatch.user.username }" >
				</td>
			</tr>
			<tr height="40px">
				<td align="right"><spring:message code="dispatch.dispatchercode"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="dispatchercode" id="dispatchercode" readonly="readonly" style="background:#eeeeee;"/>
					<%-- 
					<input  type="button" class="btn-add" value="<spring:message code="page.select"/>" onclick="selectDispatcher();" id="btnfinish">
					 --%>
					<a href="javascript:selectDispatcher();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
				</td>
			</tr>
			<tr height="40px">
				<td align="right"><spring:message code="dispatch.dispatchername"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="dispatchername" id="dispatchername" readonly="readonly" style="background:#eeeeee;"/>
					<input type="hidden"  name="dispatcherid" id="dispatcherid">
				</td>
			</tr>
       </table>     
      
      
      </div>
      <div class="fb-bom">
        <cite>
        	<%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
             --%>
            <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
            <c:if test="${dispatch.returninfo == null || dispatch.returninfo == ''}">
            	<%-- 
            	<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveAssign();" id="btnfinish">
            	 --%>
            	<a href="javascript:saveAssign();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
            </c:if>
        </cite>
        <span class="red">${dispatch.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">


 function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function goBack() {
     
    if ('${dispatch.dispatch.jumping}'== 'fromForAssign') {
      	$("#assignform").attr("action", "dispatch/findByList?jumping=findDispatchListForAssign&querystate=0");
      }
    if ('${dispatch.dispatch.jumping}'== 'fromForCheck') {
      		$("#assignform").attr("action", "dispatch/findByList?jumping=findDispatchListForCheck&querystate=34");
      }
      $("#assignform").submit();
  }
  
  function saveAssign() {
      if ($('#dispatcherid').val() == '') {
	      $.dialog.tips('<spring:message code="dispatch.dispatcherid.empty"/>', 1, 'alert.gif');
	      $('#dispatcherid').focus();
	      return;
	  }
	  if (!checkNumberChar($("#dispatcherid").val())) {
	        $.dialog.tips('<spring:message code="dispatch.dispatcherid.number"/>', 1, 'alert.gif');
	        $("#dispatcherid").focus();
	        return false;
	   }
      $("#assignform").attr("action", "dispatch/saveAssign?jumping="+'${dispatch.dispatch.jumping}');
      $("#assignform").submit();
  }
  
  
 $(function () {
       var returninfo = '${dispatch.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  	
  
  var dispatcherListDialog;
	 function selectDispatcher() {
	    dispatcherListDialog = $.dialog({
		    title: '<spring:message code="operator.operatorquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:operator/findOperatorListForDialog?queryoperatortype=2' 
		});
	 }
  
	function closeDialog(data){	
	   	
		dispatcherListDialog.close();
		$("#dispatcherid").val(data[0]);
		$("#dispatchercode").val(data[1]);
		$("#dispatchername").val(data[2]);
		
	}
 
 
</script>
</body>
</html>
