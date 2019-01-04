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
  <style> </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="problemcomplaint.problemcomplaintupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${problemcomplaint.problemcomplaint.id}"/>
    <input type="hidden" name="querynetid" id="querynetid" value="${problemcomplaint.querynetid }"/>
    <input type="hidden" name="queryareacode" id="queryareacode" value="${problemcomplaint.queryareacode }"/>
    <input type="hidden" name="querytype" id="querytype" value="${problemcomplaint.querytype }"/>
    <input type="hidden" name="queryusername" id="queryusername" value="${problemcomplaint.queryusername }"/>
    <input type="hidden" name="querystate" id="querystate" value="${problemcomplaint.querystate }"/>
    <input type="hidden" name="queryproblemtype" id="queryproblemtype" value="${problemcomplaint.queryproblemtype }"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${problemcomplaint.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="problemcomplaint.problemcomplaintupdate"/>:</div>
      <div class="fb-con" align = "center">
        <table>
          <tr height="40px">
	          <td align="right"><spring:message code="user.username"/>：</td>
			  <td align="left">
	   			<input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;" value="${problemcomplaint.username }" >
				<input type="hidden" name="userid" id="userid" value = "${problemcomplaint.problemcomplaint.userid }">
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
                   <option value="0" <c:if test="${problemcomplaint.problemcomplaint.type == '0'}">selected</c:if>><spring:message code="problemcomplaint.type.0"/></option>
                   <option value="1" <c:if test="${problemcomplaint.problemcomplaint.type == '1'}">selected</c:if>><spring:message code="problemcomplaint.type.1"/></option>
		         </select>
			</td>	
		  </tr> 
          
          <tr height="40px">
			<td align="right" ><spring:message code="problemcomplaint.problemtype"/>：</td>
			  <td align="left">
     		 	<select id="problemtype" name="problemtype" class="select">
	                   <option value="0" <c:if test="${problemcomplaint.problemcomplaint.problemtype == '0'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.0"/></option>
	                   <option value="1" <c:if test="${problemcomplaint.problemcomplaint.problemtype == '1'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.1"/></option>
	                   <option value="2" <c:if test="${problemcomplaint.problemcomplaint.problemtype == '2'}">selected</c:if>><spring:message code="problemcomplaint.problemtype.2"/></option>
             	</select>
		    </td>
		 </tr>   

          <tr height="40px">
			<td align="right" ><spring:message code="problemcomplaint.state"/>：</td>
			  <td align="left">
     		 		<select id="state" name="state" class="select">
		                   <option value="0" <c:if test="${problemcomplaint.problemcomplaint.state == '0'}">selected</c:if>><spring:message code="problemcomplaint.state.0"/></option>
		                   <option value="1" <c:if test="${problemcomplaint.problemcomplaint.state == '1'}">selected</c:if>><spring:message code="problemcomplaint.state.1"/></option>
		                   <option value="3" <c:if test="${problemcomplaint.problemcomplaint.state == '3'}">selected</c:if>><spring:message code="problemcomplaint.state.3"/></option>
		                   <option value="4" <c:if test="${problemcomplaint.problemcomplaint.state == '4'}">selected</c:if>><spring:message code="problemcomplaint.state.4"/></option>
	            	</select>
		    </td>
		  </tr> 
          
          <tr height="40px">
            <td align="right"><spring:message code="problemcomplaint.content"/>：</td>
            <td  colspan="3">  <textarea id="content" name="content" style="width:570px; height:80px;"
                        onKeyDown="checkLength('content',300)" onKeyUp="checkLength('content',300)">${problemcomplaint.problemcomplaint.content}</textarea>
            <span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">300</span><spring:message code="page.word"/></span>
            </td>
          </tr>
        </table>
      
      
      
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateProblemcomplaint();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:updateProblemcomplaint();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${problemcomplaint.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" charset="utf-8" src="js/common/areaChoose.js"></script>
<script type="text/javascript" src="js/comtools.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  function updateProblemcomplaint() {
     if ($('#userid').val() == '') {
	      $.dialog.tips('<spring:message code="problemcomplaint.user.empty"/>', 1, 'alert.gif');
	      $('#username').focus();
	      return;
	    }
      $('#updateform').attr("action", "problemcomplaint/update");
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "problemcomplaint/findByList");
      $("#updateform").submit();
  }
  
  
 $(function () {
     checkLength('content',300);
       var returninfo = '${problemcomplaint.returninfo}';
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
