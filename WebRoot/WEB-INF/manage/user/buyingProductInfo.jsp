<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="buyingProductInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="11" style="font-weight: bold;"><spring:message code="userproduct.buyingproductlist"/></td>
            <!-- 
            <td align="right">
            	<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addProduct();" id="btnfinish">&nbsp;&nbsp;&nbsp;
            </td>
             -->
          </tr>
          <tr class="lb-tit">
                <td><spring:message code="user.terminalid"/></td>
                <td><spring:message code="user.terminaltype"/></td>
          		<td><spring:message code="product.productid"/></td>
	          	<td><spring:message code="product.productname"/></td>
	          	<td><spring:message code="userproduct.type"/></td>
	          	<td><spring:message code="userproduct.starttime"/></td>
	          	<td><spring:message code="userproduct.endtime"/></td>
	          	<td><spring:message code="userproduct.price"/></td>
	          	<td><spring:message code="userproduct.buyamount"/></td>
	          	<td><spring:message code="userproduct.totalmoney"/></td>
	          	<td><spring:message code="page.operate"/></td>
         </tr>
         <c:forEach items="${user.user.buyingproductlist }" var="dataList">
	        	<tr height="30"class="lb-list productflag">
	        		<td >${dataList.terminalid }</td>
	        		<td ><spring:message code="user.terminaltype.${dataList.terminaltype}"/></td>
        			<td >${dataList.productid }</td>
        			<td >${dataList.productname }</td>
	        		<td ><spring:message code="userproduct.type.${dataList.type}"/></td>
	        		<td >${fn:substring(dataList.starttime, 0, 19)}</td>
	        		<td >${fn:substring(dataList.endtime, 0, 19)}</td>
	        		<td >${dataList.price }/<spring:message code="para.unit.${dataList.unit}"/></td>
	        		<td >${dataList.buyamount }</td>
	        		<td >${dataList.totalmoney }</td>
	        		<td>
	        			<a class="btn-del" href="javascript:deleteBuyingProduct('${dataList.terminalid}','${dataList.productid}');" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
        </table>
 </div>   	