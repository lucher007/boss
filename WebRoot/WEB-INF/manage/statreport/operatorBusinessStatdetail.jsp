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
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.operatorreportlist" /></div>
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
					<td align="right"><spring:message code="service.servicetype" />：</td>
					<td align="left" colspan="2">
						<input
						data-options="url:'statreport/getBusinesstypeJson',
										method:'get',
											valueField:'id',
											textField:'typename',
											multiple:true,
											editable:false,
											onChange:function(){
											$('#value').val('');
											},
											panelHeight:'auto',"
						class="easyui-combobox" name="businesstypes" id="businesstypes" value="" style="width:157px;"
						/>
					</td>
				</tr>
				<tr height="30px">
					<td align="right"><spring:message code="network.netname"/>：</td>
					<td align="left">
						 <input id="netid" name="netid" style="width: 157px;">
					</td>
					<td align="right"><spring:message code="store.storename" />：</td>
		    		<td>
		    			<input id="storeid" name="storeid" style="width: 157px;">
					</td>
					<td align="right" width="120px"><spring:message code="operator.operatorname" />：</td>
					<td align="left">
						 <input name="operatorid" id="operatorid" style="width: 157px;">
					</td>
				</tr>
				<tr height="30px">
					<%-- <td align="right"><spring:message code="userbusiness.source"/>：</td>
					<td>
					    <select id="source" name="source" class="select" >
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0"><spring:message code="userbusiness.source.0"/></option>
			                   <option value="1"><spring:message code="userbusiness.source.1"/></option>
			             </select>
					</td> --%>
					<td colspan="6" align="center">
		    			<a href="javascript:queryBusinessdetail();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>                                                                                                                                                                                  
						<a href="javascript:saveDownloadEventFile();" style="width:120px" class="easyui-linkbutton"><spring:message code="statistic.exportexcel"/></a>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <%-- <div style="height: 30px;margin-top: 1px" class="easyui-panel">
    	<table width="100%">
    		<td align="right"><spring:message code="statreport.operatorreport.paymentpen"/>：</td>
			<td>
           		<input readonly="readonly" type="text"  class="inp w200" name="addcount" id="addcount">
			</td>
			<td align="right"><spring:message code="statistic.totalprice"/>：</td>
			<td>
           		<input readonly="readonly" type="text"  class="inp w200" name="totalprice" id="totalprice">
			</td>
    	</table>
    </div> --%>
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
	
	var flag = true;
	
	function initOperatorBusinessdetail(){
	    $('#operatorBusinessdetail').datagrid({
	         title: '<spring:message code="menu.stat.operatorreportlist" />',
	         url:'statreport/businessStatdetailJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         showFooter: true,
	         pageSize: 10,
	         pageList: [10,25,50], 
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	         	 { field: 'usercode', title: '<spring:message code="user.usercode" />',align:"center",width:100},
	         	 { field: 'username', title: '<spring:message code="user.username" />',align:"center",width:100},
	         	 { field: 'businesstypename', title: '<spring:message code="service.servicetype" />',align:"center",width:100},
	         	 { field: 'content', title: '<spring:message code="problemcomplaint.content" />',align:"center",width:100,
	         	 	formatter: function (value) {
	         	 			if(value == "" || value == null){
	         	 				return value;
	         	 			}else{
	         	 				return "<span title='" + value + "'>" + value + "</span>";
	         	 			}
		                }
	         	 },
	         	 { field: 'price', title: '<spring:message code="statreport.business.price" />',align:"center",width:100},
	         	 { field: 'addtime', title: '<spring:message code="statreport.business.addtime" />',align:"center",width:100,
	         	 	formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
	         	        	},
	         	 },
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
		var json = {
				businesstype:$("#businesstypes").combobox("getValues").toString(),
				querystarttime:$("#querystarttime").val(),
				queryendtime:$("#queryendtime").val(),
				netid:$("#netid").combobox("getValue"),
				storeid:$("#storeid").combobox("getValue"),
				operatorid:$("#operatorid").combobox("getValue"),
				//source:$("#source").val()
		};
		
		return json;
	}
    
	function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					var data = {
 			    			businesstype:$("#businesstypes").combobox("getValues").toString(),
							querystarttime:$("#querystarttime").val(),
							queryendtime:$("#queryendtime").val(),
							netid:$("#netid").combobox("getValue"),
							storeid:$("#storeid").combobox("getValue"),
							operatorid:$("#operatorid").combobox("getValue"),
							source:$("#source").val()
						   };
							var url="statreport/exportBusinessdetailExcelFlag?rid="+Math.random();
							$.getJSON(url,data,function(jsonMsg){
								if(jsonMsg.flag=="0"){
									$.dialog.tips(jsonMsg.error, 1, 'alert.gif');
								}else if(jsonMsg.flag=="1"){
									$("#searchForm").attr("action", "statreport/exportBusinessdetailExcel"+"?rid="+Math.random());
			    					$("#searchForm").submit();
								}
							});
 				}, function(){
 							});
	}
    
	function queryBusinessdetail(){
		$('#operatorBusinessdetail').datagrid('reload',paramsJson());
	}
	
	$(function () {
       //初始化参数
	   initNetwork();
       //initStore();
       //initOperator();
       
       //初始化操作员业务统计列表
	   //initOperatorBusinessdetail();
	          
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    //初始化网络
	function initNetwork(){
	   $('#netid').combobox({    
			url:'statreport/initNetworkJson',
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'netname',
	        onSelect: function(rec){ 
	           	initStore(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(data){
			    	//初始化营业厅列表框的默认选择值
			    	if('${Statreport.netid}' != '' && '${Statreport.netid}' != null){
					  	  $(this).combobox('select',parseInt('${Statreport.netid}'));
					}else{//默认选择第一个
						var val = $('#netid').combobox("getData");
	                    for (var item in val[0]) {  
	                        if (item == "id") {  
	                            $(this).combobox("select", val[0][item]);  
	                        }  
	                     }  	
					} 
					initStore($("#netid").combobox("getValue"));
			    }
		});  
    }
    
    //初始化营业厅
    function initStore(netid) {
	   $('#storeid').combobox({    
			url:'statreport/getStoreJson?querystate=1&querynetid='+netid,
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'storename',
		    async:false,
		    onSelect: function(rec){  
		           var netid = $("#netid").combobox("getValue");
	               initOperator(netid,rec.id);//默认加载区域
	         },
		    
		    onLoadSuccess:function(node, data){
		    	 //初始化营业厅列表框的默认选择值
		    	if('${Operator.storeid}' != '' && '${Operator.storeid}' != null){
					if('${Operator.netid}' == netid){//防止选择的网络不包括默认的营业厅ID，直接把ID显示在输入库里
				  	  $('#storeid').combobox('select','${Operator.storeid}');
				  	}
				}else{//默认选择第一个
					var val = $(this).combobox("getData");  
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $('#storeid').combobox("select", val[0][item]);  
                        }  
                     }  	
				} 
				
				initOperator($("#netid").combobox("getValue"),$("#storeid").combobox("getValue"));
			  }
		});  
	}
    
   //初始化操作员
    function initOperator(netid,storeid) {
        
    	$('#operatorid').combobox({    
			url:'statreport/getOperatorJson?querynetid='+netid+'&querystoreid='+storeid,
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'operatorname',
		    async:false,
	        onSelect: function(rec){    
               //initArea(rec.id);//默认加载区域
        	},
		    onLoadSuccess:function(node, data){
			    	 //初始化营业厅列表框的默认选择值
			    	if('${Operator.operatortype}' != '0' && '${Operator.operatortype}' != '3'){
					  	  $('#operatorid').combobox('select','${Operator.id}');
					}else{//默认选择第一个
						var val = $(this).combobox("getData");  
	                    for (var item in val[0]) {  
	                        if (item == "id") {  
	                            $('#operatorid').combobox("select", val[0][item]);  
	                        }  
	                     }  	
					} 
                    //initArea('${operator.netid}'); //默认加载区域
	    			//initStore('${operator.netid}');//默认加载营业厅 
	    			 if(flag){
				      		initOperatorBusinessdetail();
				      		flag = false;
				     }
			    }
		}); 
    }
    
    
    
    

  
</script>
</body>
</html>

