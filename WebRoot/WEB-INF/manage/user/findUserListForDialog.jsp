<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
 <style>
    .seh-box table tr {
      height: 30px;
    }
  </style>
</head>

<body style="padding:0px; width:100%; ">
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		    <td width="60"><spring:message code="page.select"/></td>
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="user.usercode"/></td>
	          	<td><spring:message code="user.username"/></td>
	          	<td><spring:message code="user.mobile"/></td>
	          	<td><spring:message code="user.state"/></td>
	          	<td><spring:message code="user.address"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${user.userlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.id }">
	        	    </td>
	        		<td >${dataList.network.netname }</td>
	        		<td >${dataList.usercode }</td>
	        		<td >${dataList.username }</td>
	        		<td >${dataList.mobile }</td>
	        		<td >
	        			<spring:message code="user.state.${dataList.state}"/>
	        		</td>
	        		<td >${dataList.address }</td>
	        		<td>
	        			<a class="btn-look" href="javascript:lookUserBusinessInfo('${dataList.id}');"><spring:message code="page.look"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="user/findByListForDialog"
			    items="${user.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${user.querynetid}"/>
				<pg:param name="queryareacode" value="${user.queryareacode}"/>
				<pg:param name="queryusercode" value="${user.queryusercode}"/>
				<pg:param name="queryusername" value="${user.queryusername}"/>
				<pg:param name="querydocumentno" value="${user.querydocumentno}"/>
				<pg:param name="querystbno" value="${user.querystbno}"/>
				<pg:param name="querycardid" value="${user.querycardid}"/>
				<pg:param name="querymobile" value="${user.querymobile}"/>
				<pg:param name="querystate" value="${user.querystate}"/>
				<pg:param name="queryaddress" value="${user.queryaddress}"/>
				<pg:index>
					<spring:message code="page.total"/>:${user.pager_count}
					<pg:first unless="current">
						<a href="<%=pageUrl %>"><spring:message code="pape.firstpage"/></a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
				  		<a href="<%= prevPageUrl %>"><spring:message code="page.prevpage"/></a>
					</pg:prev>
					<pg:pages>
	   					<%if (pageNumber == currentPageNumber) { 
				    	%><span style="font:bold 16px arial;"><%= pageNumber %></span><%
				  		} else {
				    	%><a href="<%= pageUrl %>"><%= pageNumber %></a><%
				   		}
						%>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
				  		<a href="<%= nextPageUrl %>"><spring:message code="page.nextpage"/></a>
				  		
					</pg:next>
					<pg:last>
						<a href="<%=pageUrl %>"><spring:message code="page.lastpage"/></a>
					</pg:last>
				</pg:index>
			</pg:pager>
    	</cite>
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    /**
	*切换选中订户信息
	*/
	$(".lb-list").click(function(){
	var useid = $(this).find("input[type=radio]").val();
	
	var data = "id="+ useid;
	var url="user/switchUserInfo?rid="+Math.random();
	$.getJSON(url,data,function(jsonMsg){
		if(jsonMsg.flag=="0"){
		    if(jsonMsg.error != null & jsonMsg.error != ''){
		    	$.dialog.tips(jsonMsg.error, 1, 'alert.gif');
		    }
		}else if(jsonMsg.flag=="1"){
			parent.parent.closeUserInfoDialog();
		}
	});
  });
    
	
</script>
</body>
</html>

