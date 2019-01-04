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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.service"/> &gt; <spring:message code="service.serviceupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${service.service.id}"/>
    <input type="hidden" name="state" id="state" value="${service.service.state}"/>
    <input type="hidden" name="querynetid" id="querynetid" value="${service.querynetid }"/>
    <input type="hidden" name="querystate" id="querystate" value="${service.querystate }"/>
    <input type="hidden" name="queryserviceid" id="queryserviceid" value="${service.queryserviceid }"/>
    <input type="hidden" name="queryservicename" id="queryservicename" value="${service.queryservicename }"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${service.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="service.serviceupdate"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
            <td style="width: 25%; font-weight: bold;">
            	 <input type="hidden" name="netid" id="netid" value="${service.service.netid }"/>
            	${service.network.netname}
            </td>
          </tr>
		  <tr>
          	<td height="30" width="15%" align="right"><spring:message code="service.serviceid"/>：</td>
            <td width="25%">
            	<input type="text" class="inp" name=serviceid id="serviceid" 
            	maxlength="5" 
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	value="${service.service.serviceid }"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="service.servicename"/>：</td>
            <td>
              <input type="text" class="inp" name=servicename id="servicename" 
                maxlength="20"
              	value="${service.service.servicename }">
            </td>
          </tr>
          <tr style="display:none">
            <td align="right"><spring:message code="service.chargetype"/>：</td>
            <td>
              <select name="chargetype" id="chargetype" class="select" onchange="changeChargetype();">
              	  <option value="0" <c:if test="${service.service.chargetype == '0' }">selected</c:if>><spring:message code="service.chargetype.0"/></option>
              	  <option value="1" <c:if test="${service.service.chargetype == '1' }">selected</c:if>><spring:message code="service.chargetype.1"/></option>
              </select>
            </td>
          </tr>
          <tr id="pricepermonthTr" style="display:none">
            <td align="right"><spring:message code="service.pricepermonth"/>(/<spring:message code="para.unit.month"/>)：</td>
            <td>
             	<input type="text" class="inp" name="pricepermonth" id="pricepermonth" value="${service.service.pricepermonth }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10">
            	<span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateService();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateService();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${service.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  function updateService() {
      if ($('#serviceid').val() == '') {
          $.dialog.tips('<spring:message code="service.serviceid.empty"/>', 1, 'alert.gif');
          $('#serviceid').focus();
          return;
      }
      
      if ($('#chargetype').val() == '1' && $('#pricepermonth').val() == '') {
	      $.dialog.tips('<spring:message code="service.pricepermonth.empty"/>', 1, 'alert.gif');
	      $('#pricepermonth').focus();
	      return;
	    }
      
      $('#updateform').attr('action', 'service/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "service/findByList");
      $("#updateform").submit();
  }
  
  
 $(function () {
        //判断是否能单独购买
	   changeChargetype();
       
       var returninfo = '${service.service.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
   //判断是否能单独购买
	function changeChargetype(){
		if($("#chargetype").val()=="1"){
		    $("#pricepermonthTr").show();
		}else{
		    $("#pricepermonthTr").hide();
		}
	}
	
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
