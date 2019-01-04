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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.operatorreportlist" /></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
		    	<tr>
		    	<td align="right" width="120px"><spring:message code="operator.operatorname" />：</td>
        			<td>
        				<input type="text" class="inp w200" name="queryoperatorname" id="queryoperatorname"  value="${operator.queryoperatorname }">
        			</td>

		    		<td align="right" width="120px"><spring:message code="store.storename" />：</td>
		    		<td>
						 <select id="querystoreid" name="querystoreid" class="select" onchange="queryOperator();">
							 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${operator.storemap}" var="storemap" varStatus="s">
			                   <option value="${storemap.key}" <c:if test="${operator.querystoreid == storemap.key }">selected</c:if>>${storemap.value}</option>
			                </c:forEach>
			             </select>
					</td>
		    		<td>
        				<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryOperator();"/>
   		    		</td>
		    	</tr>
        		<tr>
        			
        			<td align="right"><spring:message code="operator.operatorcode" />：</td>
		    		<td colspan="3">
		    			<input type="text"  class="inp w200" name="queryoperatorcode" id="queryoperatorcode" value="${operator.queryoperatorcode }">
		    		</td>
        		
   		    	</tr>
   		    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td><spring:message code="operator.operatorname"/></td>
            <td><spring:message code="operator.operatorcode"/></td>
            <td><spring:message code="operator.mobile"/></td>
            <td><spring:message code="operator.documenttype"/></td>
            <td><spring:message code="operator.documentno"/></td>
	        <td><spring:message code="page.query" /></td>
          </tr>
          <c:forEach items="${operator.operatorlist}" var="dataList" varStatus="vs">
	          <tr class="lb-list">
	          
				<td height="30" title="${dataList.operatorname}">${fn:substring(dataList.operatorname, 0, 20)}&nbsp;</td>
				<td>${dataList.operatorcode }&nbsp;</td>
				<td>${dataList.mobile}&nbsp;</td>
				<td title="${dataList.documenttype}">${fn:substring(dataList.documenttype, 0, 20)}&nbsp;</td>
				<td title="${dataList.documentno}">${fn:substring(dataList.documentno, 0, 20)}&nbsp;</td>
	           	<td><a href="javascript:operationReport(${dataList.id },'${dataList.operatorname }');" ><spring:message code="statistic.operation.record" /></a></td>
	          </tr>
          </c:forEach>
        </table>
        
       <div class="page">
    	<cite>
        	<pg:pager
			    url="statistic/findOperatorList"
			    items="${operator.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="queryoperatorname" value="${operator.queryoperatorname}"/>
				<pg:param name="querystoreid" value="${operator.querystoreid}"/>
				<pg:param name="queryoperatorcode" value="${operator.queryoperatorcode}"/>
				<pg:param name="jumping" value="${operator.jumping}"/>
				
				<pg:index>
					<spring:message code="page.total"/>:${operator.pager_count}
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
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?skin=iblue&self=true"></script>
<script type="text/javascript">
	//查询操作员
	function queryOperator(){
		$("#searchForm").attr("action", "statistic/findOperatorList?jumping=findOperatorListForOperationStatistic");
		$("#searchForm").submit();
	}	

	
	$(function () {
       var returninfo = '${area.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    
    
    var operationReportForDialog;
	
	 function operationReport(operatorid, operatorname) {
	    	operationReportForDialog = $.dialog({
		    	title: '<spring:message code="statistic.operation.record" />('+operatorname+')',
		    	lock: true,
		    	width: 900,
		    	height: 500,
		    	top: 0,
		    	drag: true,
		    	resize: false,
		    	max: false,
		    	min: false,
		    	content: 'url:statistic/operationRecordForDialog?operatorid='+operatorid+'&operatorname='+operatorname+"&rid="+Math.random()
				});
								
	 }
</script>
</body>
</html>