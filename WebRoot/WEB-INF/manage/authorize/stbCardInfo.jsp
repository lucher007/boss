<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="stbCardInfo">
    	<table>
          
          <tr class="fbc-tit">
            <td colspan="4" style="font-weight: bold;" align="center"><spring:message code="authorize.bind.cardinfo"/></td>
          </tr>
        
          <tr class="lb-tit">
	          	<td><spring:message code="card.stbno"/></td>
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="card.incardflag"/></td>
           		<td style="white-space: nowrap;width: 51px">
           				<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						<label for="checkall"><spring:message code="page.select.all" /></label>
				</td>
         </tr>
         
         <c:forEach items="${userstb.bingUsercardList }" var="dataList">
	        	<tr height="30"class="lb-list cardflag">
	        		<td>${dataList.stbno }</td>
	        		<td>${dataList.cardid }</td>
	        		<td>
	        		<c:if test="${dataList.incardflag ne null || dataList.incardflag ne '' }">
	        			<spring:message code="card.incardflag.${dataList.incardflag }"/>
	        		</c:if>
	        		</td>
					<td><input type="checkbox" class="checkbox" name="ids" id="ids" value="${dataList.cardid}" onclick="checkbox();" style="vertical-align: middle;"></td>	        	
				</tr>
         </c:forEach>
     
        </table>
 </div>   	