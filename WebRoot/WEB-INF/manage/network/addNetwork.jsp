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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.network"/> &gt; <spring:message code="network.networkadd"/></div>
  <form action="network!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="network.networkadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="network.netid"/>：</td>
            <td width="25%">
              <input type="text" class="inp" name="netid" id="netid" value="${network.netid}" maxlength="5" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"><span class="red"> *</span>
            </td>
            <td width="15%" align="right"><spring:message code="network.pid"/>：</td>
            <td width="25%">
              <select id="pid" name="pid" class="select">
                
              </select>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="network.netname"/>：</td>
            <td>
              <input type="text" class="inp"  name="netname" id="netname" value="${network.netname }" 
              maxlength="30" ><span class="red"> *</span>
            </td>
            <td align="right"><spring:message code="network.nettype"/>：</td>
            <td>
              <select name="nettype" id="nettype" class="select">
                <option value="1" <c:if test="${network.nettype == '1' }">selected</c:if>><spring:message code="network.nettype.1"/></option>
                <option value="0" <c:if test="${network.nettype == '0' }">selected</c:if>><spring:message code="network.nettype.0"/></option>
              </select>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveNetwork();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveNetwork();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${network.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
  
  function initNetwork(){
    	$.getJSON('network/initNetworkJson?rid='+Math.random(), null, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#pid').children().remove();
		     $('#pid').append(options);
		     $('#pid').val('${network.pid}');
	   });
    }
  
  //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function saveNetwork() {
        $("#netid").val($.trim($("#netid").val()));
	    if ($('#netid').val() == '') {
	       $.dialog.tips('<spring:message code="network.netid.empty"/>', 1, 'alert.gif');
	       $('#netid').focus();
	       return;
	    } else if (!/^\d+$/.test($('#netid').val())) {
	       $.dialog.tips('<spring:message code="network.netid.number"/>', 1, 'alert.gif');
	       $('#netid').focus();
	       return;
	    }
	    $("#netname").val($.trim($("#netname").val()));
	    if ($('#netname').val() == '') {
	      $.dialog.tips('<spring:message code="network.netname.empty"/>', 1, 'alert.gif');
	      $('#netname').focus();
	      return;
	    }
	    $("#addForm").attr("action", "network/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "network/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       initNetwork();
       var returninfo = '${network.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
</script>
</body>
</html>
