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
  <style>
    .fb-con table tr {
      height: 30px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.systempara"/> &gt; <spring:message code="systempara.systemparaadd"/></div>
  <form action="systempara!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="systempara.systemparaadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="systempara.code"/>：</td>
            <td width="25%">
            	<input type="text" class="inp" name="code" id="code" value="${systempara.code }"><span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="systempara.name"/>：</td>
            <td>
              <input type="text" class="inp" name="name" id="name" value="${systempara.name }">
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="systempara.value"/>：</td>
            <td>
              <input type="text" class="inp" name="value" id="value" value="${systempara.value }">
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveSystempara();"/>
        </cite>
        <span class="red">${systempara.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/comtools.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">

  //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function saveSystempara() {
	    if ($('#code').val() == '') {
	      $.dialog.tips('<spring:message code="systempara.code.empty"/>', 1, 'alert.gif');
	      $('#code').focus();
	      return;
	    }
	   
	    $("#addForm").attr("action", "systempara/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "systempara/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${systempara.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
</script>
</body>
</html>
