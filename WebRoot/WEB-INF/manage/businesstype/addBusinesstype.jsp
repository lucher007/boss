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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.businesstype"/> &gt; <spring:message code="businesstype.businesstypeadd"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="querytypekey" id="querytypekey" value="${businesstype.querytypekey }"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${businesstype.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="businesstype.businesstypeadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="businesstype.typekey"/>：</td>
            <td width="25%">
              <input type="text" class="inp" style="width: 300px;" maxlength="50" name="typekey" id="typekey" value="${businesstype.typekey }">
            </td>
          </tr>
          
          <tr>
           	<td align="right"><spring:message code="business.type"/>：</td>
            <td>
              <input type="text" class="inp" style="width: 300px;" maxlength="50" name="typename" id="typename" value="${businesstype.typename}">
            </td>
          </tr>

          <tr>
            <td align="right"><spring:message code="businesstype.price"/>：</td>
            <td >
              <input type="text" name="price" id="price" value="${businesstype.price }" class="easyui-numberbox" data-options="precision:2" maxlength="10">
            </td>
          </tr>
          
           <%-- <tr>
           	<td align="right"><spring:message code="发票打印费项名称"/>：</td>
            <td>
              <input type="text" class="inp" name="feename" id="feename" value="${businesstype.feename}">
            </td>
          </tr> --%>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveBusinesstype();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:saveBusinesstype();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${businesstype.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">

  function saveBusinesstype() {
	  
	  $('#typekey').val($.trim($("#typekey").val()));
	  $('#typename').val($.trim($("#typename").val()));
	  
	  if ($('#typekey').val() == '') {
		    $.dialog.tips('<spring:message code="业务类型KEY不能为空"/>', 1, 'alert.gif');
		    $('#typekey').focus();
	      return;
	  }
	  if ($('#typename').val() == '') {
		    $.dialog.tips('<spring:message code="业务类型名称不能为空"/>', 1, 'alert.gif');
		    $('#typekey').focus();
	      return;
	  }
	  
  	  if($('#price').val() == ''){
  	  	 $('#price').val(0);
  	  }
  	  
      $('#updateform').attr('action', 'businesstype/save');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "businesstype/findByList");
      $("#updateform").submit();
  }
  
  
  $(function () {
      var returninfo = '${businesstype.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
  });
</script>
</body>
</html>
