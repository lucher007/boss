<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<style>
html {
	overflow-x: hidden;
}

.fb-con table {
	width: 100%;
	border: 0;
	border-spacing: 0;
	border-collapse: collapse;
}

.fb-con table tr {
	height: 30px;
}

.service table tr td {
	height: 30px;
	width: 12.5%;
}
</style>
</head>
<body style="padding:0px; width:100%; ">
	<div class="form-box">
		<div id="test" class="fb-con">
			<div id="printInfo" style="display: none;"></div>
 			<%-- <table>
				<tr class="fbc-tit">
					<td colspan="7" style="font-weight: bold;"><spring:message code="menu.business.businessquery" /></td>
				</tr>
				<tr class="lb-tit">
					<td width="60"><spring:message code="page.select"/></td>
					<td><spring:message code="userbusiness.addtime" /></td>
					<td><spring:message code="userproduct.source" /></td>
					<td><spring:message code="userbusiness.paymoney" /></td>
					<td><spring:message code="page.operate" /></td>
 						<td style="white-space: nowrap;width: 51px">
		          		<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						<label for="checkall"><spring:message code="page.select.all" /></label>
					</td> 
				</tr>
				<c:forEach items="${userbusiness.userbusinesslist }" var="dataList">
					<tr height="30" class="lb-list">
						<td width="" height="30">
							<input type="radio" name="singleselect" value="${dataList.id }+${dataList.paymoney}+${dataList.addtime}+${dataList.storeid}">
						</td>
						<td>${fn:substring(dataList.addtime, 0, 19)}</td>
						<td><spring:message code="userproduct.source.${dataList.source}" /></td>
						<td>${dataList.paymoney}</td>
						<td>
							    <a class="btn-look" href="javascript:findDetailList(${dataList.id});" ><spring:message code="print.checklist"/></a>
						</td>
						
								        	
								<td ><input type="checkbox" class="checkbox" name="ids" value="${dataList.id}" onclick="checkbox();" onchange="loadPrintInfo();" style="vertical-align: middle;"></td>
						 
					</tr>
				</c:forEach>
			</table> --%>
		</div>
		<div id="userInvoiceInfo" style="width:auto"></div>
		
		<div class="fb-bom">
	        <cite>
	            <a class="btn-a" href="javascript:isPrintTaxpayerMsg()"><span class="print"><spring:message code="print.print" /></span></a>
	        </cite>
	        <span class="red">${user.returninfo }</span>
	    </div>
		
		<div class="pop-box" id="pop-div">
			<table>
				<tr align="right" height="30px">
					<td><spring:message code="print.template" />:</td>
					<td>
						<select id="template_value" name="template_value" class="select">
							<c:forEach items="${printtemplate.printtemplatelist}" var="templateMap" varStatus="s">
								<option value='${templateMap.value}'>${templateMap.name}</option>
							</c:forEach>
						</select> 
					</td>
				</tr>
				<c:if test="${Operator.user.printtaxpayerflag == '1'}">
				<input type="hidden"  id="store" />
					<tr align="right" height="30px">
						<td><spring:message code="print.taxpayername" />:</td>
						<td><input type="text" class="inp"   id="taxpayername" name="taxpayername"  /></td>
					</tr>
					<tr align="right" height="30px">
						<td><spring:message code="print.taxpayer.number" />:</td>
						<td><input type="text"  class="inp" id="taxpayercode" name="taxpayercode"  /></td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/lodop/LodopFuncs.js"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		
		$(function () {
			$("#userInvoiceInfo").datagrid({
			 title: '<spring:message code="menu.business.businessquery" />',
	         url:'user/userInvoiceInfo?userid=${userbusiness.userid }',
	         //queryParams: usercardparamsJson(),
	         pageSize:10,
             singleSelect: true,
             pageList: [10,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         columns: [[
	         	 { field: '', title: '全选',checkbox:true,align:"center",width:40,
					  formatter: function(val, row, index){
				           return row.id;
				       }, 
				 },
	             { field: 'addtime', title: '<spring:message code="userbusiness.addtime" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },
	             },
	             { field: 'source', title: '<spring:message code="userproduct.source"/>',align:"center",width:100,
	             		formatter:function(val, row, index){
	             			if(val == '0'){
	             				return '<spring:message code="userproduct.source.0" />';
	             			}else if(val == '1'){
	             				return '<spring:message code="userproduct.source.1" />';
	             			}else if(val == '2'){
	             				return '<spring:message code="userproduct.source.2" />';
	             			}
	             		} 
	             },
	             { field: 'paymoney', title: '<spring:message code="userbusiness.paymoney"/>',align:"center",width:100},
	             { field: 'id',align:"center",width:100,hidden:true},
	             { field: 'storeid',align:"center",width:100,hidden:true},
	             { field: 'operetor', title: '<spring:message code="page.operate" />',align:"center",width:100,
	             		formatter:function(val, row, index){
	             			return '<a class="btn-edit" href="javascript:findDetailList('+row.id+');"><spring:message code="print.checklist"/></a>';
	             		} 
	             }
	         ]],
	         onLoadSuccess:function(data){ 
	         	 //隐藏表头选框
	         	 $("#userInvoiceInfo").parent().find("div .datagrid-header-check").children("input[type=\"checkbox\"]").eq(0).attr("style", "display:none;"); 
	        	 //默认选择第一条
	        	 $('#userInvoiceInfo').datagrid("selectRow", 0);
	         },
			});
			var p = $('#userInvoiceInfo').datagrid('getPager');
		     $(p).pagination({
		         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
		         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
		    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
		     });
		});
	
	
	
	 	var basepath = '<%=basePath%>';
		var LODOP;
		var needupdate = '<spring:message code="print.plugin.update"/>';
		var needinstall = '<spring:message code="print.plugin.install"/>';
		var install = '<spring:message code="print.plugin.excuteinstall"/>';
		var update = '<spring:message code="print.plugin.excuteupdate"/>';
		var refresh = '<spring:message code="print.plugin.refresh"/>';
		var notready = '<spring:message code="print.plugin.notready"/>';
		var error = '<spring:message code="print.plugin.error"/>';
		var totalPrice = '';
		var addtime = '';

		$(".lb-list").click(function() {
			var businessid = $(this).find("input[type=radio]").val().split("+")[0];
			totalPrice = $(this).find("input[type=radio]").val().split("+")[1];
			addtime = $(this).find("input[type=radio]").val().split("+")[2];
			var storeid = $(this).find("input[type=radio]").val().split("+")[3];
			$(this).find("input[type=radio]").attr('checked', 'true');
			var data = {
				businessid : businessid,
				tag : 'printInfo'
			};
			var url = 'print/getPrintInfo .' + data.tag;
			$('#printInfo').load(url, data, function() {
				$.post('taxpayer/findStore',{storeid:storeid},function(store){
					var store = eval('(' + store + ')');
					$("#store").val(store.storename);
				
				});
			});
		});

		function checkSelected() {
		var row = $("#userInvoiceInfo").datagrid('getSelected');
			if (row == null || row == "") {
				return false;
			}else{
				return true;
			}
// 			for ( var i = 0; i < document.getElementsByName("singleselect").length; i++) {
// 				if (document.getElementsByName("singleselect")[i].checked) {//得到选中的单选按钮如果要得到值 那么
// 					return true;
// 				}
// 			}
// 			return false;
		};

		function selectInvoiceTmp() {
			if (checkSelected() == false) {
				$.dialog.tips('<spring:message code="print.printtarget.empty"/>', 1, 'alert.gif');
				return;
			}
            //是否打印纳税人信息
            
			selectInvoiceDialog = $.dialog({
			    title: '<spring:message code="print.template"/>',
			    lock: true,
			    width: 400,
			    height:100,
			    top: 0,
			    drag: false,
			    resize: false,
			    max: false,
			    min: false,
			    content: $("#pop-div").html(),
			   	ok: function(){
			   		   if($('#template_value').val() == null || $('#template_value').val() == '') {
					      	$.dialog.tips('<spring:message code="print.template.empty"/>', 1, 'alert.gif');
					      return false;
					   }
					  printInvoice();
					   //保存纳税人信息
					  saveTaxpayerMsg();
			   		   
			   		},
			   	okVal:'<spring:message code="page.confirm"/>',
			   	cancel:function(){selectInvoiceDialog.close();},
			   	cancelVal:'<spring:message code="page.cancel"/>'
		   });
		};
        
        function printInvoice(){
        
        	LODOP = getLodop();
        	var value = $("#template_value").val();
			eval(value);
			var items = value.split("LODOP.ADD_PRINT_T");
			$.each(items, function(n, item) {
				if (item.indexOf("list") > 0) {
					var lists = item.split("/script>");
					var str = lists[1].replace(/[\r\n]/g, ""); //去掉换行符
					var code = str.substring(0, (str.length) - 3);
					//LODOP.SET_PRINT_STYLEA(n,"CONTENT",document.getElementById(code).innerHTML);
					LODOP.SET_PRINT_STYLEA(n, "CONTENT", document.getElementById("printInfo").innerHTML);
				}
			});
			
			LODOP.SET_SHOW_MODE("HIDE_ITEM_LIST ", true);
			LODOP.SET_PRINT_STYLEA("clientName", "CONTENT",window.parent.getUsername());
			LODOP.SET_PRINT_STYLEA("totalPrice", "CONTENT", totalPrice);
			LODOP.SET_PRINT_STYLEA("clientCode", "CONTENT", window.parent.getUsercode());
			LODOP.SET_PRINT_STYLEA("operateDate", "CONTENT",addtime.substring(0,10));
			LODOP.SET_PRINT_STYLEA("printDate", "CONTENT",new Date().toLocaleDateString());
			LODOP.SET_PRINT_STYLEA("operatorCode", "CONTENT",'${Operator.operatorcode}');
			LODOP.SET_PRINT_STYLEA("operatorName", "CONTENT",'${Operator.operatorname}');
			LODOP.SET_PRINT_STYLEA("storeName", "CONTENT",$("#store").val());
			LODOP.SET_PRINT_STYLEA("taxpayerCode", "CONTENT",$("#taxpayercode").val());
			LODOP.SET_PRINT_STYLEA("taxpayerName", "CONTENT",$("#taxpayername").val());
			LODOP.PREVIEW();
        }
        
		//全选
		function checkAll() {
			$(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
		}


		function checkbox() {
			var checked = true;
			$('.checkbox').each(function() {
				if (!$(this).attr('checked')) {
					checked = false;
				}
			});
			$('#checkall').attr('checked', checked);
		}

		function getCheckedValue() {
			var obj = document.getElementsByName('ids');
			var ids = '';
			for ( var i = 0; i < obj.length; i++) {
				if (obj[i].checked) {
					ids += obj[i].value + ',';
				}
			}
			ids = (ids.substring(ids.length - 1) == ',') ? ids.substring(0,
					ids.length - 1) : ids;
			//alert(ids==''?'你还没有选择任何内容！':ids); 
			return ids;
		}
		
	 function findDetailList(businessid) {
	  window.parent.findDetailList(businessid);
	 }
	 
	 function saveTaxpayerMsg(){
	 	var url = "taxpayer/saveUsertaxpayerMsg?rid="+new Date();
	 	var userJson = {
	 		taxpayername:$("#taxpayername").val(),
	 		taxpayercode:$("#taxpayercode").val(),
	 		userid:window.parent.getUserid()
	 	};
	 	$.post(url,userJson,function(data){
	 	});
	 
	 }
    function isPrintTaxpayerMsg(){
    	var row = $("#userInvoiceInfo").datagrid('getSelected');
    	console.info(row);
    	var businessid = row.id;
		totalPrice = row.paymoney;
		addtime = row.addtime;
		var storeid = row.storeid;
		var data = {
			businessid : businessid,
			tag : 'printInfo'
		};
		var url = 'print/getPrintInfo .' + data.tag;
		$('#printInfo').load(url, data, function() {
			$.post('taxpayer/findStore',{storeid:storeid},function(store){
				var store = eval('(' + store + ')');
				$("#store").val(store.storename);
			
			});
		});
    	
    	var url = "taxpayer/getUsertaxpayer?rid="+new Date();
    	var userid = '${userbusiness.userid}';
    	$.getJSON(url,{userid:userid},function(msg){
    	    if(msg.flag == '1'){
    	    	selectInvoiceTmp();
	    	    $("#taxpayername").val(msg.taxpayername);
	    		$("#taxpayercode").val(msg.taxpayercode);
    	    }
    	});
    
    }
     
	</script>
</body>
</html>
