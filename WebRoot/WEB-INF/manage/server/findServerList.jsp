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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
<link type="text/css" rel="stylesheet" href="js/plugin/treeTable/css/jquery.treetable.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.server"/> &gt; <spring:message code="server.serverquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td id="netid" align="right" width="120px"><spring:message code="network.netname"/>：</td>
					<td width="130px">
						 <select id="querynetid" name="querynetid" class="select" onchange="queryServer();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${server.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${server.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<td align="right" width="120px"><spring:message code="server.servertype"/>：</td>
					<td width="130px">
						 <select id="queryservertype" name="queryservertype" class="select" onchange="queryServer();">
			                   <option value=""><spring:message code="page.select"/></option>
			                   <option value="cas" <c:if test="${server.queryservertype == 'cas' }">selected</c:if>><spring:message code="server.servertype.cas"/></option>
			                   <option value="mps" <c:if test="${server.queryservertype == 'mps' }">selected</c:if>><spring:message code="server.servertype.mps"/></option>
			             	   <option value="epg" <c:if test="${server.queryservertype == 'epg' }">selected</c:if>><spring:message code="server.servertype.epg"/></option>
			             	   <option value="nvod" <c:if test="${server.queryservertype == 'nvod' }">selected</c:if>><spring:message code="server.servertype.nvod"/></option>
			             </select>
					</td>
					<td align="right">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryServer();"/>
						 --%>
						<a href="javascript:queryServer();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
					</td>
					<td width="130px">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addServer();"/>
						 --%>
						<a href="javascript:addServer();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
    	    </table>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    		<tr class="lb-tit">
          		<td><spring:message code="server.servername"/></td>
	          	<td><spring:message code="server.servertype"/></td>
	          	<td><spring:message code="network.netname"/></td>
	          	<td><spring:message code="server.versiontype"/></td>
	          	<td><spring:message code="server.ip"/></td>
	          	<td><spring:message code="server.port"/></td>
	          	<td><spring:message code="server.socketConnectState"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${server.serverlist }" var="dataList">
	        	<tr height="30"  class="lb-list">
	        		<td>${dataList.servername }&nbsp;</td>
	        		<td>
	        			<spring:message code="server.servertype.${dataList.servertype}"/>
	            	</td>
	            	<td >${dataList.network.netname }&nbsp;</td>
	            	<td>
	            	    <c:if test="${not empty dataList.versiontype}">
	            	    	<spring:message code="server.versiontype.${dataList.versiontype}"/>
	            	    </c:if>
	            	</td>
	            	<td>${dataList.ip }&nbsp;</td>
	            	<td>${dataList.port }&nbsp;</td>
	            	<td style="font-weight: bold;" valign="middle">
          	    		<c:if test="${dataList.servertype eq 'cas'}">
	            	      <c:if test="${dataList.socketConnectState eq '0'}">
	            	      		<img src="images/frame/noconnection.png" title="<spring:message code="server.socketConnectState.${dataList.socketConnectState}"/>">
	            	      </c:if>
	            	      <c:if test="${dataList.socketConnectState eq '1'}">
	            	      		<img src="images/frame/connection.png" title="<spring:message code="server.socketConnectState.${dataList.socketConnectState}"/>">
	            	      </c:if>
	            	      <!--
	            	      	<span class="red"><spring:message code="server.socketConnectState.${dataList.socketConnectState}"/></span>
	            	  	  -->
	            	   </c:if>
	            	</td>
	        		<td>
	        		   <!--
	        			<c:if test="${dataList.servertype eq 'cas'}">
	            	      <c:if test="${dataList.socketConnectState eq '0'}">
	        					<a class="btn-connect" href="javascript:connectServer('${dataList.id}');"><spring:message code="page.connect"/></a>
	        			  </c:if>
	        			</c:if>
	        			-->
	        			<a class="btn-edit" href="javascript:updateServer('${dataList.id}');"><spring:message code="page.update"/></a>
	           			<!--
	           			<a class="btn-del" href="javascript:deleteServer(${dataList.id });" ><spring:message code="page.delete"/></a>
	      				  -->
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="server/findByList"
			    items="${server.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="queryservertype" value="${server.queryservertype}"/>
				<pg:param name="querynetid" value="${server.querynetid}"/>
				<pg:index>
					<spring:message code="page.total"/>:${server.pager_count}
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
       </form>
        </div>
    
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
    //页面自动循环查询服务器状态
	var timer1 = setInterval("queryServerTimer()", 1000*5);  
	
	function queryServerTimer(){
		$("#searchForm").attr("action", "server/findByList?pager_offset="+'${server.pager_offset}');
		$("#searchForm").submit();
	}
	
    //查询
	function queryServer(){
		if($("#queryservertype").val() == 'mps' || $("#queryservertype").val() == 'epg' || $("#queryservertype").val() == 'nvod'){
			$("#netid").css("visibility","hidden");
			$("#querynetid").css("visibility","hidden");
		}
		$("#searchForm").attr("action", "server/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addServer(){
		$("#searchForm").attr("action", "server/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateServer(id){
		$("#searchForm").attr("action", "server/updateInit?id="+id+"&pager_offset="+'${server.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteServer(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>', 
			function(){ 
				$("#searchForm").attr("action", "server/delete?id="+id+"&pager_offset="+'${server.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	var connectDialog;
	function connectServer(id) {
	    clearInterval(timer1);//暂停页面自动查询循环
		connectDialog = $.dialog({
		    title: '<spring:message code="server.connect"/>',
		    lock: true,
		    width: 600,
		    height: 300,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: "url:server/connectServerInit?id="+id+"&t=" + new Date().getTime()
		});
	}
	
	function closeConnectDG(){
		connectDialog.close();
		checkForm();
	}
	
	
	
	$(function () {
		if($("#queryservertype").val() == 'mps' || $("#queryservertype").val() == 'epg' || $("#queryservertype").val() == 'nvod'){
			$("#netid").css("visibility","hidden");
			$("#querynetid").css("visibility","hidden");
		}
       var returninfo = '${server.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

