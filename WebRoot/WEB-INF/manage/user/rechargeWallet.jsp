<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
   .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.walletrecharge"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.walletrecharge"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
    	<!-- <div id="userCardInfo"></div> -->
      </div>
      
      <div id="userterminallist" style="width:auto"></div>
      
      <div class="fb-con">
        <div class="rechargeWalletInfo">
	    	<table>
	          <tr class="fbc-tit">
	            <td colspan="8" style="font-weight: bold;"><spring:message code="menu.business.walletrecharge"/></td>
	          </tr>
	          <tr>
	            <td align="right"><spring:message code="systempara.code.currency_conversion_denominator"/>：</td>
	            <td colspan="3">
	            	<input type="text" class="inp" style="width:150px;background:#eeeeee;" name="denominator" id="denominator" value="${CURRENCY_CONVERSION_DENOMINATOR}" readonly="readonly" >
	            </td>
	             <td align="right"><spring:message code="systempara.code.currency_conversion_point"/>：</td>
	            <td colspan="3">
	            	<input type="text" class="inp" style="width:150px;background:#eeeeee;" name="pointvalue" id="pointvalue" value="" readonly="readonly" >
	            </td>
	          </tr>
	          <tr>
	            <td align="right"><spring:message code="userbusiness.walletrecharge.rechargemoney"/>：</td>
	            <td colspan="3">
	            	<input type="text" class="inp" style="width:150px;" name="rechargemoney" id="rechargemoney" value="" onpaste="return false" maxlength="5"
	            	onkeyup="this.value=this.value.replace(/\D/g,'');updateRechargemoney();" onkeydown="this.value=this.value.replace(/\D/g,'');updateRechargemoney();" onafterpaste="this.value=this.value.replace(/\D/g,'')">
	            </td>
	          </tr>
	        </table>
		</div>
      </div>
      <div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		<%-- 
               		<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveRechargeWallet();" id="btnfinish">
               		 --%>
               		<a href="javascript:saveRechargeWallet();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
               </c:when>
            </c:choose>
        </cite>
        <span class="red">${user.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">
    
    function saveRechargeWallet() {
    
       //终端号
	  /*  var terminalid = $("input[type='radio']:checked").val();
	   if(terminalid == null || terminalid == ''){
	   		$.dialog.tips('<spring:message code="user.terminalid.empty"/>', 1, 'alert.gif');
	   		return false;
	   }
	   //终端类型
	   var terminaltype=  $("#type_"+terminalid).val(); */
	   
	   var row = $("#userterminallist").datagrid("getSelected");
	   if(row == "" || row == null){
	   		$.dialog.tips('<spring:message code="user.terminalid.empty"/>', 1, 'alert.gif');
	   		return false;
	   }
	   var terminalid = row.terminalid;
	   var terminaltype = row.terminaltype;
        
        if ($('#rechargemoney').val() == '') {
	      $.dialog.tips('<spring:message code="userbusiness.walletrecharge.rechargemoney.empty"/>', 1, 'alert.gif');
	      $('#rechargemoney').focus();
	      return;
	    }
	    
	    if (parseFloat($('#pointvalue').val()) <= 0 || parseFloat($('#pointvalue').val()) > 65535) {
	      $.dialog.tips('<spring:message code="userbusiness.walletrecharge.pointvalue.range"/>', 1, 'alert.gif');
	      $('#rechargemoney').focus();
	      return;
	    }
        
        $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
	        '<spring:message code="page.confirm"/>',
	 	    '<spring:message code="page.cancel"/>',
	        function(){ 
				 $("#addform").attr("action", "user/saveRechargeWallet?terminalid="+terminalid+"&terminaltype="+terminaltype);
		    	 $("#addform").submit();
			}, function(){
						});
    }
    
    
	$(function () {
	      loadUserInfo();
	      //loadUserCardInfo();
	      
	      initUserterminallist();
	      
	      var returninfo = '${user.returninfo}';
	      if (returninfo != '') {
	       	$.dialog.tips(returninfo, 1, 'alert.gif');
	      }
	 });
  
	 function loadUserInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'userInfo'
	   };
	   var url = 'user/getUserInfo .' + data.tag;
	   $('#userInfo').load(url, data, function () {
	   		//动态渲染加载的easyui组件样式
	   		$.parser.parse($('#switchButton').parent());
	   });
	 }
	
	
	function loadUserCardInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'userTerminalInfo'
	   };
	   var url = 'user/getUserCardInfo .' + data.tag;
	   $('#userCardInfo').load(url, data, function () {
	   });
	 }
	
	var unitBusinessDialog;
	function unitBusiness() {
	  
	   var address = $("#address").val();
	   if(address == null || address == ''){
	   		$.dialog.tips('<spring:message code="user.newaddress.empty"/>', 1, 'alert.gif');
	   		$("#address").focus();
	   		return false;
	   }
	  
	   unitBusinessDialog = $.dialog({
		    title: '<spring:message code="userbusiness.feecount"/>',
		    lock: true,
		    width: 800,
		    height: 400,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    cancel:false,
		    content: 'url:user/unitBusiness?businesstype='+$('#businesstype').val()+'&address='+$('#address').val()
		});
	 }
	
	function closeBusinessDialog(){
		unitBusinessDialog.close();
		loadUserInfo();
	}
	
	
	function updateRechargemoney(){
	
    	var denominator = $("#denominator").val();//货币转换因子值
    	if(denominator == ''){
    		denominator = 0;
    	}
    	
    	var rechargemoney = $("#rechargemoney").val();//充值金额
    	if(rechargemoney == ''){
    		rechargemoney = 0;
    	}
    	
    	var pointvalue =  parseFloat(denominator) * parseFloat(rechargemoney);
	    $("#pointvalue").val(parseFloat(pointvalue));
    	
    }
	
	
	/////////////////////对必要的输入框进行数字合法验证//////////////////////////
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
		updateRechargemoney();
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
			updateRechargemoney();
	}
	
	function onkeyblurCheck(obj){
		if(obj.value==0){
				obj.value='';
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
		updateRechargemoney();
	}
	
	//终端信息初始化
	function initUserterminallist(){
	    $('#userterminallist').datagrid({
	         title: '<spring:message code="user.terminalinfo" />',
	         url:'user/userterminalforWalletJson',
	         queryParams: userterminalparamsJson(),
	         pageSize:5,
             singleSelect: true,
             pageList: [5,25,50], 
	         scrollbar:true,
	         pagination: false,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         frozenColumns:[[ {field:'ck',checkbox:true}]],
	         columns: [[
	             { field: 'terminalid', title: '<spring:message code="user.terminalid"/>',align:"center",width:100},
	             { field: 'terminaltype', title: '<spring:message code="user.terminaltype"/>',align:"center",width:100,
	             	 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="user.terminaltype.0"/>';
						 	}else{
						 		return '<spring:message code="user.terminaltype.1"/>';
						 	}
           	         },
	             },
	             { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },
	             },
	             { field: 'state', title: '<spring:message code="usercard.state"/>',align:"center",width:100,
	             	 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="userstb.state.0"/>';
						 	}else if(val == '1'){
						 		return '<spring:message code="userstb.state.1"/>';
						 	}else if(val == '2'){
						 		return '<spring:message code="userstb.state.2"/>';
						 	}else if(val == '3'){
						 		return '<spring:message code="userstb.state.3"/>';
						 	}else if(val == '4'){
						 		return '<spring:message code="userstb.state.4"/>';
						 	}
           	         },
	             },
	             { field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag"/>',align:"center",width:100,
	             	formatter: function(val, row, index){
	                    if(val=='0'){
	                    	return '<spring:message code="usercard.mothercardflag.0"/>';
	                    }else if(val=='1'){
	                    	return '<spring:message code="usercard.mothercardflag.1"/>';
	                    }
	                }, 
	             },
	        	 { field: 'mothercardid', title: '<spring:message code="usercard.mothercardid" />',align:"center",width:100,},
	        	 { field: 'stbno', title: '<spring:message code="usercard.stbno" />',width:80,align:"center",},
	         ]],
	         onLoadSuccess:function(data){  
	        	 
	         },
	     });
	     var p = $('#userterminallist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	function userterminalparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
	
	//////////////////////////////////////////////////////////////////////
</script>
</body>
</html>
