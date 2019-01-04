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
  <style type="text/css">
	.fb-con table tr {
	      height: 30px;
	    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.server"/> &gt; <spring:message code="server.serverupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${server.server.id}"/>
    <input type="hidden" name="querynetid" id="querynetid" value="${server.querynetid}"/>
    <input type="hidden" name="queryservertype" id="queryservertype" value="${server.queryservertype}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${server.pager_offset }"/>
   <div class="form-box">
      <div class="fb-tit"><spring:message code="server.serverupdate"/></div>
      <div class="fb-con">
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right"><spring:message code="server.servername"/>：</td>
            <td>
              <input type="text" class="inp" name="servername" id="servername" value="${server.server.servername }"> <span class="red">*</span>
            </td>
          </tr>
          <tr id="versiontypeTr" style="display:none">
          	<td align="right"><spring:message code="server.ip"/>：</td>
            <td>
              <input type="text" class="inp" name="ip" id="ip" value="${server.server.ip }">
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="server.port"/>：</td>
            <td>
              <input type="text" class="inp" name="port" id="port" value="${server.server.port }">
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateServer();" id="btnfinish">
        </cite>
        <span class="red">${server.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" charset="utf-8" src="js/common/areaChoose.js"></script>
<script type="text/javascript" src="js/comtools.js"></script>
<script type="text/javascript">

  function updateServer() {
      if ($('#servername').val() == '') {
          $.dialog.tips('<spring:message code="server.servername.empty"/>', 1, 'alert.gif');
          $('#servername').focus();
          return;
      }

      $('#updateform').attr('action', 'server/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "server/findByList");
      $("#updateform").submit();
  }
  
  
  $(function () {
      changeServertype();
      var returninfo = '${server.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
  });
  
   function changeServertype(){
		if($("#servertype").val()=="cas"){
		    $("#versiontypeTr").show();
		}else{
		    $("#versiontypeTr").hide();
		}
	}
</script>
</body>
</html>
