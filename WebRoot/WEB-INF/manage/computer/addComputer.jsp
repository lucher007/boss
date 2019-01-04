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
  <style>
    .fb-con table tr {
      height: 30px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.computer"/> &gt; <spring:message code="computer.computeradd"/></div>
  <form action="computer!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="computer.computeradd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="25%" align="right"><spring:message code="store.storename"/>：</td>
            <td width="25%">
              <select id="storeid" name="storeid" class="select">
                <c:forEach items="${computer.storemap}" var="storeMap" varStatus="s">
                  <option value="${storeMap.key}" <c:if test="${storeMap.key == computer.storeid}">selected</c:if>>${storeMap.value}</option>
                </c:forEach>
              </select>
            </td>
            <td height="30" width="25%" align="right"><spring:message code="computer.computercode"/>：</td>
            <td width="25%">
            	<input type="text" class="inp" maxlength="20" name="computercode" id="computercode" value="${computer.computercode }">
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="computer.ip"/>(xxx.xxx.xxx.xxx)：</td>
            <td>
              <input type="text" class="inp" maxlength="15" name="ip" id="ip" value="${computer.ip }">
            </td>
            <td align="right"><spring:message code="computer.macaddress"/>(XX-XX-XX-XX-XX-XX)：</td>
            <td>
              <input type="text" class="inp" maxlength="17" name="macaddress" id="macaddress" value="${computer.macaddress }"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveComputer();"/>
        </cite>
        <span class="red">${computer.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/comtools.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">

  //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function saveComputer() {
	   
	    if($('#ip').val() != ''){
	      	if(checkip($('#ip').val())==false){
		      	 $.dialog.tips('<spring:message code="computer.ip.format.error"/>', 1, 'alert.gif');
		      	 $('#ip').focus();
				 return;
			  }
	    }
	   
	    if ($('#macaddress').val() == '') {
	      $.dialog.tips('<spring:message code="computer.macaddress.empty"/>', 1, 'alert.gif');
	      $('#macaddress').focus();
	      return;
	    }
	   
	   	if(check_mac($('#macaddress').val())==false){
      	   $.dialog.tips('<spring:message code="computer.macaddress.format.error"/>', 1, 'alert.gif');
      	   $('#macaddress').focus();
		   return;
	    }
	   
	    $("#addForm").attr("action", "computer/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "computer/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${computer.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  //js验证ip地址函数
  function checkip(ip){
	    var pcount = 0;
	    var ip_length = ip.length ;
	    var ip_letters = "1234567890." ;
	    for (p=0; p < ip_length; p++) {
			var ip_char = ip.charAt(p)
			if (ip_letters.indexOf(ip_char) == -1){
			     return false;
			}
	    }
	    for (var u = 0; u < ip_length; u++) { (ip.substr(u,1) == ".") ? pcount++ : pcount }
	    if(pcount != 3) { 
	    	return false ;
	    }
	    firstp = ip.indexOf(".");
	    lastp = ip.lastIndexOf(".");
	    str1 = ip.substring(0,firstp);
	    ipstr_tmp = ip.substring(0,lastp);
	    secondp = ipstr_tmp.lastIndexOf(".");
	    str2 = ipstr_tmp.substring(firstp+1,secondp);
	    str3 = ipstr_tmp.substring(secondp+1,lastp);
	    str4 = ip.substring(lastp+1,ip_length);
	    if (str1 == '' || str2 == '' || str3 == '' || str4 == '') { return false }
	    if (str1.length > 3 || str2.length > 3 || str3.length > 3 || str4.length > 3) { return false }
	    if (str1 <= 0 || str1 > 255) { 
	    	return false; 
	    } else if (str2 < 0 || str2 > 255) { 
	    	return false; 
	    } else if (str3 < 0 || str3 > 255) { 
	    	return false; 
	    } else if (str4 < 0 || str4 > 255) { 
	    	return false; 
	    }
	    return true;
	}

	//js验证mac地址函数
	function check_mac(chkstr){
     var pattern="/^([0-9A-F]{2})(-[0-9A-F]{2}){5}|([0-9A-F]{2})(:[0-9A-F]{2}){5}/";
     eval("var pattern=" + pattern);
     var add_p1 = pattern.test(chkstr);
     return add_p1;
}
  
</script>
</body>
</html>
