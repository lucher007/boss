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
<div id="body" style="width: 1000px; ">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.usertransfer"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.usertransfer"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
<!--     	<table> -->
<!--           <tr class="fbc-tit"> -->
<!--             <td colspan="6" style="font-weight: bold;"><spring:message code="user.stbinfo"/></td> -->
<!--           </tr> -->
<!--           <tr class="lb-tit"> -->
<!--           		<td><spring:message code="stb.stbno"/></td> -->
<!-- 	          	<td><spring:message code="user.buytime"/></td> -->
<!-- 	          	<td><spring:message code="userstb.state"/></td> -->
<!-- 	          	<td><spring:message code="userstb.mothercardflag"/></td> -->
<!-- 	          	<td><spring:message code="userstb.mothercardid"/></td> -->
<!-- 	          	<td><spring:message code="userstb.incardflag"/></td> -->
<!--          </tr> -->
<!--          <c:forEach items="${user.user.userstblist }" var="dataList"> -->
<!-- 	        	<tr height="30"class="lb-list"> -->
<!-- 	        		<td >${dataList.stbno }</td> -->
<!-- 	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td> -->
<!-- 	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td> -->
<!-- 	        		<td > -->
<!-- 		        		<c:if test="${dataList.incardflag=='2'}"> -->
<!-- 		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/> -->
<!-- 		        		</c:if> -->
<!-- 	        		</td> -->
<!-- 	        		<td >${dataList.mothercardid }</td> -->
<!-- 	        		<td ><spring:message code="userstb.incardflag.${dataList.incardflag }"/></td> -->
<!-- 	        	</tr> -->
<!--         	</c:forEach> -->
<!--         </table> -->
<!--     	<table> -->
<!--           <tr class="fbc-tit"> -->
<!--             <td colspan="6" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td> -->
<!--           </tr> -->
<!--           <tr class="lb-tit"> -->
<!--           		<td><spring:message code="card.cardid"/></td> -->
<!-- 	          	<td><spring:message code="user.buytime"/></td> -->
<!-- 	          	<td><spring:message code="usercard.state"/></td> -->
<!-- 	          	<td><spring:message code="usercard.mothercardflag"/></td> -->
<!-- 	          	<td><spring:message code="usercard.mothercardid"/></td> -->
<!-- 	          	<td><spring:message code="usercard.stbno"/></td> -->
<!--          </tr> -->
<!--          <c:forEach items="${user.user.usercardlist }" var="dataList"> -->
<!-- 	        	<tr height="30"class="lb-list"> -->
<!-- 	        		<td >${dataList.cardid }</td> -->
<!-- 	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td> -->
<!-- 	        		<td ><spring:message code="usercard.state.${dataList.state }"/></td> -->
<!-- 	        		<td > -->
<!-- 		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }"> -->
<!-- 		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/> -->
<!-- 		        		</c:if> -->
<!-- 	        		</td> -->
<!-- 	        		<td >${dataList.mothercardid }</td> -->
<!-- 	        		<td >${dataList.stbno }</td> -->
<!-- 	        	</tr> -->
<!--         	</c:forEach> -->
<!--         </table> -->
      </div>
      <div id="userStbInfoList" style="width: auto;"></div>
      <div id="userCardInfoList" style="width: auto;"></div>
      <div class="fb-con">
         <div id="transferUserInfo"></div>
      </div>
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
		        	<input type="button" class="btn-save" value="<spring:message code="menu.business.usertransfer"/>" onclick="unitBusiness();" id="btnfinish">
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
  
	$(function () {
	      loadUserInfo();
	      loadTransferUserInfo();
	      initBuyingOtherfeeDatagrid();
	      initOtherbusinesstype();
	      initUserStblist();
	      initUserCardlist();
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
  
	 function loadTransferUserInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'transferUserInfo'
	   };
	   var url = 'user/getUserInfo .' + data.tag;
	   $('#transferUserInfo').load(url, data, function () {
	   		//动态渲染加载的easyui组件样式
	   		$.parser.parse($('#selectButton').parent());
	   });
	 }
	
	var transferUserDialog;
	 function addUser() {
	    transferUserDialog = $.dialog({
		    title: '<spring:message code="user.userquery"/>',
		    lock: true,
		    width: 950,
		    height: 650,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: 'url:user/findTransferUserListForDialog?querystate=1'
		    
		});
	 }
  
	function closeTransferUserDialog(){
		transferUserDialog.close();
		loadUserInfo();
		loadTransferUserInfo();
	}
	
	
	var unitBusinessDialog;
	function unitBusiness() {
	   var stbrows = $("#userStbInfoList").datagrid("getRows");
	   var cardrows = $("#userCardInfoList").datagrid("getRows");
	   if(stbrows == "" && cardrows == ""){
	   		return false;
	   }
	   
	   var transferuserid = $("#transferuserid").val();
	   if(transferuserid == null || transferuserid == ''){
	   		$.dialog.tips('<spring:message code="user.transferuser.empty"/>', 1, 'alert.gif');
	   		return false;
	   }
	   
	   var id = $("#id").val();
	   
	   if(id == transferuserid){//过户给自己了
	   		$.dialog.tips('<spring:message code="user.transferuser.oneself"/>', 1, 'alert.gif');
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
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
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
	
	function initUserStblist(){
	    $('#userStbInfoList').datagrid({
	         title: '<spring:message code="user.stbinfo" />',
	         url:'user/userstbJson?userid=${user.user.id }',
	         pageSize:10,
             singleSelect: false,
             pageList: [10,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'stbno', title: '<spring:message code="stb.stbno"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="user.buytime"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
        	         },
	             },
	             { field: 'state', title: '<spring:message code="userstb.state"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	             		if (val == 0) {
							return	'<spring:message code="userstb.state.0"/>';
						}else if(val == 1){
							return	'<spring:message code="userstb.state.1"/>';
						}else if(val == 2){
							return	'<spring:message code="userstb.state.2"/>';
						}else if(val == 3){
							return	'<spring:message code="userstb.state.3"/>';
						}else if(val == 4){
							return	'<spring:message code="userstb.state.4"/>';
						}
	             	}
	             },
	             { field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
		             	if (row.incardflag == 2) {
		             		if (val == 0) {
								return	'<spring:message code="userstb.mothercardflag.0"/>';
							}else if(val == 1){
								return	'<spring:message code="userstb.mothercardflag.1"/>';
							}
						}
	             	}
	             },
	             { field: 'mothercardid', title: '<spring:message code="userstb.mothercardid"/>',align:"center",width:100},
	             { field: 'incardflag', title: '<spring:message code="userstb.incardflag"/>',align:"center",width:100,
	             	formatter:function(val,row,index){
	             		if (val == 0) {
							return	'<spring:message code="userstb.incardflag.0"/>';
						}else if(val == 1){
							return	'<spring:message code="userstb.incardflag.1"/>';
						}else if(val == 2){
							return	'<spring:message code="userstb.incardflag.2"/>';
						}
	             	}
	             }
	         ]],
	     });
	     var p = $('#userStbInfoList').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	function initUserCardlist(){
	    $('#userCardInfoList').datagrid({
	         title: '<spring:message code="user.cardinfo" />',
	         url:'user/usercardJson?userid=${user.user.id }',
	         pageSize:10,
             singleSelect: false,
             pageList: [10,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'cardid', title: '<spring:message code="card.cardid"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="user.buytime"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
        	         },
	             },
	             { field: 'state', title: '<spring:message code="usercard.state"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	             		if (val == 0) {
							return	'<spring:message code="userstb.state.0"/>';
						}else if(val == 1){
							return	'<spring:message code="userstb.state.1"/>';
						}else if(val == 2){
							return	'<spring:message code="userstb.state.2"/>';
						}else if(val == 3){
							return	'<spring:message code="userstb.state.3"/>';
						}else if(val == 4){
							return	'<spring:message code="userstb.state.4"/>';
						}
	             	}
	             },
	             { field: 'mothercardflag', title: '<spring:message code="usercard.mothercardflag"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	             		if (val == 0) {
							return	'<spring:message code="userstb.mothercardflag.0"/>';
						}else if(val == 1){
							return	'<spring:message code="userstb.mothercardflag.1"/>';
						}
	             	}
	             },
	             { field: 'mothercardid', title: '<spring:message code="usercard.mothercardid"/>',align:"center",width:100},
	             { field: 'stbno', title: '<spring:message code="usercard.stbno"/>',align:"center",width:100}
	         ]],
	     });
	     var p = $('#userCardInfoList').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
</script>
</body>
</html>
