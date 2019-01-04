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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.helpinfo"/> &gt; <spring:message code="helpinfo.helpinfoupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${helpinfo.helpinfo.id}"/>
    <input type="hidden" name="querytype" id="querystoreid" value="${helpinfo.querytype}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${helpinfo.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="helpinfo.helpinfoupdate"/></div>
      <div class="fb-con">
       <table>
          <tr>
            <td width="15%" align="right"><spring:message code="helpinfo.type"/>：</td>
            <td width="65%">
              <select id="type" name="type" class="select">
                  <option value="0" <c:if test="${helpinfo.helpinfo.type == '0'}">selected</c:if>><spring:message code="helpinfo.type.0"/></option>
                  <option value="1" <c:if test="${helpinfo.helpinfo.type == '1'}">selected</c:if>><spring:message code="helpinfo.type.1"/></option>
              </select>
            </td>
          </tr>
          <tr style="height: 60px;">
            <td align="right"><spring:message code="helpinfo.question"/>：</td>
            <td> 
				<textarea id="question" name="question" style="width:570px; height:80px;"
                      onKeyDown="checkLength('question',300)" onKeyUp="checkLength('content',300)">${helpinfo.helpinfo.question}</textarea>
           			 <span class="red"><spring:message code="page.can.input"/><span id="validNumquestion">300</span><spring:message code="page.word"/></span>
           	</td>
          </tr>
          <tr style="height: 60px;">
            <td align="right"><spring:message code="helpinfo.answer"/>：</td>
            <td> 
				<textarea id="answer" name="answer" style="width:570px; height:80px;"
                      onKeyDown="checkLength('answer',300)" onKeyUp="checkLength('content',300)">${helpinfo.helpinfo.answer}</textarea>
           			 <span class="red"><spring:message code="page.can.input"/><span id="validNumanswer">300</span><spring:message code="page.word"/></span>
           	</td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateHelpinfo();" id="btnfinish">
        </cite>
        <span class="red">${helpinfo.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" charset="utf-8" src="js/common/helpinfoChoose.js"></script>
<script type="text/javascript" src="js/comtools.js"></script>
<script type="text/javascript">

  function updateHelpinfo() {
  
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
		
      $('#updateform').attr('action', 'helpinfo/update');
      $("#updateform").submit();
  }
	
  function goBack() {
      $("#updateform").attr("action", "helpinfo/findByList");
      $("#updateform").submit();
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
