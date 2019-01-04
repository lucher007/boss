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
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="problemcomplaint.problemcomplaintadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="problemcomplaint.problemcomplaintadd"/></div>
      <div class="fb-con" align = "center">
      <table>
				 <tr height="55px">
					<td align="right" ><spring:message code="user.username"/>：</td>
					<td align="left">
						<input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;" >
						<input type="hidden" name="userid" id="userid">
						<%-- 
						<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="selectUser();">
						 --%>
						<a href="javascript:selectUser();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
					</td>
				</tr>
				 
				 <tr height="40px">
					<td align="right"><spring:message code="problemcomplaint.type"/>：</td>
					<td align="left">
		    			 <select id="type" name="type" class="select">
			                   <option value="0" <c:if test="${problemcomplaint.type == '0'}">selected</c:if>><spring:message code="problemcomplaint.type.0" /></option>
			                   <option value="1" <c:if test="${problemcomplaint.type == '1'}">selected</c:if>><spring:message code="problemcomplaint.type.1" /></option>
			             </select>
					</td>
				</tr>
			
				<tr height="40px">
					<td align="right"><spring:message code="problemcomplaint.problemtype"/>：</td>
					<td align="left">
		   		 		<select id="problemtype" name="problemtype" class="select">
		                   <option value="1" <c:if test="${problemcomplaint.problemtype == '1'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.1"/></option>
		                   <option value="2" <c:if test="${problemcomplaint.problemtype == '2'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.2"/></option>
		             	   <option value="0" <c:if test="${problemcomplaint.problemtype == '0'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.0"/></option>
		             	</select>
					  </td>
				</tr>   
			
				<tr height="100px">
		            <td align="right"><spring:message code="problemcomplaint.content"/>：</td>
					<td align="left">
		            <textarea id="content" name="content" style="width:570px; height:80px;"
		                        onKeyDown="checkLength('content',300)" onKeyUp="checkLength('content',300)">${problemcomplaint.content}</textarea>
		              <span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">300</span><spring:message code="page.word"/></span>
		            </td>
	           </tr>
       </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveProblemcomplaint();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveProblemcomplaint();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${problemcomplaint.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
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

  function saveProblemcomplaint() {
	  if ($('#userid').val() == '') {
	      $.dialog.tips('<spring:message code="problemcomplaint.user.empty"/>', 1, 'alert.gif');
	      $('#username').focus();
	      return;
	  }
      $("#addForm").attr("action", "problemcomplaint/save");
      $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "problemcomplaint/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${problemcomplaint.returninfo}';
       checkLength('content',300);
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
	
	 var selectUserDialog;
	 function selectUser() {
	    selectUserDialog = $.dialog({
		    title: '<spring:message code="user.userquery"/>',
		    lock: true,
		    width: 950,
		    height: 650,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:statreport/selectUserListForDialog'
		});
	 }
  
	function closeUserDialog(jsonStr){
		selectUserDialog.close();
		//将json字符串转换成json对象
	    var jsonObject =  eval("(" + jsonStr +")");
		$("#userid").val(jsonObject.id);
		$("#username").val(jsonObject.username);
	}
  
  
</script>
</body>
</html>
