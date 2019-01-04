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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="userbusiness.feecount"/></div>
  <form method="post" id="addForm" name="addForm">
    <input type="hidden" name="businesstype" id="businesstype" value="${userbusiness.businesstype }"/>
    <input type="hidden" name="businesstypekey" id="businesstypekey" value="${userbusiness.businesstypekey }"/>
    <input type="hidden" name="terminalid" id="terminalid" value="${userbusiness.terminalid }"/>
    <input type="hidden" name="terminaltype" id="terminaltype" value="${userbusiness.terminaltype }"/>
    <input type="hidden" name="cardid" id="cardid" value="${userbusiness.cardid }"/>
    <input type="hidden" name="cardstate" id="cardstate" value="${userbusiness.cardstate }"/>
    <input type="hidden" name="stbno" id="stbno" value="${userbusiness.stbno }"/>
    <input type="hidden" name="stbstate" id="stbstate" value="${userbusiness.stbstate }"/>
    <input type="hidden" name="address" id="address" value="${userbusiness.address }"/>
    <input type="hidden" name="areacode" id="areacode" value="${userbusiness.areacode }"/>
    <input type="hidden" name="terminalids" id="terminalids" value="${userbusiness.terminalids }"/>
    <div class="form-box">
      <div class="fb-tit">
      	<spring:message code="userbusiness.feecount"/>
      </div>
      <div class="fb-con">
       	<div id="printInfo" style="display: none"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--
          <tr>
          	<td height="20" width="20%" align="right"><spring:message code="user.username"/>：</td>
            <td width="30%">
            	<input type="text" class="inp" name="totalmoney" id="totalmoney" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.username }">
            </td>
            <td height="20" width="20%" align="right"><spring:message code="user.account"/>：</td>
            <td width="30%">
            	<input type="text" class="inp" name="account" id="account" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.account }">
            </td>
          </tr>
          -->
          <tr>
          	<td height="20" width="20%" align="right" style="font-weight: bold;"><spring:message code="userbusiness.totalmoney"/>：</td>
            <td width="30%">
            	<input type="text" class="inp" name="totalmoney" id="totalmoney" readonly="readonly" style="background:#eeeeee;" value="${userbusiness.userbusiness.totalmoney }"><span class="red">*</span>
            </td>
            <td align="right" style="font-weight: bold;"><spring:message code="userbusiness.shouldmoney"/>：</td>
            <td>
              <input type="text" class="inp" name=shouldmoney id="shouldmoney" readonly="readonly" style="background:#eeeeee;" value="${userbusiness.userbusiness.shouldmoney }" 
              onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);"><span class="red">*</span>
           
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="userbusiness.paytype"/>：</td>
            <td colspan="3">
            	<select id="paytype" name="paytype" class="select" onchange="changePaytype();">
                  <option value="0" <c:if test="${userbusiness.paytype == '0' }">selected</c:if>><spring:message code="userbusiness.paytype.0"/></option>
                  <option value="1" <c:if test="${userbusiness.paytype == '1' }">selected</c:if>><spring:message code="userbusiness.paytype.1"/></option>
                </select>
            </td>
          </tr>
          <tr id="accountMoneyTr" style="display:none">
          	<td align="right"><spring:message code="user.account"/>：</td>
            <td>
              <input type="text" class="inp" name=account id="account" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.account }" >
            </td>
            <td align="right"><spring:message code="userbusiness.accountmoney"/>：</td>
            <td>
              <input type="text" class="inp" name=accountmoney id="accountmoney" onpaste="return false" value="${userbusiness.userbusiness.accountmoney }" 
              onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);">
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="userbusiness.paymoney"/>：</td>
            <td colspan="3">
              <input type="text" class="inp" name="paymoney" id="paymoney" readonly="readonly" style="background:#eeeeee;" onpaste="return false" value="${userbusiness.userbusiness.shouldmoney }" 
              onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);">
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
          <c:if test="${userbusiness.userbusiness.id == null || userbusiness.id == ''}">
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack();"/>
          	<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveUser();"/>
          	 --%>
          	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:saveUser();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
          </c:if>
          <c:if test="${userbusiness.userbusiness.id != null}">
          	<%-- 
          	<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack();"/>
          	<input type="button" class="btn-print" value="<spring:message code="print.print"/>" onclick="isPrintTaxpayerMsg();"/>
          	 --%>
          	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:isPrintTaxpayerMsg();" class="easyui-linkbutton" iconCls="icon-print" style="width:80px"><spring:message code="print.print"/></a>
          </c:if>
          <!-- 
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveUser();"/>
          -->
        </cite>
        <span class="red">${userbusiness.returninfo}</span>
      </div>
    </div>
    <div class="pop-box" id="invoiceTmpInfo">
    	<table>
    		<tr align="right" height="30px">
		    	<td><spring:message code="print.template" />:</td>
				<td>
					<select id="template_value" name="template_value" class="select">
					<c:forEach items="${userbusiness.templateList}" var="template" varStatus="s">
						<option value='${template.value}'>${template.name}</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			<c:if test="${Operator.user.printtaxpayerflag == '1'}">
			<input type="hidden"  id="store" />
				<tr align="right" height="30px">
					<td><spring:message code="print.taxpayername" />:</td>
					<td><input type="text" class="inp"   id="taxpayername" name="taxpayername"   /></td>
				</tr>
				<tr align="right" height="30px">
					<td><spring:message code="print.taxpayer.number" />:</td>
					<td><input type="text"  class="inp" id="taxpayercode" name="taxpayercode"   /></td>
				</tr>
			</c:if> 
		</table>
    </div>
  </form>
</div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="<%=basePath%>js/lodop/LodopFuncs.js"></script>
<script type="text/javascript">
    var basepath = '<%=basePath%>';
	var LODOP;
	var needupdate = '<spring:message code="print.plugin.update"/>';
	var needinstall = '<spring:message code="print.plugin.install"/>';
	var install = '<spring:message code="print.plugin.excuteinstall"/>';
	var update = '<spring:message code="print.plugin.excuteupdate"/>';
	var refresh = '<spring:message code="print.plugin.refresh"/>';
	var notready = '<spring:message code="print.plugin.notready"/>';
	var error = '<spring:message code="print.plugin.error"/>';
	var totalPrice = '';
  
  	function selectInvoiceTmp() {
		//弹出选择模板框
		selectInvoiceDialog = $.dialog({
		    title: '<spring:message code="print.template"/>',
		    lock: true,
		    width: 400,
		    height:100,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: $("#invoiceTmpInfo").html(),
		   	ok: function(){
		   		   if($('#template_value').val() == null || $('#template_value').val() == '') {
				      	$.dialog.tips('<spring:message code="print.template.empty"/>', 1, 'alert.gif');
				      return false;
				   }
		   		   printInvoice();
		   		   saveTaxpayerMsg();
		   		},
		   	okVal:'<spring:message code="page.confirm"/>',
		   	cancel:function(){selectInvoiceDialog.close();},
		   	cancelVal:'<spring:message code="page.cancel"/>'
	   });
	};
	      
	function printInvoice(){
	   
	    //开始打印
	    LODOP = getLodop();
	    var value = $("#template_value").val();
		eval(value);
		var items = value.split("LODOP.ADD_PRINT_T");
		$.each(items, function(n, item) {
			if (item.indexOf("list") > 0) {
				var lists = item.split("/script>");
				var str = lists[1].replace(/[\r\n]/g, ""); //去掉换行符
				var code = str.substring(0, (str.length) - 3);
				//LODOP.SET_PRINT_STYLEA(n,"CONTENT",document.getElementById(code).innerHTML);
				LODOP.SET_PRINT_STYLEA(n, "CONTENT", document.getElementById("printInfo").innerHTML);
			}
		});
		
		LODOP.SET_SHOW_MODE("HIDE_ITEM_LIST ", true);
		LODOP.SET_PRINT_STYLEA("clientName", "CONTENT",'${Operator.user.username}');
		LODOP.SET_PRINT_STYLEA("totalPrice", "CONTENT", '${userbusiness.userbusiness.paymoney}');
		LODOP.SET_PRINT_STYLEA("clientCode", "CONTENT", '${Operator.user.usercode}');
		LODOP.SET_PRINT_STYLEA("operateDate", "CONTENT",'${userbusiness.userbusiness.addtime}'.substring(0,10));
		LODOP.SET_PRINT_STYLEA("printDate", "CONTENT",new Date().toLocaleDateString());
		LODOP.SET_PRINT_STYLEA("operatorCode", "CONTENT",'${Operator.operatorcode}');
		LODOP.SET_PRINT_STYLEA("operatorName", "CONTENT",'${Operator.operatorname}');
		LODOP.SET_PRINT_STYLEA("storeName", "CONTENT",$("#store").val());
		LODOP.SET_PRINT_STYLEA("taxpayerCode", "CONTENT",$("#taxpayercode").val());
		LODOP.SET_PRINT_STYLEA("taxpayerName", "CONTENT",$("#taxpayername").val());
		LODOP.PREVIEW();
   }
  
  
  //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }
  
  function saveUser() {
  		//余额支付
  		if($("#paytype").val()=="1"){
		   if($("#accountmoney").val()==null || $("#accountmoney").val()=='' || parseFloat($("#accountmoney").val()) == 0){
		   		$.dialog.tips('<spring:message code="userbusiness.accountmoney.empty"/>', 1, 'alert.gif');
		   		 $('#accountmoney').focus();
		   		return false;
		   }
		}
       
        $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
	        '<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
	        function(){ 
				$("#addForm").attr("action", "user/saveBusiness"+"?rid="+Math.random());
				$("#addForm").submit();
			}, function(){
						});
  }
  
  function goBack() {
     var businessid = '${userbusiness.userbusiness.id}';
     
     if(businessid != null && businessid != ''){//保存成功，关闭窗口，调用父页面的刷新
     	parent.closeBusinessDialog();
     }else{//未成功，关闭窗口，不刷新父页面
     	parent.unitBusinessDialog.close();
     }
  }
  
  $(function () {
       changePaytype();
       if('${userbusiness.userbusiness.id}' != null && '${userbusiness.userbusiness.id}' != ''){
			//初始化打印数据
       		loadInvoiceInfo();
       }
       var returninfo = '${userbusiness.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  function loadInvoiceInfo() {
	   var data = {
	   			rid : Math.random(),
				businessid : '${userbusiness.userbusiness.id}',
				tag : 'printInfo'
			};
	   var storeid = '${userbusiness.userbusiness.storeid}';
	   var url = 'print/getPrintInfo .' + data.tag;
	   $('#printInfo').load(url, data, function() {
	   		$.post('taxpayer/findStore',{storeid:storeid},function(store){
	   			var store = eval('(' + store + ')');
				$("#store").val(store.storename);
	   		});
	   });
  }
  
  //支付方式改变
  function changePaytype(){
		if($("#paytype").val()=="1"){
		    $("#accountMoneyTr").show();
		    updateAccountmoney();
		}else{
		    $("#accountMoneyTr").hide();
		    $("#paymoney").val($("#shouldmoney").val());
		}
	}
    
    function updateAccountmoney(){
    	var accountmoney = $("#accountmoney").val();//输入的订购金额
    	if(accountmoney == ''){
    		accountmoney = 0;
    	}
    	
    	var account = $("#account").val();//订户账户余额
    	if(account == ''){
    		account = 0;
    	}
    	
    	var shouldmoney = $("#shouldmoney").val();//实付金额
    	if(shouldmoney == ''){
    		shouldmoney = 0;
    	}
    	
    	//判断账户余额和应付金额大小
    	if(parseFloat(account) <=parseFloat(shouldmoney)){
    		if(parseFloat(accountmoney) > parseFloat(account)){
	    		$("#accountmoney").val(account);
	    	}
    	}else{
    		if(parseFloat(accountmoney) > parseFloat(shouldmoney)){
	    		$("#accountmoney").val(shouldmoney);
	    	}
    	}
    	
    	if($("#paytype").val()=="1"){
    		if($("#accountmoney").val() != ''){
	    		var paymoney =  parseFloat(shouldmoney) - parseFloat($("#accountmoney").val());
	    	    $("#paymoney").val(parseFloat(paymoney).toFixed(2));
	    	}
    	}else{
    		var paymoney =  parseFloat(shouldmoney);
	    	$("#paymoney").val(parseFloat(paymoney));
    	}
    	
    }
    
    /////////////////////对必要的输入框进行数字合法验证,只能输入小数点后三位//////////////////////////
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
			obj.o_value = obj.value;
		}
		if(obj.value.match(/^\d+\.\d{3}?$/)){
		   obj.value = obj.value.substr(0,obj.value.length-1);
		}
		updateAccountmoney();
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^00+/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0\.00/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0[1-9]/)) {
				obj.value = "";
			}
			if(obj.value.match(/^\d+\.\d{3}?$/)){
				obj.value = obj.value.substr(0,obj.value.length-1);
			} 
			if(obj.value == 'undefined'){
				obj.value='';
			}
			
			updateAccountmoney();
	}
	
	function onkeyblurCheck(obj){
		if(obj.value==0){
			//obj.value='';
		}
		if(obj.value==''){
			obj.value = 0;
		}
		if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
			obj.value = obj.o_value;
		}else {
			if (obj.value.match(/^\.\d+$/)) {
				obj.value = 0 + obj.value;
			}
			obj.o_value = obj.value;
		}
		if(!obj.value.match(/^\d+(\.\d{3})?$/)){
			obj.value = obj.value.substr(0,obj.value.indexOf(".")+3);
		} 
		updateAccountmoney();
	}
	//////////////////////////////////////////////////////////////////////
	
	 function saveTaxpayerMsg(){
	 	var url = "taxpayer/saveUsertaxpayerMsg?rid="+new Date();
	 	var userJson = {
	 		taxpayername:$("#taxpayername").val(),
	 		taxpayercode:$("#taxpayercode").val(),
	 		userid:'${userbusiness.userbusiness.userid}'
	 	};
	 	$.post(url,userJson,function(data){
	 	});
	 
	 }
	 function isPrintTaxpayerMsg(){
    	var url = "taxpayer/getUsertaxpayer?rid="+new Date();
    	var userid = '${userbusiness.userbusiness.userid}';
    	$.getJSON(url,{userid:userid},function(msg){
    	    if(msg.flag == '1'){
    	    	selectInvoiceTmp();
	    	    $("#taxpayername").val(msg.taxpayername);
	    		$("#taxpayercode").val(msg.taxpayercode);
    	    }
    	});
    
    }
</script>
</body>
</html>