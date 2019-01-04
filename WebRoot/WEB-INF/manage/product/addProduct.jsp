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
  <link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css" />
  <style>
    .fb-con table tr {
      height: 30px;
    }
    .refServiceInfo table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.product"/> &gt; <spring:message code="product.productadd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="product.productadd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="20%" align="right"><spring:message code="network.netname"/>：</td>
            <td width="40%">
             <select id="netid" name="netid" class="select" onchange="changeNetwork();" style="width: 250px;">
                <c:forEach items="${product.networklist}" var="dataList" varStatus="s">
                  <option value="${dataList.id}" <c:if test="${dataList.id == product.netid}">selected</c:if>>${dataList.netname}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
          	<td height="30" width="20%" align="right"><spring:message code="product.productid"/>：</td>
            <td width="40%">
            	<input type="text" class="inp" name=productid id="productid" 
            	style="width: 250px;" maxlength="5" 
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')" 
            	value="${product.productid }"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="product.productname"/>：</td>
            <td>
              <input type="text" class="inp" name=productname id="productname"
              	maxlength="50" style="width: 250px;"
               value="${product.productname }"> <span class="red">*</span>
            </td> 
          </tr>
          <tr>
            <td align="right"><spring:message code="product.pricepermonth"/>(/<spring:message code="para.unit.month"/>)：</td>
            <td>
             	<input type="text" class="inp" name="pricepermonth" id="pricepermonth" style="width: 250px;" value="${product.pricepermonth }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10" > <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="product.priceperday"/>(/<spring:message code="para.unit.day"/>)：</td>
            <td>
             	<input type="text" class="inp" name="priceperday" id="priceperday" style="width: 250px;" value="${product.priceperday }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="product.subpricepermonth"/>(/<spring:message code="para.unit.month"/>)：</td>
            <td>
             	<input type="text" class="inp" name="subpricepermonth" id="subpricepermonth" style="width: 250px;" value="${product.subpricepermonth }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span>
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="product.subpriceperday"/>(/<spring:message code="para.unit.day"/>)：</td>
            <td>
             	<input type="text" class="inp" name="subpriceperday" id="subpriceperday" style="width: 250px;" value="${product.subpriceperday }" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div id="refServiceInfo">
        
      </div>
      <div class="fb-bom">
        <cite>
          <a href="javascript:goBack();" iconCls="icon-back" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.goback"/></a>
<!--           <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" > -->
          <a href="javascript:saveProduct();" iconCls="icon-save" class="easyui-linkbutton" style="width:auto;"><spring:message code="page.save"/></a>
<!--           <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveProduct();"/> -->
        </cite>
        <span class="red">${product.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
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
		var data = {
		      netid: $('#netid').val(),
		      tag: 'refServiceInfo'
		    };
	    var url = 'product/refServiceInfo .' + data.tag;
	    $('#refServiceInfo').load(url, data, function () {
	    });
  }	
  
  
  function saveProduct() {
	    if ($('#productid').val() == '') {
	      $.dialog.tips('<spring:message code="product.productid.empty"/>', 1, 'alert.gif');
	      $('#productid').focus();
	      return;
	    }
	    
	    if ($('#productname').val() == '') {
		      $.dialog.tips('<spring:message code="product.productname.empty"/>', 1, 'alert.gif');
		      $('#productname').focus();
		      return;
		}
        
        if ($('#pricepermonth').val() == '') {
	      $.dialog.tips('<spring:message code="product.pricepermonth.empty"/>', 1, 'alert.gif');
	      $('#pricepermonth').focus();
	      return;
	    }
	    
	    if ($('#priceperday').val() == '') {
	      $.dialog.tips('<spring:message code="product.priceperday.empty"/>', 1, 'alert.gif');
	      $('#priceperday').focus();
	      return;
	    }
	    
	    if ($('#subpricepermonth').val() == '') {
		      $.dialog.tips('<spring:message code="product.subpricepermonth.empty"/>', 1, 'alert.gif');
		      $('#subpricepermonth').focus();
		      return;
		}
		    
	    if ($('#subpriceperday').val() == '') {
	      $.dialog.tips('<spring:message code="product.subpriceperday.empty"/>', 1, 'alert.gif');
	      $('#subpriceperday').focus();
	      return;
	    }
        
	    //判断是否选择业务
        //var hasSelected = false;
	    //$('.checkbox').each(function () {
	    //  if ($(this).attr('checked')) {
	    //   return hasSelected = true;
	    //  }
	    //});
	    
	    //if (!hasSelected) {
	    //  $.dialog.tips('<spring:message code="product.service.empty"/>', 1, 'alert.gif');
	    //  return;
	    //}
        
	    $("#addForm").attr("action", "product/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "product/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       changeNetwork();
       var returninfo = '${product.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
</script>
</body>
</html>
