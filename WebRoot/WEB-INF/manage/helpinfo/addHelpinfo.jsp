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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.helpinfo"/> &gt; <spring:message code="helpinfo.helpinfoadd"/></div>
  <form action="helpinfo!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="helpinfo.helpinfoadd"/></div>
      <div class="fb-con">
        <table>
          <tr>
            <td width="15%" align="right"><spring:message code="helpinfo.type"/>：</td>
            <td width="65%">
              <select id="type" name="type" class="select">
                  <option value="0" <c:if test="${helpinfo.type == '0'}">selected</c:if>><spring:message code="helpinfo.type.0"/></option>
                  <option value="1" <c:if test="${helpinfo.type == '1'}">selected</c:if>><spring:message code="helpinfo.type.1"/></option>
              </select>
            </td>
          </tr>
          <tr style="height: 60px;">
            <td align="right"><spring:message code="helpinfo.question"/>：</td>
            <td> 
				<textarea id="question" name="question" style="width:570px; height:80px;"
                      onKeyDown="checkLength('question',300)" onKeyUp="checkLength('content',300)">${helpinfo.question}</textarea>
           			 <span class="red"><spring:message code="page.can.input"/><span id="validNumquestion">300</span><spring:message code="page.word"/></span>
           	</td>
          </tr>
          <tr style="height: 60px;">
            <td align="right"><spring:message code="helpinfo.answer"/>：</td>
            <td> 
				<textarea id="answer" name="answer" style="width:570px; height:80px;"
                      onKeyDown="checkLength('answer',300)" onKeyUp="checkLength('content',300)">${helpinfo.answer}</textarea>
           			 <span class="red"><spring:message code="page.can.input"/><span id="validNumanswer">300</span><spring:message code="page.word"/></span>
           	</td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveHelpinfo();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveHelpinfo();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${helpinfo.returninfo}</span>
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

  function saveHelpinfo() {
	    $("#question").val($.trim($("#question").val()));
	    if ($('#question').val() == '') {
	      $.dialog.tips('<spring:message code="helpinfo.question.empty"/>', 1, 'alert.gif');
	      $('#question').focus();
	      return;
        }
	   
	   $("#answer").val($.trim($("#answer").val()));
	    if ($('#answer').val() == '') {
	      $.dialog.tips('<spring:message code="helpinfo.answer.empty"/>', 1, 'alert.gif');
	      $('#answer').focus();
	      return;
	    }
	   
	    $("#addForm").attr("action", "helpinfo/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "helpinfo/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       checkLength('question',300);
       checkLength('answer',300);
       var returninfo = '${helpinfo.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  
function checkLength(object, maxlength) {
    var obj = $('#' + object),
        value = $.trim(obj.val());
    if (value.length > maxlength) {
      obj.val(value.substr(0, maxlength));
    } else {
      $('#validNum' + object).html(maxlength - value.length);
    }
  }
  
</script>
</body>
</html>
