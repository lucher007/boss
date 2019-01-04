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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.userlevel"/> &gt; <spring:message code="userlevel.userlevelquery"/></div>
    <form action="" method="post" id="searchForm" name="searchForm">
    <div class="seh-box">
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="userlevel.levelname"/>：</td>
					<td width="20%">
						 <input type="text"  class="inp w200" name="querylevelname" id="querylevelname" value="${userlevel.querylevelname }">
					</td>
					<td width="130px" align="right">
		    			<%-- 
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryUserlevel();"/>
		    			<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addUserlevel();"/>
		    			 --%>
		    			<a href="javascript:queryUserlevel();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    			<a href="javascript:addUserlevel();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
		    		</td>
				</tr>
    	    </table>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="userlevel.levelname"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${userlevel.userlevellist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td title="${dataList.levelname}">${fn:substring(dataList.levelname, 0, 30)}</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateUserlevel('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<a class="btn-del" href="javascript:deleteUserlevel(${dataList.id });" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="userlevel/findByList"
			    items="${userlevel.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="queryuserlevelname" value="${userlevel.querylevelname}"/>
				<pg:index>
					<spring:message code="page.total"/>:${userlevel.pager_count}
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
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryUserlevel(){
		$("#searchForm").attr("action", "userlevel/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addUserlevel(){
		$("#searchForm").attr("action", "userlevel/addInit");
		$("#searchForm").submit();
	}	
    
    function addBatch(){
		$("#searchForm").attr("action", "userlevel/addByImportFileInit");
		$("#searchForm").submit();
	}	
    
    
    /**
	*编辑
	*/
	function updateUserlevel(id){
		$("#searchForm").attr("action", "userlevel/updateInit?id="+id+"&pager_offset="+'${userlevel.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteUserlevel(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',  
			function(){ 
				$("#searchForm").attr("action", "userlevel/delete?id="+id+"&pager_offset="+'${userlevel.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${userlevel.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    //激活
    function activeUserlevel(){
	    var checked = false;
	    $('.checkbox').each(function () {
	      if ($(this).attr('checked')) {
	        return checked = true;
	      }
	    });
	    
		if(checked){
		    $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			    '<spring:message code="page.confirm"/>',
				'<spring:message code="page.cancel"/>', 
			    function(){ 
					$("#searchForm").attr("action", "userlevel/active"+"?pager_offset="+'${userlevel.pager_offset}'+"&rid="+Math.random());
					$("#searchForm").submit();
				}, function(){
					});
		}else{
			$.dialog.tips('<spring:message code="page.select.empty"/>',1,'alert.gif');
		}
		
	}
	
	//全选
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
    
</script>
</body>
</html>

