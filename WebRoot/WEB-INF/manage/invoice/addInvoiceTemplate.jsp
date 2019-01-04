<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</style>
</head>
<body>
	<div id="body">
		<div class="cur-pos">
			<spring:message code="page.currentlocation" />
			：
			<spring:message code="menu.system.invoicetemplate" />
			&gt;
			<spring:message code="print.template.add" />
		</div>
		<form method="post" id="addForm" name="addForm">
			<div class="form-box">
				<div class="fb-tit">
					<spring:message code="print.template.add" />
				</div>
				<div class="fb-con" align="center">
					<input type="hidden" name="value" id="value" readonly="readonly" value='${printtemplate.value}' />
					<table>
					<%-- 	
						<tr height="50px">
								<td align="right" height="30"><spring:message code="print.template.code" />：</td>
								<td align="left" colspan="2"><input type="text" class="inp" name="code" id="code" value="${printtemplate.code}" />
								</td>
						</tr> 
					--%>
						<tr height="50px">
							<td align="right"><spring:message code="print.template.name" />：</td>
							<td align="left"><input type="text" class="inp" maxlength="30" name="name" id="name" value="${printtemplate.name}" style="width: 240px;"/></td>
						</tr>
						<tr height="50px">
							<td align="right"><spring:message code="print.select.paper" />：</td>
							<td><select id="pagesetting" name="pagesetting" class="select" onchange="pageSetting();">
									<%-- <option value="0">
										<spring:message code="a4" />
									</option>
									<option value="1">
										<spring:message code="b5" />
									</option> --%>
									<option value="2">
										<spring:message code="authorize.postype.1" />
									</option>
							</select>
							<span style="color: red">A4(mm)：210，297；B5(mm)：176，250</span>
							</td>
						</tr>
						<tr height="50px" class="page">
							<td align="right"><spring:message code="print.template.paperwidth" />：</td>
							<td align="left" colspan="2"><input type="text" class="inp" name="width" id="width" onChange="clearTemplate();"
								value="${printtemplate.width}"
							/></td>
							<td align="right"><spring:message code="print.template.paperheight" />：</td>
							<td align="left" colspan="2"><input type="text" class="inp" name="height" id="height" onChange="clearTemplate();"
								value="${printtemplate.height}"
							/></td>
						</tr>
						<tr height="50px">
							<td align="right" height="30"><spring:message code="print.template.backgroundimg" />：</td>
							<td align="left">
								<input type="text" class="inp" name="image" id="image" readonly="readonly" style="background:#eeeeee;width: 149px;"
									value="${printtemplate.image}" >
								<a href="javascript:vod()" onclick="javascript:$('#image').val(getImageFileName());" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
							</td>
						</tr>
						<tr height="50px" class="page">
							<td align="right"><spring:message code="invoice.background.img_x"/>：</td>
							<td align="left" colspan="2"><input type="text" class="inp" name="backimg_x" id="backimg_x" onChange="clearTemplate();"
								value="0"
							/></td>
							<td align="right"><spring:message code="invoice.background.img_y"/>：</td>
							<td align="left" colspan="2"><input type="text" class="inp" name="backimg_y" id="backimg_y" onChange="clearTemplate();"
								value="0"
							/></td>
						</tr>
						<tr height="50px">
							<td align="right"><spring:message code="print.template.printpara" />：</td>
							<td align="left"><input
								data-options="url:'print/getParaJson',
															method:'get',
															valueField:'code',
															textField:'text',
															multiple:true,
															editable:false,
															onChange:function(){
															$('#value').val('');
															},
															panelHeight:'auto',"
								class="easyui-combobox" name="parameters" id="parameters" value="${printtemplate.parameters}" style="width:240px;"
							/></td>
						</tr>
						<tr height="50px">
							<td colspan="3" align="center">
							<a class="btn-edit" href="javascript:initDesign()">
								<spring:message code="print.template.generate" />
							</a>
							</td>
							<!-- <td>
							  <a  class="btn-edit" href="javascript:loadTemplate()"><spring:message code="加载"/></a>
				      		</td> -->
						</tr>
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()"> 
						<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveTemplate();"/> 
						 --%>
						<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:saveTemplate();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red">${printtemplate.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/lodop/LodopFuncs.js"></script>
	<script type="text/javascript">
  var basepath = '<%=basePath%>';
  var LODOP; 
  var needupdate = '<spring:message code="print.plugin.update"/>';
  var needinstall = '<spring:message code="print.plugin.install"/>';
  var install =  '<spring:message code="print.plugin.excuteinstall"/>';
  var update =  '<spring:message code="print.plugin.excuteupdate"/>';
  var refresh =  '<spring:message code="print.plugin.refresh"/>';
  var notready = '<spring:message code="print.plugin.notready"/>';
  var error = '<spring:message code="print.plugin.error"/>';

function initDesign() {		
	//if($('#width').val() =="" || $('#height').val() ==""){
	//	$.dialog.tips('<spring:message code="print.paper.empty"/>', 1, 'alert.gif');
	//	return;
	//}
	if( $("#parameters").combobox('getValues').length == 0){
		$.dialog.tips('<spring:message code="print.para.empty"/>', 1, 'alert.gif');
		return;
	}
	var paper_width = $('#width').val();
	var paper_height = $('#height').val();
	var backimg_x = $('#backimg_x').val();
	var backimg_y = $('#backimg_y').val();
	if($('#value').val() == ''){
		CreatePage(paper_width, paper_height);	
		LODOP.ADD_PRINT_SETUP_BKIMG($('#image').val());
		LODOP.SET_SHOW_MODE("BKIMG_LEFT",(backimg_x)+"mm");
		LODOP.SET_SHOW_MODE("BKIMG_TOP",(backimg_y)+"mm");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",paper_width+"mm");
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",paper_height+"mm");
		//LODOP.SET_SHOW_MODE("BKIMG_LEFT",(210*0.005)+"mm");
		//LODOP.SET_SHOW_MODE("BKIMG_WIDTH",(297*0.99)+"mm");	
	} else {
		LODOP = getLodop(); 		
		eval($('#value').val()); 
	}
	if (LODOP.CVERSION) LODOP.On_Return=function(TaskID,Value){ $('#value').val(Value);};	
	$('#value').val(LODOP.PRINT_DESIGN());	
	
};

function getImageFileName() {
	clearTemplate();
	LODOP = getLodop();
	if (LODOP.CVERSION)
		CLODOP.On_Return = function(TaskID, Value) {
		$('#image').val(Value);
		};
	return LODOP.GET_DIALOG_VALUE("LocalFileFullName","*.jpg;*.bmp;.jpeg");
}

function CreatePage(width,height) {
	LODOP=getLodop(); 
	LODOP.PRINT_INITA(0,0,width+"mm", height+"mm","print");//打印初始化、设定纸张整体偏移量、设定可视编辑区域大小
	/*设定打印纸张为固定纸张或自适应内容高，并设定相关大小值或纸张名及打印方向。
		1---纵(正)向打印，固定纸张； 
		2---横向打印，固定纸张；  
		3---纵(正)向打印，宽度固定，高度按打印内容的高度自适应；
	    0(或其它)----打印方向由操作者自行选择或按打印机缺省设置；*/
 	LODOP.SET_PRINT_PAGESIZE (0,width+"mm", height+"mm","");  
 	LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);//设置打印预览、打印维护和打印设计的显示模式，设置打印预览时是否包含背景图等。
  	LODOP.SET_SHOW_MODE("HIDE_SBUTTIN_PREVIEW",1);
	var parameters = $("#parameters").combobox('getValues');
	$.each(parameters ,function(n,value){
		if(value.indexOf("list")<0){
		/*增加纯文本打印项，设定该打印项在纸张内的位置和区域大小，文本内容在该区域内自动折行，
		当内容超出区域高度时，如果对象被设为“多页文档”则会自动分页继续打印，否则内容被截取*/
			LODOP.ADD_PRINT_TEXTA(value,25+30*parseInt(n/4),25+140*(n%4),120,25,value);
		}else{
			LODOP.ADD_PRINT_TABLE(100,5,500,280,value);//增加表格打印项
		}
	}); 
};

/* function loadTemplate(){
	LODOP=getLodop(); 		
	eval('LODOP.PRINT_INITA(0,0,665,600,"打印");LODOP.ADD_PRINT_TEXTA("clientName",159,169,120,25,"clientName");LODOP.ADD_PRINT_TEXTA("totalPrice",227,130,120,25,"totalPrice");LODOP.ADD_PRINT_TEXTA("productList",224,336,120,25,"productList")'); 
    LODOP.PRINT_DESIGN();
} */

 	function saveTemplate() {
			if($('#name').val() == ''){
				$.dialog.tips('<spring:message code="print.templatename.empty"/>', 1, 'alert.gif');
			return;
			}
			if($('#value').val() == ''){
				$.dialog.tips('<spring:message code="print.value.empty"/>', 1, 'alert.gif');
			return;
			}
		 	$("#addForm").attr("action", "print/saveTemplate");
	    	$("#addForm").submit(); 
	 }
 
	function goBack() {
	    $("#addForm").attr("action", "print/findByList");
	    $("#addForm").submit(); 
 	}
 
/*  function pageSetting(){
	 var option = $("#pagesetting").val();
	 if(option=="0"){
		 $(".page").hide();
		 $("#width").val(210);
		 $("#height").val(297);
	 }else if(option=="1"){
	  	 $(".page").hide();
	 	 $("#width").val(176);
	 	 $("#height").val(250);
	 }else if (option=="2"){
	 	 $(".page").show();
	 	 $("#width").val("");
	 	 $("#height").val("");
	 }
 } */
 
 $(function () {
   // pageSetting();
      var returninfo = '${printtemplate.returninfo}';
      if (returninfo != '') {
       	$.dialog.tips(returninfo, 1, 'alert.gif');
      }
 });

function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
 }
  
 function checkLength(object, maxlength) {
   var obj = $('#' + object),
       value = $.trim(obj.val());
   if (value.length > maxlength) {
     obj.val(value.substr(0, maxlength));
   } else {
     $('#validNum' + object).html(maxlength - value.length);
   }
 }
  
function clearTemplate(){
$('#value').val('');
}
  
</script>
</body>
</html>
