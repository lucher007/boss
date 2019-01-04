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
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.problemcomplaint"/></div>
  <form action="" method="post" id="addform" name="addform">
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.problemcomplaint"/></div>
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
        <div>
	    	<table>
	          <tr class="fbc-tit" height="30px">
	            <td colspan="4" style="font-weight: bold;"><spring:message code="menu.business.problemcomplaint"/></td>
	          </tr>
	          <tr height="30px">
	            <td align="right"><spring:message code="problemcomplaint.type"/>：</td>
	      		<td> 
	      			<select id="type" name="type" class="select">
		                   <option value="0"><spring:message code="problemcomplaint.type.0" /></option>
		                   <option value="1"><spring:message code="problemcomplaint.type.1" /></option>
		            </select>
				</td>
				<td align="right"><spring:message code="problemcomplaint.problemtype"/>：</td>
	      		<td>
     		 		<select id="problemtype" name="problemtype" class="select">
		                   <option value="0"><spring:message code="problemcomplaint.problemtype.0"/></option>
		                   <option value="1"><spring:message code="problemcomplaint.problemtype.1"/></option>
		                   <option value="2"><spring:message code="problemcomplaint.problemtype.2"/></option>
		            </select>
				</td>
	          </tr>
	          <tr style="height: 60px;">
	            <td align="right"><spring:message code="problemcomplaint.content"/>：</td>
	            <td  colspan="3">  <textarea id="content" name="content" style="width:570px; height:60px;"
	                        onKeyDown="checkLength('content',300)" onKeyUp="checkLength('content',300)">${problemcomplaint.content}</textarea>
	              <span class="red"><spring:message code="page.can.input"/><span id="validNumcontent">300</span><spring:message code="page.word"/></span>
	            </td>
	          </tr>
	        </table>
		</div>
      </div>
      <div class="fb-bom">
        <cite>
        	<c:choose>  
               <c:when test="${user.user.state ne '0' && user.user.state ne '3'}">
               		<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveProblemcomplaint();" id="btnfinish">
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
    
    function saveProblemcomplaint() {
        $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
 	             '<spring:message code="page.confirm"/>',
 	             '<spring:message code="page.cancel"/>',
 	             function(){ 
					 $("#addform").attr("action", "user/saveProblemcomplaint");
			    	 $("#addform").submit();
		         }, 
                 function(){
		});
    }
    
    
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
	
	function checkLength(object, maxlength) {
	    var obj = $('#' + object),
	        value = $.trim(obj.val());
	    if (value.length > maxlength) {
	      obj.val(value.substr(0, maxlength));
	    } else {
	      $('#validNum' + object).html(maxlength - value.length);
	    }
	}
	
</script>
</body>
</html>
