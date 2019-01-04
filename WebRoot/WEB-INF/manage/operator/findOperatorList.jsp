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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.system.operator" /> &gt; <spring:message code="operator.operatorquery" /></div>
    <div class="seh-box">
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
					<td align="right"><spring:message code="store.storename" />：</td>
		    		<td>
		    			<input id="querystoreid" name="querystoreid" style="width: 157px;">
					</td>
					<td align="center">
		    			<%-- 
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryOperator();"/>
		    			 --%>
		    			<a href="javascript:queryOperator();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td align="right"><spring:message code="operator.operatorlevel" />：</td>
		    		<td>
						 <select id="queryoperatorlevel" name="queryoperatorlevel" class="select" >
							 <option value=""><spring:message code="page.select"/></option>
			                 <option value="0" <c:if test="${operator.queryoperatorlevel == '0' }">selected</c:if>><spring:message code="operator.operatorlevel.0"/></option>
			                 <option value="1" <c:if test="${operator.queryoperatorlevel == '1' }">selected</c:if>><spring:message code="operator.operatorlevel.1"/></option>
			             	 <option value="2" <c:if test="${operator.queryoperatorlevel == '2' }">selected</c:if>><spring:message code="operator.operatorlevel.2"/></option>
			             </select>
					</td>
		    		<td align="right"><spring:message code="operator.state" />：</td>
        			<td>
        				<select id="querystate" name="querystate" class="select">
			                   <option value="1" <c:if test="${operator.querystate == '1' }">selected</c:if>><spring:message code="operator.state.1"/></option>
			                   <option value="0" <c:if test="${operator.querystate == '0' }">selected</c:if>><spring:message code="operator.state.0"/></option>
			             </select>
        			</td>
        			<td align="right"><spring:message code="operator.operatortype" />：</td>
        			<td>
        				<select id="queryoperatortype" name="queryoperatortype" class="select">
        					   <option value=""><spring:message code="page.select"/></option>
			                   <option value="1" <c:if test="${operator.queryoperatortype == '1' }">selected</c:if>><spring:message code="operator.operatortype.1"/></option>
			                   <option value="2" <c:if test="${operator.queryoperatortype == '2' }">selected</c:if>><spring:message code="operator.operatortype.2"/></option>
			                   <option value="3" <c:if test="${operator.queryoperatortype == '3' }">selected</c:if>><spring:message code="operator.operatortype.3"/></option>
			             </select>
        			</td>
		    		<td align="center">
		    			<%-- 
		    			<input id="addOperatorInput" type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addOperator();"/>
		    			 --%>
		    			<a href="javascript:addOperator();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td align="right"><spring:message code="operator.operatorcode" />：</td>
		    		<td>
						<input type="text" class="inp w200" name="queryoperatorcode" id="queryoperatorcode" value="${operator.queryoperatorcode}"/>
					</td>
		    		<td align="right"><spring:message code="operator.operatorname" />：</td>
        			<td colspan="4">
        				<input type="text" class="inp w200" name="queryoperatorname" id="queryoperatorname" value="${operator.queryoperatorname}"/>
        			</td>
		    	</tr>
   		    </table>
   		</form>
    </div>
    <div class="lst-box">
	</table>
	 <div id="operatorBusinesslist" style="width:auto"></div>
   </div> 
    </div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?skin=iblue"></script>
<script type="text/javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	//页面默认加载查询标志
	var flag = true;

	
	//查询操作员
	function queryOperator(){
		$("#operatorBusinesslist").datagrid('reload',paramsJson());
	}	
	//添加操作员
	function addOperator(){
		$("#searchForm").attr("action", "operator/addInit");
		$("#searchForm").submit();
	}	
	
	/**
	*编辑
	*/
	function updateOperator(id){
		$("#searchForm").attr("action", "operator/updateInit?id="+id+"&pager_offset="+'${operator.pager_offset}');
		$("#searchForm").submit();
	}
	
	/**
	*删除
	*/
	function deleteOperator(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>', 
			function(){ 
				$("#searchForm").attr("action", "operator/delete?id="+id+"&pager_offset="+'${operator.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
		var type = '${Operator.operatortype}';
		if(type == '1' || type == '2'){
			//操作人员不能添加
			$("#addOperatorInput").hide();
		}
		//初始化网络
		initNetwork();
		
       var returninfo = '${operator.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
	
	function initOperatorBusinesslist(){
		
	    $('#operatorBusinesslist').datagrid({
	         title: '<spring:message code="statreport.operatorreport" />',
	         url:'operator/operatorBusinessJson',
	         queryParams: paramsJson(),
	         singleSelect: true,
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'loginname', title: '<spring:message code="operator.loginname"/>',align:"center",width:100},
	             { field: 'operatorname', title: '<spring:message code="operator.operatorname" />',align:"center",width:100},
	        	 { field: 'operatorcode', title: '<spring:message code="operator.operatorcode" />',align:"center",width:100},
	        	 { field: 'operatorlevel', title: '<spring:message code="operator.operatorlevel" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="operator.operatorlevel.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="operator.operatorlevel.1" />';
						 	}else if(val == '2'){
						 		return '<spring:message code="operator.operatorlevel.2" />';
						 	}
        	        },
	        	 },
	        	 { field: 'operatortype', title: '<spring:message code="operator.operatortype" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="operator.operatortype.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="operator.operatortype.1" />';
						 	}else if(val == '2'){
						 		return '<spring:message code="operator.operatortype.2" />';
						 	}else if(val == '3'){
						 		return '<spring:message code="operator.operatortype.3" />';
						 	}
           	        },
	        	 },
	        	 //{ field: 'telephone', title: '<spring:message code="operator.telephone" />',align:"center",width:100},
	        	 //{ field: 'mobile', title: '<spring:message code="operator.mobile" />',align:"center",width:100},
	        	 //{ field: 'documentno', title: '<spring:message code="operator.documentno" />',align:"center",width:100},
				 { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100,},
				 { field: 'areaname', title: '<spring:message code="area.areaname" />',align:"center",width:100,},
				 { field: 'storename', title: '<spring:message code="store.storename" />',align:"center",width:100,},
                 { field: 'operetor', title: '<spring:message code="page.operate" />',align:"center",width:100,
	        	 				formatter:function(val, row, index){ 
	        	 					if('${Operator.loginname}' == row.loginname){//操作员自己的信息，只能修改基本上信息，不能修改操作权限
		        	 					var lookContent = '<a class="btn-edit" href="javascript:userInfo('+row.id+');"><spring:message code="page.update"/></a>';
							        	return  lookContent;
	        	 					} else {
	        	 						if(row.loginname != 'admin'){ //过滤掉超级管理人员信息，不能修改
	        	 							var lookContent = '<a class="btn-edit" href="javascript:updateOperator('+row.id+');"><spring:message code="page.update"/></a>'
					            				+ '<a class="btn-del" href="javascript:deleteOperator('+row.id+');" ><spring:message code="page.delete"/></a>';
        									return  lookContent;
	        	 						}else{
	        	 							return "";
	        	 						}
	        	 						
	        	 					}
	                  	    }
	             },
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
				querynetid:$("#querynetid").combobox("getValue"),
				queryareacode: $("#queryareacode").combotree('getValue'),
				querystoreid:$("#querystoreid").combobox("getValue"),
				querystate:$("#querystate").val(),
				queryoperatortype:$("#queryoperatortype").val(),
				queryoperatorlevel:$("#queryoperatorlevel").val(),
				queryoperatorcode:$("#queryoperatorcode").val(),
				queryoperatorname:$("#queryoperatorname").val()
		};
		
		return json;
	}
	
	function initNetwork(){
	   $('#querynetid').combobox({    
			url:'user/initNetworkJson?rid='+Math.random(),
		    valueField:'id',    
		    //limitToList:true,
		    editable:false, //不可编辑，只能下拉选择值
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
			    url:'operator/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
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
			    
			    	//初始化营业厅
			    	initStore(netid);
			    	
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
	
    function initStore(netid) {
        
	   $('#querystoreid').combobox({    
			url:'statreport/getStoreJson?querystate=1&querynetid='+netid,
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'storename',
		    async:false,
		    onSelect: function(rec){  
		    	
	        },
		    
		    onLoadSuccess:function(node, data){
		    	 //初始化营业厅列表框的默认选择值
		    	if('${Operator.storeid}' != '' && '${Operator.storeid}' != null){
					if('${Operator.netid}' == netid){//防止选择的网络不包括默认的营业厅ID，直接把ID显示在输入库里
				  	  $('#querystoreid').combobox('select','${Operator.storeid}');
				  	}
				}else{//默认选择第一个
					var val = $(this).combobox("getData");  
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $('#querystoreid').combobox("select", val[0][item]);  
                        }  
                     }  	
				} 
		    	 
		    	//初始化营业厅之后，初始化页面的操作员
		    	if(flag){
		      		initOperatorBusinesslist();
		      		flag = false;
		     	}
		    }
		});  
	}
    
    //操作员修改自己的信息
    var userInfoDialog;
	function userInfo() {
	  userInfoDialog = $.dialog({
	    title: '${operator.operatorname}',
	    lock: true,
	    width: 800,
	    height: 400,
	    drag: false,
	    resize: false,
	    max: false,
	    min: false,
	    content: 'url:<%=request.getContextPath()%>/menu/updateInit?t=' + new Date().getTime() 
	  });
	}
</script>
</body>
</html>