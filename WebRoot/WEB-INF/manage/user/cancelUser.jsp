<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!doctype html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title></title>
  <link type="text/css" rel="stylesheet" href="style/user.css">
  <style>
   .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.usercancel"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.usercancel"/></div>
      <div class="fb-con">
    	<div id="userInfo"></div>
    	<table>
          <tr class="fbc-tit">
            <td colspan="6" style="font-weight: bold;"><spring:message code="user.stbinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="userstb.state"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
         </tr>
         <c:forEach items="${user.user.userstblist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.stbno }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        	</tr>
        	</c:forEach>
        </table>
    	<table>
          <tr class="fbc-tit">
            <td colspan="6" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="usercard.state"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
         </tr>
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.cardid }</td>
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
      <div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		<input type="button" class="btn-save" value="<spring:message code="menu.business.usercancel"/>" onclick="unitBusiness();" id="btnfinish">
               </c:when>
            </c:choose>
        </cite>
        <span class="red">${user.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" charset="utf-8" src="js/common/areaChoose.js"></script>
<script type="text/javascript" src="js/comtools.js"></script>
<script type="text/javascript">
  
	$(function () {
	      loadUserInfo();
	      var returninfo = '${user.returninfo}';
	      if (returninfo != '') {
	       	$.dialog.tips(returninfo, 1, 'alert.gif');
	      }
	 });
  
	 function loadUserInfo() {
	   var data = {
	     id: '${user.user.id}',
	     tag: 'userInfo'
	   };
	   var url = 'user/getUserInfo .' + data.tag;
	   $('#userInfo').load(url, data, function () {
	   });
	 }
	
	var unitBusinessDialog;
	function unitBusiness() {
	   unitBusinessDialog = $.dialog({
		    title: '<spring:message code="userbusiness.feecount"/>',
		    lock: true,
		    width: 800,
		    height: 400,
		    top: 0,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    cancel:false,
		    content: 'url:user/unitBusiness?businesstype='+$('#businesstype').val()
		});
	 }
	
	function closeBusinessDialog(){
		unitBusinessDialog.close();
		$("#addform").attr("action", "user/businessUnit");
      	$("#addform").submit();
	}
	
</script>
</body>
</html>
