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
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" /> &gt; <spring:message code="menu.authorize.authorizequery" /></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
							<td align="right" width="120px"><spring:message code="授权类型"/>：</td>
					<td>
                                <select id="queryterminaltype" name="queryterminaltype" class="select">
					                   <option value="0"><spring:message code="server.versiontype.gos_pn"/></option>
					                   <option value="1"><spring:message code="server.versiontype.gos_gn"/></option>
					             </select>		
					</td>
						<td align="right">终端号：</td>
						<td><input type="text" class="inp w200"  name="queryterminalid" id="queryterminalid" value="${authorizehistory.terminalid}"></td>										
						<td><input type="button" class="btn-sch" value="搜索" onclick="queryRecord();" /></td>
					</tr>
					<%-- 	<tr>
									
									<td align="right"><spring:message code="statistic.userproduct.querystarttime"/>：</td>
									<td>
				                 		<input type="text" id="querystarttime" name="querystarttime"  onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
									</td>
									<td align="right"><spring:message code="statistic.userproduct.queryendtime"/>：</td>
									<td>
				                 		<input type="text" id="queryendtime" name="queryendtime"  onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
									</td>
									<td width="130px"><input type="button" class="btn-add" value="刷新授权" onclick="queryRecord();" /></td>
						</tr> --%>
      
   		    </table>
   		</form>
    </div>
    <div class="lst-box">
			<table id="treetable" class="treetable" width="100%" border="0" cellspacing="0" cellpadding="0">
          	<tr class="lb-tit">
			            <td><spring:message code="卡号/机顶盒号"/></td>
			            <td><spring:message code="CA类型"/></td>
					    <td><spring:message code="操作日期"/></td>
          </tr>
          <c:forEach items="${authorizehistory.authorizehistorylist}" var="dataList" varStatus="vs">
				<tr height="30"class="lb-list">
				        <td>${dataList.cardid}</td>
				        <td>${dataList.versiontype}</td>
						<td>${dataList.addtime}</td>
						
		          </tr>
          </c:forEach>
        </table>
        
       <div class="page">
    	<cite>
        	<pg:pager
			    url="authorize/findByList"
			    items="${authorizehistory.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:index>
					<spring:message code="page.total"/>:${authorizehistory.pager_count}
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
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

	//查询操作员
	function queryRecord(){
		$("#searchForm").attr("action", "authorize/findByList");
		$("#searchForm").submit();
	}	

	$(function (){
       var returninfo = '${authorizehistory.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });

</script>
</body>
</html>