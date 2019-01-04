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
</head>

<body>
<div id="body">
	<form action="" method="post" id="searchForm" name="searchForm">
		<input type="hidden" readonly="readonly" id="querynetid" name="querynetid" value="${statreport.querynetid}">
		<input type="hidden" readonly="readonly" id="queryareacode" name="queryareacode" value="${statreport.queryareacode}">
	   	<input type="hidden" readonly="readonly" id="querystarttime" name="querystarttime" value="${statreport.querystarttime}">
	   	<input type="hidden" readonly="readonly" id="queryendtime" name="queryendtime" value="${statreport.queryendtime}">
	   	<input type="hidden" readonly="readonly" id="queryproductid" name="queryproductid" value="${statreport.queryproductid}">
	</form>
	<div class="lst-box">
		<div id="userOfflineDetailStat" style="width:855px"></div>
	</div> 
	
	<div align="center" style="margin-top: 10px">
		<a href="javascript:saveDownloadEventFile();" style="width:120px" class="easyui-linkbutton"><spring:message code="statistic.exportexcel"/></a>
	</div>	    
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function initUserOfflineDetailStat(){
	    $('#userOfflineDetailStat').datagrid({
	         title: '<spring:message code="statreport.userOfflineStatdetail" />',
	         url:'statreport/userOfflineStatDialogJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         pageSize: 10,
	         pageList: [10,25,50], 
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	         	 { field: 'terminalid', title: '<spring:message code="user.terminalid" />',align:"center",width:100},
	         	 { field: 'usercode', title: '<spring:message code="user.usercode" />',align:"center",width:100},
	         	 { field: 'username', title: '<spring:message code="user.username" />',align:"center",width:100},
	         	 { field: 'areacode', title: '<spring:message code="area.areacode" />',align:"center",width:100},
	         	 { field: 'telephone', title: '<spring:message code="user.telephone" />',align:"center",width:100},
	         	 { field: 'address', title: '<spring:message code="user.address" />',align:"center",width:100,
	         	 	formatter: function (value) {
		                    return "<span title='" + value + "'>" + value + "</span>";
		                }
	         	 },
	         ]]
	     });
	     var p = $('#userOfflineDetailStat').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//将表单数据转为json
	function paramsJson(){
		var json = {
				querynetid:$("#querynetid").val(),
				queryareacode:$("#queryareacode").val(),
				querystarttime:$("#querystarttime").val(),
				queryendtime:$("#queryendtime").val(),
				queryproductid:$("#queryproductid").val(),
		};
		
		return json;
	}
    
    function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					
					var data = {
 			    			querynetid:$("#querynetid").val(),
							queryareacode:$("#queryareacode").val(),
							querystarttime:$("#querystarttime").val(),
							queryendtime:$("#queryendtime").val(),
							queryproductid:$("#queryproductid").val(),
						   };
					var url="statreport/exportUserOfflineDetailStatExcelFlag?rid="+Math.random();
					$.getJSON(url,data,function(jsonMsg){
						if(jsonMsg.flag=="0"){
							$.dialog.tips(jsonMsg.error, 1, 'alert.gif');
						}else if(jsonMsg.flag=="1"){
							$("#searchForm").attr("action", "statreport/exportUserOfflineDetailStatExcel");
							$("#searchForm").submit();
						}
					});
 				}, function(){
 							});
	}
	
	$(function () {
	   initUserOfflineDetailStat();
	   
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
  
	    
  
</script>
</body>
</html>

