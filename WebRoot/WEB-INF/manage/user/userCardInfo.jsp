<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="userCardInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="8" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="usercard.state"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
          </tr>
          
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.cardid}">
	        	    	<input type="hidden" id="state_${dataList.cardid}" value="${dataList.state }" >
	        	    </td>
	        		<td >${dataList.cardid }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="usercard.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td>${dataList.stbno}</td>
	        	</tr>
        </c:forEach>
        </table>
 </div>  
 
 <div class="userTerminalInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="8" style="font-weight: bold;"><spring:message code="user.terminalinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="user.terminalid"/></td>
          		<td><spring:message code="user.terminaltype"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="user.terminalstate"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
          </tr>
       
          <c:forEach items="${user.user.userstblist }" var="dataList">
          	<c:if test="${dataList.incardflag == '2'}">
	        	<tr height="30" class="lb-list">
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.stbno}">
	        	    	<input type="hidden" id="state_${dataList.stbno}" value="${dataList.state }" >
	        	    	<input type="hidden" id="type_${dataList.stbno}" value="0" >
	        	    </td>
	        		<td >${dataList.stbno }</td>
	        		 <td><spring:message code="user.terminaltype.0"/></td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td></td>
	        	</tr>
	        </c:if>
         </c:forEach>
         
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30" class="lb-list">
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.cardid}">
	        	    	<input type="hidden" id="state_${dataList.cardid}" value="${dataList.state }" >
	        	    	<input type="hidden" id="type_${dataList.cardid}" value="1" >
	        	    </td>
	        		<td >${dataList.cardid }</td>
	        		<td><spring:message code="user.terminaltype.1"/></td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="usercard.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td>${dataList.stbno}</td>
	        	</tr>
        </c:forEach>
        </table>
 </div> 
 
 <div class="userRebackTerminalInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="8" style="font-weight: bold;"><spring:message code="user.terminalinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td width="60"><spring:message code="page.select"/></td>
          		<td><spring:message code="device.deviceno"/></td>
          		<td><spring:message code="user.terminaltype"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="user.terminalstate"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
          </tr>
       
          <c:forEach items="${user.user.userstblist }" var="dataList">
        	<tr height="30" class="lb-list">
        		<td width="" height="30">
        	    	<input type="radio"  name="_selKey"  value="${dataList.stbno}">
        	    	<input type="hidden" id="state_${dataList.stbno}" value="${dataList.state }" >
        	    	<input type="hidden" id="type_${dataList.stbno}" value="0" >
        	    </td>
        		<td >${dataList.stbno }</td>
        		 <td><spring:message code="user.terminaltype.0"/></td>
        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
        		<td></td>
        	</tr>
         </c:forEach>
         
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        
        	<tr height="30" class="lb-list">
        		<td width="" height="30">
        	    	<input type="radio"  name="_selKey"  value="${dataList.cardid}">
        	    	<input type="hidden" id="state_${dataList.cardid}" value="${dataList.state }" >
        	    	<input type="hidden" id="type_${dataList.cardid}" value="1" >
        	    </td>
        		<td >${dataList.cardid }</td>
        		<td><spring:message code="user.terminaltype.1"/></td>
        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
        		<td ><spring:message code="usercard.state.${dataList.state }"/></td>
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