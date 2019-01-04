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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.dispatchupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${dispatch.dispatch.id}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${dispatch.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="dispatch.dispatchupdate"/>:</div>
      <div class="fb-con" align="center">
        <table>
			<tr>
				<td align="right"><spring:message code="user.username"/>：</td>
				<td align="left"><input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;"  value = "${dispatch.user.username }" >
					<input type="hidden" name="userid" id="userid" value = "${dispatch.dispatch.userid }">
				</td>
			</tr>
	
			<tr>	
				<td align="right"><spring:message code="dispatch.problemtype"/>：</td>
	      		<td align="left"> 
		      		<select id="problemtype" name="problemtype" class="select"> 
					        <option value="0" <c:if test="${dispatch.dispatch.problemtype == '0'}">selected</c:if>>
								<spring:message code= "dispatch.problemtype.0"/>
							</option>
							<option value="1"<c:if test="${dispatch.dispatch.problemtype == '1'}">selected</c:if>>
								<spring:message code= "dispatch.problemtype.1"/>
							</option>
							<option value="2"<c:if test="${dispatch.dispatch.problemtype == '2'}">selected</c:if>>
								<spring:message code= "dispatch.problemtype.2"/>
							</option>       
					</select>
				</td>
			</tr>
			<tr>
            	<td align="right"><spring:message code="dispatch.content"/>：</td>
            	<td align="left">  
            		<textarea id="content" name="content" style="width:500px; height:80px;"
                        onKeyDown="checkLength('content',300)" onKeyUp="checkLength('content',300)">${dispatch.dispatch.content}</textarea>
            		<span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">300</span><spring:message code="page.word"/></span>
            	</td>
          </tr>
       </table>     
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateDispatch();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateDispatch();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${dispatch.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">


 function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function updateDispatch() {
      $('#updateform').attr("action", "dispatch/update");
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "dispatch/findByList?jumping=findDispatchList");
      $("#updateform").submit();
  }
  
 $(function () {
		checkLength('content',300);
       var returninfo = '${dispatch.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
	var transferUserDialog;
	 function addUser() {
	    transferUserDialog = $.dialog({
		    title: '<spring:message code="menu.business.userquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:dispatch/findUserListForDialog' 
		});
	 }
  
   function checkLength(object, maxlength) {
    var obj = $('#' + object),
        value = $.trim(obj.val());
    if (value.length > maxlength) {
      obj.val(value.substr(0, maxlength));
    } else {
      $('#validNum' + object).html(maxlength - value.length);
    }
  }
  

	function closeDialog(data){
		transferUserDialog.close();
		$("#userid").val(data[0]);
		$("#netid").val(data[1]);
		$("#username").val(data[2]);
		$("#netname").val(data[3]);
	}
 
</script>
</body>
</html>
