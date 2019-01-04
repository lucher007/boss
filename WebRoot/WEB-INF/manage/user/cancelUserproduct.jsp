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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.cancelproduct"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.cancelproduct"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
<!--     	<table> -->
<!-- 	      	  <tr class="fbc-tit"> -->
<!-- 	            <td colspan="12" style="font-weight: bold;"><spring:message code="user.productinfo"/></td> -->
<!-- 	          </tr> -->
<!-- 	          <tr class="lb-tit"> -->
<!-- 	          		<td><spring:message code="user.terminalid"/></td> -->
<!-- 	          		<td><spring:message code="user.terminaltype"/></td> -->
<!-- 	          		<td><spring:message code="product.productid"/></td> -->
<!-- 		          	<td><spring:message code="product.productname"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.type"/></td> -->
<!-- 		          	<td><spring:message code="user.buytime"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.starttime"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.endtime"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.totalmoney"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.source"/></td> -->
<!-- 		          	<td><spring:message code="userproduct.state"/></td> -->
<!-- 		          	<td><spring:message code="page.operate"/></td> -->
<!-- 	         </tr> -->
<!-- 	         <c:forEach items="${user.user.userproductlist }" var="dataList"> -->
<!-- 		        	<tr height="30"class="lb-list"> -->
<!-- 		        		<td >${dataList.terminalid }</td> -->
<!-- 		        		<td ><spring:message code="user.terminaltype.${dataList.terminaltype }"/></td> -->
<!-- 	        			<td >${dataList.productid }</td> -->
<!-- 	        			<td >${dataList.productname }</td> -->
<!-- 		        		<td ><spring:message code="userproduct.type.${dataList.type }"/></td> -->
<!-- 		        		<td >${fn:substring(dataList.addtime, 0, 19)}</td> -->
<!-- 		        		<td >${fn:substring(dataList.starttime, 0, 19)}</td> -->
<!-- 		        		<td >${fn:substring(dataList.endtime, 0, 19)}</td> -->
<!-- 		        		<td >${dataList.totalmoney}</td> -->
<!-- 		        		<td ><spring:message code="userproduct.source.${dataList.source }"/></td> -->
<!-- 		        		<td ><spring:message code="userproduct.state.${dataList.state }"/></td> -->
<!-- 		        		<td > -->
<!-- 		        			<c:if test="${dataList.state eq '1' }"> -->
<!-- 		        				<a class="btn-del" href="javascript:unitCancelBusiness(${dataList.id });" ><spring:message code="page.cancel"/></a> -->
<!-- 		        			</c:if> -->
<!-- 		        		</td> -->
<!-- 		        	</tr> -->
<!-- 	        	</c:forEach> -->
<!-- 	        </table> -->
      <div class="fb-bom">
      <!-- 
        <cite>
        	<input type="button" class="btn-save" value="<spring:message code="page.refresh"/>" onclick="authorizeRefresh();" id="btnfinish">
        </cite>
       -->
        <span class="red">${user.returninfo }</span>
      </div>
    </div>
	</div>
	<div id="userterminallist" style="width:auto;height:200px"></div>
	<div id="terminaltools">
		  <div style="margin-bottom:5px">
				<spring:message code="user.terminalid"/>：<input type="text"  class="inp w200" name="terminalid" id="terminalid"  onkeydown="if(event.keyCode==13){queryUserterminallist();}" >
				<span style="display: none">
					<input type="text"  class="inp w200" >
				</span>
		  </div>
	  </div>
	<div id="userproductlist" style="width:auto"></div>
	<div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		<a href="javascript:unitCancelBusiness();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.cancel"/></a>
               </c:when>
            </c:choose>
        </cite>
        <span class="red">${user.returninfo }</span>
      </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
  
	$(function () {
	      loadUserInfo();
	      loadUserproductInfo();
	      initUserterminallist();
	      initUserproductlist();
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
  
	 function loadUserproductInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'userproductInfo'
	   };
	   var url = 'user/getUserproductInfo .' + data.tag;
	   $('#userproductInfo').load(url, data, function () {
	   });
	 }
	
	var unitCancelBusinessDialog;
	function unitCancelBusiness() {
		var rows = $("#userproductlist").datagrid("getChecked");
		var ids = "";
		for(var i = 0;i < rows.length;i++){
			ids = ids + rows[i].id + ",";
		}
	    //查询当前订户该产品的授权结束时间
        var data = {
				     productids: ids
				   };
		var url="userproduct/checkedUserproductCancel?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag == "0"){
		   		$.dialog.tips('<spring:message code="userproduct.authorization.started"/>', 1, 'alert.gif');
		   		return false;
			}else{
				unitCancelBusinessDialog = $.dialog({
				    title: '<spring:message code="userbusiness.feecount"/>',
				    lock: true,
				    width: 800,
				    height: 400,
				    top: 0,
				    drag: false,
				    resize: false,
				    max: false,
				    min: false,
				    content: 'url:user/unitCancelBusiness?businesstype='+$('#businesstype').val()+'&productids='+ids
				});
			}
		});
			
	   
	 }
	
	function closeCancelBusinessDialog(){
		unitCancelBusinessDialog.close();
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
	}
	
	//选择智能卡列表
	function queryUserterminallist(){
		var terminalid = $('#terminalid').val();
		//刷新
		$('#userterminallist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			queryterminalid:terminalid
		});
		$('#userproductlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			queryterminalid:terminalid
		});		
	}
	
	function initUserterminallist(){
	    $('#userterminallist').datagrid({
	         title: '<spring:message code="user.terminalinfo" />',
	         url:'user/userterminalJson',
	         queryParams: userterminalparamsJson(),
	         pageSize:10,
             singleSelect: true,
             pageList: [10,25,50], 
	         scrollbar:true,
	         pagination: false,
	         fitColumns:true,
	         rownumbers:true,
	         onClickRow: onClickRow,
	         toolbar:'#terminaltools',
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         toolbar:'#terminaltools',
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
	             { field: 'state', title: '<spring:message code="user.terminalstate"/>',align:"center",width:100,
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
	             	formatter:function(val, row, index){ 
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
	        	 //默认选择第一条
	        	 $('#usercardlist').datagrid("selectRow", '');
	        	 //加载第一条智能卡的产品信息
	        	 initUserproductlist();
	         },
	     });
	     var p = $('#userterminallist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
 
    //将表单数据转为json
	function userterminalparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
	
	//点击表格某一条
	function onClickRow(index, data){
		var terminalid = data.terminalid;
		$('#userproductlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			queryterminalid:terminalid,
		});	
	}
	
	function initUserproductlist(){
	    $('#userproductlist').datagrid({
	         title: '<spring:message code="user.productinfo" />',
	         url:'user/userproductInfo',
	         queryParams: userproductparamsJson(),
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
	         	 { field: 'id', title: '全选',checkbox:true,align:"center",width:40,
				 },
	             { field: 'terminalid', title: '<spring:message code="user.terminalid"/>',align:"center",width:150},
	             { field: 'terminaltype', title: '<spring:message code="user.terminaltype" />',align:"center",width:90,
	            	 formatter:function(val, row, index){ 
	            		 if(val==0){
		         				return	'<spring:message code="user.terminaltype.0"/>';
		         			}else if(val ==1){
		         				return	'<spring:message code="user.terminaltype.1"/>';
		         			}
           	         },
	             },
	        	 { field: 'productid', title: '<spring:message code="product.productid" />',align:"center",width:80,},
	        	 { field: 'productname', title: '<spring:message code="product.productname" />',align:"center",width:100,},
	        	 { field: 'type', title: '<spring:message code="userproduct.type" />',align:"center",width:100,
	        	 	formatter:function(value){
	        	 		if (value == 1) {
							return	'<spring:message code="userproduct.type.1"/>';
						}else if(value == 2){
							return	'<spring:message code="userproduct.type.2"/>';
						}else {
							return	'<spring:message code="userproduct.type.3"/>';
						}
	        	 	}
	        	 },
	        	 { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:155,
	        		 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
        	         },
	        	 },
	        	 { field: 'starttime', title: '<spring:message code="userproduct.starttime" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,10);
        	         },
	        	 },
	        	 { field: 'endtime', title: '<spring:message code="userproduct.endtime" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,10);
        	         },
	        	 },
	        	 { field: 'totalmoney', title: '<spring:message code="userproduct.totalmoney" />',align:"center",width:80,},
	        	 { field: 'source', title: '<spring:message code="userproduct.source" />',align:"center",width:90,
	            	 formatter:function(val, row, index){ 
	            		 if(val==0){
		         				return	'<spring:message code="userproduct.source.0"/>';
		         			}else if(val ==1){
		         				return	'<spring:message code="userproduct.source.1"/>';
		         			}
           	         },
	             },
	             { field: 'state', title: '<spring:message code="userproduct.state" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            		 if(val==0){
		         				return	'<spring:message code="userproduct.state.0"/>';
	         			 }else if(val ==1){
	         				return	'<spring:message code="userproduct.state.1"/>';
	         			 }else if(val ==4){
	         				return	'<spring:message code="userproduct.state.4"/>';
	         			 }
           	         },
	             },
	             /* { field: 'id', title: '<spring:message code="page.operate" />',width:80,align:"center",
					   formatter: function(val, row, index){
						   if(row.state=='1'){
		                    	return '<a class="btn-del" href="javascript:unitCancelBusiness('+row.id+');" ><spring:message code="page.cancel"/></a>';
		                    }
		          		},
		          } */
	         ]],
	     });
	     var p = $('#userproductlist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	//将表单数据转为json
	function userproductparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
</script>
</body>
</html>
