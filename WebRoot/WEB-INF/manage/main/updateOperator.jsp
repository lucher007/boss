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
  <style>
    .fb-con table tr {
      height: 30px;
    }
  </style>
</head>

<body>
<div id="body">
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${operator.operator.id}"/>
    <input type="hidden" name="state" id="state" value="${operator.operator.state}"/>
    <input type="hidden" name="operatorlevel" id="operatorlevel" value="${operator.operator.operatorlevel }">
    <input type="hidden" name="netid" id="netid" value="${operator.operator.netid }">
    <input type="hidden" name="areacode" id="areacode" value="${operator.operator.areacode }">
    <input type="hidden" name="storeid" id="storeid" value="${operator.operator.storeid }">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="operator.operatorupdate"/></div>
      <div class="fb-con">
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
         <tr>
         	<td height="30" width="15%" align="right"><spring:message code="operator.operatorlevel"/>：</td>
            <td style="width: 25%; font-weight: bold;">
            	<spring:message code="operator.operatorlevel.${operator.operator.operatorlevel }"/>
            </td>
          	<td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
            <td style="width: 25%; font-weight: bold;">${operator.network.netname}</td>
          </tr>
          <tr>
         	<td height="30" width="15%" align="right"><spring:message code="area.areaname"/>：</td>
           	<td style="width: 25%; font-weight: bold;">${operator.area.areaname}</td>
			<td height="30" width="15%" align="right"><spring:message code="store.storename"/>：</td>
           	<td style="width: 25%; font-weight: bold;">${operator.store.storename}</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="operator.loginname"/>：</td>
            <td style="width: 35%; font-weight: bold;">${operator.operator.loginname }</td>
            <td align="right"><spring:message code="operator.operatorname"/>：</td>
          	<td>
				<input type="text" class="inp" name="operatorname" id="operatorname" 
				maxlength="50"
				value="${operator.operator.operatorname }">
			</td>
          </tr>
          <tr>
			<td align="right"><spring:message code="operator.telephone"/>：</td>
          	<td>
				<input type="text" class="inp" name="telephone" id="telephone"
				maxlength="15"
				onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
				onafterpaste="this.value=this.value.replace(/[^-\d]/g,'')" 
				 value="${operator.operator.telephone }">
			</td>
            <td align="right"><spring:message code="operator.mobile"/>：</td>
          	<td>
				<input type="text" class="inp" name="mobile" id="moblie" 
				maxlength="15"
				onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
				onkeyup="this.value=this.value.replace(/\D/g,'')"
				value="${operator.operator.mobile}">
			</td>
		  </tr>
          <tr>
		  	<td align="right"><spring:message code="operator.documenttype"/>：</td>
          	<td>
				<input type="text" class="inp" name="documenttype" id="documenttype" maxlength="50" value="${operator.operator.documenttype }">
			</td>
			<td align="right"><spring:message code="operator.documentno"/>：</td>
          	<td>
				<input type="text" class="inp" name="documentno" id="documentno" maxlength="50" value="${operator.operator.documentno }">
			</td>
		  </tr>
          <tr>
          	<td align="right"><spring:message code="operator.email"/>：</td>
          	<td>
				<input type="text" class="inp" name="email" id="email" maxlength="50" value="${operator.operator.email }">
			</td>
          	<td align="right"><spring:message code="operator.address"/>：</td>
          	<td>
				<input type="text" class="inp" name="address" id="address" maxlength="100" value="${operator.operator.address}">
			</td>
		  </tr>
		 <%--  
		  <tr>
          	<td align="right"><spring:message code="operator.state"/>：</td>
          	<td>
			  <select name="state" id="state" class="select">
              	  <option value="1" <c:if test="${operator.operator.state == '1' }">selected</c:if>><spring:message code="store.state.1"/></option>
                  <option value="0" <c:if test="${operator.operator.state == '0' }">selected</c:if>><spring:message code="store.state.0"/></option>
              </select>
			</td>
			 
		 	<td height="30" width="15%" align="right"><spring:message code="role.rolename"/>：</td>
           	 <td width="25%">
            	<select id="roleid" name="roleid" class="select">
                <c:forEach items="${operator.rolemap}" var="roleMap" varStatus="s">
                  <option value="${roleMap.key}" <c:if test="${roleMap.key == operator.roleid}">selected</c:if>>${roleMap.value}</option>
                </c:forEach>
              </select>
            </td> 
		  </tr> 
		  --%>
			<tr>
				<td align="right"></td>
	          	<td>
	          		<a class="btn-edit" href="javascript:updatePasswordInit();"><spring:message code="operator.passwordupdate"/></a>
				</td>
			</tr>

        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateOperator();" id="btnfinish">
        </cite>
        <span class="red">${operator.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  function updateOperator() {
//       if ($('#operatorcode').val() == '') {
//           $.dialog.tips('<spring:message code="operator.operatorcode.empty"/>', 1, 'alert.gif');
//           $('#operatorcode').focus();
//           return;
//       }
      
//       if ( $('#storeid').combobox('getValue')=='') {
// 	      $.dialog.tips('<spring:message code="store.storecode.empty"/>', 1, 'alert.gif');
//           $('#storeid').focus();
//           return;
//       }
      $('#updateform').attr('action', 'menu/update');
      $("#updateform").submit();
  }
  
  function updatePasswordInit() {
      $("#updateform").attr("action", "menu/updatePasswordInit");
      $("#updateform").submit();
  }
  
  $(function () {
      initStore();
      var returninfo = '${operator.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
  });
  

  
function initStore() {
	   $('#storeid').combobox({    
		url:'store/getStore?querynetid='+$('#netid').val(),
	    valueField:'id',    
	    limitToList:true,
	    textField:'storename',
	       onLoadSuccess:function(node, data){
		    	initStoreValue();
		    }
	});  
}
     
  //初始化营业厅列表框的默认选择值
  function initStoreValue(){
	  if('${operator.operator.storeid}' != '' && '${operator.operator.storeid}' != null){
			if('${operator.operator.netid}' == $('#netid').val()){
		  	  $('#storeid').combobox('select','${operator.operator.storeid}');
		  	}
	  }
  } 
  
  
</script>
</body>
</html>
