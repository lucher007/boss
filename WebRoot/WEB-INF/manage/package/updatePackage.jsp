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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.product.package" />&gt;<spring:message code="package.manage.add"/></div>
		<div style="margin:10px 0;"></div>
		
		<form action="" method="post" id="packageForm" name="packageForm">
			<input type="hidden" name="id" id="id" value="${package.pack.id}"/>
		    <input type="hidden" name="querynetid" id="querynetid" value="${package.querynetid}"/>
		    <input type="hidden" name="queryname" id="queryname" value="${package.queryname}"/>
		    <input type="hidden" name="pager_offset" id="pager_offset" value="${package.pager_offset }"/>
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:950px">
				<table width="100%">
				<tr height="30px">
						<td align="right" width="15%"><spring:message code="network.netname"/>：</td>
						<td width="30%">
							<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${package.network.netname }">
							<input type="hidden" name="netid" id="netid" value="${package.pack.netid }"/>
						</td>
						<td align="right"><spring:message code="package.name"/>：</td>
						<td>
					          <input type="text" class="inp" name="name" id="name" style="width: 300px;" value="${package.pack.name}" /> <span class="red">*</span>
						</td>
						<!-- <td align="right" width="120px"><spring:message code="package.type"/>：</td>
						<td colspan="2">
							<select id="type" name="type" class="select" style="width:157px;" onchange="initStbtype();">
									<option value="0"><spring:message code="package.type.0"/></option>
									<option value="1"><spring:message code="package.type.1"/></option>
 							</select>
						</td> -->
				</tr>
				
				<!-- 
				<tr height="30px">
						<td align="right" width="120px"><spring:message code="package.customer.type"/>：</td>
						<td>
							<select id="usertype" name="usertype" class="select" style="width:157px;" onchange="initStbtype();">
									<option value="0"><spring:message code="package.customer.type.0"/></option>
									<option value="1"><spring:message code="package.customer.type.1"/></option>
 							</select>
						</td>
				</tr> 

				<tr height="30px">
						<td align="right"><spring:message code="authorize.area.target"/>：</td>
						<td> 
							<select id="areacode_option" name="areacode_option" onchange="areacode_optionInit();" class="select">
				                   <option value="0"><spring:message code="authorize.area.target.0" /></option>
				                   <option value="1"><spring:message code="authorize.area.target.1" /></option>
				             </select>
						</td>
					
						<td align="right" class="inputarea"><spring:message code="area.areacode" />：</td>
						<td colspan="2" class="inputarea">
							<input type="text" class="inp w200" name="areacode" id="areacode" readonly="readonly" style="background:#eeeeee;" value="${stbdefaultmsg.areano }">
							<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseArea();">
						</td>
				</tr>
 				-->
				<tr height="30px">
						<td align="right"><spring:message code="package.starttime"/>：</td>
						<td>
							<input type="text" id="starttime" name="starttime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w200" style="width: 180px;" value="${fn:substring(package.pack.starttime, 0, 10)}"/>
							<span class="red">*</span>
						</td>
					
						<td align="right"><spring:message code="package.endtime"/>：</td>
						<td>
							<input type="text" id="endtime" name="endtime" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w200" style="width: 180px;" value="${fn:substring(package.pack.endtime, 0, 10)}"/>
							<span class="red">*</span>
						</td>
				</tr>
				 
				</table>
			</div>

			<div style="margin:10px 0;"></div>
			<div id="add_service">
				<div class="easyui-panel" title="<spring:message code="package.service.add"/>" style="width:950px">
					<table width="100%">
						<tr height="30px">
							<td align="center"><a href="javascript:openWindow('openAccount');" style="width:120px" class="easyui-linkbutton"><spring:message code="package.service.openaccount"/></a></td>
							<td align="center"><a href="javascript:openWindow('stb');" style="width:120px" class="easyui-linkbutton"><spring:message code="package.service.stb"/></a></td>
							<td align="center"><a href="javascript:openWindow('card');" style="width:120px" class="easyui-linkbutton"><spring:message code="package.service.card"/></a></td>
						</tr>
						
						<tr height="30px">
							<td align="center"><a href="javascript:openWindow('productPackage');" style="width:120px" class="easyui-linkbutton"><spring:message code="package.service.productpackage"/></a></td>
							<td align="center"><a href="javascript:openWindow('recharge');" style="width:120px" class="easyui-linkbutton"><spring:message code="package.service.recharge"/></a></td>
						</tr>	
					</table>
				</div>
			</div>
			<div style="margin:10px 0;"></div>
			<table title="<spring:message code="package.content"/>" id="tg"></table>
			<input type="hidden" id="package_json" name="package_json"/>
		</form>
			
			<div style="margin:10px 0;"></div>
			<div align="center">
				<a href="javascript:goBack();" class="easyui-linkbutton"><spring:message code="page.goback"/></a>
				<a href="javascript:savePackage();" class="easyui-linkbutton"><spring:message code="page.save"/></a>
			</div>
	
			<!-- 5个业务的隐藏弹窗 -->
			<!-- 	1.开户窗口 -->			
			<div id="openAccount" class="easyui-window" title="<spring:message code="package.service.openaccount"/>" closed="true" style="width:480px;height:200px;">
			<form style="padding:10px 20px 10px 40px;">
				<table width="100%">
						<tr>
							<td align="right"><spring:message code="package.openaccount.price" />：</td>
							<td><input type="text" class="inp" id="openAccountPrice" name="openAccountPrice" 
								onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10" ></td>
						</tr>
				</table>
				
				<div style="margin:20px 0;"></div>
				
				<div style="padding:5px;text-align:center;">
					<a onclick="saveOpenAccount(this)" style="width:60px" class="easyui-linkbutton"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this)"style="width:60px"  class="easyui-linkbutton"><spring:message code="page.cancel"/></a>
				</div>
			</form>
		
			</div>
			
			<!-- 	2.机顶盒窗口-->			
			<div id="stb" class="easyui-window" title="<spring:message code="package.service.stb"/>"  closed="true" style="width:480px;height:200px;">
			<form style="padding:10px 20px 10px 40px;">
					<table width="100%">
							<!--
							<tr height="30px">
								<td align="right" width="120px"><spring:message code="package.stb.stbtype"/>：</td>
								<td>
									 <select id="incardflag" name="incardflag" class="select">
										 <option value="0"><spring:message code="stb.incardflag.0"/></option>
						                 <option value="1"><spring:message code="stb.incardflag.1"/></option>
						             	 <option value="2"><spring:message code="stb.incardflag.2"/></option>
						             </select>
								</td>
							</tr>
							  -->
							<tr height="30px">
								<td align="right"><spring:message code="package.stb.price"/>：</td>
								<td>
									<input type="text" class="inp" name="stbPrice" id="stbPrice" 
										onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10">
								</td>
							</tr>
					</table>
					<div style="margin:20px 0;"></div>
						
				<div style="padding:5px;text-align:center;">
					<a onclick="saveStb(this);"class="easyui-linkbutton" style="width:60px"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this)" class="easyui-linkbutton" style="width:60px"><spring:message code="page.cancel"/></a>
				</div>
			</form>
			</div>
			
			<!--智能卡卡窗口-->			
			<div id="card" class="easyui-window" title="<spring:message code="package.service.card"/>" closed="true" style="width:480px;height:200px;">
			<form style="padding:10px 20px 10px 40px;">
				<table width="100%">
						<tr height="30px">
							<td align="right" width="120px"><spring:message code="package.card.cardtype"/>：</td>
							<td>
								 <select id="cardtype" name="cardtype" class="select">
									 <option value="0"><spring:message code="package.card.cardtype.0"/></option>
					                 <option value="1"><spring:message code="package.card.cardtype.1"/></option>
					             </select>
							</td>
						</tr>
						<tr height="30px">
							<td align="right"><spring:message code="package.card.price"/>：</td>
							<td><input type="text" class="inp w200" name="cardPrice" id="cardPrice"
							onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10">
							</td>
						</tr>
				</table>
				<div style="margin:20px 0;"></div>
				<div style="padding:5px;text-align:center;">
					<a onclick="saveCard(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.cancel"/></a>
				</div>
			</form>
			</div>
			
				<!-- 	4.节目套餐窗口-->			
			<div id="productPackage" class="easyui-window" title="<spring:message code="package.service.productpackage"/>" closed="true" style="width:800px;height:600px;">
			<form style="padding:10px 20px 10px 40px;">
				<input type="hidden" name="productPackagePrice" id="productPackagePrice" value="0" readonly = "readonly">
				<table id="productPackage_Data"></table>
				<div style="margin:20px 0;"></div>
				<table width="100%">
					<tr>
						<td align="right" width="10%"><spring:message code="package.product.excuteprice" />：</td>
						<td align="left" width="30%"><input type="text" class="inp w200" id="setprice" name="setprice" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"> <span class="red">*</span></td>
						<td align="rigth" width="10%"><spring:message code="package.product.authorize_duration" />：</td>
						<td align="left" width="30%"><input type="text" class="inp w200" id="month" name="month" maxlength="3" 
			            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
			            	onafterpaste="this.value=this.value.replace(/\D/g,'')" ><span class="red">*</span></td>
					</tr>
				</table>
				<div style="margin:20px 0;"></div>
				<div style="padding:5px;text-align:center;">
					<a onclick="saveProductPackage(this);"class="easyui-linkbutton" style="width:60px"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this);" class="easyui-linkbutton" style="width:60px"><spring:message code="page.cancel"/></a>
				</div>
			</form>
			</div>
	
			<!-- 	5.充值窗口-->			
			<div id="recharge" class="easyui-window" title="<spring:message code="package.service.recharge"/>"  closed="true" style="width:350px;height:200px;">
			<form style="padding:10px 20px 10px 40px;">
				<p><spring:message code="pakcage.recharge.rechargeamount" />：<input type="text" class="inp w200" id="rechargemoney" name="rechargemoney" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"></p>
				<p><spring:message code="pakcage.recharge.paymoney" />：<input type="text" class="inp w200" id="shouldmoney" name="shouldmoney" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" maxlength="10"></p>
				<div style="padding:5px;text-align:center;">
					<a onclick="saveRecharge(this);" class="easyui-linkbutton" style="width:60px"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this)" class="easyui-linkbutton" style="width:60px"><spring:message code="page.cancel"/></a>
				</div>
			</form>
			</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
 	<script type="text/javascript" src="js/form.js"></script>
 	<script type="text/javascript">

 	var cards_index = 1;
	var openAccount_index = 1;
	var stb_index = 1;
	var recharge_index = 1;
	var productPackage_index = 1;
	var editIndex = undefined;
	var areaDialog;
	//alert('${package.pack.package_json}');
	var jsonObject =  eval("(" + '${package.pack.package_json}' +")");
	var packageJson ={"rows":jsonObject.rows, "footer":[{"name":'<spring:message code="package.treegrid.totalprice"/>',"totalprice":0.00}]};
	 packageJson.footer[0].totalprice = getPackageTotalPrice();
	
	var dataForProductpackage = [];
	var servicenameJson = {
		 "1" : '<spring:message code="package.service.openaccount"/>',
		 "2" : '<spring:message code="package.service.stb"/>',
		 "3" : '<spring:message code="package.service.card"/>',
		 "4" : '<spring:message code="package.service.productpackage"/>',
		 "5" : '<spring:message code="package.service.recharge"/>'
     };	
 	
 	
    //保存套餐
 	function savePackage() {
		//alert(JSON.stringify(packageJson));	
		
		//将套餐json复制给package_json,方便后台取值
		$("#package_json").val(JSON.stringify(packageJson));
		
		if ($('#netid').val() == null || $('#netid').val() == '') {
 		      $.dialog.tips('<spring:message code="card.netid.empty"/>', 1, 'alert.gif');
 		      $('#netid').focus();
 		      return;
		}
		
		if ($('#name').val() == null || $('#name').val() == '') {
		      $.dialog.tips('<spring:message code="package.name.empty"/>', 1, 'alert.gif');
		      $('#name').focus();
		      return;
		}
		
		if ($('#starttime').val() == '' || $('#endtime').val() == '') {
		      $.dialog.tips('<spring:message code="authorize.duration.empty"/>', 1, 'alert.gif');
		      return;
		 }
	 	$("#packageForm").attr("action", "package/update").submit();
	};
				
	function goBack(){
		$("#packageForm").attr("action", "package/findByList").submit();
	}

	//保存开户费用
	function saveOpenAccount(obj){   //1111
			deleteServiceByKeyId("1");  //一个套餐内只能有一个开户 去掉这行允许多个开户
			var openAccount = {};
			openAccount['id']="1."+ openAccount_index;   //    1开户 2智能卡 3机顶盒 4节目套餐 5充值
			openAccount_index++;
			openAccount['name'] = '<spring:message code="package.service.openaccount"/>';
			openAccount['price'] = new Number($('#openAccountPrice').val());
			openAccount['totalprice'] = openAccount['price'];
			openAccount['detail'] = '<spring:message code="package.openaccount.price"/>:' + openAccount['totalprice'];
			//开户内容
			var service = findServiceById("1");
			service.children.push(openAccount);
      		//刷新开户费用
			saveService(obj);
	}
		
	function saveStb(obj){   //2222
			//var incardflag = $('#incardflag').val();
			var stb = {};
			stb['price'] = new Number($('#stbPrice').val());
			stb['totalprice'] = stb['price'];
			stb['detail'] = '<spring:message code="package.stb.price"/>:' + stb['totalprice'];
			//var stbtype='';
			//if(incardflag == "0"){
			//  stbtype = '<spring:message code="stb.incardflag.0"/>';
			//}else if (incardflag == "1"){
			//	stbtype = '<spring:message code="stb.incardflag.1"/>';
			//}else if (incardflag == "2"){
			//  stbtype = '<spring:message code="stb.incardflag.2"/>';
			//}
			
			stb['name'] = '<spring:message code="package.service.stb" />';
      		stb['id'] = "2."+ stb_index;   //    1开户 2机顶盒 3智能卡 4节目套餐 5充值
   			//stb['incardflag'] = incardflag;
   			stb_index++;
      		findServiceById("2").children.push(stb);
      		saveService(obj);
		}
		
		function saveCard(obj){  //333333
				var card = {};
				card['price'] = new Number($('#cardPrice').val());
				card['totalprice'] = card['price'];
				card['detail'] = '<spring:message code="package.card.price"/>:' + card['totalprice'];
				card['mothercardflag'] =  $('#cardtype').val(); //0母卡1子卡
				card['name'] = card['mothercardflag'] == 0 ?  '<spring:message code="package.service.card" />' +'(' + '<spring:message code= "package.card.cardtype.0"/>' + ')' 
																		 : '<spring:message code="package.service.card" />' +'(' + '<spring:message code= "package.card.cardtype.1"/>' + ')' ;
       			card['id'] = "3."+ cards_index;   //   1开户 2机顶盒 3智能卡 4节目套餐 5充值
       			cards_index++;
       			findServiceById("3").children.push(card);
       		    saveService(obj);
		}
	
		function saveProductPackage(obj){   //4444
			   //获取页面选中的产品json信息
			   var rows = $('#productPackage_Data').datagrid('getSelections');
		       
			   if ($('#setprice').val() == null || $('#setprice').val() == '') {
		 		      $.dialog.tips('<spring:message code="package.setprice.empty"/>', 2, 'alert.gif');
		 		      $('#setprice').focus();
		 		      return;
	 		    }
			   
			   if ($('#month').val() == null || $('#month').val() == '') {
		 		      $.dialog.tips('<spring:message code="package.month.empty"/>', 1, 'alert.gif');
		 		      $('#month').focus();
		 		      return;
	 		    }
			   
			   for(var i=0; i<rows.length; i++){
					var product = {};
					product['productid'] = rows[i].productid;
					
					product['id'] = "4." + rows[i].productid;
					
					product['name'] = rows[i].productname;
					
					product['price'] = $('#setprice').val();
					product['count'] = $('#month').val(); //转化为字符串
					
					product['totalprice'] = (product['price'] * product['count']);
					
					product['detail'] = '<spring:message code="package.productpackage.price" />:' + product['price'] + " * " + product['count'];
					
					//去掉重复的产品，以最新的为主
// 					deleteServiceChildByChildId("4",product['id']);
					findServiceById("4").children.push(product);
					
	       		    saveService(obj);
			   }
		}
		
		function saveRecharge(obj){   //5555
				deleteServiceByKeyId("5");  //一个套餐内只能有一个充值每次添加删除之前的
				var recharge = {};
				recharge['id'] = "5."+ recharge_index;   //  1开户 2智能卡 3机顶盒 4节目套餐 5充值
				recharge_index++;
				recharge['name'] = '<spring:message code="package.service.recharge" />';
				recharge['totalprice'] =new Number($('#shouldmoney').val());
				recharge['rechargemoney'] =new Number($('#rechargemoney').val());
				recharge['detail'] = '<spring:message code="pakcage.recharge.rechargeamount" />:' + recharge['rechargemoney']  + ',<spring:message code="pakcage.recharge.paymoney" />:' + recharge['totalprice'];
				findServiceById("5").children.push(recharge);
       		    saveService(obj);
		}
    
	//计算总价
	function getPackageTotalPrice(){
		var packageTotalPrice = 0;
		for (var i=0; i < packageJson.rows.length; i++){
			for(var j=0; j<packageJson.rows[i].children.length; j ++){
				packageTotalPrice += packageJson.rows[i].children[j].totalprice;
			}
		}
		return packageTotalPrice;
	}

	  function sortid(a,b){  
              return new Number(a.id)-new Number(b.id); 
      }  

	  function saveService(obj){
		       
               packageJson.rows.sort(sortid);  
               
               packageJson.footer[0].totalprice = getPackageTotalPrice(); 
               
			   $('#tg').treegrid('loadData',packageJson);
			   
      		   closeWindow(obj);
	  }
		
	  function findServiceById(id){
			if(packageJson.rows.length != 0){
				
				for(var i = 0; i < packageJson.rows.length; i++){
					if(packageJson.rows[i].id == id){
						//alert("found it!");
						return packageJson.rows[i];
					}
				}
			}
			//alert("not found, create a new");
			var service = {};
			service['id'] = id;
			service['name'] = servicenameJson[id];
			service['children'] = [];
			packageJson.rows.push(service);
			return service;
		}

		$(function() {
				getProductList();
				initTreegrid();
				var returninfo = '${package.returninfo}';
				if (returninfo != '') {
					$.dialog.tips(returninfo, 1, 'alert.gif');
				}
		});

		function initDatagrid(data,datagridid){
            $('#' + datagridid).datagrid({
                 title: '<spring:message code="package.product.list" />',
                 data:data.slice(0,10),  
                 pagination: true,
                 singleSelect: false,
                 pageSize: 10,
                 pageList: [10,25,50], 
                 fitColumns:true,
                 //onClickCell:onClickCell,
                 idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
                 loadMsg:'loading...',
                 columns: [[
                     { field: 'id',width:100,align:"center",checkbox:true},
                     { field: 'productid', title: '<spring:message code="product.productid" />',width:100,align:"center"},
                     { field: 'productname', title: '<spring:message code="product.productname" />',width:100,align:"center" },
                     { field: 'pricepermonth', title: '<spring:message code="product.pricepermonth" />',width:100,align:"center"},
                     { field: 'subpricepermonth', title: '<spring:message code="product.subpricepermonth" />',width:100,align:"center"},
                     //{ field: 'setprice', title: '<spring:message code="package.product.excuteprice" />' ,editor:"text",width:100,align:"center",editor:{type:'numberbox',options:{precision:2}}},
                     //{ field: 'month', title: '<spring:message code="package.product.authorize_duration" />' ,editor:"text",width:100,align:"center",editor:'numberbox'}
                 ]]
             });
             var pager = $("#" + datagridid).datagrid("getPager");  
	            pager.pagination({  
	            	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
		            afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
		         	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>",
	            	total:data.length,  
	                onSelectPage:function (pageNo, pageSize) {  
				                    var start = (pageNo - 1) * pageSize;  
				                    var end = start + pageSize;  
				                    $("#" + datagridid).datagrid("loadData", data.slice(start, end));  
				                    	pager.pagination('refresh', {  
				                        total:data.length,  
				                        pageNumber:pageNo  
				                    });  
				                },
	            });  
		}
		
		function getProductList(){
	           $('#productPackage_Data').datagrid({
	                title: '<spring:message code="package.product.list" />',
	                url:'package/getProductList',
	                pagination: true,
		            queryParams: {
						querynetid: $("#querynetid").val(),
						querystate: '1',
					},
	                pageSize: 10,
	                singleSelect: false,
	                pageList: [10,25,50], 
	                fitColumns:true,
	                idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	                loadMsg:'loading...',
	                columns: [[
	                           { field: 'id',width:100,align:"center",checkbox:true},
	                           { field: 'productid', title: '<spring:message code="product.productid" />',width:100,align:"center"},
	                           { field: 'productname', title: '<spring:message code="product.productname" />',width:100,align:"center" },
	                           { field: 'pricepermonth', title: '<spring:message code="product.pricepermonth" />',width:100,align:"center"},
	                           { field: 'subpricepermonth', title: '<spring:message code="product.subpricepermonth" />',width:100,align:"center"},
	                ]]
	            });
	            var p = $('#productPackage_Data').datagrid('getPager');
		         $(p).pagination({
		          	beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
		          	afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
		       		displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
		         });
		}
		
	 	function initTreegrid(){
			$('#tg').treegrid({
				width:950,
				height:300,
				animate:true,
				collapsible:true,
				fitColumns:true,
				showFooter: true,
				data:packageJson,
				method: 'get',
				idField:'id',
				treeField:'name',
				columns:[[
	                {title:'<spring:message code="package.treegrid.service" />',width:100,align:'left',field:'name'},
					{title:'<spring:message code="package.treegrid.description" />',width:60,align:'center',field:'detail'},
					{title:'<spring:message code="package.treegrid.totalprice" />',width:80,align:'center',field:'totalprice'},
					{title:'<spring:message code="page.operate" />',width:80,align:'center',field:'id',
						formatter:function(val, row, index){ 
							var formatter = '<a class="btn-del" href="javascript:deleteServiceNode(\''+ val +'\')"><spring:message code="page.delete"/></a>';
							return formatter;
              	        },
              		},
				]]
			});
		}
	    
	 	
	 	//开启弹出框
		function openWindow(service_name){
			
			//节目套餐窗口，需要先赋值
			if(service_name == 'productPackage'){
				if ($('#netid').val() == null || $('#netid').val() == '') {
		 		      $.dialog.tips('<spring:message code="card.netid.empty"/>', 1, 'alert.gif');
		 		      $('#netid').focus();
		 		      return;
	 		    }
				$('#productPackage_Data').datagrid('reload',{
					querynetid: $("#querynetid").val(),
					querystate: '1',
				});
			}
			
			$('#'+service_name).window('open');
			
		}
		
		//关闭弹出框
		function  closeWindow(obj){
			$(obj).parents('.easyui-window').window('close');
			$("#package_json").val(JSON.stringify(packageJson));
		}
			
		function chooseArea() {
			areaDialog = $.dialog({
				title : '<spring:message code="authorize.area.choose"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:authorize/findAreaListForDialog'
			});
		}
		
		function closeDialog(areacode) {
			areaDialog.close();
			$("#areacode").val(areacode);
		}
	
		function areacode_optionInit() {
			if ($("#areacode_option").val() == "0") {
				$(".inputarea").show();
				$("#areacode").val("");
			} else {
				$("#areacode").val("ffffffff");
				$(".inputarea").hide();
			}
		};
	    
		
		//初始化产品列表信息
	 	function initProductData(){
	 		//每次加载，都先清空数组 
	 		dataForProductpackage.splice(0,dataForProductpackage.length);
 			var data = {
 				querynetid: $('#netid').val(),
 				querystate: '1',
			    rid: new Date().getTime(),
		    };
 			
          	$.getJSON('package/getProductList', data, function(productJson) {
		 	for ( var index in productJson.rows) {
					dataForProductpackage.push({
					"id": productJson.rows[index].id,
					"productid":productJson.rows[index].productid,
					"productname":productJson.rows[index].productname,
					"price":productJson.rows[index].price,
					"setprice":productJson.rows[index].setprice,
					"month":productJson.rows[index].month
					});
				}    //end for
				initDatagrid(dataForProductpackage,"productPackage_Data");
				});  //end getjson
	 	}
	 	
		function deleteServiceByKeyId(id){
			if(packageJson.rows.length != 0){
				for(var i = 0; i < packageJson.rows.length; i++){
					if(packageJson.rows[i].id == id){
						packageJson.rows.splice(i,1);
						return ;
					}
				}
			}
		}
		
		function deleteServiceChildByChildId(id,childid){
			if(packageJson.rows.length != 0){
				//循环业务层
				for(var i = 0; i < packageJson.rows.length; i++){
					if(packageJson.rows[i].id == id){
						
						var children = packageJson.rows[i].children;
						//循环业务的子节点
						for(var j = 0; j < children.length; j++){
							if(children[j].id == childid){//找到该子节点
								packageJson.rows[i].children.splice(j,1);
							}
						}
						//packageJson.rows.splice(i,1);
						return ;
					}
				}
			}
		}
		
		function deleteServiceNode(id){
			var ids = id.split(".");
			if(ids.length == 1){//根节点，直接找到根节点，删除
				if(packageJson.rows.length != 0){
					//循环业务层
					for(var i = 0; i < packageJson.rows.length; i++){
						if(packageJson.rows[i].id == id){
							packageJson.rows.splice(i,1);
						}
					}
				}
			}else{ //子节点
				if(packageJson.rows.length != 0){
					//循环业务层
					for(var i = 0; i < packageJson.rows.length; i++){
						if(packageJson.rows[i].id == ids[0]){
							//找到子节点
							var children = packageJson.rows[i].children;
							//如果该子节点只有一个child，删除之后该子节点也一起删除
							if(packageJson.rows[i].children.length == 1){
								packageJson.rows.splice(i,1);
							}else{//如果不止一个child，就删除该child
								//循环业务的子节点
								for(var j = 0; j < children.length; j++){
									if(children[j].id == id){//找到该子节点
										packageJson.rows[i].children.splice(j,1);
									}
								}
							}
						}
					}
				}
			}
			
			//重新刷新树
			packageJson.rows.sort(sortid);  
            packageJson.footer[0].totalprice = getPackageTotalPrice(); 
            $('#tg').treegrid('loadData',packageJson);
		}
		
		function cleanPackageJson(){
			
			//重新刷新树
			if(packageJson.rows.length != 0){
				packageJson.rows.splice(0,packageJson.rows.length);
			}
			
            packageJson.footer[0].totalprice = getPackageTotalPrice(); 
            $('#tg').treegrid('loadData',packageJson);
		}
		
	</script>
</body>
</html>