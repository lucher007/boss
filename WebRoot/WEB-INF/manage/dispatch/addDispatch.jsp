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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.dispatchadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="dispatch.dispatchadd"/></div>
     	<input type="hidden" name="netid" id="netid" />
  		<input type="hidden" name="areacode" id="areacode"/>
     	<input type="hidden" id="problemtype" name="problemtype"/> 
      <div class="fb-con" align = "center">
      <table>
			<tr>
				<td align="right"><spring:message code="problemcomplaint.complaintcode"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="complaintcode" id="complaintcode" readonly="readonly" style="background:#eeeeee;"/>
					<input type="hidden" class="inp" name="complaintid" id="complaintid"  />
					<%-- 
					<input  type="button" class="btn-add" value="<spring:message code="page.select"/>" onclick="addDispatch();" id="btnfinish">
					 --%>
					<a href="javascript:addDispatch();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
				</td>
			</tr>
			<tr>
				<td align="right"><spring:message code="user.username"/>：</td>
				<td align="left" >
					<input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;" >
					<input type="hidden" name="userid" id="userid">
				</td>
			</tr>
			<tr style="height: 60px;">
	            <td align="right"><spring:message code="dispatch.content"/>：</td>
	            <td> 
					<textarea id="content" name="content" style="width:570px; height:80px;"
                       onKeyDown="checkLength('content',300)" onKeyUp="checkLength('content',300)">${dispatch.content}</textarea>
            			 <span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">300</span><spring:message code="page.word"/></span>
            	</td>
            </tr>
       </table>     
      </div>
      
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveDispatch();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveDispatch();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${dispatch.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  //判断是否为数字
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
  
  function saveDispatch() {
	  if ($('#userid').val() == '') {
	      $.dialog.tips('<spring:message code="dispatch.complaintno.empty"/>', 1, 'alert.gif');
	      $('#username').focus();
	      return;
	    }
	    $("#addForm").attr("action", "dispatch/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "dispatch/findByList?jumping=findDispatchList");
      $("#addForm").submit();
  }
  
  $(function () {
checkLength('content',300);
       var returninfo = '${dispatch.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
	 var complaintListDialog;
	 function addDispatch() {
	    complaintListDialog = $.dialog({
		    title: '<spring:message code="dispatch.complaintquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:dispatch/findProblemcomplaintListForDialog?querystate=0' 
		});
	 }
  
	function closeDialog(data){		
		complaintListDialog.close();
	/*     ${dataList.id }
	        ${dataList.userid }
	        ${dataList.user.username }
	        ${dataList.user.netid }
	        ${dataList.user.areacode }
	        ${dataList.problemtype }
	        ${dataList.complaintcode } */
		$("#complaintid").val(data[0]);
		$("#userid").val(data[1]);
		$("#username").val(data[2]);
		$("#netid").val(data[3]);
		$("#areacode").val(data[4]);
		$("#problemtype").val(data[5]);	
		$("#complaintcode").val(data[6]);	
		$("#content").val(data[7]);
	}
	
</script>
</body>
</html>
