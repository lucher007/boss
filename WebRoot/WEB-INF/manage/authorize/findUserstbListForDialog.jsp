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
</head>
<body>
	<div id="body">
		<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.stb"/> &gt; <spring:message code="stb.stbquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="versiontype" id="versiontype" value="${userstb.versiontype }"/>
        	<input type="hidden" name="netid" id="netid" value="${userstb.netid }"/>
            <table width="100%">
				<tr>
					<td align="right"><spring:message code="stb.stbno"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querystbno" id="querystbno" value="${userstb.querystbno }">
					</td>
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryStb();"/>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		    <td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="stb.incardflag"/></td>
	          	<%-- <td><spring:message code="stb.cardid"/></td> --%>
        	</tr>
        	<c:forEach items="${userstb.userstblist }" var="dataList">
	        	<tr height="30" class="lb-list">
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.stbno }">
	        	    </td>
	        		<td >${dataList.stbno }</td>
	        		<td><spring:message code="userstb.incardflag.${dataList.incardflag }"/></td>
	        		<%-- <td >${dataList.cardid }</td> --%>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="authorize/findUserstbListForDialog"
			    items="${userstb.pager_count}"
			    index="center"
			    maxPageItems="5"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="versiontype" value="${userstb.versiontype}"/>
				<pg:param name="netid" value="${userstb.netid}"/>
				<pg:param name="querystbno" value="${userstb.querystbno}"/>
				<pg:index>
					<spring:message code="page.total"/>:${userstb.pager_count}
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
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
	<script type="text/javascript">

	$(function() {
		var returninfo = '${stb.returninfo}';
		if (returninfo != '') {
			$.dialog.tips(returninfo, 1, 'alert.gif');
		}
	});

	$(".lb-list").click(function() {
		var stbno = $(this).find("input[type=radio]").val();
		$(this).find("input[type=radio]").attr('checked', 'true');
		parent.closeDialog(stbno);
	});
		
		//查询机顶盒
	function queryStb(){
		$("#searchForm").attr("action", "authorize/findUserstbListForDialog");
		$("#searchForm").submit();
	}	
		
	</script>
</body>
</html>
