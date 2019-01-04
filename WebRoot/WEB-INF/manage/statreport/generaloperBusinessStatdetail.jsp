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
	<% String start =  (String)request.getAttribute("querystarttime");
		  String end =  (String)request.getAttribute("queryendtime");
	%>
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
					
					<td align="right"><spring:message code="service.servicetype"/>：</td>
					<td align="left">
						 <input id="businesstype" name="businesstype">
					</td>
				</tr>
				<tr>
					<td align="right" width="120px"><spring:message code="operator.operatortype.1" />：</td>
					<td align="left">
						<input class="inp w200"  value="${Operator.operatorname}" readonly="readonly">
						 <input type="hidden" name="operatorid" id="operatorid" value="${Operator.id}">
					</td>
					<td align="right" width="120px"><spring:message code="operator.operatorcode" />：</td>
					<td align="left">
						 <input class="inp w200" name="operatorcode" id="operatorcode" value="${Operator.operatorcode}" readonly="readonly"/>
					</td>
				</tr>
					
				<tr height="40px">
		    		<td colspan="6" align="center">
		    			<a href="javascript:queryBusinessdetail();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>                                                                                                                                                                                  
						<%-- <a href="javascript:saveDownloadEventFile();" style="width:120px" class="easyui-linkbutton"><spring:message code="statistic.exportexcel"/></a> --%>
		    		</td>
				</tr>
			
    	    </table>
   		</form>
    </div>
    
   <div class="lst-box">
	 <div id="operatorBusinessdetail" style="width:auto"></div>
   </div> 	    
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	function initOperatorBusinessdetail(){
	    $('#operatorBusinessdetail').datagrid({
	         title: '<spring:message code="statreport.operatorreport" />',
	         url:'statreport/businessStatdetailJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination:true,
	         fitColumns:true,
	         pageSize: 10,
	         pageList: [10,25,50], 
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	         	 { field: 'userid', title: '<spring:message code="user.usercode" />',align:"center",width:100},
	         	 { field: 'username', title: '<spring:message code="user.username" />',align:"center",width:100},
	         	 { field: 'content', title: '<spring:message code="problemcomplaint.content" />',align:"center",width:100},
	         	 { field: 'price', title: '<spring:message code="statreport.business.price" />',align:"center",width:100},
	         	 { field: 'addtime', title: '<spring:message code="statreport.business.addtime" />',align:"center",width:100},
	         	 { field: 'operatorname', title: '<spring:message code="operator.operatorname" />',align:"center",width:100},
	         	 { field: 'areacode', title: '<spring:message code="area.areacode" />',align:"center",width:100},
	         ]]
	     });
	     var p = $('#operatorBusinessdetail').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//将表单数据转为json
	function paramsJson(){
   		//获取业务类型
   		/* $("input:checkbox").each(function() { 
    		if ($(this).attr('checked')) { 
    			$(this).attr("value",$(this).attr("id"));
    		}else{
    			$(this).attr("value","");
    		} 
		});  */
   		
		
		var json = {
				querystarttime:$("#querystarttime").val(),
				queryendtime:$("#queryendtime").val(),
				businesstype:$("#businesstype").combobox("getValue"),
				operatorid:$("#operatorid").val()
		};
		
		return json;
	}
    
	function saveDownloadEventFile(){
		$("#searchForm").attr("action", "statistic/findExportOperatorReportExcel");
		$("#searchForm").submit();
	}
    
    /* function queryDateType(){
	  	$("#queryyear").hide();
		$("#querymonth").hide();
		$("#queryday").hide();  
		if($("#querydatetype").val() =="1"){
			$("#queryyear").show(); 
		}else if ($("#querydatetype").val() == "2"){
			$("#querymonth").show(); 
		}else if ($("#querydatetype").val() == "3"){
			$("#queryday").show(); 
		}
	} */
    
    
	
	function queryBusinessdetail(){
		$('#operatorBusinessdetail').datagrid('reload',paramsJson());
	}
	
	
	$(function () {
       //queryDateType();
       
       //初始化参数
	   initNetwork();
       initStore();
       initOperator();
       initBusinesstype();
       
       //初始化操作员业务统计列表
	   initOperatorBusinessdetail();
	          
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    //初始化网络
	function initNetwork(){
	   $('#netid').combobox({    
			url:'statreport/initNetworkJson?rid=',
		    valueField:'id',    
		    //limitToList:true,
		    textField:'netname',
	        onSelect: function(rec){    
               initStore(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(node, data){
			    	//初始化营业厅列表框的默认选择值
			    	
			    }
		});  
	   
    }
    
    //初始化营业厅
    function initStore(netid) {
    	$('#storeid').combobox({    
			url:'statreport/getStoreJson?querynetid='+netid,
		    valueField:'id',    
		    //limitToList:true,
		    textField:'storename',
	        onSelect: function(rec){    
               initOperator(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(node, data){
			    	//初始化营业厅列表框的默认选择值
			    	
			    }
		}); 
    }
    
    //初始化操作员
    function initOperator(storeid) {
    	$('#operatorid').combobox({    
			url:'statreport/getOperatorJson?querystoreid='+storeid,
		    valueField:'id',    
		    //limitToList:true,
		    textField:'operatorname',
	        onSelect: function(rec){    
               //initArea(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(node, data){
			    	//初始化营业厅列表框的默认选择值
			    	
			    }
		}); 
    }
    
    //初始化业务类型
    function initBusinesstype() {
    	$('#businesstype').combobox({    
			url:'statreport/getBusinesstypeJson',
		    valueField:'id',    
		    //limitToList:true,
		    textField:'typename',
	        onSelect: function(rec){    
               //initArea(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(node, data){
			    	//初始化营业厅列表框的默认选择值
			    	
			    }
		}); 
    }
    
    
    
    

  
</script>
</body>
</html>

