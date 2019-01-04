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
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
<style>
	html { overflow-x:hidden; }
    .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
   
  </style>
</head>

<body style="padding:0px; width:100%; ">
	<div class="form-box">
	    <div class="fb-con">
	      	<table>
	      	  <tr class="fbc-tit">
	            <td colspan="10" style="font-weight: bold;"><spring:message code="user.productinfo"/></td>
	          </tr>
	          <tr class="lb-tit">
	          		<td><spring:message code="user.terminalid"/></td>
	          		<td><spring:message code="user.terminaltype"/></td>
	          		<td><spring:message code="product.productid"/></td>
		          	<td><spring:message code="product.productname"/></td>
		          	<td><spring:message code="user.buytime"/></td>
		          	<td><spring:message code="userproduct.type"/></td>
		          	<td><spring:message code="userproduct.starttime"/></td>
		          	<td><spring:message code="userproduct.endtime"/></td>
		          	<td><spring:message code="userproduct.source"/></td>
		          	<td><spring:message code="userproduct.state"/></td>
	         </tr>
	         <c:forEach items="${userproduct.userproductlist }" var="dataList">
		        	<tr height="30"class="lb-list">
		        		<td >${dataList.terminalid }</td>
		        		<td ><spring:message code="user.terminaltype.${dataList.terminaltype }"/></td>
	        			<td >${dataList.productid }</td>
	        			<td >${dataList.productname }</td>
		        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
		        		<td ><spring:message code="userproduct.type.${dataList.type }"/></td>
		        		<td >${fn:substring(dataList.starttime, 0, 19)}</td>
		        		<td >${fn:substring(dataList.endtime, 0, 19)}</td>
		        		<td ><spring:message code="userproduct.source.${dataList.source }"/></td>
		        		<td ><spring:message code="userproduct.state.${dataList.state }"/></td>
		        	</tr>
	        	</c:forEach>
	        </table>
		</div>
	    <div class="page">
	    	<cite>
				<pg:pager
				    url="userproduct/findByList"
				    items="${userproduct.pager_count}"
				    index="center"
				    maxPageItems="5"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">	
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="userid" value="${userproduct.userid}"/>
					<pg:param name="cardid" value="${userproduct.cardid}"/>
					<pg:index>
						<spring:message code="page.total"/>:${userproduct.pager_count}
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
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
</script>
</body>
</html>

