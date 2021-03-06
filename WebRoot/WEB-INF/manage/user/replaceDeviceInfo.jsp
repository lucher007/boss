<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="userStbInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="7" style="font-weight: bold;"><spring:message code="user.stbinfo"/></td>
            <td align="right">
            </td>
          </tr>
          <tr class="lb-tit">
                <td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="stb.stbno"/></td>
          		<td><spring:message code="user.buytime"/></td>
          		<td><spring:message code="stb.price"/></td>
	          	<td><spring:message code="userstb.state"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
	          	<td><spring:message code="userstb.incardflag"/></td>
         </tr>
         <c:forEach items="${user.user.userstblist }" var="dataList">
	        	<tr height="30" class="lb-list stbflag" >
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.stbno }">
	        	    </td>
	        		<td >${dataList.stbno }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td >${dataList.price }</td>
	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td ><spring:message code="userstb.incardflag.${dataList.incardflag }"/></td>
	        	</tr>
        	</c:forEach>
        </table>
 </div>   
<div class="userCardInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="6" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td>
            <td align="right">
            </td>
          </tr>
          <tr class="lb-tit">
                <td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="card.cardid"/></td>
          		<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="card.price"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
         </tr>
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30"class="lb-list cardflag">
	        	    <td width="" height="30">
	        			<input type="radio"  name="_selKey"  value="${dataList.cardid }">
	        	    </td>
	        		<td >${dataList.cardid }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td >${dataList.price }</td>
	        		<td >
		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td >${dataList.stbno }</td>
	        	</tr>
        	</c:forEach>
        </table>
 </div>   	