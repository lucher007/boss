<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 发票打印表格 -->
<div class="printInfo">
    	<table border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse" bordercolor="#333333" >
        <c:forEach items="${userbusinessdetail.userbusinessdetaillist }" var="dataList">
		        	<tr height="30"class="lb-list">
		        		<td width="20%"align="center">${dataList.businesstypename }</td>
		        		<td width="30%"align="center">${dataList.content }</td>
		        		<td width="35%" align="center">${fn:substring(dataList.addtime, 0, 19)}</td>
		        		<td width="15%" align="right">${dataList.totalmoney }</td>
		        	</tr>
	         </c:forEach>
        </table>
</div>

<!-- 发票模板 -->
<div class="invoiceTmpInfo">
		<spring:message code="print.template"/>:
		<select id="template_value" name="template_value" class="select">
			<c:forEach items="${printtemplate.templateMap}" var="templateMap" varStatus="s">
				<option value='${templateMap.value}'>${templateMap.key}</option>
			</c:forEach>
		</select> 
</div>



