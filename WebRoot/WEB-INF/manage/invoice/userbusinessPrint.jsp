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
			<div id="printInfo" style="display: none"></div>
			<table>
				<tr class="fbc-tit">
					<td colspan="7" style="font-weight: bold;"><spring:message code="menu.business.businessquery" /></td>
				</tr>
				<tr class="lb-tit">
					<td width="60"><spring:message code="page.select" /></td>
					<td><spring:message code="userbusiness.addtime" /></td>
					<td><spring:message code="userproduct.source" /></td>
					<td><spring:message code="userbusiness.shouldmoney" /></td>
					<td><spring:message code="page.operate" /></td>
					<!-- 	<td style="white-space: nowrap;width: 51px">
		          		<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						<label for="checkall"><spring:message code="page.select.all" /></label>
					</td> -->
				</tr>
				<c:forEach items="${userbusiness.userbusinesslist }" var="dataList">
					<tr height="30" class="lb-list">
						<td width="" height="30"><input type="radio" name="singleselect" value="${dataList.id }+${dataList.shouldmoney}">
						</td>
						<td>${fn:substring(dataList.addtime, 0, 19)}</td>
						<td><spring:message code="userproduct.source.${dataList.source}" /></td>
						<td>${dataList.shouldmoney}</td>
						<td>
							    <a class="btn-look" href="javascript:findDetailList(${dataList.id});" ><spring:message code="print.checklist"/></a>
						</td>
						
						<%-- 		        	
								<td ><input type="checkbox" class="checkbox" name="ids" value="${dataList.id}" onclick="checkbox();" onchange="loadPrintInfo();" style="vertical-align: middle;"></td>
						--%>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="page">
			<cite> <pg:pager url="print/findBusinessByList" items="${userbusiness.pager_count}" index="center"
					maxPageItems="${userbusiness.pager_openset}" maxIndexPages="5" isOffset="<%= true %>" export="offset,currentPageNumber=pageNumber"
					scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="userid" value="${userbusiness.userid}" />
					<pg:index>
						总共${userbusiness.pager_count}条记录
						<pg:first unless="current">
							<a href="<%=pageUrl%>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
							<a href="<%=prevPageUrl%>">前一页</a>
						</pg:prev>
						<pg:pages>
							<%
								if (pageNumber == currentPageNumber) {
							%><span style="font:bold 16px arial;"><%=pageNumber%></span>
							<%
								} else {
							%><a href="<%=pageUrl%>"><%=pageNumber%></a>
							<%
								}
							%>
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
							<a href="<%=nextPageUrl%>">下一页</a>
						</pg:next>
						<pg:last>
							<a href="<%=pageUrl%>">末页</a>
						</pg:last>
					</pg:index>
				</pg:pager>
		   </cite>
		</div>
		<div class="fb-bom">
	        <cite>
	            <a class="btn-a" href="javascript:selectInvoiceTmp()"><span class="print"><spring:message code="print.print" /></span></a>
	        </cite>
	        <span class="red">${user.returninfo }</span>
	    </div>
		<div class="pop-box" id="pop-div">
			<spring:message code="print.template" />:
			<select id="template_value" name="template_value" class="select">
				<c:forEach items="${printtemplate.templateMap}" var="templateMap" varStatus="s">
					<option value='${templateMap.key}'>${templateMap.value}</option>
				</c:forEach>
			</select> 
		</div>
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
		var install = '<spring:message code="print.plugin.excuteinstall"/>';
		var update = '<spring:message code="print.plugin.excuteupdate"/>';
		var refresh = '<spring:message code="print.plugin.refresh"/>';
		var notready = '<spring:message code="print.plugin.notready"/>';
		var error = '<spring:message code="print.plugin.error"/>';
		var paymoney = '';

		$(".lb-list").click(function() {
			var businessid = $(this).find("input[type=radio]").val().split("+")[0];
			paymoney = $(this).find("input[type=radio]").val().split("+")[1];
			$(this).find("input[type=radio]").attr('checked', 'true');
			//alert(businessid);
			var data = {
				businessid : businessid,
				tag : 'printInfo'
			};
			var url = 'print/getPrintInfo .' + data.tag;
			$('#printInfo').load(url, data, function() {
			});
		});

		function checkSelected() {
			for ( var i = 0; i < document.getElementsByName("singleselect").length; i++) {
				if (document.getElementsByName("singleselect")[i].checked) {//得到选中的单选按钮如果要得到值 那么
					return true;
				}
			}
			return false;
		};

		function selectInvoiceTmp() {
			if (checkSelected() == false) {
				$.dialog.tips('<spring:message code="print.printtarget.empty"/>', 1, 'alert.gif');
				return;
			}

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
			LODOP.SET_PRINT_STYLEA("totalPrice", "CONTENT", paymoney);
			LODOP.SET_PRINT_STYLEA("clientCode", "CONTENT", window.parent.getUsercode());
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
     
     
	</script>
</body>
</html>
