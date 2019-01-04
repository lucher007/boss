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
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="statreport.operatorreport" /></div>
    <div class="easyui-panel" title="<spring:message code="page.query"/>">
        <form action="" method="post" id="searchForm" name="searchForm">
       		<table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="statistic.userproduct.querystarttime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="querystarttime" name="querystarttime" value="" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
					<td align="right"><spring:message code="statistic.userproduct.queryendtime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="queryendtime" name="queryendtime" value="" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
				</tr>
				<tr>
					<td align="right" width="120px"><spring:message code="operator.operatortype.1" />：</td>
					<td align="left">
						 <input type="hidden" name="operatorid" id="operatorid" value="${Operator.id}">
						 <input class="inp w200"  value="${Operator.operatorname}" readonly="readonly">
					</td>
					<td align="right" width="120px"><spring:message code="operator.operatorcode" />：</td>
					<td align="left">
						 <input class="inp w200" name="operatorcode" id="operatorcode" value="${Operator.operatorcode}" readonly="readonly"/>
					</td>
					
				</tr>
				
				<tr height="40px">
		    		<td colspan="6" align="center">
		    			<a href="javascript:queryBusinesslist();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>                                                                                                                                                                                  
						<a href="javascript:saveDownloadEventFile();" style="width:120px" class="easyui-linkbutton"><spring:message code="statistic.exportexcel"/></a>
		    		</td>
				</tr>
			
    	    </table>
   		</form>
    </div>
    
   <div class="lst-box">
	 <div id="operatorBusinesslist" style="width:auto"></div>
   </div> 	    
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function initOperatorBusinesslist(){
	    $('#operatorBusinesslist').datagrid({
	         title: '<spring:message code="statreport.operatorreport" />',
	         url:'statreport/operatorBusinessStatJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination: false,
	         fitColumns:true,
	         rownumbers:true,
	         showFooter: true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'businesstypename', title: '<spring:message code="business.type" />',align:"center",width:100},
	             { field: 'count', title: '<spring:message code="statistic.count" />',align:"center",width:100},
	        	 { field: 'totalprice', title: '<spring:message code="statreport.business.price" />',align:"center",width:100},
	         ]]
	     });
	     var p = $('#operatorBusinesslist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//将表单数据转为json
	function paramsJson(){
		var json = {
				querystarttime:$("#querystarttime").val(),
				queryendtime:$("#queryendtime").val(),
				operatorid:$("#operatorid").val()
		};
		
		return json;
	}
    
	function saveDownloadEventFile(){
		$("#searchForm").attr("action", "statistic/findExportOperatorReportExcel");
		$("#searchForm").submit();
	}
	
	
	function queryBusinesslist(){
		$('#operatorBusinesslist').datagrid('reload',paramsJson());
	}
	
	
	$(function () {
       //初始化操作员业务统计列表
	   initOperatorBusinesslist();
	          
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    
    

  
</script>
</body>
</html>

