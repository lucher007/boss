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
      height: 30px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.devicebuy"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.devicebuy"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
    	<!-- <div id="userstbInfo"></div>
        <div id="buyingStbInfo"></div>
        <div id="buyingCardInfo"></div>
        <div id="buyingProductInfo"></div> -->
        
        <!-- 改变子母卡属性弹出框 -->
        <div class="pop-box" id="pop-div">
			<table width="400" border="0" cellpadding="0" cellspacing="0">
	          <tr>
	            <td height="30" width="30%" align="right"><spring:message code="userstb.mothercardflag"/>：</td>
	            <td width="60%">
	            	<select id="mothercardflag" name="mothercardflag" class="select" onchange="onchangeMothercardflag();">
		                <option value="1" ><spring:message code="userstb.mothercardflag.1"/></option>
		                <option value="0" ><spring:message code="userstb.mothercardflag.0"/></option>
		            </select>
	            </td>
	          </tr>
	          <tr id="mothercardidTr">
	            <td height="30" width="30%" align="right"><spring:message code="userstb.mothercardid"/>：</td>
	            <td width="60%">
	            	<select id="mothercardid" name="mothercardid" class="select">
			        </select>
	            </td>
	          </tr>
			</table>
		</div>
        
      </div>
      
      <!-- 机顶盒信息 -->
      <div id="userstblist" style="width:auto;"></div>
      
      <!-- 机顶盒购买 -->
      <div style="margin:10px 0;"></div>
      <table id="buyingstbData" style="width:auto;height: 200px;"></table>
      <div id="stbtools">
		<span style="margin-bottom:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:addStb();"><spring:message code="business.type.buystb"/></a>
		</span>
		<span style="margin-bottom:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:addBatchStb();"><spring:message code="business.type.buystb"/></a>
		</span>
	  </div>
	  
	  <!-- 智能卡购买 -->
      <div style="margin:10px 0;"></div>
      <table id="buyingcardData" style="width:auto;height: 200px;"></table>
      <c:if test = "${user.user.stbcardpairflag  ne '1'}">
	      <div id="cardtools">
			<span style="margin-bottom:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:addCard('');"><spring:message code="business.type.buycard"/></a>
			</span>
			<span style="margin-bottom:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:addBatchCard('');"><spring:message code="business.type.buycard"/></a>
			</span>
		  </div>
	  </c:if>
      
      <!-- 产品购买 -->
      <div style="margin:10px 0;"></div>
      <table id="buyingproductData" style="width:auto;height: 200px;"></table>
      <%-- <div id="producttools">
		<div style="margin-bottom:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:addProduct();"><spring:message code="business.type.buyproduct"/></a>
		</div>
	  </div> --%>
      
      <!-- 其他费用收取 -->
      <div style="margin:10px 0;"></div>
      <table id="buyingotherfeeData" style="width:auto;height: 150px;"></table>
      <div id="otherfeetools">
		<div style="margin-bottom:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:openWindow('otherfee');"><spring:message code="otherexpenses"/></a>
		</div>
	  </div>
      <!--其他费用收取窗口-->		
	  <div id="otherfee" class="easyui-window" title="<spring:message code="otherexpenses"/>" closed="true" style="width:450px;height:250px;">
		<div style="padding:10px 20px 10px 40px;">
			<table width="100%">
				 <tr height="30px">
		            <td align="right"><spring:message code="service.servicetype"/>：</td>
					<td align="left">
						 <input id="typekey" name="typekey" style="width: 157px;">
						 <span class="red">*</span>
					</td>
		        </tr>
		        <tr height="30px">
		            <td align="right"><spring:message code="statreport.business.price"/>：</td>
		            <td align="left">
		            	<input type="text" class="easyui-numberbox" style="width: 157px;" data-options="precision:2"  style="width:150px;" name="price" id="price"  onpaste="return false" maxlength="10">
		            </td>
		        </tr>
		        <tr height="30px">
		            <td align="right"><spring:message code="otherexpenses.remark"/>：</td>
		            <td align="left">
		            	<input type="text"  class="inp" style="width:250px;" name="remark" id="remark"  maxlength="30" >
		            </td>
		        </tr>
			</table>
		<div style="margin:20px 0;"></div>
			<div style="padding:5px;text-align:center;">
				<a onclick="saveOtherfee(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.save"/></a>
				<a onclick="closeWindow(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.cancel"/></a>
			</div>
		</div>
	  </div>
	  
      <div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		 <%-- 
               		 <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="unitBusiness();" id="btnfinish">
               		  --%>
               		 <a href="javascript:unitBusiness();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
               </c:when>
            </c:choose>
        </cite>
        <span class="red">${user.returninfo }</span>
      </div>
    </div>
    
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">
	
	 function updateProduct() {
	    if ($('#userid').val() == '') {
	      $.dialog.tips('<spring:message code="user.userid.empty"/>', 1, 'alert.gif');
	      $('#userid').focus();
	      return;
	    }
	       
	    var hasSelected = false;
	    $('.checkbox').each(function () {
	      if ($(this).attr('checked')) {
	        return hasSelected = true;
	      }
	    });
	    if (!hasSelected) {
	      $.dialog.tips('<spring:message code="user.service.empty"/>', 1, 'alert.gif');
	      return;
	    }
	     
	     $('#addform').attr('action', 'user/update');
	     $("#addform").submit();
	 }
	 
	 function goBack() {
	     $("#addform").attr("action", "user/findByList");
	     $("#addform").submit();
	 }
  
  
	$(function () {
	      loadUserInfo();
	      //loadUserstbInfo();
	      //loadBuyingStbInfo();
	      //loadBuyingCardInfo();
	      //loadBuyingProductInfo();
	      
	      initBuyingOtherfeeDatagrid();
	      initOtherbusinesstype();
	      
	      initUserstblist();
	      initBuyingStbDatagrid();
	      initBuyingCardDatagrid();
	      initBuyingProductDatagrid();
	      
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
	 
	 function loadUserstbInfo() {
		   var data = {
		     id: '${user.user.id}',
		     tag: 'userstbInfo'
		   };
		   var url = 'user/getUserstbInfo .' + data.tag;
		   		$('#userstbInfo').load(url, data, function () {
		   });
	 }
  
	 function loadBuyingStbInfo() {
	  
	   var data = {
	     id: '${user.user.id}',
	     tag: 'buyingStbInfo'
	   };
	   
	   var url = 'user/getBuyingStbInfo .' + data.tag;
	   $('#buyingStbInfo').load(url, data, function () {
	   });
	 }
  
	 function loadBuyingCardInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'buyingCardInfo'
	   };
	   var url = 'user/getBuyingCardInfo .' + data.tag;
	   $('#buyingCardInfo').load(url, data, function () {
	   });
	 }
	 
	 function loadBuyingProductInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'buyingProductInfo'
	   };
	   var url = 'user/getBuyingProductInfo .' + data.tag;
	   $('#buyingProductInfo').load(url, data, function () {
	   });
	 }
  
	 var stbDialog;
	 function addStb() {
 		stbDialog = $.dialog({
		    title: '<spring:message code="stb.stbquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findStbListForDialog?querystate=0'
		});
	 }
	 
	 var batchStbDialog;
	 function addBatchStb() {
 		batchStbDialog = $.dialog({
		    title: '<spring:message code="stb.stbquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findBatchStbListForDialog?querystate=0'
		});
	 }
  
	function closeStbDialog(){
		stbDialog.close();
		//loadBuyingStbInfo();
		//loadBuyingCardInfo();
		
		$('#buyingcardData').datagrid('reload');
		$('#buyingstbData').datagrid('reload');
	}
	
	function closeBatchStbDialog(){
		batchStbDialog.close();
		
		$('#buyingcardData').datagrid('reload');
		$('#buyingstbData').datagrid('reload');
	}
  
    //删除购买中的机顶盒
	function deleteBuyingStb(stbno){
	    var data = "stbno="+ stbno;
		var url="user/deleteBuyingStb?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//loadBuyingStbInfo();
				//loadBuyingCardInfo();
				//loadBuyingProductInfo();
				
				$('#buyingstbData').datagrid('reload');
				$('#buyingcardData').datagrid('reload');
				$('#buyingproductData').datagrid('reload');
			}
		});
	}	
	
	var cardDialog;
	function addCard(stbno) {
		//判断已购买卡的机顶盒不能再购买卡
		var rows = $('#buyingcardData').datagrid('getRows');
		for(var i = 0;i < rows.length;i++){
			if(rows[i].stbno == stbno){
				return false;
			} 
		}
		
	   cardDialog = $.dialog({
		    title: '<spring:message code="card.cardquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findCardListForDialog?querystate=0'+'&stbno='+stbno
	   });
	}
	
	var batchCardDialog;
	function addBatchCard(stbno) {
	   batchCardDialog = $.dialog({
		    title: '<spring:message code="card.cardquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findBatchCardListForDialog?querystate=0'+'&stbno='+stbno
	   });
	}
     
    function closeCardDialog(){
		cardDialog.close();
		//loadUserstbInfo();
		//loadBuyingStbInfo();
		//loadBuyingCardInfo();
		
		$('#buyingcardData').datagrid('reload');
	}
	
	function closeBatchCardDialog(){
		batchCardDialog.close();
		
		$('#buyingcardData').datagrid('reload');
	}
	
	//删除购买中的智能卡
	function deleteBuyingCard(cardid){
		var rows = $("#buyingstbData").datagrid("getRows");
		for(var i = 0;i < rows.length;i++){
			if(rows[i].paircardflag == "1"){//入库机卡绑定
				return;
			}
		}
		
	    var data = "cardid="+ cardid;
		var url="user/deleteBuyingCard?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//loadUserstbInfo();
				//loadBuyingStbInfo();
				//loadBuyingCardInfo();
				//loadBuyingProductInfo();
				$('#buyingstbData').datagrid('reload');
				$('#buyingcardData').datagrid('reload');
				$('#buyingcardData').datagrid('clearSelections');
				$('#buyingproductData').datagrid('reload');
			}
		});
	}	
	
	var productDialog;
	function addProduct(cardid,stbno,mothercardflag,mothercardid) {
		
	   //var cardid = $("input[type='radio']:checked").val();
	   //if(cardid == null || cardid == ''){
	   //		$.dialog.tips('<spring:message code="userproduct.cardid.empty"/>', 1, 'alert.gif');
	   //		return false;
	   //}
	   
	   /* var row = $('#buyingcardData').datagrid('getSelected');
	   if(row == '' || row == null){
	   		$.dialog.tips('<spring:message code="userproduct.cardid.empty"/>', 1, 'alert.gif');
	   		return false;
	   }
	   cardid = row.cardid;
	   stbno = row.stbno;
	   mothercardflag = row.mothercardflag;
	   mothercardid = row.mothercardid; */
	   
	   productDialog = $.dialog({
		    title: '<spring:message code="product.productquery"/>',
		    lock: true,
		    width: 900,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findProductListForDialog?cardid='+cardid+'&stbno='+stbno+'&mothercardflag='+mothercardflag+'&mothercardid='+mothercardid
	   });
	}
     
    function closeProductDialog(){
		productDialog.close();
		//loadBuyingProductInfo();
		$('#buyingproductData').datagrid('reload');
	}
	
	//删除购买中的产品
	function deleteBuyingProduct(terminalid,productid){
	    var data = {
	    			terminalid: terminalid,
				    productid: productid
				   };
		var url="user/deleteBuyingProduct?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
				$.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//loadBuyingProductInfo();
				$('#buyingproductData').datagrid('reload');
			}
		});
	}	
	
	var unitBusinessDialog;
	function unitBusiness() {
	   
	   /* if($('.stbflag').length==0 && $('.cardflag').length==0 && $('.productflag').length==0){
	   		return false;
	   } */
	   if($('#buyingstbData').datagrid('getRows') == '' && $('#buyingcardData').datagrid('getRows') == ''
	   		&& $('#buyingproductData').datagrid('getRows') == ''){
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
		    content: 'url:user/unitBusiness?businesstype='+$('#businesstype').val()
		});
	 }
	
	function closeBusinessDialog(){
		unitBusinessDialog.close();
		//loadUserInfo();
		//loadBuyingStbInfo();
		//loadBuyingCardInfo();
		//loadBuyingProductInfo();
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
	}
	
	var updateMothercardflagDialog;
	function updateMothercardflagInit(terminaltype,terminalid) {	   
	    var data = {
		    terminaltype: terminaltype,
		    terminalid: terminalid,
		    t: new Date().getTime()
		  };
		  
		 $.getJSON('userproduct/initMothercardListJson', data, function (mothercardListJson) {
		       var options = '<option value=""><spring:message code="page.select"/></option>';
		       for (var key in mothercardListJson) {
		            options += '<option value="' + key + '">' + mothercardListJson[key] + '</option>';
		  	   }
		       $('#mothercardid').children().remove();
		       $('#mothercardid').append(options);
	      });
		  
	     updateMothercardflagDialog = $.dialog({
		    title: '<spring:message code="userstb.mothercardflag"/>',
		    lock: true,
		    width: 400,
		    height:100,
		    top: 200,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: $("#pop-div").html(),
		   	ok: function(){
		   		   if($('#mothercardflag').val() == '1' && $('#mothercardid').val() == '') {
				      	$.dialog.tips('<spring:message code="usercard.mothercardid.empty"/>', 1, 'alert.gif');
				      	$('#mothercardid').focus();
				      return false;
				   }
		   		   updateMothercardflag(terminaltype,terminalid);
		   		},
		   	okVal:'<spring:message code="page.confirm"/>',
		   	cancel:function(){/* updateMothercardflagDialog.close(); */},
		   	cancelVal:'<spring:message code="page.cancel"/>'
	   });
	 }
	
	function onchangeMothercardflag(){
		if($("#mothercardflag").val()=="1"){
		    $("#mothercardidTr").show();
		}else{
		    $("#mothercardidTr").hide();
		}
	}
	
	function updateMothercardflag(terminaltype,terminalid){
		var data = {
				     terminaltype: terminaltype,
				       terminalid: terminalid,
				     mothercardflag: $('#mothercardflag').val(),
				     mothercardid: $('#mothercardid').val()
				   };
		var url="userproduct/updateMothercardflag?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
		    
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 2, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//closeUpdateMothercardflagDialog();
				if(terminaltype == '0'){//机顶盒
					$('#buyingstbData').datagrid('reload');
				}else{
					$('#buyingcardData').datagrid('reload');
				}
			}
		});
    }
	
	function closeUpdateMothercardflagDialog(){
		loadBuyingStbInfo();
		loadBuyingCardInfo();
		loadBuyingProductInfo();
		updateMothercardflagDialog.close();
	}
	
	//初始化其他费用收取
	function initBuyingOtherfeeDatagrid(){
      $('#buyingotherfeeData').datagrid({
           title: '<spring:message code="otherexpenses"/>',
           //queryParams: paramsJson(),
           url:'user/getBuyingOtherfeeJson',
           pagination: false,
           singleSelect: true,
           scrollbar:true,
           rownumbers:true,
           toolbar:'#otherfeetools',
           //checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'正在加载数据......',
           columns: [[
			   { field: 'typekey', title: '<spring:message code="otherexpenses.key"/>',width:50,align:"center",},
			   { field: 'typename', title: '<spring:message code="otherexpenses.name"/>',width:50,align:"center",},
			   { field: 'price', title: '<spring:message code="otherexpenses.price"/>',width:50,align:"center",},
			   { field: 'remark', title: '<spring:message code="otherexpenses.remark"/>',width:50,align:"center",},
			   { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:50,
  	 					formatter:function(val, row, index){ 
  	 						return '<a class="btn-del" href="javascript:deleteBuyingOtherfee(\''+row.typekey+'\');" ><spring:message code="page.delete"/></a>';
            	       }
       			},
           ]]
       });
	}
	
	//开启弹出框
    function openWindow(service_name){
	    //如果是弹出其他费用收取框，先初始化业务类型数据
		$('#'+service_name).window('open');
		$('#'+service_name).window("resize",{top:$(document).scrollTop() + ($(window).height()-250) * 0.5});//居中显示
	}
	
	 //关闭弹出框
	function  closeWindow(obj){
		$(obj).parents('.easyui-window').window('close');
	}
	
	//初始化其他业务类型
	function initOtherbusinesstype(){
	   $('#typekey').combobox({    
			url:'businesstype/initOtherbusinesstypeJson',
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'name',
	        onSelect: function(rec){ 
	        	$('#price').numberbox('setValue',rec.price);
        	},
		    onLoadSuccess:function(data){
			    	//初始化列表框的默认选择值
					var val = $('#typekey').combobox("getData");
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $(this).combobox("select", val[0][item]);  
                        }  
                     }  	
			    }
		});  
    }
    
    //其他费用收取添加
    function saveOtherfee(obj){
		
    	if ($('#typekey').combobox('getValue') == '') {
		      //$.dialog.tips('请选择业务类型', 1, 'alert.gif');
		      $('#typekey').next('span').find('input').focus();
		      return;
	    }
		
    	var typekey = $('#typekey').combobox('getValue');
		var data = {
				typekey:typekey,
				price: $('#price').numberbox('getValue'),
				remark:$('#remark').val(),
			  };
			var url="user/addBuyingOtherfee?rid="+Math.random();
			$.getJSON(url,data,function(jsonMsg){
				$(obj).parents('.easyui-window').window('close');
				if(jsonMsg.flag=="0"){
				    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
				}else if(jsonMsg.flag=="1"){
					//刷新收取的其他收费
					$('#buyingotherfeeData').datagrid('reload');
				}
			});
	}
	
	//删除购买中的其他费用
	function deleteBuyingOtherfee(typekey){
    	 
		var data = {
				typekey:typekey,
			  };
	   
		var url="user/deleteBuyingOtherfee?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//刷新收取的其他收费
				$('#buyingotherfeeData').datagrid('reload');
			}
		});
	}
	
	//终端信息初始化
	function initUserstblist(){
	    $('#userstblist').datagrid({
	         title: '<spring:message code="user.stbinfo" />',
	         url:'user/userbuystbJson',
	         queryParams: userstbparamsJson(),
	         pageSize:5,
             singleSelect: true,
             pageList: [5,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         //frozenColumns:[[ {field:'ck',checkbox:true}]],
	         columns: [[
	             { field: 'stbno', title: '<spring:message code="stb.stbno"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },
	             },
	             { field: 'state', title: '<spring:message code="userstb.state"/>',align:"center",width:100,
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
	                    if(row.incardflag == '2'){//无卡机顶盒
	                    	if(val=='0'){
		                    	return '<spring:message code="userstb.mothercardflag.0"/>';
		                    }else if(val=='1'){
		                    	return '<spring:message code="userstb.mothercardflag.1"/>';
		                    }
	                    }
	                }, 
	             },
	        	 { field: 'mothercardid', title: '<spring:message code="userstb.mothercardid" />',align:"center",width:100,},
	        	 { field: 'incardflag', title: '<spring:message code="userstb.incardflag" />',align:"center",width:100,
	        	 	formatter: function(val, row, index){
	                    if(val=='0'){
	                    	return '<spring:message code="userstb.incardflag.0"/>';
	                    }else if(val=='1'){
	                    	return '<spring:message code="userstb.incardflag.1"/>';
	                    }else if(val=='2'){
	                    	return '<spring:message code="userstb.incardflag.2"/>';
	                    }
	                }, 
	        	 },
	        	 { field: 'buycardflag', title: '<spring:message code="page.operate" />',width:80,align:"center",
	        	 	formatter: function(val, row, index){
	                    if(val=='0' && row.incardflag != '2'){//未买卡的有卡机顶盒
	                    	if('${user.user.stbcardpairflag}' == '1'){//发送机卡绑定指令
		                    	return '<a class="btn-add" href="javascript:addCard(\''+row.stbno+'\');" ><spring:message code="business.type.buycard"/></a>';
		                    }
			   			}
	                },
	        	 },
	         ]],
	         onBeforeSelect:function(){//不能选中
		         return false;
		     },
	     });
	     var p = $('#userstblist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	function userstbparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
	
	//初始化购买中的机顶盒列表
	function initBuyingStbDatagrid(){
      $('#buyingstbData').datagrid({
           title: '<spring:message code="userstb.buyingstblist"/>',
           //queryParams: paramsJson(),
           url:'user/getBuyingStbJson',
           pagination: false,
           singleSelect: true,
           scrollbar:true,
           rownumbers:true,
           toolbar:'#stbtools',
           //checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'正在加载数据......',
           columns: [[
			   { field: 'stbno', title: '<spring:message code="stb.stbno"/>',width:50,align:"center",},
			   { field: 'price', title: '<spring:message code="stb.price"/>',width:50,align:"center",},
			   { field: 'servername', title: '<spring:message code="server.servername"/>',width:50,align:"center",},
			   { field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag"/>',width:50,align:"center",
			   		formatter: function(val, row, index){
	                    if(row.incardflag == '2'){//无卡机顶盒
	                    	if(val=='0'){
		                    	return '<spring:message code="userstb.mothercardflag.0"/>' + 
		                    		'<a class="btn-edit" href="javascript:updateMothercardflagInit(0,\''+row.stbno+'\');"><spring:message code="page.update"/></a>';
		                    }else if(val=='1'){
		                    	return '<spring:message code="userstb.mothercardflag.1"/>' + 
		                    		'<a class="btn-edit" href="javascript:updateMothercardflagInit(0,\''+row.stbno+'\');"><spring:message code="page.update"/></a>';
		                    }
	                    	
	                    }
	                }, 
			   },
			   { field: 'mothercardid', title: '<spring:message code="userstb.mothercardid"/>',width:50,align:"center",},
			   { field: 'incardflag', title: '<spring:message code="userstb.incardflag"/>',width:50,align:"center",
			   		formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="userstb.incardflag.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="userstb.incardflag.1" />';
						 	}else if(val == '2'){
						 		return '<spring:message code="userstb.incardflag.2" />';
						 	}
     	              },
			   },
			   { field: 'id', title: '<spring:message code="page.operate"/>',width:50,align:"center",
			   		formatter:function(val, row, index){ 
			   			if(row.incardflag == '2'){//无卡机顶盒
			   				return '<a class="btn-add" href="javascript:addProduct(\'\',\''+row.stbno+'\',\''+row.mothercardflag+'\',\''+row.mothercardid+'\');" ><spring:message code="business.type.buyproduct"/></a>' +
			   					'<a class="btn-del" href="javascript:deleteBuyingStb(\''+row.stbno+'\');" ><spring:message code="page.delete"/></a>';
			   			}else{//有卡机顶盒
			   				if('${user.user.stbcardpairflag}' == '1'){//发送机卡绑定指令
				   				return '<a class="btn-add" href="javascript:addCard(\''+row.stbno+'\');" ><spring:message code="business.type.buycard"/></a>' + 
				   					'<a class="btn-del" href="javascript:deleteBuyingStb(\''+row.stbno+'\');" ><spring:message code="page.delete"/></a>';
				   			}else{
				   				return '<a class="btn-del" href="javascript:deleteBuyingStb(\''+row.stbno+'\');" ><spring:message code="page.delete"/></a>';
				   			}
			   			}
            	    }
			   },
			   { field: 'paircardflag', hidden: 'true'}
           ]],
           onBeforeSelect:function(){//不能选中
		         return false;
		     },
       });
	}
	
	//初始化购买中的智能卡列表
	function initBuyingCardDatagrid(){
      $('#buyingcardData').datagrid({
           title: '<spring:message code="usercard.buyingcardlist"/>',
           //queryParams: paramsJson(),
           url:'user/getBuyingCardJson',
           pagination: false,
           singleSelect: true,
           scrollbar:true,
           rownumbers:true,
           toolbar:'#cardtools',
           //checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'正在加载数据......',
           //frozenColumns:[[ {field:'ck',checkbox:true}]],
           columns: [[
			   { field: 'cardid', title: '<spring:message code="card.cardid"/>',width:50,align:"center",},
			   { field: 'price', title: '<spring:message code="card.price"/>',width:50,align:"center",},
			   { field: 'mothercardflag', title: '<spring:message code="usercard.mothercardflag"/>',width:50,align:"center",
				   formatter: function(val, row, index){
	                    if(val=='0'){
	                    	return '<spring:message code="usercard.mothercardflag.0"/>' + 
	                    		'<a class="btn-edit" href="javascript:updateMothercardflagInit(1,\''+row.cardid+'\');"><spring:message code="page.update"/></a>';
	                    }else if(val=='1'){
	                    	return '<spring:message code="usercard.mothercardflag.1"/>' + 
	                    		'<a class="btn-edit" href="javascript:updateMothercardflagInit(1,\''+row.cardid+'\');"><spring:message code="page.update"/></a>';
	                    }
	                }, 
			   },
			   { field: 'mothercardid', title: '<spring:message code="usercard.mothercardid"/>',width:50,align:"center",},
			   { field: 'stbno', title: '<spring:message code="card.stbno"/>',width:50,align:"center",},
			   { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:50,
  	 					formatter:function(val, row, index){ 
  	 						if(row.pairstbflag == '1'){//已配对机顶盒
  	 							return '<a class="btn-add" href="javascript:addProduct(\''+row.cardid+'\',\'\',\''+row.mothercardflag+'\',\''+row.mothercardid+'\');" ><spring:message code="business.type.buyproduct"/></a>';
  	 						}else{//已配对机顶盒
  	 							return '<a class="btn-add" href="javascript:addProduct(\''+row.cardid+'\',\'\',\''+row.mothercardflag+'\',\''+row.mothercardid+'\');" ><spring:message code="business.type.buyproduct"/></a>' +
	 							   '<a class="btn-del" href="javascript:deleteBuyingCard(\''+row.cardid+'\');" ><spring:message code="page.delete"/></a>';
  	 						}
            	       }
       			},
           ]],
           onBeforeSelect:function(){//不能选中
		         return false;
		     },
       });
	}
	
	//初始化购买中的产品列表
	function initBuyingProductDatagrid(){
      $('#buyingproductData').datagrid({
           title: '<spring:message code="userproduct.buyingproductlist"/>',
           //queryParams: paramsJson(),
           url:'user/getBuyingProductJson',
           pagination: false,
           singleSelect: true,
           scrollbar:true,
           rownumbers:true,
           //toolbar:'#producttools',
           //checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'正在加载数据......',
           columns: [[
			   { field: 'terminalid', title: '<spring:message code="user.terminalid"/>',width:80,align:"center",},
			   { field: 'terminaltype', title: '<spring:message code="user.terminaltype"/>',width:50,align:"center",
			   		formatter:function(val, row, index){ 
					 	if(val == '0'){
					 		return '<spring:message code="user.terminaltype.0"/>';
					 	}else if(val == '1'){
					 		return '<spring:message code="user.terminaltype.1"/>';
					 	}
          	        },
			   },
			   { field: 'productid', title: '<spring:message code="product.productid"/>',width:50,align:"center",},
			   { field: 'productname', title: '<spring:message code="product.productname"/>',width:50,align:"center",},
			   { field: 'type', title: '<spring:message code="userproduct.type"/>',width:50,align:"center",},
			   { field: 'starttime', title: '<spring:message code="userproduct.starttime"/>',width:50,align:"center",
				    formatter:function(val, row, index){ 
					 	return val==null?val:val.substring(0,10);
          	        },
			   },
			   { field: 'endtime', title: '<spring:message code="userproduct.endtime"/>',width:50,align:"center",
				   formatter:function(val, row, index){ 
					 	return val==null?val:val.substring(0,10);
         	        },
			   },
			   { field: 'price', title: '<spring:message code="userproduct.price"/>',width:50,align:"center",},
			   { field: 'buyamount', title: '<spring:message code="userproduct.buyamount"/>',width:50,align:"center",},
			   { field: 'totalmoney', title: '<spring:message code="userproduct.totalmoney"/>',width:50,align:"center",},
			   { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:50,
  	 					formatter:function(val, row, index){ 
  	 						return '<a class="btn-del" href="javascript:deleteBuyingProduct(\''+row.terminalid+'\',\''+row.productid+'\');" ><spring:message code="page.delete"/></a>';
            	       }
       			},
           ]],
           onBeforeSelect:function(){//不能选中
		         return false;
		     },
       });
	}
	
</script>
</body>
</html>
