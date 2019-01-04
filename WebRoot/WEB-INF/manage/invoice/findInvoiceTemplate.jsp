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
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<link type="text/css" rel="stylesheet" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>

<body>
	<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.invoicetemplate"/> &gt; <spring:message code="print.template.query"/></div>
        <form action="" method="post" id="searchForm" name="searchForm">
    		<div class="seh-box">
				<table width="100%">
				    <!--
					<tr>					
						<td align="right" width="120px"><spring:message code="print.template.code"/>：</td>
						<td align="left"><input type="text" class="inp w200"  name="querycode" id="querycode" value="${printtemplate.querycode}"></td>
						<td align="right">
							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addTemplate();" />
						</td>				
					</tr> 
					  -->
					<tr>
						<td align="right"><spring:message code="print.template.name"/>：</td>
						<td>
							<input type="text" class="inp w200"  name="queryname" id="queryname" value="${printtemplate.queryname}">
						</td>	
						<td align="right">
							<%-- 
							<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryTemplate();" />
							<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addTemplate();" />
							 --%>
							<a href="javascript:queryTemplate();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
							<a href="javascript:addTemplate();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
						</td>
					</tr>
			
				</table>
			</div>
    
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		
    		<tr class="lb-tit">
				<!--     			
				<td><spring:message code="print.template.code"/></td>
				 -->	      
 			   	<td><spring:message code="print.template.name"/></td>
	          	<td><spring:message code="operator.addtime"/></td>   
	            <td><spring:message code="print.template"/></td>   
		        <td><spring:message code="page.operate"/></td>	       
        	</tr>

        	<c:forEach items="${printtemplate.printtemplatelist }" var="dataList">
	        	<tr height="30"class="lb-list">
					<%-- 	        	 	
					<td >${dataList.code}</td>
					 --%>	        		
 					<td >${dataList.name}</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		
	        		<td>	
	        			<input type="hidden" id='${dataList.id}' readonly="readonly" value='${dataList.value}' />
	        			<a class="btn-look" href="javascript:previewTemplate(${dataList.id});" ><spring:message code="print.preview"/></a>
	        		</td>
	        		
	        		<td>
	        			<a class="btn-edit" href="javascript:updateTemplate('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deleteTemplate(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	
	        	</tr>
        	</c:forEach>
    	
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="print/findByList"
			    items="${printtemplate.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querycode" value="${printtemplate.querycode}"/>
				<pg:param name="queryname" value="${printtemplate.queryname}"/>
				
				<pg:index>
					<spring:message code="page.total"/>:${printtemplate.pager_count}
					<pg:first unless="current">
						<a href="<%=pageUrl %>"><spring:message code="pape.firstpage"/></a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
				  		<a href="<%= prevPageUrl %>"><spring:message code="page.prevpage"/></a>
					</pg:prev>
					<pg:pages>
	   					<%if (pageNumber == currentPageNumber) { 
				    	%><span style="font:bold 16px arial;"><%= pageNumber %></span><%
				  		} else {
				    	%><a href="<%= pageUrl %>"><%= pageNumber %></a><%
				   		}
						%>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
				  		<a href="<%= nextPageUrl %>"><spring:message code="page.nextpage"/></a>
					</pg:next>
					<pg:last>
						<a href="<%=pageUrl %>"><spring:message code="page.lastpage"/></a>
					</pg:last>
				</pg:index>
			</pg:pager>
    	</cite>
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
	
	$(function () {
       var returninfo = '${dispatch.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
	function queryTemplate(){
	    $("#searchForm").attr("action", "print/findByList");
		$("#searchForm").submit();
	}	
	
	function addTemplate(){
		$("#searchForm").attr("action", "print/addInit");
		$("#searchForm").submit();
	}	
	
	function previewTemplate(id){
		  var valuestring = $("#"+ id).val();
		  LODOP=getLodop(); 		
		  eval(valuestring); 
		  LODOP. SET_SHOW_MODE("HIDE_DISBUTTIN_SETUP",true);
		  LODOP. SET_SHOW_MODE("HIDE_PBUTTIN_SETUP",true);
		  LODOP. SET_SHOW_MODE("HIDE_VBUTTIN_SETUP",true);
		  LODOP. SET_SHOW_MODE("HIDE_ABUTTIN_SETUP",true);
		  LODOP. SET_SHOW_MODE("HIDE_RBUTTIN_SETUP",true);
		  LODOP. SET_SHOW_MODE("HIDE_ITEM_LIST ",true);
		  LODOP.PRINT_SETUP();
	};
	
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () {
	      if (!$(this).attr('checked')) {
	        checked = false;
	      }
	    });
	    $('#checkall').attr('checked', checked);
	}
	
	function deleteTemplate(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			 '<spring:message code="page.confirm"/>',
			 '<spring:message code="page.cancel"/>',
			 function(){ 
				$("#searchForm").attr("action", "print/delete?id="+id+"&pager_offset="+'${printtemplate.pager_offset}'+"&rid="+Math.random()).submit();
			}, function(){
						});
	}

	function updateTemplate(id) {
		$("#searchForm").attr("action","print/updateInit?id=" + id + "&pager_offset="+ '${printtemplate.pager_offset}').submit();
	}

 
</script>
</body>
</html>

