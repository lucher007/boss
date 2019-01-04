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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.card"/> &gt; <spring:message code="card.cardadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="card.cardadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="provider.model"/>：</td>
            <td width="25%">
             <select id="providerid" name="providerid" class="select" style="width: 250px;">
                <c:forEach items="${card.providerlist}" var="dataMap" varStatus="s">
                  <option value="${dataMap.id}" <c:if test="${dataMap.id == card.providerid}">selected</c:if>>${dataMap.model}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
          	<td align="right" width="15%"><spring:message code="network.netname"/>：</td>
			<td align="left">
				<select id="netid" name="netid" class="select" style="width: 250px;">
						<c:forEach items="${card.networklist}" var="networkMap" varStatus="s">
							<option value="${networkMap.id}" <c:if test="${networkMap.id == card.netid }">selected</c:if>>${networkMap.netname}</option>
						</c:forEach>
				</select>
			</td>	
          </tr>
          <tr>
          	 <td align="right" width="15%"><spring:message code="server.versiontype"/>：</td>
             <td width="25%">
             	<select name="versiontype" id="versiontype" class="select" style="width: 250px;">
	                <!--
	                	<option value="gos_gn" <c:if test="${card.versiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
	                  -->
	                <option value="gos_pn" <c:if test="${card.versiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
	            </select>
             </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="card.cardid"/>：</td>
            <td>
             	<input type="text" style="width: 250px;" class="inp" name="cardid" id="cardid" value="${card.cardid }" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="card.incardflag"/>：</td>
            <td>
              <select name="incardflag" id="incardflag" class="select" style="width: 250px;">
              	  <option value="0" <c:if test="${card.incardflag == '0' }">selected</c:if>><spring:message code="card.incardflag.0"/></option>
              	  <option value="1" <c:if test="${card.incardflag == '1' }">selected</c:if>><spring:message code="card.incardflag.1"/></option>
              </select>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="card.stbno"/>：</td>
            <td>
             	<input type="text" class="inp" name="stbno" id="stbno" value="${card.stbno }" readonly="readonly" style="background:#eeeeee; width:250px;">
           		<%-- <input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseStb();">
           		<input  type="button" class="btn-back"  id="btnfinish" value="<spring:message code="page.clean"/>" onclick="cleanStbno();"> --%>
            	<a href="javascript:chooseStb();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.select"/></a>
            	<a href="javascript:cleanStbno();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.clean"/></a>
            </td>
          </tr>
          <!-- 
          <tr >
            <td align="right"><spring:message code="card.pincode"/>：</td>
            <td>
             	<input type="text" class="inp" name="pincode" id="pincode" value="${card.pincode }">
            </td>
          </tr>
           -->
        </table>
      </div>
      <div class="fb-bom">
	        <cite>
		          <%-- <span><input type="button" class="btn-back" value="<spring:message code="stb.fileimport"/>" onclick="AddByImportFile();" /></span>
		          <span><input type="button" class="btn-back" value="<spring:message code="page.goback" />" onclick="goBack()" /></span>
		          <span><input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveCard();"/></span> --%>
		          <a href="javascript:AddByImportFile();" class="easyui-linkbutton" style="width:80px"><spring:message code="stb.fileimport"/></a>
	        	  <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  <a href="javascript:saveCard();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
	        </cite>
        	<span class="red">${card.returninfo}</span>
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
      $("#addForm").attr("action", "card/addByImportFileInit").submit();
  }

  function saveCard() {
        
	    if ($('#providerid').val()== null || $('#providerid').val() == '') {
	      $.dialog.tips('<spring:message code="card.providerid.empty"/>', 1, 'alert.gif');
	      $('#providerid').focus();
	      return;
	    } 
	    
	    if ($('#netid').val() == null || $('#netid').val() == '') {
	      $.dialog.tips('<spring:message code="card.netid.empty"/>', 1, 'alert.gif');
	      $('#netid').focus();
	      return;
	    }
       
	    if ($('#cardid').val() == '') {
	      $.dialog.tips('<spring:message code="card.cardid.empty"/>', 1, 'alert.gif');
	      $('#cardid').focus();
	      return;
	    }
	   	
	    $("#addForm").attr("action", "card/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "card/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       var returninfo = '${card.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
    var stbDialog;
	function chooseStb() {
	    var netid = $("#netid").val();
	    var versiontype = $("#versiontype").val();
	    
	    if ($('#providerid').val()== null || $('#providerid').val() == '') {
	      $.dialog.tips('<spring:message code="card.providerid.empty"/>', 1, 'alert.gif');
	      $('#providerid').focus();
	      return;
	    } 
	    
	    if ($('#netid').val() == null || $('#netid').val() == '') {
	      $.dialog.tips('<spring:message code="card.netid.empty"/>', 1, 'alert.gif');
	      $('#netid').focus();
	      return;
	    }
	    
		stbDialog = $.dialog({
			title : '<spring:message code="authorize.userstb.choose"/>',
			lock : true,
			width : 900,
			height : 500,
			top : 0,
			drag : false,
			resize : false,
			max : false,
			min : false,
			content : 'url:stb/findStbListForDialog?rid='+Math.random()+'&querynetid='+netid+'&queryversiontype=' + versiontype+'&querystate=0'
		});
	}
	
	function closeStbDialog(stbno) {
		stbDialog.close();
		$("#stbno").val(stbno);
	}
   
	function cleanStbno() {
		  $('#stbno').val("");
	  }
</script>
</body>
</html>
