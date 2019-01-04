<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="refServiceInfo">
   	<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center" colspan="8">
              <input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
              <label for="checkall"><spring:message code="page.select.all"/></label>
            </td>
          </tr>
            <c:forEach items="${product.servicelist}" var="service" varStatus="s">
              <c:if test="${s.index % 4 == 0}">
                <tr>
              </c:if>
              <td align="right">
                <input type="checkbox" class="checkbox" name="ids" id="${service.id}" value="${service.serviceid}"
                       onclick="checkbox();" style="vertical-align: middle;"
                       <c:if test="${service.belongproduct}">checked</c:if>>
              </td>
              <td>
                <label for="${service.id}">${service.servicename}(${service.serviceid})</label>
              </td>
              <c:if test="${s.count % 4 == 0 or s.last}">
                </tr>
              </c:if>
            </c:forEach>
        </table>
 </div>   	