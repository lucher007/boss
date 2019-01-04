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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.productbuy"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.productbuy"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
        <%-- <table>
          <tr class="fbc-tit">
            <td colspan="8" style="font-weight: bold;"><spring:message code="user.terminalinfo"/></td>
          </tr>
          <tr class="lb-tit">
                <!-- 
          		<td width="60"><spring:message code="page.select"/></td>
          		 -->
          		<td><spring:message code="user.terminalid"/></td>
          		<td><spring:message code="user.terminaltype"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="usercard.state"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
	          	<td><spring:message code="page.operate"/></td>
          </tr>
          <c:forEach items="${user.user.userstblist }" var="dataList">
          	<c:if test="${dataList.incardflag == '2'}">
	        	<tr height="30" class="lb-list">
	        		<!-- 
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.stbno}">
	        	    </td>
	        	     -->
	        		<td >${dataList.stbno }</td>
	        		<td><spring:message code="user.terminaltype.0"/></td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td></td>
	        		<td>
	        		    <c:choose>  
			               <c:when test="${dataList.state eq '1'}">
			               		<a class="btn-add" href="javascript:addProduct('','${dataList.stbno}','${dataList.mothercardflag}','${dataList.mothercardid}');" ><spring:message code="business.type.buyproduct"/></a>
			               </c:when>
			            </c:choose>
	      			</td>
	        	</tr>
	        </c:if>
         </c:forEach>
          <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<!-- 
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.cardid }">
	        	    </td>
	        	     -->
	        		<td >${dataList.cardid }</td>
	        		<td><spring:message code="user.terminaltype.1"/></td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="usercard.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td >${dataList.stbno }</td>
	        		<td>
	        			<c:choose>  
			               <c:when test="${dataList.state eq '1'}">
			               		<a class="btn-add" href="javascript:addProduct('${dataList.cardid}','','${dataList.mothercardflag}','${dataList.mothercardid}');" ><spring:message code="business.type.buyproduct"/></a>
			               </c:when>
			            </c:choose>
	      			</td>
	        	</tr>
        	</c:forEach>
        </table> --%>
        <div id="buyingProductInfo"></div>
      </div>
      
      <div id="userterminallist" style="width:auto;height: 200px;"></div>
      
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
	      //loadBuyingStbInfo();
	      //loadBuyingCardInfo();
	      //loadBuyingProductInfo();
	      initBuyingOtherfeeDatagrid();
	      initOtherbusinesstype();
	      
	      initUserterminallist();
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
  
	function closeStbDialog(){
		stbDialog.close();
		loadBuyingStbInfo();
		loadBuyingCardInfo();
	}
  
	var cardDialog;
	function addCard() {
	   cardDialog = $.dialog({
		    title: '<spring:message code="card.cardquery"/>',
		    lock: true,
		    width: 800,
		    height: 500,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findCardListForDialog?querystate=0'
	   });
	}
     
    function closeCardDialog(){
		cardDialog.close();
		loadBuyingCardInfo();
	}
	
	//删除购买中的智能卡
	function deleteBuyingCard(cardid){
	    var data = "cardid="+ cardid;
		var url="user/deleteBuyingCard?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				loadBuyingCardInfo();
				loadBuyingProductInfo();
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
	   
	   /* var row = $('#userterminallist').datagrid('getSelected');
	   if(row == '' || row == null){
	   		$.dialog.tips('<spring:message code="userproduct.cardid.empty"/>', 1, 'alert.gif');
	   		return false;
	   }
	   if(row.terminaltype == '0'){//机顶盒
	   		cardid = "";
	   		stbno = row.terminalid;
	   }else{//智能卡
	   		cardid = row.terminalid;
	   		stbno = "";
	   }
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
	   if($('#buyingproductData').datagrid('getRows') == ''){
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
	function initUserterminallist(){
	    $('#userterminallist').datagrid({
	         title: '<spring:message code="user.terminalinfo" />',
	         url:'user/userterminalJson',
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
	         //frozenColumns:[[ {field:'ck',checkbox:true}]],
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
	         	 { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:50,
	         	 	formatter: function(val, row, index){
	         	 		if(row.terminaltype == '0'){//机顶盒
	         	 			return '<a class="btn-add" href="javascript:addProduct(\'\',\''+row.terminalid+'\',\''+row.mothercardflag+'\',\''+row.mothercardid+'\');" ><spring:message code="business.type.buyproduct"/></a>';
	         	 		}
	                    return '<a class="btn-add" href="javascript:addProduct(\''+row.terminalid+'\',\'\',\''+row.mothercardflag+'\',\''+row.mothercardid+'\');" ><spring:message code="business.type.buyproduct"/></a>';
	                },
	         	 }
	         ]],
	         onBeforeSelect:function(){//不能选中
		         return false;
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
           toolbar:'#producttools',
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
           ]]
       });
	}
	
</script>
</body>
</html>
