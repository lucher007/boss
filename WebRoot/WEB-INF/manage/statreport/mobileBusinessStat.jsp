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
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.mobileBusinessStat" /></div>
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
					<td align="right"><spring:message code="network.netname"/>：</td>
					<td align="left">
						 <input id="querynetid" name="querynetid" style="width: 157px;">
					</td>
					
					<td align="right"><spring:message code="area.areacode" />：</td>
		    		<td>
		    			<input id="queryareacode" name="queryareacode" style="width: 157px;">
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
	 <div id="mobileBusinesslist" style="width:auto"></div>
   </div> 	    
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	var flag = true;
	
	function initMobileBusinesslist(){
	    $('#mobileBusinesslist').datagrid({
	         title: '<spring:message code="menu.stat.mobileBusinessStat" />',
	         url:'statreport/mobileBusinessStatJson',
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
	     var p = $('#mobileBusinesslist').datagrid('getPager');
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
				querynetid:$("#querynetid").combobox("getValue"),
				queryareacode:$("#queryareacode").combobox("getValue"),
		};
		
		return json;
	}
    
	function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					$("#searchForm").attr("action", "statreport/exportMobileBusinessExcel");
					$("#searchForm").submit();
 				}, function(){
 							});
	}
    
    function initPage(){
	  	if($("#operatortype").val() == "1"){//普通操作员
	  		$("#netid").attr("readonly","readonly");
	  		//$("#storeid").attr("readonly","readonly");
	  		$("#operatorid").attr("readonly","readonly");
	  	}
	}
	
	function queryBusinesslist(){
		$('#mobileBusinesslist').datagrid('reload',paramsJson());
	}
	
	$(function () {
       //初始化参数
	   initNetwork();
       
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
		   $('#querynetid').combobox({    
				url:'user/initNetworkJson?rid='+Math.random(),
			    valueField:'id',    
			    //limitToList:true,
			    editable:false,
			    textField:'netname',
		        onSelect: function(rec){    
	               initArea(rec.id);//默认加载区域
	        	},
			    onLoadSuccess:function(node, data){
				    	//初始化营业厅列表框的默认选择值
				    	
				    	if('${Operator.netid}' != '' && '${Operator.netid}' != null){
						  	  $(this).combobox('select',parseInt('${Operator.netid}'));
						}else{//默认选择第一个
							var val = $('#querynetid').combobox("getData");  
		                    for (var item in val[0]) {  
		                        if (item == "id") {  
		                            $(this).combobox("select", val[0][item]);  
		                        }  
		                     }  	
						} 
	                    initArea($("#querynetid").combobox("getValue")); //默认加载区域
		    			//initStore('${operator.netid}');//默认加载营业厅 
				    }
			});  
		   
	    }

	    function initArea(netid) {
		  $('#queryareacode').combotree({   
			    url:'user/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
			    //数据执行之后才加载
			    onLoadSuccess:function(node, data){
			    	if('${Operator.areacode}' != '' && '${Operator.areacode}' != null){
					  	  var node = $('#queryareacode').combotree('tree').tree('find', '${Operator.areacode}');
					  	  if(node != null){
					  	  	$('#queryareacode').combotree('setValue', node.id);
					  	  }else{
					  	  	$('#queryareacode').combotree('setValue', '');
					  	  }
				     }else{
				     	$('#queryareacode').combotree('setValue', '');
				     }
				     if(flag){
				    	 initMobileBusinesslist();
				     	 flag = false;
				     }
			    },
			    //选择之前运行
			    onBeforeSelect : function(node) {
			         //返回树对象  
			        var tree = $(this).tree;  
			        //选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
			        var isLeaf = tree('isLeaf', node.target);  
			        if (!isLeaf) {  
			            //清除选中  
			           //$("#queryareacode").treegrid("unselect");
			        }  
				    //if (node.children != undefined) {
				    // 	$("#areacode").treegrid("unselect");
				    //}
				},
			    //绑定onchanger事件
			    onChange:function(){  
	                //queryUser();
	            }
		  }); 
	  }
    
    
    
    

  
</script>
</body>
</html>

