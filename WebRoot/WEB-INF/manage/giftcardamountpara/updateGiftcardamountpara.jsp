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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.giftcardamount"/> &gt; <spring:message code="giftcardamountpara.giftcardamountparaupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${giftcardamountpara.giftcardamountpara.id}"/>
    <input type="hidden" name="parakey" id="parakey" value="${giftcardamountpara.giftcardamountpara.parakey}"/>
    <input type="hidden" name="querystate" id="querystate" value="${giftcardamountpara.giftcardamountpara.querystate}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${giftcardamountpara.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="giftcardamountpara.giftcardamountparaupdate"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right"><spring:message code="giftcardamountpara.giftcardamountparaparakey"/>：</td>
            <td style="font-weight: bold;">${giftcardamountpara.giftcardamountpara.parakey}</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="giftcardamountpara.giftcardamountparaamount"/>：</td>
            <td>
             	<input type="text" class="inp" name="amount" id="amount" value="${giftcardamountpara.giftcardamountpara.amount }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10">
            	<span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="giftcardamountpara.state"/>：</td>
            <td>
             	<select id="state" name="state" class="select">
					<option value="0" <c:if test="${giftcardamountpara.giftcardamountpara.state == '0'}">selected</c:if>><spring:message code="giftcardamountpara.state.0" /></option>
					<option value="1" <c:if test="${giftcardamountpara.giftcardamountpara.state == '1'}">selected</c:if>><spring:message code="giftcardamountpara.state.1" /></option>
				</select>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateGiftcardamountpara();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateGiftcardamountpara();" id="btnfinish" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${giftcardamountpara.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  function updateGiftcardamountpara() {
      
      if ($('#state').val() == '1' && $('#amount').val() == '') {
	      $.dialog.tips('<spring:message code="giftcardamountpara.giftcardamountparaamount.empty"/>', 1, 'alert.gif');
	      $('#amount').focus();
	      return;
	    }
      
      $('#updateform').attr('action', 'giftcardamountpara/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "giftcardamountpara/findByList");
      $("#updateform").submit();
  }
  
  
 $(function () {
       var returninfo = '${giftcardamountpara.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
	
	/////////////////////对必要的输入框进行数字合法验证，最多3位小数//////////////////////////
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
			obj.o_value = obj.value;
		}
		if(obj.value.match(/^\d+\.\d{3}?$/)){
		   obj.value = obj.value.substr(0,obj.value.length-1);
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^00+/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0\.00/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0[1-9]/)) {
				obj.value = "";
			}
			if(obj.value.match(/^\d+\.\d{3}?$/)){
				obj.value = obj.value.substr(0,obj.value.length-1);
			} 
			if(obj.value == 'undefined'){
				obj.value='';
			}
			
			updateAccountmoney();
	}
	
	function onkeyblurCheck(obj){
		if(obj.value==0){
				obj.value='';
		}
		if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
			obj.value = obj.o_value;
		}else {
			if (obj.value.match(/^\.\d+$/)) {
				obj.value = 0 + obj.value;
			}
			obj.o_value = obj.value;
		}
		if(!obj.value.match(/^\d+(\.\d{3})?$/)){
			obj.value = obj.value.substr(0,obj.value.indexOf(".")+3);
		} 
	}
	//////////////////////////////////////////////////////////////////////
</script>
</body>
</html>
