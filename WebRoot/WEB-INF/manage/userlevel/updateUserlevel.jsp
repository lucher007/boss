<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
  <link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
  <link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
  <style>
    .fb-con table tr {
      height: 30px;
    }
    .refServiceInfo table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.userlevel"/> &gt; <spring:message code="userlevel.userlevelupdate"/></div>
  <form method="post" id="addForm" name="addForm">
  	<input type="hidden" name="id" id="id" value="${userlevel.userlevel.id}">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="userlevel.userlevelupdate"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
         
          <tr>
            <td align="right"><spring:message code="userlevel.levelname"/>：</td>
            <td>
              <input type="text" class="inp" name=levelname id="levelname"
              	maxlength="50" style="width: 250px;" value="${userlevel.userlevel.levelname }"> <span class="red">*</span>
            </td> 
          </tr>
         
        </table>
      </div>
      <div id = "productDG" style="width:100%; height:auto;">
		<input type="hidden"name="productJson" id="productJson" >
  	  </div>
      <div class="fb-bom">
        <cite>
          <%-- 
          <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateUserlevel();"/>
           --%>
          <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	      <a href="javascript:updateUserlevel();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${userlevel.returninfo}</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/common/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
  
  
  function updateUserlevel() {
	   
	    if ($('#levelname').val() == '') {
		      $.dialog.tips('<spring:message code="userlevel.levelname.empty"/>', 1, 'alert.gif');
		      $('#levelname').focus();
		      return;
		}
	    
	    //获取所有选择的产品
	    var rowsSelected = $('#productDG').datagrid('getChecked');
        if(rowsSelected == null  || rowsSelected == ''){
        	 $.dialog.tips('<spring:message code="userlevel.product.empty"/>', 1, 'alert.gif');
		      return;
        }
	    
	    //将row转换成json字符串
	 	var event = JSON.stringify(rowsSelected);
	 	//中文进行编码转换，防止乱码
		var o = JSON.parse(event); 
		//将Json字符串赋值给event
		eval("var event = '"+JSON.stringify(o)+"';"); 
		
		$("#productJson").val(event);
		
		//alert($("#productJson").val());
		
        
	    $("#addForm").attr("action", "userlevel/update");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "userlevel/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
	  initProductDatagrid();
       var returninfo = '${userlevel.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  function initProductDatagrid(){
	  
      $('#productDG').datagrid({
           title: '<spring:message code="product.productquery"/>',
           queryParams: paramsJson(),
           url:'userlevel/findUserlevelproductListJson',
           pagination: false,
           singleSelect: false,
           scrollbar:true,
           checkOnSelect: false,// 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。 如果为false，当用户仅在点击该复选框的时候才会呗选中或取消。
           //pageSize: 10,
           //pageList: [10,30,50], 
           fitColumns:true,
           idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
           loadMsg:'loading...',
           onClickCell: onClickCell,
           columns: [[
               { field: 'id', title: '全选',checkbox:true,align:"center",width:40,
				  formatter: function(val, row, index){
	                    return row.id;
	                }, 
			   },   
			   { field: 'netname', title: '<spring:message code="network.netname"/>',width:50,align:"center",},
               { field: 'productid', title: '<spring:message code="product.productid"/>',width:50,align:"center",},
               { field: 'productname', title: '<spring:message code="product.productname"/>',width:100,align:"center"},
               { field: 'pricepermonth', title: '<spring:message code="product.pricepermonth"/>',width:60,align:"center",
            	   editor:{
		                   type: 'numberbox',
		                   options:{precision:2}
		               },
		       },
               { field: 'priceperday', title: '<spring:message code="product.priceperday"/>',width:60,align:"center",
		    	   editor:{
	                   type: 'numberbox',
	                   options:{precision:2}
	               },
               },
               { field: 'subpricepermonth', title: '<spring:message code="product.subpricepermonth"/>',width:60,align:"center",
            	   editor:{
		                   type: 'numberbox',
		                   options:{precision:2}
		               },
		       },
               { field: 'subpriceperday', title: '<spring:message code="product.subpriceperday"/>',width:60,align:"center",
		    	   editor:{
	                   type: 'numberbox',
	                   options:{precision:2}
	               },
               },
           ]],
           onLoadSuccess:function(data){  
        	    var rowData = data.rows;    
        	    $.each(rowData,function(index,row){//遍历JSON     
        	        if(row.checkedFlag == '1'){ //如果数据行为已选中则选中改行   
        	        	$("#productDG").datagrid("checkRow", index);  
        	            //$("#productDG").datagrid("selectRecord", row.id);  
        	        }  
        	           
        	    });  
        	},  
       });
	}
  
    //将表单数据转为json
	function paramsJson(){
	 	var id = $("#id").val();
	 	var json = '';
	 	if(id != null && id != ''){
	 		json = {
	 			id:id,
		 	};
	 	}else{//默认不查询产品信息，故参数乱设置
	 		json = {
	 			id:'-111',
		 	};
	 	}
	 	return json;
	 }
   
    
	//单元格编辑，按回车键
	 function onClickCell(index, field){
			
		 //不是点击价单元格，不进入修改模式
		 if(field != 'pricepermonth' && field != 'priceperday' && field != 'subpricepermonth' && field != 'subpriceperday'){
			 return;
		 }  
		
	      $(this).datagrid('beginEdit', index);
          var ed = $(this).datagrid('getEditor', {index:index,field:field});
          if(ed != null){
	          //获取编辑单元格对象
	           var editorObject = $(ed.target);
	          //光标指向该编辑框
	          editorObject.focus();
			
			   //绑定回车事件
	         	var currentEdatagrid = $(this);  
	     	    $('.datagrid-editable .textbox,.datagrid-editable .datagrid-editable-input,.datagrid-editable .textbox-text').bind('keydown', function(e){  
	     	    	
	     	    	   var code = e.keyCode || e.which;  
	                   if(code == 13){
	                	    
	                	   //获取输入的产品标识
	                       //var editorContent = editorObject.val();
	                	 
	                      	//var allrows = $('#productDG').datagrid("getRows"); // 这段代码是// 对某个单元格赋值
			           
			            	// 刷新该行, 只有刷新了才有效果
							//$(this).datagrid('refreshRow', index);
						
							//如果该行处于"行编辑"状态, 如果直接调用"refreshRow"方法. 会报data is undefined这个错; 
							//需要先调用"endEdit", 再调用"refreshRow", 最后调用"selectRow"和"beginEdit"这两个方法便可了;
	                      	//$('#userproductDG').datagrid('endEdit', index).datagrid('refreshRow', index).datagrid('selectRow', index).datagrid(
	                        //	'beginEdit', index);
	                           		
	                        $(currentEdatagrid).datagrid('acceptChanges');  
	                      	$(currentEdatagrid).datagrid('endEdit', index); 
						
	                 }; 	 
	            }); 
            }
		}
</script>
</body>
</html>
