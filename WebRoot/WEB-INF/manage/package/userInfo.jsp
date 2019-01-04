<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <input type="hidden" name="netid" id="netid" value="${user.user.netid}"/>
		<input type="hidden" name="userid" id="userid" value="${user.user.id}"/>
		<input type="hidden" name="userstbsJson" id="userstbsJson" value='${user.userstbsJson}'/>
		<input type="hidden" name="usercardsJson" id="usercardsJson" value='${user.usercardsJson}'/>
		        
 		<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr style="height: 25px;">
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r" title="${user.user.network.netname}">${fn:substring(user.user.network.netname, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="area.areacode"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r">${user.user.area.areaname}(${user.user.area.areacode})</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.usercode"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;">${user.user.usercode}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.username"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r" title="${user.user.username}">${fn:substring(user.user.username, 0, 20)}</td>
          </tr>
          <tr style="height: 25px;">
            <td width="10%" align="right" class="line-r"><spring:message code="user.mobile"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r">${user.user.mobile}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.telephone"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r">${user.user.telephone}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documenttype"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r" title="${user.user.documenttype}">${fn:substring(user.user.documenttype, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documentno"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" title="${user.user.documentno}">${fn:substring(user.user.documentno, 0, 20)}</td>
          </tr>
          <tr style="height: 25px;">
            <td width="10%" align="right" class="line-r"><spring:message code="user.email"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r" title="${user.user.email}">${fn:substring(user.user.email, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.score"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r">${user.user.score}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.account"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r">${user.user.account}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.state"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;"><spring:message code="user.state.${user.user.state}"/></td>
          </tr>
          <tr style="height: 25px;">
            <td width="10%" align="right" class="line-r"><spring:message code="user.address"/>：</td>
            <td width="15%" align="left" style="font-weight: bold;" class="line-r" colspan="6" title="${user.user.address}">${fn:substring(user.user.address, 0, 70)}</td>
         
            <td align="center">
				<a href="javascript:selectUser();" class="easyui-linkbutton"><spring:message code="选择其他用户"/></a>
            </td>
         
          </tr>
        </table>

 	<script type="text/javascript">
     		$(function() {
				var returninfo = '${user.returninfo}';
				if (returninfo != '') {
					$.dialog.tips(returninfo, 1, 'alert.gif');
				}
		});
     
     </script>
     

