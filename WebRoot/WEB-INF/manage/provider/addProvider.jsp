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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.provider"/> &gt; <spring:message code="provider.provideradd"/></div>
  <form action="provider!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="provider.provideradd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="35%" align="right"><spring:message code="provider.companyname"/>：</td>
            <td width="55%">
              <input type="text" class="inp" name="companyname" id="companyname" maxlength="80" value="${provider.companyname}" style="width:250px;" ><span class="red">*</span>
            </td>
          </tr>
          <tr>
             <td align="right"><spring:message code="provider.model"/>：</td>
             <td>
                <input type="text" class="inp" name="model" id="model" maxlength="80" value="${provider.model}" style="width:250px;"><span class="red">*</span>
             </td>
          </tr>
          <tr>
             <td align="right"><spring:message code="provider.type"/>：</td>
             <td>	
             	<select name="type" id="type" class="select">
             	  <option value="0" <c:if test="${provider.type == '0' }">selected</c:if>><spring:message code="provider.type.0"/></option>
              	  <option value="1" <c:if test="${provider.type == '1' }">selected</c:if>><spring:message code="provider.type.1"/></option>
                </select>
             </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="provider.mainprice"/>：</td>
            <td>
             	<input type="text" class="inp" name="mainprice" id="mainprice" value="${provider.mainprice }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="provider.subprice"/>：</td>
            <td>
             	<input type="text" class="inp" name="subprice" id="subprice" value="${provider.subprice }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveprovider();"/> --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
          <a href="javascript:saveprovider();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${provider.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
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

  function saveprovider() {
  		$("#companyname").val($.trim($("#companyname").val()));
	    if ($('#companyname').val() == '') {
	      $.dialog.tips('<spring:message code="provider.companyname.empty"/>', 1, 'alert.gif');
	      $('#companyname').focus();
	      return;
	    }
	    $("#model").val($.trim($("#model").val()));
	    if ($('#model').val() == '') {
	      $.dialog.tips('<spring:message code="provider.model.empty"/>', 1, 'alert.gif');
	      $('#model').focus();
	      return;
	    }
	    $("#mainprice").val($.trim($("#mainprice").val()));
	    if ($('#mainprice').val() == '') {
	      $.dialog.tips('<spring:message code="provider.mainprice.empty"/>', 1, 'alert.gif');
	      $('#mainprice').focus();
	      return;
	    } 
	    $("#subprice").val($.trim($("#subprice").val()));
	    if ($('#subprice').val() == '') {
	      $.dialog.tips('<spring:message code="provider.subprice.empty"/>', 1, 'alert.gif');
	      $('#subprice').focus();
	      return;
	    } 
	    
	    $("#addForm").attr("action", "provider/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "provider/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${provider.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
</script>
</body>
</html>
