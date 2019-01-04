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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.giftcard"/> &gt; <spring:message code="giftcard.giftcardadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="giftcard.giftcardadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td height="30" width="15%" align="right"><spring:message code="giftcard.batchno"/>：</td>
            <td width="25%">
             	<input type="text" readonly="readonly" id="batchno" name="batchno" value="${giftcard.batchno}" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyyMMdd'});" class="Wdate inp w150" />
            </td>
          </tr>
          <tr>
            <td width="15%" align="right"><spring:message code="giftcard.amountpara"/>：</td>
            <td width="25%">
             <select id="amountpara" name="amountpara" class="select">
                <c:forEach items="${giftcard.amountparalist}" var="amountpara" varStatus="s">
                  <option value="${amountpara.parakey}" <c:if test="${amountpara.parakey == giftcard.amountpara}">selected</c:if>>${amountpara.amount}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
            <td width="15%" align="right"><spring:message code="giftcard.number"/>：</td>
            <td width="25%">
            	<input type="text" class="inp" name=number id="number" 
            	maxlength="3" 
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')" 
            	value="${giftcard.number }"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveGiftcard();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveGiftcard();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${giftcard.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
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

  function saveGiftcard() {
	    if ($('#batchno').val() == '') {
	      $.dialog.tips('<spring:message code="giftcard.batchno.empty"/>', 1, 'alert.gif');
	      $('#batchno').focus();
	      return;
	    }
	    
	    if ($('#amountpara').val() == '') {
	      $.dialog.tips('<spring:message code="giftcard.amountpara.empty"/>', 1, 'alert.gif');
	      $('#amountpara').focus();
	      return;
	    }
	    
	    if ($('#number').val() == '') {
	      $.dialog.tips('<spring:message code="giftcard.number.empty"/>', 1, 'alert.gif');
	      $('#number').focus();
	      return;
	    }
	   
	    $("#addForm").attr("action", "giftcard/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "giftcard/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${giftcard.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
</script>
</body>
</html>
