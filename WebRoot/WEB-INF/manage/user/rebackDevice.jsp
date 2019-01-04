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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.rebackdevice"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.rebackdevice"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
      </div>
      <div id="userCardInfo" style="width: auto;"></div>
      <div class="fb-con">
    	<div class="oldDeviceInfo">
		    	<table>
		          <tr class="fbc-tit">
		            <td colspan="8" style="font-weight: bold;"><spring:message code="userbusiness.rebackdevice.state"/></td>
		          </tr>
		          <tr>
		            <td align="right" colspan="2"><span class="red"><spring:message code="userbusiness.rebackdevice.state"/>：</span></td>
		            <td colspan="6">
		            	<select id="devicestate" name="devicestate" class="select">
		            	 	   <option value="3"><spring:message code="stb.state.3"/></option>
			                   <option value="0"><spring:message code="stb.state.0"/></option>
			            </select>
			            <span class="red">*</span>
		            </td>
		          </tr>
		        </table>
		</div>
      </div>
     
      <div class="fb-bom">
        <cite>
        	<%-- 
        	<input type="button" class="btn-save" value="<spring:message code="business.type.rebackdevice"/>" onclick="unitCancelBusiness();" id="btnfinish">
        	 --%>
        	<a href="javascript:unitCancelBusiness();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${user.returninfo }</span>
      </div>
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
	      loadUserCardInfo();
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
	 	$('#userCardInfo').datagrid({
	         title: '<spring:message code="user.terminalinfo" />',
	         url:'user/userTerminalInfoJson?userid=${user.user.id }',
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
				 { field: 'id', title: '全选',checkbox:true,align:"center",width:40},
	             { field: 'deviceno', title: '<spring:message code="device.deviceno"/>',align:"center",width:100},
	             { field: 'terminaltype', title: '<spring:message code="user.terminaltype" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            		 if(val== "0"){
		         				return	'<spring:message code="user.terminaltype.0"/>';
		         			}else if(val == "1"){
		         				return	'<spring:message code="user.terminaltype.1"/>';
		         			}
           	         },
	             },
	             { field: 'buytime', title: '<spring:message code="user.buytime" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
        	         },
	        	 },
	             { field: 'terminalstate', title: '<spring:message code="user.terminalstate"/>',align:"center",width:100,
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
	         onLoadSuccess:function(data){ 
	         	 //隐藏表头选框
	         	 $("#userCardInfo").parent().find("div .datagrid-header-check").children("input[type=\"checkbox\"]").eq(0).attr("style", "display:none;"); 
	        	 //默认选择第一条
	        	 $('#userInvoiceInfo').datagrid("selectRow", 0);
	        	 //加载第一条智能卡的产品信息
	        	 //initUserproductlist();
	         },
	     });
	     var p = $('#userCardInfo').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
// 	   var data = {
// 	     id: '${user.user.id}',
// 	     tag: 'userRebackTerminalInfo'
// 	   };
// 	   var url = 'user/getUserCardInfo .' + data.tag;
// 	   $('#userCardInfo').load(url, data, function () {
// 	   });
	 }
	
	var unitCancelBusinessDialog;
	function unitCancelBusiness() {
	   
	   //终端号
// 	   var terminalid = $("input[type='radio']:checked").val();
// 	   if(terminalid == null || terminalid == ''){
// 	   		$.dialog.tips('<spring:message code="user.terminalid.empty"/>', 1, 'alert.gif');
// 	   		return false;
// 	   }
	   
	   //终端类型
// 	   var terminaltype=  $("#type_"+terminalid).val();
	    //获取所有选择的产品
	   var rowsSelected = $('#userCardInfo').datagrid('getChecked');
	   if(rowsSelected == null  || rowsSelected == ''){
       	 $.dialog.tips('<spring:message code="user.terminalid.empty"/>', 1, 'alert.gif');
		      return;
       }
       //终端号
       var terminalidarr = [];
		for(var i = 0;i < rowsSelected.length;i++){
			terminalidarr.push(rowsSelected[i].deviceno);
			if (i > 0) {
				if (rowsSelected[i].terminaltype != rowsSelected[i-1].terminaltype) {
					$.dialog.tips('<spring:message code="stopOrStart.selectTerminal"/>', 1, 'alert.gif');
					return false;
				}
			}
		}
	    var terminalids = terminalidarr.join(',');
	    var terminaltype = rowsSelected[0].terminaltype;
// 	   var row = $('#userCardInfo').datagrid("getSelected");
// 	   if (row == null || row == "") {
// 			$.dialog.tips('<spring:message code="user.terminalid.empty"/>', 1, 'alert.gif');
// 			return false;
// 	   }
// 	   var terminalid = row.deviceno;
	   //判断如果回收的终端有副机，先请回收副机
	   var data = {
			   terminalids: terminalids,
			   terminaltype: terminaltype
	   };
		var url="user/validRebakDevice?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 2, 'alert.gif');
			    return false;
			}else if(jsonMsg.flag=="1"){
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
				    cancel:false,
				    content: 'url:user/unitCancelBusiness?businesstype='+$('#businesstype').val()+'&terminalids='+terminalids+'&terminaltype='+terminaltype+'&devicestate='+$('#devicestate').val()
				});
			}
		});
	 }
	
	function closeCancelBusinessDialog(){
		unitCancelBusinessDialog.close();
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
	}
	
</script>
</body>
</html>
