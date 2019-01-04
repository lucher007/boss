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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.card"/> &gt; <spring:message code="card.cardquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="state" id="state" value="${card.state}"/>
        	<input type="hidden" name="stbno" id="stbno" value="${card.stbno}"/>
        	<input type="hidden" name="querystate" id="querystate" value="${card.querystate}"/>
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.network.netname }">
					</td>
					<td align="right" ><spring:message code="server.versiontype"/>：</td>
					<td width="130px" colspan="2">
						 <input type="text" class="inp" name="versiontype" id="versiontype" readonly="readonly" style="background:#eeeeee;" value="<spring:message code="server.versiontype.gos_pn"/>">
					</td>
					<td align="right" ><spring:message code="systempara.code.send_stbcardpair_flag"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input style="width: 30px;" type="text" class="inp" name="stbcardpair" id="stbcardpair" readonly="readonly" style="background:#eeeeee;" value="<spring:message code="systempara.code.send_stbcardpair_flag.0"/>">
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="card.startcardid"/>：</td>
					<td >
						 <input type="text"  class="inp w200" name="startcardid" id="startcardid" >
					</td>
					<td align="right"><spring:message code="card.endcardid"/>：</td>
					<td >
						 <input type="text"  class="inp w200" name="endcardid" id="endcardid" >
					</td>
					<td >
		    			<a href="javascript:queryCard();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    		</td>
		    		<td >
		    			<a href="javascript:addCard();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <!-- 机顶盒信息 -->
    <div id="cardlist" style="width:839px;"></div>
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryCard(){
		$("#cardlist").datagrid('reload',{
			startcardid: $("#startcardid").val(),
			endcardid: $("#endcardid").val(),
			stbcardpair: "0",
		});
	}	
	
	//添加智能卡
	function addCard(){
		var rows = $("#cardlist").datagrid("getSelections");
		var cardids = "";
		for(var i = 0;i < rows.length;i++){
			cardids = cardids + rows[i].cardid + ",";
		}
		var data = "cardids="+ cardids;
		var url="user/addBatchBuyingCard?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				parent.closeBatchCardDialog();
			}
		});
		
	}
	
	$(function () {
	   //initServer();
	   initCardlist();
       var returninfo = '${card.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
    	
    	var data = {
			    t: new Date().getTime()
		     };
    	$.getJSON('network/initNetworkJson', data, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${card.querynetid}');
		     initServer();
	   });
    }
    
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
	     $('#queryserverid').val('${card.queryserverid}');
	  });
  }
  
  $(".lb-list").click(function(){
	var data = {
	    stbno: $('#stbno').val(),
	    cardid: $(this).find("input[type=radio]").val()
	  };
	var url="user/addBuyingCard?rid="+Math.random();
	$.getJSON(url,data,function(jsonMsg){
		if(jsonMsg.flag=="0"){
		    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
		}else if(jsonMsg.flag=="1"){
			parent.closeCardDialog();
		}
	});
  });
  
  	//智能卡信息初始化
	function initCardlist(){
	    $('#cardlist').datagrid({
	         title: '<spring:message code="user.cardinfo" />',
	         url:'user/findBatchCardList',
	         queryParams: cardparamsJson(),
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
	             { field: 'cardid', title: '<spring:message code="card.cardid"/>',align:"center",width:120},
	             { field: 'servername', title: '<spring:message code="card.serverid" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            	 	if(val == 'gos_pn'){
	            	 		return '<spring:message code="server.versiontype.gos_pn"/>';
	            	 	}else if(val == 'gos_gn'){
	            	 		return '<spring:message code="server.versiontype.gos_gn"/>';
	            	 	}
          	         },
	             },
	             { field: 'model', title: '<spring:message code="card.model"/>',align:"center",width:100,
	             	formatter:function(val, row, index){ 
	            	 	return val==null?val:val.substring(0,30);
          	        },
	             },
	             { field: 'state', title: '<spring:message code="card.state"/>',align:"center",width:100,
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
	        	 { field: 'incardflag', title: '<spring:message code="card.incardflag" />',align:"center",width:100,
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
	        	 { field: 'stbno', title: '<spring:message code="card.stbno" />',width:120,align:"center",
	        	 }
	         ]],
	     });
	     var p = $('#cardlist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	function cardparamsJson(){
		var json = {
			startcardid: $("#startcardid").val(),
			endcardid: $("#endcardid").val(),
			stbcardpair: "0",
		};
		return json;
	}
  
</script>
</body>
</html>

