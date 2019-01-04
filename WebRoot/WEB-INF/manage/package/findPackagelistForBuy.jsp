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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.package"/>  &gt; <spring:message code="package.querypackage"/></div>
        <form action="" method="post" id="searchForm" name="searchForm">
    		<div class="seh-box">
				<table width="100%">
					<tr>
						<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
						<td align="left">
							 <input id="querynetid" name="querynetid" style="width: 150px;">
						</td>
						<td align="right"><spring:message code="package.name"/>：</td>
						<td>
							<input type="text" class="inp w200"  name="queryname" id="queryname" style="width: 200px;" value="${package.queryname}">
						</td>	
						<td align="center">
							<%-- 
							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryPackage();" />
							 --%>
							<a href="javascript:queryPackage();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
						</td>
						<!-- 
						<td align="center">
							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addPackageInit();" />
						</td>
						 -->
					</tr>
				</table>
			</div>
    
		    <div style="margin:20px 0;"></div>
		   	<div id="packagelist" style="width:950px"></div>
    	</form>
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	//控制页面默认第一次加载JSON数据用的，由于页面参数还没初始化完成，EASYUI加载表格数据时，不能访问页面参数的控件值
	var flag = true;
    
    //查询操作员
	function queryPackage(){
	    $("#searchForm").attr("action", "package/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addPackageInit(){
		$("#searchForm").attr("action", "package/addPackageInit");
		$("#searchForm").submit();
	}	
	
	//删除
	function deletePackage(id) {
			$.dialog.confirmMultiLanguage(
					'<spring:message code="page.confirm.execution"/>?',
					'<spring:message code="page.confirm"/>',
					'<spring:message code="page.cancel"/>', function() {
						$("#searchForm").attr(
								"action",
								"package/delete?id=" + id
										+ "&pager_offset="
										+ '${package.pager_offset}'
										+ "&rid=" + Math.random());
						$("#searchForm").submit();
					}, function() {
					});
	}    
		
	function buyPackage(id){
		$("#searchForm").attr("action", "package/buyPackageInit?id="+id);
		$("#searchForm").submit();
	}
    
	$(function () {
		initNetwork();
       var returninfo = '${package.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
	
	//全选
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () {
	      if (!$(this).attr('checked')) {
	        checked = false;
	      }
	    });
	    $('#checkall').attr('checked', checked);
	}
	
	/**
	*编辑
	*/
	function updatePackage(id){
		$("#searchForm").attr("action", "package/updateInit?id="+id+"&pager_offset="+'${package.pager_offset}');
		$("#searchForm").submit();
	}
	
	function initNetwork(){
	   $('#querynetid').combobox({    
			url:'user/initNetworkJson?rid='+Math.random(),
		    valueField:'id',    
		    //limitToList:true,
		    editable:false, //不可编辑，只能下拉选择值
		    textField:'netname',
	        onSelect: function(rec){    
               //initArea(rec.id);//默认加载区域
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
                    //initArea($("#netid").combobox("getValue")); //默认加载区域
	    			//initStore('${operator.netid}');//默认加载营业厅 
			    	//初始化区域之后，再加载默认页面查询数据
			    	if(flag){
			    		initPackagelist();
			      		flag = false;
			        }
			    }
		});  
	   
    }
	
	function initPackagelist(){
		
        $('#packagelist').datagrid({
             title: '<spring:message code="package.info" />',
             url:'package/queryPackagelistJson',
             pagination: true,
             queryParams: {
					querynetid: $('#querynetid').combobox('getValue'),
		            queryname:$('#queryname').val(),
				},
             pageSize: 10,
             singleSelect: true,
             pageList: [10,25,50], 
             fitColumns:true,
             idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
             loadMsg:'loading...',
             columns: [[
                 { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100 },
                 { field: 'name', title: '<spring:message code="package.name" />',align:"center",width:200,
                	 formatter: function (value) {
		                    return "<span title='" + value + "'>" + value + "</span>";
		                }	 
                 },
                 { field: 'type', title: '<spring:message code="package.type" />',align:"center",width:100,
                	 formatter:function(value, row, index){ 
                		if(value==0){
             				return	'<spring:message code="package.type.0"/>';
             			}else if(value ==1){
             				return	'<spring:message code="package.type.1"/>';
             			}
           	        },
                 },
                 { field: 'totalmoney', title: '<spring:message code="package.totalmoney" />',align:"center",width:100 },
                 { field: 'starttime', title: '<spring:message code="package.starttime" />',align:"center",width:100,
                	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,10);
         	         },
                 },
            	 { field: 'endtime', title: '<spring:message code="package.endtime" />',align:"center",width:100,
                	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,10);
         	         },
            	 },
     		     { field: 'addtime', title: '<spring:message code="operator.addtime" />',align:"center",width:100,
            		 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,10);
         	         },
     		     },	  		      
              	 { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:100,
     		    	formatter:function(val, row, index){ 
     		    		if(row.buyfalg == '1'){
     		    			var formatter = '<a class="btn-up" href="javascript:buyPackage('+ val +')"><spring:message code="package.buy"/></a>';
    						return formatter;
     		    		}else{
     		    			return "";
     		    		}
						
          	        }, 
     		     }
             ]]
         });
       var p = $('#packagelist').datagrid('getPager');
       $(p).pagination({
           beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
           afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
        	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
       });
	}
	
	function queryPackage() {
		$('#packagelist').datagrid('reload',{
			querynetid: $('#querynetid').combobox('getValue'),
            queryname:$('#queryname').val(),
		});	
		   
	}
</script>
</body>
</html>

