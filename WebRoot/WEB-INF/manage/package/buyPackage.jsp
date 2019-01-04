<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html>
<head>
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.buypackage" />&gt;<spring:message code="package.buy"/>(${package.name})</div>
		<div style="margin:20px 0;"></div>
		  <form action="" method="post" id="packageForm" name="packageForm">	
		        <input type="hidden" class="inp" name="id" id="id" value='${package.id}'/>	
				<input type="hidden" class="inp" name="package_json" id="package_json" value='${package.package_json}'/> 
				<input type="hidden" class="inp" name="type" id="type" value="${package.type}"/> 
				<input type="hidden" class="inp" name="service_ids" id="service_ids" value='${package.service_ids}'/> 
			
			<div id="service0" class="services">
				<div id="selectUser" align="center" title="<spring:message code="user.userquery"/>" style="width:100%">
			        <table>
		        		  <tr height="40px">
								<td width="100%">
										<a href="javascript:selectUser();" class="easyui-linkbutton"><spring:message code="user.userquery"/></a>
								</td>
						  </tr>
					</table>
				</div>
			</div>
			<div style="margin:20px 0;"></div>
		</form>   <!-- 放这里为了包括DIV：selectUser中加载的子页面中的元素 ：userid-->
		
		<div id="service1" class="services">
			<div id="openAccountInfo" title="<spring:message code="user.useradd"/>" style="width:100%"></div>
		</div>
		<div style="margin:20px 0;"></div>
		
		<div id="service2" class="services">
			<div id="buyingStbInfo" style="width:100%"></div>
		</div>
		<div style="margin:20px 0;"></div>
				
		<div id="service3" class="services">
			<div id="buyingCardInfo" style="width:100%"></div>
		</div>
		<div style="margin:20px 0;"></div>
			
		<div id="service4" class="services">
			<div id="tg" title="<spring:message code="package.service.productpackage"/>" style="width:100%"></div>
		</div>
		<div style="margin:20px 0;"></div>
			
		<div id="service5" class="services">
			<div  id="rechargeInfo" align="center" title="<spring:message code="package.service.recharge"/>"style="width:100%">
				<table>
          				<tr height="40px">
				           <td align="right" width="20%"><spring:message code="pakcage.recharge.rechargeamount"/>：</td>
		           		   <td align="leth" width="30%"><input type="text" class="inp" name="rechargemoney" id="rechargemoney" readonly="readonly" style="background:#eeeeee;"></td>
				           <td align="right" width="20%"><spring:message code="pakcage.recharge.paymoney"/>：</td>
		           		   <td align="leth" width="30%"><input type="text" class="inp" name="paymoney" id="paymoney" readonly="readonly" style="background:#eeeeee;"></td>
						</tr>
				</table>
			</div>
		</div>
		<div style="margin:20px 0;"></div>
		<div align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr height="30px">
		            <td height="20" width="50%" align="right" style="font-weight: bold;"><spring:message code="userbusiness.totalmoney"/>：</td>
		            <td width="50%" align="left">
		            	<input type="text" class="inp" name="totalmoney" id="totalmoney" readonly="readonly" style="background:#eeeeee;" value="${package.totalmoney }"><span class="red">*</span>
		            </td>
		         </tr>
			</table>
		</div>
		<div style="margin:20px 0;"></div>
		<div align="center">
			<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="page.goback"/></a>                                                                                                                                                                                  
			<a href="javascript:submitJson();" class="easyui-linkbutton"><spring:message code="page.save"/></a>
			<!-- 
			<a href="javascript:show0();" class="easyui-linkbutton"><spring:message code="test"/></a>
			 -->
		</div>
	
		<div id="productBinding" class="easyui-window" title="<spring:message code="package.terminalinfo"/>" closed="true" style="width:500px;">
			<div id="terminalsForProductBinding"></div>
		</div>
		
		<div id="chooseStbForCard" class="easyui-window" title="<spring:message code="package.stbinfo"/>" closed="true" style="width:500px;">
			<div id="stbsForChoose"></div>
		</div>
		
		<div id="chooseMothercardForCard" class="easyui-window" title="<spring:message code="package.cardinfo"/>" closed="true" style="width:500px;">
			<div id="cardsForChoose"></div>
		</div>

	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
 	<script type="text/javascript">
       //全局变量
       	var JsonData =  JSON.parse('${package.package_json}');
	  	var serviceids = '${package.service_ids}';  		
		var packageUser = [];
		var packageStb = [];
		var packageCard = [];
		var packageProduct = [];
	 	var terminalsForProductBinding = [];
    	var stbsForCard = [];
		var mothercardForCard = [];
		var selectUserDialog;
        var stbDialog;
		var cardDialog;
	    
	    function submitJson(){
		    unselectAll();
	  		if(!checkUser()){ return; }
	  		if(serviceids.indexOf("2") >= 0){
	  			  	if(!checkStb()){return;} 
	  		}
	  		if(serviceids.indexOf("3") >= 0 ){
					if(!checkCard()){return;} 
	  		}
	  		if(serviceids.indexOf("4") >= 0 ){
		   			if(!checkProductPackage()){return;} 
	  		}
	  		//赋值数组JSON
	        $("#package_json").val(JSON.stringify(JsonData));
	      
	     
	  		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
	  			'<spring:message code="page.confirm"/>',
	  			'<spring:message code="page.cancel"/>',
	  			function(){ 
	  				$("#packageForm").attr("action", "package/saveBuyInfo?rid="+Math.random());
	  				$("#packageForm").submit();
	  			}, function(){
	  						});
	        //$("#packageForm").attr("action", "package/saveBuyInfo").submit();
	   }
	    
	    function unselectAll(){
		   	if(serviceids.indexOf("2") >= 0){
	  			$("#buyingStbInfo").datagrid("unselectAll");
	  		}
	  		if(serviceids.indexOf("3") >= 0){
	  		  	$("#buyingCardInfo").datagrid("unselectAll");
	  		}
	  		if(serviceids.indexOf("4") >= 0){
	  	  		$("#tg").treegrid("unselectAll");
	  		}
	    }
	    
	    function checkUser(){
	      if('${package.type}' == "0"){
  		 	  if ($('#netid').combobox('getValue') == '') {
			      $.dialog.tips('<spring:message code="network.netid.empty"/>', 1, 'alert.gif');
			      //$('#netid').focus();
			      $('#netid').next('span').find('input').focus();
			      return false;
			  }
			  if ($('#areacode').combotree('getValue') == '') {
			      $.dialog.tips('<spring:message code="area.areacode.empty"/>', 1, 'alert.gif');
			      $('#areacode').next('span').find('input').focus();
			      //$('#areacode').focus();
			      return false;
			  }
  		 	  saveUser();
  		  }else{
		  		  if($("#userid").val() == undefined){
		  		 	$.dialog.tips('<spring:message code="package.user.empty"/>', 1, 'alert.gif');
		  		  return false;
		  		  }
  		  }
  		  return true;
	    }
	    
	    function checkStb(){
			for(var i = 0; i<packageStb.length; i++){
		       	if(packageStb[i].stbno == undefined || packageStb[i].stbno == ''){
					highlightError("buyingStbInfo",packageStb[i].id);
		       	 	$.dialog.tips('<spring:message code="package.stbno.empty"/>', 1, 'alert.gif');
		       		return false;
		       	}
			 }
			return true;
	    }
	    
	    function checkCard(){
			for(var i = 0; i<packageCard.length; i++){
		       	//验证智能卡号是否为空
				if(packageCard[i].cardid == undefined || packageCard[i].cardid == ''){
					highlightError("buyingCardInfo",packageCard[i].id);
		       		$.dialog.tips('<spring:message code="package.cardid.empty"/>', 1, 'alert.gif');
		       		return false;
		        }
		       	//如果为子机，请选择主机号
	       		if(packageCard[i].mothercardflag == "1" && packageCard[i].mothercardid ==""){
	      			highlightError("buyingCardInfo",packageCard[i].id);
	       	 		$.dialog.tips('<spring:message code="usercard.mothercardid.empty"/>', 1, 'alert.gif');
	       			return false;
	       		}
		       	//如果系统设置机卡绑定，请选择配对机顶盒号
		       	var stbcardpairflag = '${package.stbcardpairflag}';
		        if(stbcardpairflag == '1'){//系统默认机卡绑定，智能卡必须选择机顶盒
		    	   if(packageCard[i].stbno == undefined || packageCard[i].stbno == ''){
		    		    highlightError("buyingCardInfo",packageCard[i].id);
		       	 		$.dialog.tips('<spring:message code="usercard.stbno.empty"/>', 1, 'alert.gif');
		       			return false;
		    	   }
		       }
			 }
			return true;
	    }
	    
	    function checkProductPackage(){
			for(var i = 0; i<packageProduct.length; i++){
		       	if(packageProduct[i].terminalid == undefined){
					highlightError("tg",packageProduct[i].id);
		       	 	$.dialog.tips('<spring:message code="package.productbind.empty"/>', 1, 'alert.gif');
		       		return false;
		       	}
			 }
			return true;
	    }
	    
	    function highlightError(windowid,rowid){
	    		$("#" + windowid).datagrid("selectRecord", rowid); 
	    		if(windowid=="tg"){
	    			$("#" + windowid).treegrid("select", rowid); 
	    		}
	    }
	     		
		function goBack(){
			$("#packageForm").attr("action", "package/findPackagelistForBuy").submit();
		}
	
	  //初始化页面   
     	function initPage(){
			$(".services").hide();
			for(var i = 0; i < JsonData.rows.length; i++){
				var serviceid = JsonData.rows[i].id;
				$("#service"+serviceid).show();//显示
				//	alert(i);
				if(serviceid == "1"){
					loadOpenAccountInfo(i);
				}else if(serviceid == "2"){
					loadPackageStb(i);
				}else if(serviceid == "3"){
					loadPackageCard(i);
				}else if(serviceid == "4"){
					loadPackageProduct(i);
				}else if(serviceid == "5"){
					loadRechargeInfo(i);
				}												
			}
			loadSelectUserInfo();
		}
		
	   $(function() {
				initPage();
				var returninfo = '${package.returninfo}';
				if (returninfo != '') {
					$.dialog.tips(returninfo, 1, 'alert.gif');
				}
		});
     
     	// 加载业务窗口
       function loadSelectUserInfo(){
	       //	alert('${package.service_ids}'.indexOf("1") >= 0 ? "开户套餐" : "非开户套餐");
  		   if('${package.type}' == "1"){
	       		$("#service0").show();//显示
	     		$('#selectUser').panel();     
	       	}
       }
     
 		function loadOpenAccountInfo(index) {
		    packageUser = JsonData.rows[index].children;
		 	$('#openAccountInfo').panel({href:'package/openAccountInit'});  
		 }
		 
 		function loadPackageStb(index){
          	packageStb = JsonData.rows[index].children;
			initDatagridForStb(packageStb);
 		}
	
		function loadPackageCard(index){
          	packageCard = JsonData.rows[index].children;
			initDatagridForCard(packageCard);
 		}
 		
		function loadPackageProduct(index){
		    packageProduct = JsonData.rows[index].children;
			for(var i = 0; i < packageProduct.length; i++){
				packageProduct[i].root = true;
				packageProduct[i].state = "open";
			}
			//$("#testjson").val(JSON.stringify(packageProduct));
			initTreegridForProduct();
		}
		
		function loadRechargeInfo(index){
		 	var packageRecharge = JsonData.rows[index].children;
			$("#rechargemoney").val(packageRecharge[0].rechargemoney);
			$("#paymoney").val(packageRecharge[0].totalprice);
			$('#rechargeInfo').panel();   
		}
		 
		 //EASYUI窗口构造
	 	function initDatagridForStb(data){
             $('#buyingStbInfo').datagrid({
                  title: '<spring:message code="package.service.stb" />',
                  data:data.slice(0,10),  
                  pagination: false,
                  pageSize: 10,
                  singleSelect: true,
                  pageList: [10,25,50], 
                  fitColumns:true,
                  idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
                  loadMsg:'loading...',
                  columns: [[
	                      { field: 'name', title: '<spring:message code="package.itemname" />',align:"center",width:100},
	                      { field: 'totalprice', title: '<spring:message code="package.pacakge.price" />',align:"right",width:50},	           
 		                  { field: 'stbno', title: '<spring:message code="stb.stbno" />',align:"center",width:100},
 		                  //{ field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag" />',width:50,align:"center",formatter:formatMothercardflagForStb},
  		                  //{ field: 'mothercardid', title: '<spring:message code="userstb.mothercardid" />',width:200,align:"center",formatter:formatMothercardid},
						  { field:'id',title:'<spring:message code="page.operate" />',width:100,align:"center", formatter:formatOperationForStb}          
                  ]]
              });
              var pager = $("#buyingStbInfo").datagrid("getPager");  
				            pager.pagination({  
				            	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
					            afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
					         	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>",
				                total:data.length,
				                onSelectPage:function (pageNo, pageSize) {  
				                    var start = (pageNo - 1) * pageSize;  
				                    var end = start + pageSize;  
				                    $("#buyingStbInfo").datagrid("loadData", data.slice(start, end));  
				                    	pager.pagination('refresh', {  
				                        total:data.length,  
				                        pageNumber:pageNo  
				                    });  
				                }  
				            });  
 				}
		
			function initDatagridForCard(data){
	             $('#buyingCardInfo').datagrid({
	                  title: '<spring:message code="package.service.card" />',
	                  data:data.slice(0,10),  
	                  pagination: false,
	                  pageSize: 10,
	                  singleSelect: true,
	                  pageList: [10,25,50], 
	                  fitColumns:true,
	                  idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	                  loadMsg:'loading...',
	                  columns: [[
	                      { field: 'name', title: '<spring:message code="package.itemname" />',align:"center",width:100 },
	                      { field: 'totalprice', title: '<spring:message code="package.pacakge.price" />',align:"right",width:50},
	                 	  { field: 'cardid', title: '<spring:message code="card.cardid" />',align:"center",width:100},
  		                  { field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag" />',width:50,align:"center",formatter:formatMothercardflagForCard},
  		                  { field: 'mothercardid', title: '<spring:message code="usercard.mothercardid" />',align:"center",width:200,formatter:formatMothercardIdForCard},
  		                  { field: 'stbno', title: '<spring:message code="card.stbno" />',align:"center",width:200,
  		                	       //formatter:formatStbnoForCard
  		                  },
  		                  { field:'id',title:'<spring:message code="page.operate" />',align:"center", formatter:formatOperationForCard}          
   						//{ field: 'netid', title: '<spring:message code="netid" />',align:"center"},
  		           		//{ field: 'serverid', title: '<spring:message code="serverid" />',align:"center"},
                   		//{ field: 'incardflag', title: '<spring:message code="incardflag" />',align:"center"},
		         			//{ field: 'mothercardflag', title: '<spring:message code="usercard.mothercardflag" />',align:"center",width:100,formatter:formatMothercardflagForCard},
	                  ]]
	              });
	             
	             var pager = $("#buyingCardInfo").datagrid("getPager");  
		            pager.pagination({  
		            	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
			            afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
			         	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>",
		                total:data.length,  
		                onSelectPage:function (pageNo, pageSize) {  
		                    var start = (pageNo - 1) * pageSize;  
		                    var end = start + pageSize;  
		                    $("#buyingCardInfo").datagrid("loadData", data.slice(start, end));  
		                    	pager.pagination('refresh', {  
		                        total:data.length,  
		                        pageNumber:pageNo  
		                    });  
		                }  
		            });  
	 	}
		 				
		function initTreegridForProduct(){
				$('#tg').treegrid({
				//	width:950,
				//	height:250,
					animate:true,
					collapsible:true,
					fitColumns:true,
					showFooter: true,
					data:packageProduct,
					method: 'get',
					idField:'id',
					treeField:'name',
					columns:[[
		                {title:'<spring:message code="package.treegrid.service" />',width:100,align:'left',field:'name'},
						{title:'<spring:message code="package.treegrid.description" />',width:150,align:'center',field:'detail'},
						{title:'<spring:message code="package.pacakge.price" />',width:80,align:'right',field:'totalprice'},
						{title:'<spring:message code="package.binding.terminaltype" />',width:80,align:'center',field:'terminaltype',formatter:treegridFormatterForTerminaltype},
						{title:'<spring:message code="package.binding.terminalid" />',width:80,align:'center',field:'terminalid'},
						{title:'<spring:message code="page.operate" />',width:80,align:'center',field:'root',formatter:formatOperationForProduct}
					]]
				});
			}
		 
		  function initDatagridForProductBinding(data){
	             $('#terminalsForProductBinding').datagrid({
	                //  title: '<spring:message code="package.terminal.select" />',
	                  data:data.slice(0,5),  
	                  pagination: true,
	                  pageSize: 5,
	                  singleSelect: true,
	                  pageList: [5,10,25], 
	                  fitColumns:true,
	                  idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	                  loadMsg:'loading...',
	                  columns: [[
	                      { field: 'terminaltype', title: '<spring:message code="user.terminaltype" />',align:"right", width:75, formatter:productbindingFormatterForTerminaltype}, //终端类型（0-机顶盒号；1-智能卡号）
	                 	  { field: 'terminalid', title: '<spring:message code="user.terminalid" />',align:"center",width:175},
					  	  { field:'id',title:'<spring:message code="page.operate" />',align:"center", formatter:formatOperationForProductBinding,width:100}          
	                  ]]
	              });
	              var pager = $("#terminalsForProductBinding").datagrid("getPager");  
					            pager.pagination({  
					            	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
						            afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
						         	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>",
					                total:data.length,  
					                onSelectPage:function (pageNo, pageSize) {  
						                    var start = (pageNo - 1) * pageSize;  
						                    var end = start + pageSize;  
						                    $("#terminalsForProductBinding").datagrid("loadData", data.slice(start, end));  
						                    pager.pagination('refresh', { total:data.length,pageNumber:pageNo});  
					                }  
					            });   
	 				}
					
			function initStbsForChoose(data){
	             $('#stbsForChoose').datagrid({
	                //  title: '<spring:message code="package.terminal.select" />',
	                  data:data.slice(0,5),  
	                  pagination: true,
	                  pageSize: 5,
	                  singleSelect: true,
	                  pageList: [5,10,25], 
	                  fitColumns:true,
	                  idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	                  loadMsg:'loading...',
	                  columns: [[
	                 	  { field: 'terminalid', title: '<spring:message code="stb.stbno" />',align:"center",width:175},
					  	  { field:'id',title:'<spring:message code="page.operate" />',align:"center", formatter:formatOperationStbChoose,width:100}          
	                  ]]
	              });
	              var pager = $("#stbsForChoose").datagrid("getPager");  
					            pager.pagination({  
					            	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
						            afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
						         	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>",
					                total:data.length,  
					                onSelectPage:function (pageNo, pageSize) {  
						                    var start = (pageNo - 1) * pageSize;  
						                    var end = start + pageSize;  
						                    $("#terminalsForProductBinding").datagrid("loadData", data.slice(start, end));  
						                    pager.pagination('refresh', { total:data.length,pageNumber:pageNo});  
					                }  
					            });   
	 				}	

			function initCardsForChoose(data){
	             $('#cardsForChoose').datagrid({
	                //  title: '<spring:message code="package.terminal.select" />',
	                  data:data.slice(0,10),  
	                  pagination: false,
	                  pageSize: 5,
	                  singleSelect: true,
	                  pageList: [5,10,25], 
	                  fitColumns:true,
	                  idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	                  loadMsg:'loading...',
	                  columns: [[
	                 	  { field: 'terminalid', title: '<spring:message code="card.cardid" />',align:"center",width:175},
					  	  { field:'id',title:'<spring:message code="page.operate" />',align:"center", formatter:formatOperationCardChoose,width:100}          
	                  ]]
	              });
	              var pager = $("#cardsForChoose").datagrid("getPager");  
			            pager.pagination({  
			                total:data.length,  
			                onSelectPage:function (pageNo, pageSize){  
			                	
				                    var start = (pageNo - 1) * pageSize;  
				                    var end = start + pageSize;  
				                    $("#terminalsForProductBinding").datagrid("loadData", data.slice(start, end));  
				                    pager.pagination('refresh', { total:data.length,pageNumber:pageNo});  
			                }  
			            });   
	 				}						
	 				
	 	//EASYUI FORMATTER
		function formatStbnoForCard(value,row,index){
			var formatter = '<a class="btn-edit" onclick="openChooseStbWindow('+ index +')"><spring:message code="选择机顶盒"/></a>';
			if(row.stbno != "" && row.stbno !=undefined ){
				return row.stbno + formatter;
			}else{
				return formatter;
			}
		}

	 	function formatOperationForProductBinding(value,row,index){
	 		return  '<a style="color:blue" href="javascript:chooseTerminal('+ index +')">'+'<spring:message code="package.terminal.select" />'+'</a>';
	 	}

		function formatOperationForProduct(value,row,index){
			return row.root ? '<a style="color:blue" href="javascript:openProductBindingWindow()">'+'<spring:message code="package.binding" />'+'</a>' : "-";
		}
		
	 	function formatOperationForStb(value,row,index){
			return '<a style="color:blue" href="javascript:addStb(' +row.incardflag + ')">'+'<spring:message code="package.terminal.select" />'+'</a>';
		}
		
		//  cardid  mothercardflag mothercardid
		function formatCardidForStb(value,row,index){
			return row.incardflag == "1" ? row.cardid : "-";
		}
		
	 	function formatMothercardid(value,row,index){
			return row.mothercardflag == "1" ? row.mothercardid : "-";
		}
		
	 	function formatMothercardflagForStb(value,row,index){
	 		var incardflag = row.incardflag;
	 		var flag = row.mothercardflag;
			var formatter = "-";
			if(incardflag == "2"){
				var i18n = flag == "0" ? '<spring:message code="userstb.mothercardflag.0"/>' : '<spring:message code="userstb.mothercardflag.1"/>';
				formatter = i18n;
				//formatter = i18n + '<a class="btn-edit" onclick="toggleMothercardFlag('+ index +')"><spring:message code="page.switch"/></a>';
				 //var d = '<a href="#" onclick="jsView(\''+row.modelId+'\',\''+row.description+'\')">查看</a>';  多个参数写法
			}
		   return formatter;
	  	}
	 	
		function formatMothercardflagForCard(value,row,index){
			var flag = row.mothercardflag;
			var formatter = "-";
			if(flag != "" && flag != undefined){
				var i18n = flag == "0" ? '<spring:message code="userstb.mothercardflag.0"/>' : '<spring:message code="userstb.mothercardflag.1"/>';
				formatter = i18n;
				 //formatter = i18n + '<a class="btn-edit" onclick="toggleMothercardFlag('+ index +')"><spring:message code="page.switch"/></a>';
				//var d = '<a href="#" onclick="jsView(\''+row.modelId+'\',\''+row.description+'\')">查看</a>';  多个参数写法
				
			}
		   return formatter;
	  	}
	  	
	  	function formatMothercardIdForCard(value,row,index){
			//alert(row.mothercardflag);
			row.mothercardid = row.mothercardid == undefined ? "" : row.mothercardid;
			return  row.mothercardflag == "1" ?  row.mothercardid+ '<a class="btn-edit" onclick="openChooseMothercardWindow('+ index +')"><spring:message code="page.select"/></a>' : '-';
	  	}
		
	 	function formatOperationForCard(value,row,index){
			return '<a style="color:blue" href="javascript:addCard();">'+ '<spring:message code="package.terminal.select" />' +'</a>';
		}
		
			function formatOperationCardChoose(value,row,index){
	 		return  '<a style="color:blue" href="javascript:chooseMothercard('+ index +')">'+'<spring:message code="page.select" />'+'</a>';
	 	}

			
		function formatOperationStbChoose(value,row,index){
	 		return  '<a style="color:blue" href="javascript:chooseStbnoForCard('+ index +')">'+'<spring:message code="page.select" />'+'</a>';
	 	}
			
		function treegridFormatterForTerminaltype(value,row,index){
		if(row.terminaltype == "0") {
				return '<spring:message code="package.service.stb"/>';
			}else if(row.terminaltype == "1"){
				return '<spring:message code="package.service.card"/>';
			}
		}
				
		function productbindingFormatterForTerminaltype(value,row,index){
				if(row.terminaltype == "0") {
					return '<spring:message code="package.service.stb"/>';
				}else if(row.terminaltype == "1"){
					return '<spring:message code="package.service.card"/>';
				}
			}
		 
	 	//页面控制函数
	 	function chooseStbnoForCard(index){
			var choose_row =   $("#stbsForChoose").datagrid("getRows")[index];
			var row = $("#buyingCardInfo").datagrid("getSelected");  
			var index = $("#buyingCardInfo").datagrid("getRowIndex", row);
			row.stbno = choose_row.terminalid;
		   $("#buyingCardInfo").datagrid("updateRow", {index: index});
		 	$('#buyingCardInfo').datagrid('refreshRow',index);
			$('#chooseStbForCard').window('close');  
		}
		 		 
 		function chooseMothercard(index){
 			var choose_row =   $("#cardsForChoose").datagrid("getRows")[index];
			var row = $("#buyingCardInfo").datagrid("getSelected");  
			var index = $("#buyingCardInfo").datagrid("getRowIndex", row);
			row.mothercardid = choose_row.terminalid;
		   $("#buyingCardInfo").datagrid("updateRow", {index: index});
		 	$('#buyingCardInfo').datagrid('refreshRow',index);
			$('#chooseMothercardForCard').window('close');  
 		}
	
		function openChooseStbWindow(){
			if(initStbDataForChoose()){
				$("#chooseStbForCard").window('open');
				initStbsForChoose(stbsForCard);
			}else{
				alert( '<spring:message code="package.stbinfo.empty"/>');
			}
		}
		
		function openChooseMothercardWindow(){
			if(initMothercardDataForChoose()){
				$("#chooseMothercardForCard").window('open');
				initCardsForChoose(mothercardForCard);
			}else{
				alert('<spring:message code="package.cardinfo.empty"/>');
			}
		}	
	    
		 //初始化选择机顶盒数据
		function initStbDataForChoose(){
	    	 stbsForCard = [];
			 //初始化已经购买的机顶盒数据
	    	 if($("#userstbsJson").val()!= undefined && $("#userstbsJson").val()!= "" ){
			 	var userstbJson = JSON.parse($("#userstbsJson").val()).rows;
			 	if(!pushStbsForCard(userstbJson)){return false;}
			 }		
			 //初始化页面正在购买的机顶盒数据
			 if(!pushStbsForCard(packageStb)){return false;}
 			 return true;
		}
	
	    //初始化选择母卡数据
		function initMothercardDataForChoose(){
			mothercardForCard = [];
			//封装订户已经购买的智能卡数据
			if($("#usercardsJson").val()!= undefined && $("#usercardsJson").val()!= "" ){
				var usercardsJson = JSON.parse($("#usercardsJson").val()).rows;
				if(!pushMothercard(usercardsJson)){
					return false;
				}
			}
			//封装页面正在购买的智能卡数据
			if(!pushMothercard(packageCard)){
				return false;
			}
 			return true;
		}
	
		function pushMothercard(data){
			 for(var i=0; i<data.length; i++){
				 if(data[i].cardid == undefined){return false;}
				 //只封装主机的智能卡号
				 if(data[i].mothercardflag == "0"){
					var card = {};
					card['id'] = data[i].id;
					card['terminaltype'] = "1";
					card['terminalid'] = data[i].cardid;
					mothercardForCard.push(card);
				 }
				 return true;
			}
		}
		
		function pushStbsForCard(data){
				for(var i = 0; i<data.length; i++){
		       			if(data[i].stbno == undefined && data[i].incardflag != "0"){return false;}
						if(data[i].incardflag == "0"){
				       			var stb = {};
				       			stb['id'] = data[i].id;
				       			stb['terminaltype'] =  "0"; //终端类型（0-机顶盒号；1-智能卡号）
					 			stb['terminalid'] = data[i].stbno;
					 			stbsForCard.push(stb);
						}
			 	}
			 	return true;
		}
		

		function openProductBindingWindow(){
			if(terminalsForProductBindingInit()){
				$("#productBinding").window('open');
				initDatagridForProductBinding(terminalsForProductBinding);
			}else{
				alert('<spring:message code="package.terminal.notselected"/>');
			}
		}		
	 	
	 	function pushTerminalStb(data){
	 		for(var i = 0; i<data.length; i++){
	       			if(data[i].stbno == undefined && data[i].incardflag != "0"){
	       				return false;
	       			}
					if(data[i].incardflag == "2"){//无卡机顶盒
			       			var stb = {};
			       			stb['id'] = data[i].id;
			       			stb['terminaltype'] =  "0"; //终端类型（0-机顶盒号；1-智能卡号）
				 			stb['terminalid'] = data[i].stbno;
				 			terminalsForProductBinding.push(stb);
					}
		 	}
		 	return true;
	 	}
	 		
	 	function pushTerminalCard(data){
			 for(var i=0; i<data.length; i++){
				 if(data[i].cardid == undefined){return false;}
				 	var card = {};
				 	card['id'] = data[i].id;
				 	card['terminaltype'] = "1";
				 	card['terminalid'] = data[i].cardid;
				 	terminalsForProductBinding.push(card);
			 	}
			 	return true;
	 	}
	 	
	 	function terminalsForProductBindingInit(){
				terminalsForProductBinding = [];
				if($("#userstbsJson").val()!= undefined &&$("#userstbsJson").val()!= "" ){
					var userstbJson = JSON.parse($("#userstbsJson").val()).rows;
					if(!pushTerminalStb(userstbJson)){
						return false;
					}
				}
				if($("#usercardsJson").val()!= undefined &&$("#usercardsJson").val()!= "" ){
					var usercardsJson = JSON.parse($("#usercardsJson").val()).rows;
					if(!pushTerminalCard(usercardsJson)){
						return false;
					}
				}
				if(!pushTerminalStb(packageStb)){
					return false;
				}
				if(!pushTerminalCard(packageCard)){
					return false;
				}
	 			return true;
	 	}
		
		 //选择窗口
		function selectUser() {
		    selectUserDialog = $.dialog({
			    title: '<spring:message code="menu.business.userquery"/>',
			    lock: true,
			    width: 960,
			    height: 600,
			    top: 0,
			    drag: false,
			    resize: false,
			    max: false,
			    min: false,
			    content: 'url:package/findUserListForDialog' 
			});
		 }

		function closeDialog(data){
			selectUserDialog.close();
		 	$('#selectUser').panel({    
			   href:'package/selectUser?id='+ data,    
			  	onLoad:function(){    
				 // alert($("#userid").val());
			    }       
			});     
		}
		
		//选择机顶盒号
		function addStb(incardflag) {
			
			var querynetid;
			
			if('${package.type}' == "0"){
	  		 	  if ($('#netid').combobox('getValue') == '') {
				      $.dialog.tips('<spring:message code="network.netid.empty"/>', 1, 'alert.gif');
				      $('#netid').focus();
				      return;
				  }
				  querynetid = $('#netid').combobox('getValue');
	  		  }else{
		  		  if($("#userid").val() == undefined){
		  		 		$.dialog.tips('<spring:message code="package.user.empty"/>', 1, 'alert.gif');
		  		  		return;
		  		  }
		  		querynetid = $('#netid').val();  
	  		}
			
		    stbDialog = $.dialog({
			    title: '<spring:message code="stb.stbquery"/>',
			    lock: true,
			    width: 800,
			    height: 500,
			    top: 0,
			    drag: false,
			    resize: false,
			    max: false,
			    min: false,
			    content: 'url:package/findStbListForDialog?querystate=0&querynetid=' + querynetid
			}); 
		}
		 
		function addCard() {
			
			var querynetid;
			
			if('${package.type}' == "0"){
	  		 	  if ($('#netid').combobox('getValue') == '') {
				      $.dialog.tips('<spring:message code="network.netid.empty"/>', 1, 'alert.gif');
				      $('#netid').focus();
				      return;
				  }
				  querynetid = $('#netid').combobox('getValue');
	  		  }else{
		  		  if($("#userid").val() == undefined){
		  		 		$.dialog.tips('<spring:message code="package.user.empty"/>', 1, 'alert.gif');
		  		  		return;
		  		  }
		  		querynetid = $('#netid').val();  
	  		}	
			
		   cardDialog = $.dialog({
			    title: '<spring:message code="card.cardquery"/>',
			    lock: true,
			    width: 800,
			    height: 500,
			    top: 0,
			    drag: false,
			    resize: false,
			    max: false,
			    min: false,
			    content: 'url:package/findCardListForDialog?querystate=0&querynetid=' + querynetid
		   });
		}
		 
		 //业务保存
		function saveUser(){
				packageUser[0].netid = new Number($("#netid").combobox('getValue'));
				packageUser[0].areacode = $('#areacode').combotree('getValue');
				packageUser[0].username =  $("#username").val();
				packageUser[0].mobile = $("#username").val();
				packageUser[0].telephone= $("#telephone").val();
				packageUser[0].email=$("#email").val();
				packageUser[0].documenttype=  $("#documenttype").val();
				packageUser[0].documentno= $("#documentno").val();
				packageUser[0].address= $("#address").val();
				packageUser[0].password= $("#password").val();
		 }
         
		 //关闭机顶盒选择界面，刷新机顶盒JSON
		 function closeStbDialog(data){
			 	
			   stbDialog.close();
			   var dataArray = data.split("+");   
			   
			    //判断是否已经选择了该机顶盒,如果已经选择，就不能选择了
				var rows = $("#buyingStbInfo").datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					if(dataArray[2] == rows[i].stbno){
						$.dialog.tips('<spring:message code="userstb.buyingstbno.existed"/>', 2, 'alert.gif');
		  		  		return;
					}
				}
			     
				var row = $("#buyingStbInfo").datagrid("getSelected");  
				var index = $("#buyingStbInfo").datagrid("getRowIndex", row);
				//data:   netid + serverid + stbno + incardflag + cardid
				
				row.netid = dataArray[0];
				row.serverid = dataArray[1];
				row.stbno = dataArray[2];
				row.incardflag = dataArray[3];
				//row.cardid = dataArray[4];
				row.mothercardflag = row.incardflag== "2" ?  "0" : "";
				//alert(JSON.stringify(row));
				
				$('#buyingStbInfo').datagrid('updateRow',{index: index});
				$('#buyingStbInfo').datagrid('refreshRow',index);
				
				if(serviceids.indexOf("2") > 0){
					var row = $("#buyingCardInfo").datagrid("getData").rows[index];
					if(row != null && row != ''){
						row.netid = dataArray[0];
						row.serverid = dataArray[1];
						row.stbno = dataArray[2];
						row.incardflag = dataArray[3];
						row.cardid = dataArray[4];
					  	$('#buyingCardInfo').datagrid('updateRow',{index: index});
					  	$('#buyingCardInfo').datagrid('refreshRow',index);
					}
				}
		}
		
		function toggleMothercardFlag(index){
				var row =   $("#buyingStbInfo").datagrid("getRows")[index];
				row.mothercardflag = row.mothercardflag=="0" ? "1" : "0";
			     $("#buyingStbInfo").datagrid("updateRow", {index: index});
				 $('#buyingStbInfo').datagrid('refreshRow',index);
		}
		
		//关闭选择智能卡界面
	    function closeCardDialog(data){
				cardDialog.close();
				
				 var dataArray = data.split("+");   
				//判断是否已经选择了该机顶盒,如果已经选择，就不能选择了
				var rows = $("#buyingCardInfo").datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					if(dataArray[2] == rows[i].cardid){
						$.dialog.tips('<spring:message code="usercard.buyingcardid.existed"/>', 2, 'alert.gif');
		  		  		return;
					}
				}
				
				var row = $("#buyingCardInfo").datagrid("getSelected");  
				var index = $("#buyingCardInfo").datagrid("getRowIndex", row);
				//data: netid + serverid + cardid
				var dataArray = data.split("+");
				row.netid = dataArray[0];
				row.serverid = dataArray[1];
				row.cardid = dataArray[2];
				row.incardflag = dataArray[3];
			  	$('#buyingCardInfo').datagrid('updateRow',{index: index});
			  	$('#buyingCardInfo').datagrid('refreshRow',index);
		}
		
		function chooseTerminal(index){
			var choose_row =   $("#terminalsForProductBinding").datagrid("getRows")[index];
			var update_row = $("#tg").treegrid("getSelected");  
			$('#tg').treegrid('update',{id: update_row.id,row: {terminaltype: choose_row.terminaltype,terminalid: choose_row.terminalid}});
			$('#tg').treegrid('refresh', update_row.id);
			$('#productBinding').window('close');  
			}
		
		
	    </script>
</body>
</html>