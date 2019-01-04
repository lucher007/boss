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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.businesstype"/> &gt; <spring:message code="businesstype.businesstypequery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="businesstype.typekey"/>：</td>
					<td width="130px"><input type="text" class="inp w200" name="querytypekey" id="querytypekey" value="${businesstype.querytypekey}"/></td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryBusinesstype();"/>
						 --%>
						<a href="javascript:queryBusinesstype();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					
					<td width="130px">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addBusinesstype();"/>
						 --%>
						<a href="javascript:addBusinesstype();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
					
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="businesstype.typekey"/></td>
          		<td><spring:message code="business.type"/></td>
	          	<td><spring:message code="businesstype.price"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${businesstype.businesstypelist }" var="dataList">
	        	<tr height="30" class="lb-list">
	        		<td>${dataList.typekey}</td>
	        		<c:choose>  
		               <c:when test="${dataList.definedflag == '0'}">
		               		<td><spring:message code="business.type.${dataList.typekey}"/></td>
		               </c:when>
		               <c:otherwise>
		               		<td>${dataList.typekey}</td>
		               </c:otherwise>
	                </c:choose>
	        		<td>${dataList.price}&nbsp;</td>
	        		<td>
	        			<a class="btn-edit" href="javascript:updateBusinesstype('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<c:if test="${dataList.definedflag == '1'}">
	           				<a class="btn-del" href="javascript:deleteBusinesstype(${dataList.id });" ><spring:message code="page.delete"/></a>
	      				</c:if>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="businesstype/findByList"
			    items="${businesstype.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querytypekey" value="${businesstype.querytypekey}"/>
				<pg:index>
					<spring:message code="page.total"/>:${businesstype.pager_count}
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
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    //查询
	function queryBusinesstype(){
		$("#searchForm").attr("action", "businesstype/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addBusinesstype(){
		$("#searchForm").attr("action", "businesstype/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateBusinesstype(id){
		$("#searchForm").attr("action", "businesstype/updateInit?id="+id+"&pager_offset="+'${businesstype.pager_offset}');
		$("#searchForm").submit();
	}
    
	
	$(function () {
       var returninfo = '${businesstype.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
	
	/**
	*删除
	*/
	function deleteBusinesstype(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			 '<spring:message code="page.confirm"/>',
			 '<spring:message code="page.cancel"/>',
			 function(){ 
				$("#searchForm").attr("action", "businesstype/delete?id="+id+"&pager_offset="+'${businesstype.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
</script>
</body>
</html>

