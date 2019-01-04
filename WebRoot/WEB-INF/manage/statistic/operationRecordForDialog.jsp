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
</head>

<body>
	<div id="body">
     <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
       		  <input type="hidden" id="operatorid" name="operatorid" value="${userbusinessdetail.operatorid}" />
              <input type="hidden" id="operatorname" name="operatorname" value="${userbusinessdetail.operatorname}" />
       
       <table width="100%">
				<tr>
					<td align="right"><spring:message code="statistic.querytime.range" />：</td>
					<td>
						<select id="querydatetype" name="querydatetype" class="select" onChange="queryDateType()">
								<option value="1" <c:if test="${userbusinessdetail.querydatetype == '1'}">selected</c:if>><spring:message code="statistic.querytime.byyear" /></option>
								<option value="2" <c:if test="${userbusinessdetail.querydatetype == '2'}">selected</c:if>><spring:message code="statistic.querytime.bymonth" /></option>
								<option value="3" <c:if test="${userbusinessdetail.querydatetype == '3'}">selected</c:if>><spring:message code="statistic.querytime.byday" /></option>
						</select>
					</td>
									
					<td align="right"><spring:message code="statistic.querydate" />：</td>
					<td>
                 		 <input value="${userbusinessdetail.queryyear}" type="text" id="queryyear" name="queryyear" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy'});" class="Wdate inp w150" />
					     <input value="${userbusinessdetail.querymonth}" type="text" id="querymonth" name="querymonth" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowClear:true,dateFmt:'yyyy-MM'});" class="Wdate inp w150" />
					     <input value="${userbusinessdetail.queryday}" type="text" id="queryday" name="queryday" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
				
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryDate();"/>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    
    	<div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td><spring:message code="user.username" /></td>
            <td><spring:message code="business.type" /></td>
            <td><spring:message code="statistic.operation.content" /></td>
            <td><spring:message code="statistic.totalprice" /></td>
          </tr>
          <c:forEach items="${userbusinessdetail.userbusinessdetaillist}" var="dataList" varStatus="vs">
	          <c:if test="${dataList.businesstypekey ne 'transferusered'}">
		          <tr class="lb-list">	          
					<td height="30" title="${dataList.user.username}">${fn:substring(dataList.user.username, 0, 30)}&nbsp;</td>
					<td> <spring:message code="business.type.${dataList.businesstypekey }" />&nbsp;</td>
					<td title="${dataList.content}">${fn:substring(dataList.content, 0, 30)}&nbsp;</td>
					<td>${dataList.totalmoney}&nbsp;</td>								
		          </tr>
	          </c:if>
          </c:forEach>
    	 </table>
    </div>
    	    
    	   <div class="page">
        	<cite>
             <pg:pager
				    url="statistic/operationRecordForDialog"
				    items="${userbusinessdetail.pager_count}"
				    index="center"
				    maxPageItems="5"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">	
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="operatorid" value="${userbusinessdetail.operatorid }"/>
					<pg:param name="operatorname" value="${userbusinessdetail.operatorname }"/>
					<pg:param name="querydatetype" value="${userbusinessdetail.querydatetype }"/>
					<pg:param name="queryyear" value="${userbusinessdetail.queryyear }"/>
					<pg:param name="querymonth" value="${userbusinessdetail.querymonth }"/>
					<pg:param name="queryday" value="${userbusinessdetail.queryday }"/>
					<pg:index>
					
						<spring:message code="page.total"/>:${userbusinessdetail.pager_count}
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
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript">

	function queryDate(){
		$("#searchForm").attr("action", "statistic/operationRecordForDialog");
		$("#searchForm").submit();
	}
	
	 function queryDateType(){
	  	$("#queryyear").hide();
		$("#querymonth").hide();
		$("#queryday").hide();  
		if($("#querydatetype").val() =="1"){
			$("#queryyear").show(); 
		}else if ($("#querydatetype").val() == "2"){
			$("#querymonth").show(); 
		}else if ($("#querydatetype").val() == "3"){
			$("#queryday").show(); 
		}
	}
	
	$(function () {
   	   queryDateType();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
  
</script>
</body>
</html>

