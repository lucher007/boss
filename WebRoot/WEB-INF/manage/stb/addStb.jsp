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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.stb"/> &gt; <spring:message code="stb.stbadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="stb.stbadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="provider.model"/>：</td>
            <td width="25%">
             <select id="providerid" name="providerid" class="select" style="width: 250px;">
                <c:forEach items="${stb.providerlist}" var="dataMap" varStatus="s">
                  <option value="${dataMap.id}" <c:if test="${dataMap.id == stb.providerid}">selected</c:if>>${dataMap.model}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
          	<td align="right" width="15%"><spring:message code="network.netname"/>：</td>
			<td align="left">
				<select id="netid" name="netid" class="select" style="width: 250px;">
						<c:forEach items="${stb.networklist}" var="networkMap" varStatus="s">
							<option value="${networkMap.id}" <c:if test="${stb.netid == networkMap.id }">selected</c:if>>${networkMap.netname}</option>
						</c:forEach>
				</select>
			</td>	
          </tr>
          <tr>
          	 <td align="right" width="15%"><spring:message code="server.versiontype"/>：</td>
             <td width="25%">
             	<select name="versiontype" id="versiontype" class="select" onchange="changerVersiontype();" style="width: 250px;">
             		<option value="gos_pn" <c:if test="${stb.versiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
	                <option value="gos_gn" <c:if test="${stb.versiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
	            </select>
             </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="stb.stbno"/>：</td>
            <td>
             	<input type="text" style="width: 250px;" class="inp" name="stbno" id="stbno" value="${stb.stbno }" maxlength="8"  onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="stb.incardflag"/>：</td>
            <td>
              <select name="incardflag" id="incardflag" class="select" style="width: 250px;">
              </select>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
        	<span><a href="stb/addByImportFileInit" class="btn-print"><spring:message code="stb.fileimport"/></a></span> 
        	<span><a href="stb/addStbpaircardByImportFileInit" class="btn-print"><spring:message code="stb.fileimport.paircard"/></a></span> 
   			<%-- <span><input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" /></span>
			<span><input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveStb();"/></span> --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
          <a href="javascript:saveStb();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${stb.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
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
  
  function AddByImportFile(){
      $("#addForm").attr("action", "stb/addByImportFileInit").submit();
  }
  
  function saveStb() {
	    if ($('#providerid').val()== null || $('#providerid').val() == '') {
	      $.dialog.tips('<spring:message code="stb.providerid.empty"/>', 1, 'alert.gif');
	      $('#providerid').focus();
	      return;
	    } 
	    
	    if ($('#netid').val() == null || $('#netid').val() == '') {
	      $.dialog.tips('<spring:message code="stb.netid.empty"/>', 1, 'alert.gif');
	      $('#netid').focus();
	      return;
	    }  
	    
	    if ($('#stbno').val() == '') {
		      $.dialog.tips('<spring:message code="stb.stbno.empty"/>', 1, 'alert.gif');
		      $('#stbno').focus();
		      return;
		} 
	    
	    $("#addForm").attr("action", "stb/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "stb/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       changerVersiontype();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
    //判断是否内置卡
	function changerVersiontype(){
		if($("#versiontype").val()=="gos_gn"){
		   var html = "";
	           html += "<option value=\"2\" " + ('${stb.incardflag}' == '2' ? 'selected':'') + " ><spring:message code="stb.incardflag.2"/></option>";
		       $('#incardflag').html(html);
		}else{
		  var html = "";
		  	  html += "<option value=\"0\" " + ('${stb.incardflag}' == '0' ? 'selected':'') + " ><spring:message code="stb.incardflag.0"/></option>";
	          html += "<option value=\"1\" " + ('${stb.incardflag}' == '1' ? 'selected':'') + " ><spring:message code="stb.incardflag.1"/></option>";
	          //html += "<option value=\"2\" " + ('${stb.incardflag}' == '2' ? 'selected':'') + " ><spring:message code="stb.incardflag.2"/></option>";
		      $('#incardflag').html(html);
		}
	}
    
</script>
</body>
</html>
