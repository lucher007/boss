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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.server"/> &gt; <spring:message code="server.serveradd"/></div>
  <form action="server!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="server.serveradd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right"><spring:message code="server.servername"/>：</td>
            <td>
              <input type="text" class="inp" name="servername" id="servername" value="${server.servername }" maxlength="30" > <span class="red">*</span>
            </td>
            <td align="right"><spring:message code="server.servertype"/>：</td>
            <td>
              <select name="servertype" id="servertype" class="select" onchange="changeServertype();">
                <option value="cas"    <c:if test="${server.servertype == 'cas' }">selected</c:if>><spring:message code="server.servertype.cas"/></option>
                <option value="mps"  <c:if test="${server.servertype == 'mps' }">selected</c:if>><spring:message code="server.servertype.mps"/></option>
                <option value="epg"   <c:if test="${server.servertype == 'epg' }">selected</c:if>><spring:message code="server.servertype.epg"/></option>
                <option value="nvod" <c:if test="${server.servertype == 'nvod' }">selected</c:if>><spring:message code="server.servertype.nvod"/></option>
              </select>
            </td>
           </tr>
           <tr id="versiontypeTr" style="display:none">
           	 	<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
            	<td width="25%">
	              <select id="netid" name="netid" class="select">
	                <c:forEach items="${server.networkmap}" var="dataMap" varStatus="s">
	                  <option value="${dataMap.key}" <c:if test="${dataMap.key == server.netid}">selected</c:if>>${dataMap.value}</option>
	                </c:forEach>
	              </select>
              </td>
             <td align="right"><spring:message code="server.versiontype"/>：</td>
             <td>
             	<select name="versiontype" id="versiontype" class="select">
             		 <option value="gos_pn" <c:if test="${server.versiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
	                 <option value="gos_gn" <c:if test="${server.versiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
	            </select>
             </td>
           </tr>
           <tr>
            <td align="right"><spring:message code="server.ip"/>：</td>
            <td>
              <input type="text" class="inp" name="ip" id="ip" maxlength="15" value="${server.ip }"> <span class="red">*</span>
            </td>
            <td align="right"><spring:message code="server.port"/>：</td>
            <td>
              <input type="text" class="inp" name="port" id="port" value="${server.port }" maxlength="5" autocomplete="off" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveServer();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:saveServer();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${server.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
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

  function saveServer() {
	    if ($('#servername').val() == '') {
	      $.dialog.tips('<spring:message code="server.servername.empty"/>', 1, 'alert.gif');
	      $('#servername').focus();
	      return;
	    }
	   	
	   	if ($('#ip').val() == '') {
	      $.dialog.tips('<spring:message code="server.ip.empty"/>', 1, 'alert.gif');
	      $('#ip').focus();
	      return;
	    }
	   	
	   	if(checkip($('#ip').val())==false){
	      	 $.dialog.tips('<spring:message code="server.ip.format.error"/>', 1, 'alert.gif');
	      	 $('#ip').focus();
			 return;
		}
	   	
	   	if ($('#port').val() == '') {
	      $.dialog.tips('<spring:message code="server.port.empty"/>', 1, 'alert.gif');
	      $('#port').focus();
	      return;
	    }
	   	
	    $("#addForm").attr("action", "server/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "server/findByList");
      $("#addForm").submit();
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
	
	
	//js验证ip地址函数
  function checkip(ip){
	    var pcount = 0;
	    var ip_length = ip.length ;
	    var ip_letters = "1234567890." ;
	    for (p=0; p < ip_length; p++) {
			var ip_char = ip.charAt(p);
			if (ip_letters.indexOf(ip_char) == -1){
			     return false;
			}
	    }
	    for (var u = 0; u < ip_length; u++) { 
	    	(ip.substr(u,1) == ".") ? pcount++ : pcount ;
	    }
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
	    if (str1 == '' || str2 == '' || str3 == '' || str4 == '') { return false; }
	    if (str1.length > 3 || str2.length > 3 || str3.length > 3 || str4.length > 3) { return false; }
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

</script>
</body>
</html>
