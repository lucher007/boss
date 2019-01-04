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
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.userproductaudiencestat" /></div>
    <div class="easyui-panel" title="<spring:message code="page.query"/>">
        <form action="" method="post" id="searchForm" name="searchForm">
       		<table width="100%">
				<tr>
					<td align="right"><spring:message code="network.netname"/>：</td>
					<td align="left">
						 <input id="querynetid" name="querynetid" style="width: 157px;">
					</td>
					<td align="right"><spring:message code="area.areacode"/>：</td>
					<td align="left">
						<input id="queryareacode" name="queryareacode" style="width: 157px;">
					</td>
				</tr>
				
				<tr height="30px">
					<td align="right"><spring:message code="statistic.userproduct.querystarttime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="querystarttime" name="querystarttime" value="<%=start%>" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
					<td align="right"><spring:message code="statistic.userproduct.queryendtime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="queryendtime" name="queryendtime" value="<%=end%>" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
				</tr>
			
				<tr height="30px">
					<td colspan="6" align="center">
		    			<a href="javascript:queryUserproductAudienceStat();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>                                                                                                                                                                                  
		    			<a href="javascript:saveDownloadEventFile();" style="width:120px" class="easyui-linkbutton"><spring:message code="statistic.exportexcel"/></a>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    
   <div class="lst-box">
	 <div id="userproductAudienceStat" style="width:auto"></div>
   </div>
   <%-- <div style="margin:10px 0;" align="right">
		<a href="javascript:getSelected();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>
	</div> 	 --%>    
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	var flag = true;
	
	function initUserproductAudienceStat(){
	    $('#userproductAudienceStat').datagrid({
	         title: '<spring:message code="menu.stat.userproductaudiencestat" />',
	         url:'statreport/userProductAudienceStatJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination: false,
	         fitColumns:true,
	         pageSize: 10,
	         pageList: [10,25,50], 
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	         	 { field: 'netid', title: '<spring:message code="network.netid" />',align:"center",width:100 , hidden:"true"},
	         	 { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100},
	         	 { field: 'productid', title: '<spring:message code="statreport.userproductid" />',align:"center",width:100},
	         	 { field: 'productname', title: '<spring:message code="statreport.userproductname" />',align:"center",width:100},
	         	 { field: 'count', title: '<spring:message code="statreport.terminal.count" />',align:"center",width:100},
	         	 { field: 'usercount', title: '<spring:message code="statreport.user.count" />',align:"center",width:100},
	         	 { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:100,formatter:formatUserOperation }
	         ]]
	     });
	     var p = $('#userproductAudienceStat').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//将表单数据转为json
	function paramsJson(){
		var json = {
				querynetid:$("#querynetid").combobox("getValue"),
				queryareacode:$("#queryareacode").combotree("getValue"),
				querystarttime:$("#querystarttime").val(),
				queryendtime:$("#queryendtime").val(),
		};
		
		return json;
	}
	
	function getSelected(){
		var row = $("#userproductAudienceStat").datagrid('getSelected');
		var querynetid = row.netid;
		var queryareacode = $("#queryareacode").combotree("getValue");
		var querystarttime = $("#querystarttime").val();
		var	queryendtime = $("#queryendtime").val();
		if (row){
			//$.messager.alert('Info', row.netname+":"+row.productid+":"+row.productname);
			var operatorReportForDialog;
	    	operatorReportForDialog = $.dialog({
		    	title: '<spring:message code="statreport.productaudience.detail" />('+row.netname+'_'+row.productname+')',
		    	lock: true,
		    	width: 900,
		    	height: 530,
		    	top: 0,
		    	drag: true,
		    	resize: false,
		    	max: false,
		    	min: false,
		    	content: 'url:statreport/userProductAudienceStatDialog?querynetid='+querynetid+'&queryareacode='+queryareacode+'&querystarttime='+querystarttime+'&queryendtime='+queryendtime+'&queryproductid='+row.productid
				});
		}
	}
    
    function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					$("#searchForm").attr("action", "statreport/exportUserProductAudienceStatExcel");
					$("#searchForm").submit();
 				}, function(){
 							});
	}
    
	function queryUserproductAudienceStat(){
		$('#userproductAudienceStat').datagrid('reload',paramsJson());
	}
	
	function formatUserOperation(value,row,index){
		var formatter = '<a class="btn-look" href="javascript:getSelected('+ value +')"><spring:message code="page.look"/></a>';
		return formatter;
	}
	
	$(function () {
	   
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
				     	initUserproductAudienceStat();
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

