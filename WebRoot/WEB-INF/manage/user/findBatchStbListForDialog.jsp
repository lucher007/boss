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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.stb"/> &gt; <spring:message code="stb.stbquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="state" id="state" value="${stb.state}"/>
        	<input type="hidden" name="querystate" id="querystate" value="${stb.querystate}"/>
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.network.netname }">
						<input type="hidden" name="querynetid" id="querynetid" value="${Operator.user.network.id }"/>
					</td>
					<td align="right" width="120px"><spring:message code="server.versiontype"/>：</td>
					<td width="130px" colspan="2">
						 <select id="queryversiontype" name="queryversiontype" class="select" >
							 <option value=""><spring:message code="page.select"/></option>
							 <option value="gos_gn" ><spring:message code="server.versiontype.gos_gn"/></option>
			                 <option value="gos_pn" ><spring:message code="server.versiontype.gos_pn"/></option>
			             </select>
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="stb.stbno"/>：</td>
					<td colspan="3">
						 <input type="text"  class="inp w200" name="querystbno" id="querystbno" value="${stb.querystbno }">
					</td>
					
					<td>
		    			<a href="javascript:queryStb();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    			<a href="javascript:addStb();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <!-- 机顶盒信息 -->
    <div id="stblist" style="width:839px;"></div>
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    //查询机顶盒
	function queryStb(){
		$("#stblist").datagrid('reload',{
			queryversiontype:$("#queryversiontype").val(),
			querystbno:$("#querystbno").val(),
		});
	}	
	
	//添加机顶盒
	function addStb(){
		var rows = $("#stblist").datagrid("getSelections");
		var stbnos = "";
		for(var i = 0;i < rows.length;i++){
			stbnos = stbnos + rows[i].stbno + ",";
		}
		var data = "stbnos="+ stbnos;
		var url="user/addBatchBuyingStb?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				parent.closeBatchStbDialog();
			}
		});
		
	}
	
	$(function () {
	   //initServer();
	   initStblist();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initServer() {
	  var data = {
	    querynetid: $('#querynetid').val(),
	    queryservertype: 'cas'
	  };
	  
	  $.getJSON('server/initServerJson', data, function (serverJson) {
	     var options = '<option value=""><spring:message code="page.select"/></option>';
	     for (var key in serverJson) {
	        options += '<option value="' + key + '">' + serverJson[key] + '</option>';
	     }
	     $('#queryserverid').children().remove();
	     $('#queryserverid').append(options);
	     $('#queryserverid').val('${stb.queryserverid}');
	  });
  }
  
  $(".lb-list").click(function(){
	var stbno = $(this).find("input[type=radio]").val();
	var data = "stbno="+ stbno;
	var url="user/addBuyingStb?rid="+Math.random();
	$.getJSON(url,data,function(jsonMsg){
		if(jsonMsg.flag=="0"){
		    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
		}else if(jsonMsg.flag=="1"){
			parent.closeStbDialog();
		}
	});
  });
  
  	//终端信息初始化
	function initStblist(){
	    $('#stblist').datagrid({
	         title: '<spring:message code="user.stbinfo" />',
	         url:'user/findBatchStbList',
	         queryParams: stbparamsJson(),
	         pageSize:10,
             singleSelect: false,
             pageList: [10,50,100], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	         	 { field: 'id', title: '全选',checkbox:true,align:"center",width:40,
				 },
	             { field: 'stbno', title: '<spring:message code="stb.stbno"/>',align:"center",width:80},
	             { field: 'versiontype', title: '<spring:message code="server.versiontype" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            	 	if(val == 'gos_pn'){
	            	 		return '<spring:message code="server.versiontype.gos_pn"/>';
	            	 	}else if(val == 'gos_gn'){
	            	 		return '<spring:message code="server.versiontype.gos_gn"/>';
	            	 	}
          	         },
	             },
	             { field: 'model', title: '<spring:message code="stb.model"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	            	 	return val==null?val:val.substring(0,30);
          	        },
	             },
	             { field: 'state', title: '<spring:message code="stb.state"/>',align:"center",width:100,
	             	 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="stb.state.0"/>';
						 	}else if(val == '1'){
						 		return '<spring:message code="stb.state.1"/>';
						 	}else if(val == '2'){
						 		return '<spring:message code="stb.state.2"/>';
						 	}else if(val == '3'){
						 		return '<spring:message code="stb.state.3"/>';
						 	}
	          	         },
	             },
	        	 { field: 'incardflag', title: '<spring:message code="stb.incardflag" />',align:"center",width:100,
	        	 	formatter: function(val, row, index){
	                    if(val=='0'){
	                    	return '<spring:message code="stb.incardflag.0"/>';
	                    }else if(val=='1'){
	                    	return '<spring:message code="stb.incardflag.1"/>';
	                    }else if(val=='2'){
	                    	return '<spring:message code="stb.incardflag.2"/>';
	                    }
	                }, 
	        	 },
	        	 { field: 'paircardid', title: '<spring:message code="stb.paircardid" />',width:120,align:"center",
	        	 }
	         ]],
	     });
	     var p = $('#stblist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	function stbparamsJson(){
		var json = {
				queryversiontype:$("#queryversiontype").val(),
				querystbno:$("#querystbno").val(),
		};
		return json;
	}
  
</script>
</body>
</html>

