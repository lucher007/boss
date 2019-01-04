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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.giftcardamount"/> &gt; <spring:message code="giftcardamountpara.giftcardamountparaadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="giftcardamountpara.giftcardamountparaadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          
         <tr class="rangetag">
            <td align="right"><spring:message code="giftcardamountpara.giftcardamountparaparakey"/>：</td>
            <td>
             	<input type="text" class="inp" name="giftcardamountparakey" id="giftcardamountparakey">
            </td>
          </tr>
          
          <tr class="rangetag">
            <td align="right"><spring:message code="giftcardamountpara.giftcardamountparaamount"/>：</td>
            <td>
             	<input type="text" class="inp" name="giftcardamountpara" id="giftcardamountpara" onkeyup="checkNumberChar(this)">
            </td>
          </tr>
          
        </table>
      </div>
      <div class="fb-bom">
	        <cite>
		          <span><input type="button" class="btn-back" value="<spring:message code="page.goback" />" onclick="goBack()" /></span>
		          <span><input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveCard();"/></span>
	        </cite>
        	<span class="red">${card.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript">

  //判断是否为数字
  function checkNumberChar(ob) {
  debugger;
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function saveCard() {

	    if ($('#giftcardamountparakey').val() == '') {
	      $.dialog.tips('<spring:message code="giftcardamountpara.giftcardamountparaparakey.empty"/>', 1, 'alert.gif');
	      $('#giftcardamountparakey').focus();
	      return;
	    }
	    
        if ($('#giftcardamountpara').val() == '') {
	      $.dialog.tips('<spring:message code="giftcardamountpara.giftcardamountparaamount.empty"/>', 1, 'alert.gif');
	      $('#giftcardamountpara').focus();
	      return;
	    }

	    $("#addForm").attr("action", "giftcardamount/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "giftcardamount/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${card.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
</script>
</body>
</html>
