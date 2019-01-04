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
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
</head>
<body>
	<div id="body">
			<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.batchpreauthorize"/></div>
			<form action="" method="post" id="sendForm" name="sendForm" enctype="multipart/form-data">
			<div class="easyui-panel" title="<spring:message code="page.search"/>" style="width:950px">
			<table width="100%">
			    <tr height="40px">
					<td align="right"><spring:message code="network.netname" />：</td>
					<td align="left">
						<select id="querynetid" name="querynetid" class="select" onchange="queryTerminallist();">
							<c:forEach items="${product.networkmap}" var="networkMap" varStatus="s">
								<option value="${networkMap.key}" <c:if test="${product.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
							</c:forEach>
						</select>
					</td>
					
					<td align="right"><spring:message code="product.productid" />：</td>
					<td align="left">
						<input type="text" class="inp w150" name="queryproductid" id="queryproductid" value="${authorizeParamForPages.queryproductid }">
					</td>
			
					<td align="right"><spring:message code="product.productname" />：</td>
					<td align="left">
						<input type="text" class="inp w200" name="queryproductname" id="queryproductname" value="${authorizeParamForPages.queryproductname }">
					</td>
				</tr>
			    
			    <tr height="40px">
					<td align="center" colspan="6">
						<a href="javascript:queryProduct();" style="width:120px" class="easyui-linkbutton"><spring:message code="page.search"/></a>                                                                                                                                                                                  
					</td>
				</tr>
				</table>	
			</div>
						
			<div style="margin:20px 0;"></div>
	
			<div id="productlist" style="width:950px"></div>
			
			<div style="margin:20px 0;"></div>
		
		
			<div class="easyui-panel" title="<spring:message code="authorize.parameter.config"/>" style="width:950px">
			<table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="userproduct.starttime" />：</td>
					<td>
						<input type="text" id="starttime" name="starttime" 
						 onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endtime\');}'});"
						 class="Wdate inp w150" value="${authorizeParamForPages.starttime }"/>
					</td>
					<td align="right"><spring:message code="userproduct.endtime" />：</td>
					<td>
						<input type="text" id="endtime" name="endtime" 
						 onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'starttime\');}'});" 
						 class="Wdate inp w150" value="${authorizeParamForPages.endtime }"/>
					</td>
				</tr>
			    <tr height="30px">
			    	<td align="right"><spring:message code="server.versiontype"/>：</td>
		            <td>
		             	<select name="versiontype" id="versiontype" class="select" onchange="setForm();queryTerminallist();">
			                <option value="gos_pn" <c:if test="${authorizeParamForPages.versiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
			                <option value="gos_gn" <c:if test="${authorizeParamForPages.versiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
			            </select>
		             </td>
		             <td align="right"><spring:message code="authorize.addressingmode" />：</td>
					 <td>
						<select id="addressing_mode" name="addressing_mode" class="select" onchange="setForm();queryTerminallist();">
							<option value="0" <c:if test="${authorizeParamForPages.addressing_mode == '0' }">selected</c:if>><spring:message code="authorize.addressingmode.0"/></option>
							<option value="1" <c:if test="${authorizeParamForPages.addressing_mode == '1' }">selected</c:if>><spring:message code="authorize.addressingmode.1"/></option>
							<option value="2" <c:if test="${authorizeParamForPages.addressing_mode == '2' }">selected</c:if>><spring:message code="authorize.addressingmode.2"/></option>
							<option value="3" <c:if test="${authorizeParamForPages.addressing_mode == '3' }">selected</c:if>><spring:message code="authorize.addressingmode.3"/></option>
						</select>
						
					</td>
			    </tr>
				<tr height="30px" class="cardidsingletag">
					<td align="right" ><spring:message code="card.cardid" />：</td>
					<td colspan="3">
						<input type="text" class="inp w200" name="cardid" id="cardid" value="${authorizeParamForPages.cardid }" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
					</td>
				</tr>
				<tr height="30px" class="cardidrangetag">
					<td align="right" ><spring:message code="authorize.startcardid" />：</td>
					<td >
						<input type="text" class="inp w200" name="startcardid" id="startcardid" value="${authorizeParamForPages.startcardid }" maxlength="16"  onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
					</td>
					<td align="right" ><spring:message code="authorize.endcardid" />：</td>
					<td>
						<input type="text" class="inp w200" name="endcardid" id="endcardid" value="${authorizeParamForPages.endcardid }" maxlength="16" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')">
					</td>
				</tr>
				<tr height="30px" class="stbnosingletag">
					<td align="right" ><spring:message code="stb.stbno" />：</td>
					<td colspan="3">
						<input type="text" class="inp w200" name="stbno" id="stbno" value="${authorizeParamForPages.stbno }" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')">
					</td>
				</tr>
				<tr height="30px" class="stbnorangetag">
					<td align="right"><spring:message code="authorize.startstbno" />：</td>
					<td>
						<input type="text" class="inp w200" name="startstbno" id="startstbno" value="${authorizeParamForPages.startstbno }" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')">
					</td>
					<td align="right"><spring:message code="authorize.endstbno" />：</td>
					<td>
						<input type="text" class="inp w200" name="endstbno" id="endstbno" value="${authorizeParamForPages.endstbno }" maxlength="8" onkeyup="checkHex(this)" onkeypress="checkHex(this)" onblur="checkHex(this)" onafterpaste="this.value=this.value.replace(/[^0-9a-fA-F]/g,'')">
					</td>
				</tr>
				<tr height="30px" class="fileimporttag">
					<td align="right"><spring:message code="uploadify.filepath"/>：</td>
					<td colspan="3">
						<input type="text" id="txt" name="txt" readonly="readonly" style="width: 230px" class="inp"/> 
						<input type="button" style="width:70px;height:23px;" name="selectbutton" id="selectbutton" value="<spring:message code="page.select" />"  onclick="uploadfile.click()"/> 
						<input type="file" name="uploadfile" id="uploadfile" onchange="txt.value=this.value" style="position:absolute;width:100px;height:23px;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;margin-left:-103px;"/>
						<a href="cascommand/downloadTerminalTemplate" class="btn-print"><spring:message code="uploadify.download.template"/></a>
					</td>
				</tr>
				<tr class="tableselectiontag">
					<td colspan="4">
						<div id="terminallist" style="width:100%"></div>
					</td>
				</tr>
				
				<tr height="40px">
						<td align="center" colspan="6">
								<a href="javascript:preAuth();" class="easyui-linkbutton"><spring:message code="authorize.preauth"/></a>                                                                                                                                                                                  
						</td>
				</tr>
			</table>
			
			<input type="hidden"  name="ids" id="ids">
			<input type="hidden"  name="terminalids" id="terminalids">
		</div>
	</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
				
      function initProductlist(){
           $('#productlist').datagrid({
                title: '<spring:message code="package.product.list" />',
                url:'cascommand/queryProducts',
                pagination: true,
                queryParams: {
				querynetid: $("#querynetid").val(),
				queryproductid: $("#queryproductid").val(),
				queryproductname: $("#queryproductname").val()
			},
                pageSize: 10,
                singleSelect: false,
                pageList: [10,25,50], 
                fitColumns:true,
                idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
                loadMsg:'loading...',
                columns: [[
                 	  { field: 'id', title: '<spring:message code="id" />',checkbox:true,align:"center",width:100 },
                    { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100 },
                    { field: 'productname', title: '<spring:message code="product.productname" />',align:"center",width:100},
               	  { field: 'productid', title: '<spring:message code="product.productid" />',align:"center",width:100},
	                  { field: 'state', title: '<spring:message code="product.state" />',align:"center",width:100,formatter:formatProductState}
	            	  //{ field: 'mothercardid', title: '<spring:message code="usercard.mothercardid" />',align:"center",width:100,formatter:formatMothercardIdForCard},
			  //{ field:'id',title:'<spring:message code="page.operate" />',align:"center", formatter:formatOperationForCard}          
                ]]
            });
                 var p = $('#productlist').datagrid('getPager');
         $(p).pagination({
          beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
          afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
       	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
         });
            
	}
	
	function formatProductState(value,row,index){
		if(value==0){
		return	'<spring:message code="product.state.0"/>';
		}else if(value ==1){
		return	'<spring:message code="product.state.1"/>';
		}
		
	}
	
	function getChecked(){
		var ids = [];
		var rows = $('#productlist').datagrid('getChecked');
		for(var i=0; i<rows.length; i++){
			ids.push(rows[i].id);
		}
		$("#ids").val(ids.join(','));
	}
	
	function getTerminalChecked(){
		var terminalids = [];
		var rows = $('#terminallist').datagrid('getChecked');
		for(var i=0; i<rows.length; i++){
			terminalids.push(rows[i].id);
		}
		$("#terminalids").val(terminalids.join(','));
	}
	
	
	
	
	//查询操作员
	function queryProduct() {
		$('#productlist').datagrid('reload',{
				querynetid: $("#querynetid").val(),
				queryproductid: $("#queryproductid").val(),
				queryproductname: $("#queryproductname").val()
		});
	}

	function preAuth() {
		if ($("#starttime").val() == "") {
			$.dialog.tips(
					'<spring:message code="authorize.starttime.empty"/>',
					1, 'alert.gif');
			return;
		}
		if ($("#endtime").val() == "") {
			$.dialog.tips(
					'<spring:message code="authorize.endtime.empty"/>', 1,
					'alert.gif');
			return;
		}
		if ($("#addressing_mode").val() == "0" ) {
			if($("#versiontype").val() == "gos_pn" && $("#cardid").val() == ""){
				$.dialog.tips(
					'<spring:message code="authorize.cardid.empty"/>', 1,
					'alert.gif');
				$("#cardid").focus();
				return;
			}
			if($("#versiontype").val() == "gos_gn" && $("#stbno").val() == ""){
				$.dialog.tips(
					'<spring:message code="authorize.stbno.empty"/>', 1,
					'alert.gif');
				$("#stbno").focus();
				return;
			}
		} else if ($("#addressing_mode").val() == "1") {
			if($("#versiontype").val() == "gos_pn" && ($("#startcardid").val() == "" || $("#endcardid").val() == "")){
				$.dialog.tips(
							'<spring:message code="authorize.addressingrange.empty"/>',
							1, 'alert.gif');
				return;
			}
			if($("#versiontype").val() == "gos_gn" && ($("#startstbno").val() == "" || $("#endstbno").val() == "")){
				$.dialog.tips(
					'<spring:message code="authorize.addressingrange.empty"/>', 1,
					'alert.gif');
				return;
			}
		} else if ($("#addressing_mode").val() == "2") {
			if($("#uploadfile").val() == ""){
				$.dialog.tips(
							'<spring:message code="uploadify.filename.null"/>',
							1, 'alert.gif');
				return;
			}
		} else if ($("#addressing_mode").val() == "3") {
			//获取选择的终端号
			getTerminalChecked();
			if ($("#terminalids").val() == "") {
				$.dialog.tips(
						'<spring:message code="user.terminalid.empty"/>', 1,
						'alert.gif');
				return;
			}
		}

		getChecked();

		if ($("#ids").val() == "") {
			$.dialog.tips(
					'<spring:message code="authorize.product.empty"/>', 1,
					'alert.gif');
			return;
		}
		
		$.dialog({
		    title: '<spring:message code="menu.authorize.batchpreauthorize"/>',
		    lock: true,
		    background: '#000', /* 背景色 */
		    opacity: 0.5,       /* 透明度 */
		    content: '<spring:message code="page.confirm.execution"/>',
		    icon: 'alert.gif',
		    ok: function () {
		    	$("#sendForm").attr("action", "cascommand/send_batchpreauthorize"+"?rid="+Math.random());
				$("#sendForm").submit();
		        /* 这里要注意多层锁屏一定要加parent参数 */
		        $.dialog({
		        	lock: true,
		            title: '<spring:message code="page.notice"/>',
		        	content: '<spring:message code="page.wait"/>......', 
		        	max: false,
				    min: false,
				    cancel:false,
		        	icon: 'loading.gif',
		        });
		        return false;
		    },
		    okVal: '<spring:message code="page.confirm"/>',
		    cancel: true,
		    cancelVal:'<spring:message code="page.cancel"/>'
		});
		
		
		//$("#sendForm").attr("action", "cascommand/send_batchpreauthorize").submit();
	}

	$(function() {
		initProductlist();
		initTerminallist();
		setForm();
		var returninfo = '${authorizeParamForPages.returninfo}';
		if (returninfo != '') {
			$.dialog.tips(returninfo, 1, 'alert.gif');
		};
	});
	
	function setForm() {
	  
	  //默认全部隐藏
	  $(".cardidsingletag").hide();
	  $(".cardidrangetag").hide();
	  $(".stbnosingletag").hide();
	  $(".stbnorangetag").hide();
	  $(".fileimporttag").hide();
	  $(".tableselectiontag").hide();
	  
	  if($("#versiontype").val() == "gos_pn"){
	  	//判断单播还是多播
	  	if ($("#addressing_mode").val() == "0") {
			$(".cardidsingletag").show();
		} else if ($("#addressing_mode").val() == "1") {
			$(".cardidrangetag").show();
		}else if ($("#addressing_mode").val() == "2") {
			$(".fileimporttag").show();
		}else if ($("#addressing_mode").val() == "3") {
			$(".tableselectiontag").show();
		}
	  }else if($("#versiontype").val() == "gos_gn"){
	  	//判断单播还是多播
	  	if ($("#addressing_mode").val() == "0") {
			$(".stbnosingletag").show();
		} else if ($("#addressing_mode").val() == "1"){
			$(".stbnorangetag").show();
		}else if ($("#addressing_mode").val() == "2") {
			$(".fileimporttag").show();
		}else if ($("#addressing_mode").val() == "3") {
			$(".tableselectiontag").show();
		}
	  }
	}
	
	//查询终端列表
	function initTerminallist(){
            $('#terminallist').datagrid({
                 title: '<spring:message code="user.terminalinfo" />',
                 url:'cascommand/queryTerminalList',
                 pagination: true,
                 queryParams: {
					querynetid: $("#querynetid").val(),
					queryversiontype: $("#versiontype").val(),
				},
                 pageSize: 10,
                 singleSelect: false,
                 pageList: [10,25,50], 
                 fitColumns:true,
                 idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
                 loadMsg:'loading...',
                 columns: [[
                  	  { field: 'id', title: '<spring:message code="id" />',checkbox:true,align:"center",width:100 },
                     { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100 },
                     { field: 'terminalid', title: '<spring:message code="user.terminalid" />',align:"center",width:100},
                     { field: 'terminaltype', title: '<spring:message code="user.terminaltype" />',align:"center",width:100,
                      		formatter:function(val, row, index){ 
							 	if(val == '0'){
							 		return '<spring:message code="user.terminaltype.0"/>';
							 	}else if(val == '1'){
							 		return '<spring:message code="user.terminaltype.1"/>';
							 	}
                  	        },
                     },
                 ]]
             });
          //分页显示多语言国际化
          var p = $('#terminallist').datagrid('getPager');
          $(p).pagination({
           beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
           afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
        	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
          });
             
		}
	
	//查询操作员
	function queryTerminallist() {
		$('#terminallist').datagrid('reload',{
			querynetid: $("#querynetid").val(),
			queryversiontype: $("#versiontype").val(),
		});
	}
		
</script>
</body>
</html>
