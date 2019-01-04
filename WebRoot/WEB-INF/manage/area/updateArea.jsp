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
    body { padding: 10px 0; }
		.form-box table { width: 100%; }
		.form-box table tr td { height: 30px; width: expression((cellIndex%2==0)?"15%":"25%"); text-align: expression((cellIndex%2==0)?"right":"left"); }
		.form-box table tr td:nth-child(odd) { width: 15%; text-align: right; }
		.form-box table tr td:nth-child(even) { width: 25%; text-align: left; }
		.select { width: 158px; border:solid #3b98c6 1px; }
		.inp { width: 150px; }
  </style>
</head>

<body>
<div id="body">
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${area.area.id}"/>
    <input type="hidden" name="queryserverid" id="queryserverid" value="${area.queryserverid}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${area.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="area.areaupdate"/></div>
      <div class="fb-con">
       <table>
          <tr>
          	<td align="right" width="20%"><spring:message code="network.netname"/>：</td>
			<td align="left" width="40%">
			   <input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee; width: 200px;" value="${area.network.netname }">
               <input type="hidden" id="netid" name="netid" value="${area.network.id }">
			</td>
		  </tr>
		  <tr>
            <td align="right" width="20%"><spring:message code="area.pid"/>：</td>
            <td align="left" width="40%">
			   <input type="text" class="inp" name="parentareaname" id="parentareaname" readonly="readonly" style="background:#eeeeee; width: 200px;" value="${area.parentarea.areaname }">
               <input type="hidden" id="pid" name="pid" value="${area.parentarea.id }">
            </td>
          </tr>
          <tr>
            <td align="right" width="20%"><spring:message code="area.areacode"/>：</td>
            <td align="left" width="40%">
              <input type="text" class="inp" name="areacode" id="areacode" style="width: 200px;" value="${area.area.areacode}" maxlength="3" onkeyup="checkNumRange(this,1,255)" onkeypress="checkNumRange(this,1,255)" onblur="checkNumRange(this,1,255)" onafterpaste="this.value=this.value.replace(/\D/g,'')"> <span class="red">* (1 ~ 255)</span>
<!--               <input type="hidden" name="code" id="code" value="${area.area.code}"/> -->
            </td>
          </tr>
		  <tr>
            <td align="right" width="20%"><spring:message code="area.areaname"/>：</td>
            <td align="left" width="40%">
             	<input type="text" class="inp" name="areaname" id="areaname"  style="width: 200px;"value="${area.area.areaname }" maxlength="30"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right" width="20%"><spring:message code="area.remark"/>：</td>
            <td align="left" width="40%">
              <input type="text" class="inp" name="code" id="code" style="width: 200px;" value="${area.area.code}" maxlength="15"> <span class="red">* ( 0.0.0.0 )</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateArea();" id="btnfinish">
        	 --%>
        	<a href="javascript:updateArea();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${area.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">

  function updateArea() {
 	  if(checkip($('#code').val())==false){
      	  $.dialog.tips('<spring:message code="area.casnumber.format.error"/>', 1, 'alert.gif');
      	  $('#code').focus();
		  return;
	  }
      if ($('#areacode').val() == '') {
          $.dialog.tips('<spring:message code="area.areacode.empty"/>', 1, 'alert.gif');
          $('#areacode').focus();
          return;
      }
      
      if ($('#areaname').val() == '') {
	      $.dialog.tips('<spring:message code="area.areaname.empty"/>', 1, 'alert.gif');
	      $('#areaname').focus();
	      return;
	  }
      
      $('#updateform').attr('action', 'area/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "area/findByList");
      $("#updateform").submit();
  }
  
  
  $(function () {
      var returninfo = '${area.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
      
      var flag = '${area.flag}';
      if (flag == '1') {//修改成功
	      var node = {
	        id: '${area.area.id}',
	        pId: '${area.area.pid}',
	        name: '${area.area.areaname}(${area.area.areacode_12})',
	        isParent: true,
	        type: 2
	      };
	      parent.updateNode(node);
	  }
  });
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
	    var firstp = ip.indexOf(".");
	    var lastp = ip.lastIndexOf(".");
	    var str1 = ip.substring(0,firstp);
	    var ipstr_tmp = ip.substring(0,lastp);
	    var secondp = ipstr_tmp.lastIndexOf(".");
	    var str2 = ipstr_tmp.substring(firstp+1,secondp);
	    var str3 = ipstr_tmp.substring(secondp+1,lastp);
	    var str4 = ip.substring(lastp+1,ip_length);
	    if (str1 == '' || str2 == '' || str3 == '' || str4 == '') { return false; }
	    if (str1.length > 3 || str2.length > 3 || str3.length > 3 || str4.length > 3) { return false; }
	    if (str1 < 0 || str1 > 255) { 
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
