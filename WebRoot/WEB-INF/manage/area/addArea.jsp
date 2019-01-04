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
  <form action="area!save" method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="area.areaadd"/></div>
      <div class="fb-con">
        <table>
          <tr>
          	<td align="right" width="20%"><spring:message code="network.netname"/>：</td>
			<td align="left" width="40%">
			   <input type="text" class="inp"  name="netname" id="netname" readonly="readonly" style="background:#eeeeee; width: 200px;"  value="${area.network.netname }">
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
          </tr>
           	<td align="right" width="20%"><spring:message code="area.areacode"/>：</td>
            <td align="left" width="40%">
              <input type="text" class="inp" style="width: 200px;" maxlength="3" name="areacode" id="areacode" value="${area.areacode }" onkeyup="checkNumRange(this,1,255)" onkeypress="checkNumRange(this,1,255)" onblur="checkNumRange(this,1,255)" onafterpaste="this.value=this.value.replace(/\D/g,'')"> <span class="red">* (1 ~ 255)</span>
            </td>
          <tr>
            <td align="right" width="20%"><spring:message code="area.areaname"/>：</td>
            <td align="left" width="40%">
              <input type="text" class="inp" style="width: 200px;" maxlength="30" name="areaname" id="areaname" value="${area.areaname }"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveArea();"/>
           --%>
          <a href="javascript:saveArea();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${area.returninfo}</span>
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

  function saveArea() {
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
	   
	    $("#addForm").attr("action", "area/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "area/findByList?serverid=&netid=");
      $("#addForm").submit();
  }
  
  $(function () {
  
       var returninfo = '${area.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
       
       var flag = '${area.flag}';
       if (flag == '1') {//添加成功
	      var newNode = {
	          id: '${area.id}',
	         pId: '${area.pid}',
	        name: '${area.areaname}(${area.areacode_12})',
	        path: 'area/updateInit?id=${area.id}',
	    isParent: true,
	        type: 2
	      };
	      parent.addNode(newNode);
	   }
  });
  
  
</script>
</body>
</html>
