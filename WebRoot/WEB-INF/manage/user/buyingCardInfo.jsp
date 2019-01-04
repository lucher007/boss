<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="buyingCardInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="5" style="font-weight: bold;"><spring:message code="usercard.buyingcardlist"/></td>
            <td align="right">
                <c:if test="${user.user.stbcardpairflag eq '0'}">
            		<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addCard('');" id="btnfinish">&nbsp;&nbsp;&nbsp;
            	</c:if>
            </td>
          </tr>
          <tr class="lb-tit">
                <!--
                <td width="60"><spring:message code="page.select"/></td>
          		 -->
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="card.price"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="card.stbno"/></td>
	          	<td><spring:message code="page.operate"/></td>
         </tr>
         <c:forEach items="${user.user.buyingcardlist }" var="dataList">
	        	<tr height="30"class="lb-list cardflag">
	        	    <!-- 
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.cardid }">
	        	    </td>
	        	     -->
	        		<td >${dataList.cardid }</td>
	        		<td >${dataList.price }</td>
	        		<td >
	        			<spring:message code="usercard.mothercardflag.${dataList.mothercardflag }"/>
	        			<a class="btn-edit" href="javascript:updateMothercardflagInit('1','${dataList.cardid}');"><spring:message code="page.update"/></a>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td >${dataList.stbno }</td>
	        		<td>
	        			<a class="btn-add" href="javascript:addProduct('${dataList.cardid }','','${dataList.mothercardflag}','${dataList.mothercardid}');" ><spring:message code="business.type.buyproduct"/></a>
	        		    <c:if test="${dataList.incardflag == '0'}">
	        				<a class="btn-del" href="javascript:deleteBuyingCard('${dataList.cardid}');" ><spring:message code="page.delete"/></a>
	      			    </c:if>
	      			</td>
	        	</tr>
        	</c:forEach>
        </table>
 </div>   	