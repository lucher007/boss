<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<style>
	html { overflow-x:hidden; }
    .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 30px;
    }
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
   
  </style>
</head>

<body style="padding:0px; width:100%; ">
	<div class="form-box">
<!-- 	    <div class="fb-con"> -->
<!-- 	      	<table> -->
<!-- 	      	  <tr class="fbc-tit"> -->
<!-- 	            <td colspan="10" style="font-weight: bold;"><spring:message code="menu.business.businessquery"/></td> -->
<!-- 	          </tr> -->
<!-- 	          <tr class="lb-tit"> -->
<!-- 	                <td><spring:message code="business.type"/></td> -->
<!-- 	          		<td><spring:message code="user.terminalid"/></td> -->
<!-- 	          		<td><spring:message code="user.terminaltype"/></td> -->
<!-- 	          		<td><spring:message code="userbusinessdetail.content"/></td> -->
<!-- 	          		<td><spring:message code="userbusinessdetail.totalmoney"/></td> -->
<!-- 	          		<td><spring:message code="userbusinessdetail.addtime"/></td> -->
<!-- 	          		<td><spring:message code="userbusiness.source"/></td> -->
<!-- 	          		<td><spring:message code="operator.operatorcode"/></td> -->
<!-- 	         </tr> -->
<!-- 	         <c:forEach items="${userbusinessdetail.userbusinessdetaillist }" var="dataList"> -->
<!-- 		        	<tr height="30"class="lb-list"> -->
<!--     					<td > -->
<!--     						<c:if test="${dataList.businesstypekey != null && dataList.businesstypekey ne '' }"> -->
<!--     							<spring:message code="business.type.${dataList.businesstypekey }"/></td> -->
<!-- 		        			</c:if> -->
<!-- 		        		<td >${dataList.terminalid }</td> -->
<!-- 		        		<td > -->
<!-- 		        			<c:if test="${dataList.terminaltype != null && dataList.terminaltype ne '' }"> -->
<!-- 		        				<spring:message code="user.terminaltype.${dataList.terminaltype }"/> -->
<!-- 		        			</c:if> -->
<!-- 		        		</td> -->
<!-- 		        		<td class="remarkClass" title="${dataList.content }">${fn:substring(dataList.content, 0, 20)}&nbsp;</td> -->
<!-- 		        		<td >${dataList.totalmoney }</td> -->
<!-- 		        		<td >${fn:substring(dataList.addtime, 0, 19)}</td> -->
<!-- 		        		<td ><spring:message code="userbusiness.source.${dataList.source }"/></td> -->
<!-- 		        		<td >${dataList.operator.operatorcode }</td> -->
<!-- 		        	</tr> -->
<!-- 	        	</c:forEach> -->
<!-- 	        </table> -->
<!-- 		</div> -->
		<div id="userBusinessDetailList" style="width: auto;"></div>
  </div>
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
	    $('#userBusinessDetailList').datagrid({
	         title: '<spring:message code="menu.business.businessquery" />',
	         url:'user/userBusinessDetailList?userid=${userbusinessdetail.userid }',
	         pageSize:10,
             singleSelect: true,
             pageList: [10,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         //onClickRow: onClickRow,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'type', title: '<spring:message code="business.type"/>',align:"center",width:100,
	             	formatter:function(val, row, index){
		             	if (val == 'adduser') {
		             		return	'<spring:message code="business.type.adduser"/>';
						}else if(val == 'buycard'){
		             		return	'<spring:message code="business.type.buycard"/>';
						}else if(val == 'buystb'){
		             		return	'<spring:message code="business.type.buystb"/>';
						}else if(val == 'pausecard'){
		             		return	'<spring:message code="business.type.pausecard"/>';
						}else if(val == 'transferaddress'){
		             		return	'<spring:message code="business.type.transferaddress"/>';
						}else if(val == 'opencard'){
		             		return	'<spring:message code="business.type.opencard"/>';
						}else if(val == 'rebackstb'){
		             		return	'<spring:message code="business.type.rebackstb"/>';
						}else if(val == 'rebackcard'){
		             		return	'<spring:message code="business.type.rebackcard"/>';
						}else if(val == 'fillcard'){
		             		return	'<spring:message code="business.type.fillcard"/>';
						}else if(val == 'rechargeaccount'){
		             		return	'<spring:message code="business.type.rechargeaccount"/>';
						}else if(val == 'rechargewallet'){
		             		return	'<spring:message code="business.type.rechargewallet"/>';
						}else if(val == 'buyproduct'){
		             		return	'<spring:message code="business.type.buyproduct"/>';
						}else if(val == 'transferuser'){
		             		return	'<spring:message code="business.type.transferuser"/>';
						}else if(val == 'canceluser'){
		             		return	'<spring:message code="business.type.canceluser"/>';
						}else if(val == 'replacestb'){
		             		return	'<spring:message code="business.type.replacestb"/>';
						}else if(val == 'replacecard'){
		             		return	'<spring:message code="business.type.replacecard"/>';
						}else if(val == 'cancelproduct'){
		             		return	'<spring:message code="business.type.cancelproduct"/>';
						}else if(val == 'updateuser'){
		             		return	'<spring:message code="business.type.updateuser"/>';
						}else if(val == 'updatefee'){
		             		return	'<spring:message code="business.type.updatefee"/>';
						}else if(val == 'authorizerefresh'){
		             		return	'<spring:message code="business.type.authorizerefresh"/>';
						}else if(val == 'rebackdevice'){
		             		return	'<spring:message code="business.type.rebackdevice"/>';
						}
	             	}
	             },
	             { field: 'terminalid', title: '<spring:message code="user.terminalid"/>',align:"center",width:100},
	             { field: 'terminaltype', title: '<spring:message code="user.terminaltype"/>',align:"center",width:100,
	             	formatter:function(val, row, index){
	             		if (val == 0) {
		             		return	'<spring:message code="user.terminaltype.0"/>';
						}else{
							return	'<spring:message code="user.terminaltype.1"/>';
						}
	             	},
	             },
	             { field: 'content', title: '<spring:message code="userbusinessdetail.content"/>',align:"center",width:100,
	             	formatter: function (value) {
         	 			if(value == "" || value == null){
         	 				return value;
         	 			}else{
         	 				return "<span title='" + value + "'>" + value + "</span>";
         	 			}
	                }
	             },
	             { field: 'totalmoney', title: '<spring:message code="userbusinessdetail.totalmoney"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="userbusinessdetail.addtime"/>',align:"center",width:110,
	             	formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },	
	             },
	             { field: 'source', title: '<spring:message code="userbusiness.source"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="userbusiness.source.0"/>';
	         			}else {
	         				return	'<spring:message code="userbusiness.source.1"/>';
	         			}
           	        },
	             },
	             { field: 'operatorcode', title: '<spring:message code="operator.operatorcode"/>',align:"center",width:100}
	             
	         ]],
	         onLoadSuccess:function(data){  
	        	 //默认选择第一条
	        	 $('#userBusinessDetailList').datagrid("selectRow", 0);
	         },
	     });
	     var p = $('#userBusinessDetailList').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	})
</script>
</body>
</html>

