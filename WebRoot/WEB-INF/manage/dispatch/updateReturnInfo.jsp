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
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.updatereturninfo"/></div>
  <form action="" method="post" id="assignform" name="assignform">
    <input type="hidden" name="id" id="id" value="${dispatch.dispatch.id}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${dispatch.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="dispatch.returninfo"/></div>
      <div class="fb-con" align="center">
        <table>
			<tr height="40px">
				<td align="right"><spring:message code="dispatch.dispatchcode"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="dispatchcode" id="dispatchcode" readonly="readonly" style="background:#eeeeee;"  value = "${dispatch.dispatch.dispatchcode}" >
				    <input type="hidden"  name="operatorid" id="operatorid" value="${Operator.id}">
				</td>
			</tr>
			
			<tr height="40px">
				<td align="right"><spring:message code="user.username"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="username" id="username" readonly="readonly" style="background:#eeeeee;"  value = "${dispatch.user.username }" >
				</td>
			</tr>

			<tr height="40px">
				<td align="right"><spring:message code="dispatch.dispatchername"/>：</td>
				<td align="left">
					<input type="text" class="inp" name="dispatchername" id="dispatchername" readonly="readonly" style="background:#eeeeee;"value = "${dispatch.worker.operatorname }"/>
					<input type="hidden"  name="dispatcherid" id="dispatcherid" value="${dispatch.dispatch.dispatcherid}">
				</td>
			</tr>
		
			<tr height="40px">
				<td align="right"><spring:message code="dispatch.state"/>：</td>
				<td align="left">
      				<select id="state" name="state" class="select">
	                   <option value="3" <c:if test="${dispatch.dispatch.state == '3'}">selected</c:if>><spring:message code="dispatch.state.3" /></option>
	                   <option value="4" <c:if test="${dispatch.dispatch.state == '4'}">selected</c:if>><spring:message code="dispatch.state.4" /></option>
			        </select>
				</td>
			</tr>
			
			<tr height="40px">
				 <td align="right"><spring:message code="dispatch.dealdate"/>：</td>
				 <td align="left">
	                 <input type="text" id="dealdate" name="dealdate" value="${dispatch.dealdate}" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd  HH:mm:ss'});" class="Wdate inp w150" />
	             </td>	
			</tr>

			<tr height="60px">
            	<td align="right"><spring:message code="dispatch.result"/>：</td>
            	<td>
            		<textarea id="dealresult" name="dealresult" style="width:570px; height:80px;" onKeyDown="checkLength('dealresult',300)" onKeyUp="checkLength('dealresult',300)">${dispatch.dealresult }</textarea>
                	<span class="red"><spring:message code="page.can.input"/><span id="validNumdealresult">300</span><spring:message code="page.word"/></span>
            	</td>
         	 </tr>
       
       </table>     
      </div>
     
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateReturnInfo();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateReturnInfo();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${dispatch.returninfo}</span>
      </div>
  
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" charset="utf-8" src="js/common/areaChoose.js"></script>
 <script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/comtools.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">


 function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function goBack() {
      $("#assignform").attr("action", "dispatch/findByList?jumping=findReturnDispatchList&querystate=12");
      $("#assignform").submit();
  }
  
    function updateReturnInfo() {
        if ($('#state').val() == '') {
	      $.dialog.tips('<spring:message code="dispatch.state.empty"/>', 1, 'alert.gif');
	      $('#state').focus();
	      return;
	    }
       
       if ($('#dealdate').val() == '') {
	      $.dialog.tips('<spring:message code="dispatch.dealdate.empty"/>', 1, 'alert.gif');
	     // $('#dealdate').focus();
	      return;
	    }
 
      $("#assignform").attr("action", "dispatch/updateReturnInfo");
      $("#assignform").submit();
  }
  
  
 $(function () {
      checkLength('dealresult',300);
       var returninfo = '${dispatch.returninfo}';
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
