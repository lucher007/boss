<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!doctype html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title></title>
  <link type="text/css" rel="stylesheet" href="style/user.css">
  <link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
  <link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
  <link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
  <link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
  <style>
   .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="otherexpenses"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
	    <div class="fb-con">
	    	<div id="userInfo"></div>
		</div>
        <!-- 其他费用收取 -->
       	<div style="margin:10px 0;"></div>
      	<table id="buyingotherfeeData" style="width:auto;height: 150px;"></table>
      	<div id="otherfeetools">
			<div style="margin-bottom:5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="javascript:openWindow('otherfee');"><spring:message code="otherexpenses"/></a>
			</div>
	  	</div>
        <!--其他费用收取窗口-->		
		<div id="otherfee" class="easyui-window" title="<spring:message code="otherexpenses"/>" closed="true" style="width:450px;height:250px;">
			<div style="padding:10px 20px 10px 40px;">
				<table width="100%">
					 <tr height="30px">
			            <td align="right"><spring:message code="service.servicetype"/>：</td>
						<td align="left">
							 <input id="typekey" name="typekey" style="width: 157px;">
							 <span class="red">*</span>
						</td>
			        </tr>
			        <tr height="30px">
			            <td align="right"><spring:message code="statreport.business.price"/>：</td>
			            <td align="left">
			            	<input type="text" class="easyui-numberbox" style="width: 157px;" data-options="precision:2"  style="width:150px;" name="price" id="price"  onpaste="return false" maxlength="10">
			            </td>
			        </tr>
			        <tr height="30px">
			            <td align="right"><spring:message code="otherexpenses.remark"/>：</td>
			            <td align="left">
			            	<input type="text"  class="inp" style="width:250px;" name="remark" id="remark"  maxlength="30" >
			            </td>
			        </tr>
				</table>
				<div style="margin:20px 0;"></div>
				<div style="padding:5px;text-align:center;">
					<a onclick="saveOtherfee(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.save"/></a>
					<a onclick="closeWindow(this);" style="width:60px" class="easyui-linkbutton"><spring:message code="page.cancel"/></a>
				</div>
			</div>
		  </div>
	      <div class="fb-bom">
	        <cite>
	        	<c:choose>  
	               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
	               		 <%-- 
	               		 <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="unitBusiness();" id="btnfinish">
	               		  --%>
	               		 <a href="javascript:unitBusiness();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
	               </c:when>
	            </c:choose>
	        </cite>
	        <span class="red">${user.returninfo }</span>
	    </div>
    </div>
  </form>
  <div id="printInfo" style="display: none"></div>
  <div class="pop-box" id="pop-div">
		<table>
			<tr align="right" height="30px">
				<td><spring:message code="print.template" />:</td>
				<td>
					<select id="template_value" name="template_value" class="select">
						<c:forEach items="${user.buyingbusiness.templateList}" var="templateMap" varStatus="s">
							<option value='${templateMap.value}'>${templateMap.name}</option>
						</c:forEach>
					</select> 
				</td>
			</tr>
			<tr align="right" height="30px">
				<td><spring:message code="userbusiness.invoicecode"/>:</td>
				<td><input type="text" class="inp"  id="startinvoicecode" name="startinvoicecode"  /></td>
			</tr>
			<c:if test="${user.user.printtaxpayerflag == '1'}">
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
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lodop/LodopFuncs.js"></script>
<script type="text/javascript">
  	
  	//发票打印
	var basepath = '<%=basePath%>';
	var LODOP;
	var needupdate = '<spring:message code="print.plugin.update"/>';
	var needinstall = '<spring:message code="print.plugin.install"/>';
	var install = '<spring:message code="print.plugin.excuteinstall"/>';
	var update = '<spring:message code="print.plugin.excuteupdate"/>';
	var refresh = '<spring:message code="print.plugin.refresh"/>';
	var notready = '<spring:message code="print.plugin.notready"/>';
	var error = '<spring:message code="print.plugin.error"/>';
	var totalPrice;
    
    function saveRechargeAccount() {
        if ($('#typekey').combobox('getValue') == '') {
		      $.dialog.tips('请选择业务类型', 1, 'alert.gif');
		      $('#typekey').next('span').find('input').focus();
		      return;
	    }
        
        $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
 	             '<spring:message code="page.confirm"/>',
 	             '<spring:message code="page.cancel"/>',
 	             function(){ 
					 $("#addform").attr("action", "user/saveFeecollection");
			    	 $("#addform").submit();
		         }, 
                 function(){
		});
    }
    
    
	$(function () {
	      loadUserInfo();
	      initOtherbusinesstype();
	      initBuyingOtherfeeDatagrid();
	      var returninfo = '${user.returninfo}';
	      if (returninfo != '') {
	       	$.dialog.tips(returninfo, 1, 'alert.gif');
	       	//是否发票打印弹框
	       	$.dialog.confirmMultiLanguage('是否需要打印发票？','打印','不打印',
	  				function(){
	  					//初始化打印数据
	  					loadInvoiceInfo();
	  					//打印
	  					isPrintTaxpayerMsg();
	  				},
	  				function(){}
	  		);
	      }
	 });
	 
	 //初始化其他费用收取
	function initBuyingOtherfeeDatagrid(){
      $('#buyingotherfeeData').datagrid({
           title: '<spring:message code="otherexpenses"/>',
           //queryParams: paramsJson(),
           url:'user/getBuyingOtherfeeJson',
           pagination: false,
           singleSelect: true,
           scrollbar:true,
           rownumbers:true,
           toolbar:'#otherfeetools',
           //checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'正在加载数据......',
           columns: [[
			   { field: 'typekey', title: '<spring:message code="otherexpenses.key"/>',width:50,align:"center",},
			   { field: 'typename', title: '<spring:message code="otherexpenses.name"/>',width:50,align:"center",},
			   { field: 'price', title: '<spring:message code="otherexpenses.price"/>',width:50,align:"center",},
			   { field: 'remark', title: '<spring:message code="otherexpenses.remark"/>',width:50,align:"center",},
			   { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:50,
  	 					formatter:function(val, row, index){ 
  	 						return '<a class="btn-del" href="javascript:deleteBuyingOtherfee(\''+row.typekey+'\');" ><spring:message code="page.delete"/></a>';
            	       }
       			},
           ]]
       });
	}
	
	//其他费用收取添加
    function saveOtherfee(obj){
		
    	if ($('#typekey').combobox('getValue') == '') {
		      //$.dialog.tips('请选择业务类型', 1, 'alert.gif');
		      $('#typekey').next('span').find('input').focus();
		      return;
	    }
		
    	var typekey = $('#typekey').combobox('getValue');
		var data = {
				typekey:typekey,
				price: $('#price').numberbox('getValue'),
				remark:$('#remark').val(),
			  };
			var url="user/addBuyingOtherfee?rid="+Math.random();
			$.getJSON(url,data,function(jsonMsg){
				$(obj).parents('.easyui-window').window('close');
				if(jsonMsg.flag=="0"){
				    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
				}else if(jsonMsg.flag=="1"){
					//刷新收取的其他收费
					$('#buyingotherfeeData').datagrid('reload');
				}
			});
	}
	
	 //删除购买中的其他费用
	function deleteBuyingOtherfee(typekey){
    	 
		var data = {
				typekey:typekey,
			  };
	   
		var url="user/deleteBuyingOtherfee?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 1, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				//刷新收取的其他收费
				$('#buyingotherfeeData').datagrid('reload');
			}
		});
	}
	
	//开启弹出框
    function openWindow(service_name){
	    //如果是弹出其他费用收取框，先初始化业务类型数据
		$('#'+service_name).window('open');
		$('#'+service_name).window("resize",{top:$(document).scrollTop() + ($(window).height()-250) * 0.5});//居中显示
	}
	
	 //关闭弹出框
	function  closeWindow(obj){
		$(obj).parents('.easyui-window').window('close');
	}
	
	//初始化其他业务类型
	function initOtherbusinesstype(){
	   $('#typekey').combobox({    
			url:'businesstype/initOtherbusinesstypeJson',
		    valueField:'id',    
		    //limitToList:true,
		    editable:false,
		    textField:'name',
	        onSelect: function(rec){ 
	        	$('#price').numberbox('setValue',rec.price);
        	},
		    onLoadSuccess:function(data){
			    	//初始化列表框的默认选择值
					var val = $('#typekey').combobox("getData");
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $(this).combobox("select", val[0][item]);  
                        }  
                     }  	
			    }
		});  
    }
    
    //保存
	var unitBusinessDialog;
	function unitBusiness() {
		
	   var rows = $('#buyingotherfeeData').datagrid("getRows");
		   
	   if(rows ==null || rows =='' || rows.length<0){
		   $.dialog.tips('<spring:message code="otherexpenses.add"/>', 1, 'alert.gif');
		   return;
	   }
	   
	   
	   unitBusinessDialog = $.dialog({
		    title: '<spring:message code="userbusiness.feecount"/>',
		    lock: true,
		    width: 800,
		    height: 400,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		   	cancel:false,
		    content: 'url:user/unitBusiness?businesstype='+$('#businesstype').val()
		});
	 }
  
	function closeBusinessDialog(){
		unitBusinessDialog.close();
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
	}
	
	function loadUserInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'userInfo'
	   };
	   var url = 'user/getUserInfo .' + data.tag;
	   $('#userInfo').load(url, data, function () {
	   		//动态渲染加载的easyui组件样式
	   		$.parser.parse($('#switchButton').parent());
	   });
	}
    
    function isPrintTaxpayerMsg(){
	   	var url = "taxpayer/getUsertaxpayer?rid="+new Date();
	   	var userid = '${user.id}';
	   	$.getJSON(url,{userid:userid},function(msg){
	   	    if(msg.flag == '1'){
	   	    	selectInvoiceTmp();
	   	    	//发票号
				//getInvoice();
	    	    $("#taxpayername").val(msg.taxpayername);
	    		$("#taxpayercode").val(msg.taxpayercode);
	   	    }
	   	});
	 }
	 
	 //获取发票号
    function getInvoice(){
    	var url = "operator/getOperaterInvoice?rid="+new Date();
    	var operaterId = '${Operator.id}';
    	$.getJSON(url,{operaterId:operaterId},function(msg){
    		if(msg.flag == '1'){
    	    	$("#startinvoicecode").val(msg.invoice);
    	    }
    	});
    }
	 
	function selectInvoiceTmp() {
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
					   //保存纳税人信息
					  saveTaxpayerMsg();
					 //保存发票号
					 var temp = saveInvoiceNumber();
					 if(temp==1){
					   	printInvoice();
					 }
			   		},
			   	okVal:'<spring:message code="page.confirm"/>',
			   	cancel:function(){/* selectInvoiceDialog.close(); */},
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
			//转化成大写金额
			var amountPrice = smalltoBIG(totalPrice);
			
			LODOP.SET_SHOW_MODE("HIDE_ITEM_LIST ", true);
			LODOP.SET_PRINT_STYLEA("clientName", "CONTENT","用户名："+window.parent.getUsername());
			LODOP.SET_PRINT_STYLEA("totalPrice", "CONTENT", "金额（小写）："+totalPrice);
			LODOP.SET_PRINT_STYLEA("amountPrice", "CONTENT", "金额（大写）："+amountPrice);
			LODOP.SET_PRINT_STYLEA("clientCode", "CONTENT", window.parent.getUsercode());
			LODOP.SET_PRINT_STYLEA("operateDate", "CONTENT",addtime.substring(0,10));
			LODOP.SET_PRINT_STYLEA("printDate", "CONTENT",new Date().toLocaleDateString());
			LODOP.SET_PRINT_STYLEA("operatorCode", "CONTENT",'${Operator.operatorcode}');
			LODOP.SET_PRINT_STYLEA("operatorName", "CONTENT",'${Operator.operatorname}');
			LODOP.SET_PRINT_STYLEA("storeName", "CONTENT",$("#store").val());
			LODOP.SET_PRINT_STYLEA("taxpayerCode", "CONTENT",$("#taxpayercode").val());
			LODOP.SET_PRINT_STYLEA("taxpayerName", "CONTENT",$("#taxpayername").val());
			LODOP.SET_PRINT_STYLEA("invoiceNumber", "CONTENT",$("#startinvoicecode").val());
			LODOP.PREVIEW();
    }
	
    function saveInvoiceNumber(){
    	var number = $("#startinvoicecode").val();
     	var temp = 1;
		$.ajax({
	        url: "operator/updateInvoiceNumber?rid="+new Date(),
	        async: false, //改为同步方式
	        type: "POST",
	        data: {startinvoicecode:number},
	        success: function (msg) {
	        	if(msg.flag == '0'){
	            	temp = 0;
    				$.dialog.tips("发票号已用完，请领取新的发票号！", 2, 'alert.gif');
    			}
	        },
	        dataType:"json"
	    });
    	return temp; 
    }
    
    function loadInvoiceInfo() {
	   var data = {
	   			rid : Math.random(),
				businessid : '${user.buyingbusiness.id}',
				tag : 'printInfo'
			};
	   var storeid = '${user.buyingbusiness.storeid}';
	   var url = 'print/getPrintInfo .' + data.tag;
	   $('#printInfo').load(url, data, function() {
	   		$.post('taxpayer/findStore',{storeid:storeid},function(store){
	   			var store = eval('(' + store + ')');
				$("#store").val(store.storename);
	   		});
	   });
  	}
  	
  	//转大写金额
  	function smalltoBIG(n){    
        var fraction = ['角', '分'];    
        var digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];    
        var unit = [ ['元', '万', '亿'], ['', '拾', '佰', '仟']  ];    
        var head = n < 0? '负': '';    
        n = Math.abs(n);    
      
        var s = '';    
      
        for (var i = 0; i < fraction.length; i++){    
            s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');    
        }    
        s = s || '整';    
        n = Math.floor(n);    
      
        for (var i = 0; i < unit[0].length && n > 0; i++){    
            var p = '';    
            for (var j = 0; j < unit[1].length && n > 0; j++){    
                p = digit[n % 10] + unit[1][j] + p;    
                n = Math.floor(n / 10);    
            }    
            s = p.replace(/(零.)*零$/, '').replace(/^$/, '零')  + unit[0][i] + s;    
        }    
        return head + s.replace(/(零.)*零元/, '元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');    
    }
	
	
	 
</script>
</body>
</html>
