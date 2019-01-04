<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="buyingStbInfo">
    	<table>
          <tr class="fbc-tit">
            <td colspan="6" style="font-weight: bold;"><spring:message code="userstb.buyingstblist"/></td>
            <td align="right">
            	<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addStb();" id="btnfinish">&nbsp;&nbsp;&nbsp;
            </td>
          </tr>
          <tr class="lb-tit">
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="stb.price"/></td>
	          	<td><spring:message code="server.servername"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
	          	<td><spring:message code="userstb.incardflag"/></td>
	          	<td><spring:message code="page.operate"/></td>
         </tr>
         <c:forEach items="${user.user.buyingstblist }" var="dataList">
	        	<tr height="30" class="lb-list stbflag" >
	        		<td >${dataList.stbno }</td>
	        		<td >${dataList.price }</td>
	        		<td >${dataList.servername }</td>
	        		<td >
	        			<c:if test="${dataList.incardflag=='2'}">
	        				<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        			<a class="btn-edit" href="javascript:updateMothercardflagInit('0','${dataList.stbno}');"><spring:message code="page.update"/></a>
	        			</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td ><spring:message code="userstb.incardflag.${dataList.incardflag }"/></td>
	        		<td>
	        			<c:if test="${dataList.incardflag eq '2'}">
	        				<a class="btn-add" href="javascript:addProduct('','${dataList.stbno}','${dataList.mothercardflag}','${dataList.mothercardid}');" ><spring:message code="business.type.buyproduct"/></a>
	        			</c:if>
	        			<c:if test="${user.user.stbcardpairflag eq '1' && dataList.incardflag ne '2' && dataList.buycardflag eq '0'}">
	        				<a class="btn-add" href="javascript:addCard('${dataList.stbno}');" ><spring:message code="business.type.buycard"/></a>
	        			</c:if>
	        			<a class="btn-del" href="javascript:deleteBuyingStb('${dataList.stbno}');" ><spring:message code="page.delete"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
        </table>
 </div>   	