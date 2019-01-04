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
	 <% String start =  (String)request.getAttribute("querystarttime");
		  String end =  (String)request.getAttribute("queryendtime");
	%> 
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.stat.manage" /> &gt; <spring:message code="menu.stat.productbuyedstat" /></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td>
						 <select id="querynetid" name="querynetid" class="select" onchange="queryProduct();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${product.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${product.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<td align="right" width="120px"><spring:message code="product.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" onchange="queryProduct();">
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${product.querystate == '0'}">selected</c:if>><spring:message code="product.state.0"/></option>
			                   <option value="1" <c:if test="${product.querystate == '1'}">selected</c:if>><spring:message code="product.state.1"/></option>
			             </select>
					</td>
					<td width="130px">
						 <a onclick="saveDownloadEventFile();" class="btn-add3"><span><spring:message code="statistic.exportexcel" /></span></a>
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="product.productname"/>：</td>
					<td colspan= 3>
						 <input type="text"  class="inp w200" name="queryproductname" id="queryproductname" value="${product.queryproductname }">
					</td>
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryProduct();"/>
		    		</td>
				</tr>
				<tr>
				<td align="right"><spring:message code="statistic.userproduct.querystarttime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="querystarttime" name="querystarttime" value="<%=start%>" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
					<td align="right"><spring:message code="statistic.userproduct.queryendtime"/>：</td>
					<td>
                 		<input type="text" readonly="readonly" id="queryendtime" name="queryendtime" value="<%=end%>" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
				</tr>
    	    </table>
    	 </form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
	          	<td><spring:message code="product.productname"/></td>
	          	<td><spring:message code="product.state"/></td>
	          	<td><spring:message code="statistic.userproduct.openbalance"/></td>
	          	<td><spring:message code="statistic.userproduct.closingbalance"/></td>
	          	<td><spring:message code="statistic.userproduct.entitlementadded"/></td>
	          	<td><spring:message code="statistic.userproduct.entitlementremoved"/></td>
	          	<td><spring:message code="statistic.userproduct.entitlementexpired"/></td>
		        <td><spring:message code="statistic.userproduct.timeperiod"/></td>
        	</tr>
        	
        	<c:forEach items="${product.productlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	    <td class="remarkClass" title="${dataList.network.netname }">${fn:substring(dataList.network.netname, 0, 20)}&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.productname }">${fn:substring(dataList.productname, 0, 20)}&nbsp;</td>
	        		<td >
	        			<spring:message code="product.state.${dataList.state}"/>
	        		</td>
	        		<td>${dataList.businessReport.openingBalance }</td>
	          		<td>${dataList.businessReport.closingBalance}</td>
	          		<td>${dataList.businessReport.entitlementAdded }</td>
	          		<td>${dataList.businessReport.entitlementRemoved }</td>
	          		<td>${dataList.businessReport.entitlementExpired }</td>
	        		<td>
 	      			<spring:message code="statistic.userproduct.from"/> ${dataList.businessReport.querystarttime } <spring:message code="statistic.userproduct.to"/> ${dataList.businessReport.queryendtime }
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="statistic/findUserProductList"
			    items="${product.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${product.querynetid}"/>
				<pg:param name="querystate" value="${product.querystate}"/>
				<pg:param name="queryproductid" value="${product.queryproductid}"/>
				<pg:param name="queryproductname" value="${product.queryproductname}"/>
				<pg:param name="querystarttime" value="<%=start%>"/>
				<pg:param name="queryendtime" value="<%=end%>"/>
				<pg:index>
					<spring:message code="page.total"/>:${product.pager_count}
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
<script type="text/javascript">
	
	function queryProduct(){
		$("#searchForm").attr("action", "statistic/findUserProductList");
		$("#searchForm").submit();
	}	

	function saveDownloadEventFile(){
		$("#searchForm").attr("action", "statistic/findExportUserProductReportExcel");
		$("#searchForm").submit();
	}

	function updateProduct(id){
		$("#searchForm").attr("action", "product/updateInit?id="+id+"&pager_offset="+'${product.pager_offset}');
		$("#searchForm").submit();
	}
	
	$(function () {
       var returninfo = '${product.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });

</script>
</body>
</html>

