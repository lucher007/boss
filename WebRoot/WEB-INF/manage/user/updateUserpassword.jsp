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
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.updateuserpassword"/></div>
  <form method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="score" id="score" value="${user.user.score}"/>
    <input type="hidden" name="account" id="account" value="${user.user.account}"/>
    <input type="hidden" name="state" id="state" value="${user.user.state}"/>
    <div class="form-box">
      <%-- <div class="fb-tit" ><spring:message code="menu.business.updateuserpassword"/></div> --%>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--
          <tr>
            <td height="30" width="20%" align="right"><spring:message code="network.netname"/>：</td>
            <td width="25%">
             <select id="netid" name="netid" class="select" onchange="initArea();">
                <c:forEach items="${user.networkmap}" var="dataMap" varStatus="s">
                  <option value="${dataMap.key}" <c:if test="${dataMap.key == user.user.netid}">selected</c:if>>${dataMap.value}</option>
                </c:forEach>
              </select>
              <span class="red">*</span>
            </td>
            <td height="30" width="15%" align="right"><spring:message code="area.areaname"/>：</td>
			<td colspan="3">
				<input class="easyui-combotree"  data-options="" id="areacode" name="areacode" style="width:40%" >
				<span class="red">*</span>
			</td>
          </tr>
            -->
          <tr class="fbc-tit">
	        <td colspan="7" style="font-weight: bold;"><spring:message code="menu.business.updateuserpassword"/></td>
	        <td>
	        	 <%-- 
	       <input type="button" class="btn-back" value="<spring:message code="page.switch"/>" onclick="switchUser('<spring:message code="menu.business.userquery"/>')" >
	        --%>
	        	 <a href="javascript:switchUser('<spring:message code="menu.business.userquery"/>');" class="easyui-linkbutton" id="switchButton" iconCls="icon-back" style="width:80px"><spring:message code="page.switch"/></a>
	        </td>
	      </tr>
          <tr>
            <td height="30" width="20%" align="right"><spring:message code="network.netname"/>：</td>
            <td style="width: 35%; font-weight: bold;">${user.user.network.netname }
            	<input type="hidden" class="inp" name="netid" id="netid" value="${user.user.netid }">
            </td>
            <td height="30" width="15%" align="right"><spring:message code="area.areacode"/>：</td>
			<td style="width: 35%; font-weight: bold;">${user.user.area.areaname}(${user.user.area.areacode})
				<input type="hidden" class="inp" name="areacode" id="areacode" value="${user.user.areacode }">
			</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.username"/>：</td>
          	<td style="width: 35%; font-weight: bold;">${user.user.username }
				<input type="hidden" class="inp" name="username" id="username" value="${user.user.username }"
				maxlength="50" 
				>
			</td>
			<td align="right"><spring:message code="user.userlevel"/>：</td>
            <td style="width: 35%; font-weight: bold;">${user.user.userlevel.levelname }
            	<input type="hidden" class="inp"  name="mobile" id="mobile" value="${user.user.mobile }"
            	maxlength="15" 
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')"
            	>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.telephone"/>：</td>
            <td style="width: 35%; font-weight: bold;">${user.user.telephone }
            	<input type="hidden" class="inp" name="telephone" id="telephone" value="${user.user.telephone }"
            	maxlength="15" 
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </td>
            <td align="right"><spring:message code="user.email"/>：</td>
          	<td style="width: 35%; font-weight: bold;">${user.user.email }
				<input type="hidden" class="inp" name="email" id="email" value="${user.user.email }"
				maxlength="50" 
				>
			</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.documenttype"/>：</td>
            <td style="width: 35%; font-weight: bold;">${user.user.documenttype }
            	<input type="hidden" class="inp" name="documenttype" id="documenttype" value="${user.user.documenttype }"
            	maxlength="50" >
            </td>
            <td align="right"><spring:message code="user.documentno"/>：</td>
          	<td style="width: 35%; font-weight: bold;">${user.user.documentno }
				<input type="hidden" class="inp" name="documentno" id="documentno" value="${user.user.documentno }"
				maxlength="50" >
			</td>
          </tr>
          <tr>
          	<td align="right"><spring:message code="user.password"/>：</td>
          	<td>
				<input type="text" class="inp" name="password" id="password" value="${user.user.password }"
				maxlength="15">
				<span class="red">*</span>
			</td>
			<td align="right"><spring:message code="user.paypassword"/>：</td>
          	<td>
				<input type="text" class="inp" name="paypassword" id="paypassword" value="${user.user.paypassword }"
				maxlength="15">
				<span class="red">*</span>
			</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.address"/>：</td>
            <td colspan="3" style="width: 35%; font-weight: bold;">${user.user.address }
            	<input type="hidden" class="inp" style="width:400px;" name="address" id="address" value="${user.user.address }"
            	maxlength="100" >
            </td>
            
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		<%-- 
               		<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateUser();"/>
               		 --%>
               		<a href="javascript:updateUser();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
               </c:when>
            </c:choose>
        </cite>
        <span class="red">${user.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }
  
  function checkAll() {
    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
  }

  function checkbox() {
    var checked = true;
    $('.checkbox').each(function () {
      if (!$(this).attr('checked')) {
        return checked = false;
      }
    });
    $('#checkall').attr('checked', checked);
  }
  
  //
  function changeNetwork(){
	$("#addform").attr("action", "user/addInit");
	$("#addform").submit();
  }	
  
  
  function nextStep(){
	$("#addform").attr("action", "user/businessUnit?businesstype=buyDevice");
	$("#addform").submit();
  }	
  
  
  function updateUser() {
  		if($('#password').val() == password && $('#paypassword').val() ==paypassword){
  			return;
  		}
		if ($('#password').val() == '') {
		      $.dialog.tips('<spring:message code="user.password.empty"/>', 2, 'alert.gif');
		      $('#password').focus();
		      return;
		}
		if ($('#paypassword').val() == '') {
		      $.dialog.tips('<spring:message code="user.paypassword.empty"/>', 2, 'alert.gif');
		      $('#paypassword').focus();
		      return;
		}
		        
	    $("#addform").attr("action", "user/update");
	    $("#addform").submit();
  }
  
  function goBack() {
      $("#addform").attr("action", "user/findByList");
      $("#addform").submit();
  }
  
  var password;
  var paypassword;
  $(function () {
  	   password = $('#password').val();
  	   paypassword = $('#paypassword').val();
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  
</script>
</body>
</html>
