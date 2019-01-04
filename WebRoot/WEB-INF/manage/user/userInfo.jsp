<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="userInfo">
		<input type="hidden" name="id" id="id" value="${user.user.id}"/>
    	<table>
          <tr class="fbc-tit">
            <td colspan="7" style="font-weight: bold;"><spring:message code="user.userinfo"/></td>
            <td>
            	 <%-- 
		         <input type="button" class="btn-back" value="<spring:message code="page.switch"/>" onclick="switchUser('<spring:message code="menu.business.userquery"/>')" >
		          --%>
            	 <a href="javascript:switchUser('<spring:message code="menu.business.userquery"/>');" class="easyui-linkbutton" id="switchButton" iconCls="icon-back" style="width:80px"><spring:message code="page.switch"/></a>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.network.netname}">${fn:substring(user.user.network.netname, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="area.areacode"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.area.areaname}(${user.user.area.areacode})</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.usercode"/>：</td>
            <td width="15%" style="font-weight: bold;">${user.user.usercode}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.username"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.username}">${fn:substring(user.user.username, 0, 20)}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.mobile"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.mobile}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.telephone"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.telephone}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documenttype"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.documenttype}">${fn:substring(user.user.documenttype, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documentno"/>：</td>
            <td width="15%" style="font-weight: bold;" title="${user.user.documentno}">${fn:substring(user.user.documentno, 0, 20)}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.email"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.email}">${fn:substring(user.user.email, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.score"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.score}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.account"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.account}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.state"/>：</td>
            <td width="15%" style="font-weight: bold;">
               <c:choose>  
	               <c:when test="${user.user.state == '0' || user.user.state == '3'}">
	               		<span class="red"><spring:message code="user.state.${user.user.state}"/></span>
	               </c:when>
	               <c:otherwise>
	               		<spring:message code="user.state.${user.user.state}"/>
	               </c:otherwise>
               </c:choose>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.address"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" colspan="3" title="${user.user.address}">${fn:substring(user.user.address, 0, 70)}</td>
          	<td width="10%" align="right" class="line-r"><spring:message code="user.userlevel"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.userlevel.levelname}">${fn:substring(user.user.userlevel.levelname, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="systempara.remark"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.remark}">${fn:substring(user.user.remark, 0, 20)}</td>
          </tr>
        </table>
</div>

<div class="transferUserInfo">
		<input type="hidden" name="transferuserid" id="transferuserid" value="${user.user.transferuser.id}"/>
    	<table>
          <tr class="fbc-tit">
          	<td colspan="7" style="font-weight: bold;"><spring:message code="user.transferuserinfo"/></td>
            <td align="right">
            	<%-- 
            	<input type="button" class="btn-add" value="<spring:message code="page.select"/>" onclick="addUser();" id="btnfinish">&nbsp;&nbsp;&nbsp;
            	 --%>
            	<a href="javascript:addUser();" class="easyui-linkbutton" id="selectButton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.network.netname}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="area.areaname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">
              <c:if test="${user.user.transferuser.area.areacode ne null && user.user.transferuser.area.areacode ne ''}">
              	${user.user.transferuser.area.areaname}(${user.user.transferuser.area.areacode})
              </c:if>
              <c:if test="${user.user.transferuser.area.areacode eq null || user.user.transferuser.area.areacode eq ''}">
              	${user.user.transferuser.area.areaname}
              </c:if>
            </td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.usercode"/>：</td>
            <td width="15%" style="font-weight: bold;">${user.user.transferuser.usercode}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.username"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.username}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.mobile"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.mobile}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.telephone"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.telephone}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documenttype"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.documenttype}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documentno"/>：</td>
            <td width="15%" style="font-weight: bold;">${user.user.transferuser.documentno}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.email"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.email}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.score"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.score}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.account"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.transferuser.account}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.state"/>：</td>
            <td width="15%" style="font-weight: bold;">
            <c:if test="${user.user.transferuser.state != null}">
            	<spring:message code="user.state.${user.user.transferuser.state}"/>
            </c:if>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.address"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" colspan="7">${user.user.transferuser.address}</td>
          </tr>
        </table>
</div>

<div class="replaceStbInfo">
		<input type="hidden" name="replacestbid" id="replacestbid" value="${user.user.replacestb.id}"/>
    	<table>
          <tr class="fbc-tit">
          	<td colspan="5" style="font-weight: bold;"><spring:message code="user.stbinfo"/></td>
            <td align="right">
            	<%-- 
            	<input type="button" class="btn-add" value="<spring:message code="page.select"/>" onclick="selectStb();" id="btnfinish">&nbsp;&nbsp;&nbsp;
            	 --%>
            	<a href="javascript:selectStb();" class="easyui-linkbutton" id="selectStb" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacestb.network.netname}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.servername"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacestb.server.servername}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="stb.model"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacestb.model}</td>
          </tr>
           <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="stb.stbno"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacestb.stbno}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="stb.price"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacestb.saleprice}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="stb.incardflag"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">
	            <c:if test="${user.user.replacestb.incardflag != null}">
	            	<spring:message code="stb.incardflag.${user.user.replacestb.incardflag}"/>
	            </c:if>
            </td>
          </tr>
        </table>
</div>

<div class="replaceCardInfo">
		<input type="hidden" name="replacecardid" id="replacecardid" value="${user.user.replacecard.cardid}"/>
    	<table>
          <tr class="fbc-tit">
          	<td colspan="5" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td>
            <td align="right">
            	<%-- 
            	<input type="button" class="btn-add" value="<spring:message code="page.select"/>" onclick="selectCard();" id="btnfinish">&nbsp;&nbsp;&nbsp;
            	 --%>
            	<a href="javascript:selectCard();" class="easyui-linkbutton" id="selectCard" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacecard.network.netname}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.servername"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacecard.server.servername}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="card.model"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacecard.model}</td>
          </tr>
           <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="card.cardid"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacecard.cardid}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="card.price"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.replacecard.saleprice}</td>
          	<td width="10%" align="right" class="line-r"><spring:message code="stb.incardflag"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">
	            <c:if test="${user.user.replacecard.incardflag != null}">
	            	<spring:message code="stb.incardflag.${user.user.replacecard.incardflag}"/>
	            </c:if>
            </td>
          </tr>
        </table>
</div>

