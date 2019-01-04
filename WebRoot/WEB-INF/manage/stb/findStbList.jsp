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
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.stb"/> &gt; <spring:message code="stb.stbquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td width="20%">
						 <select id="querynetid" name="querynetid" class="select">
			             </select>
					</td>
					<td align="right" width="120px"><spring:message code="server.versiontype"/>：</td>
					<td width="130px">
						 <select id="queryversiontype" name="queryversiontype" class="select" onchange="queryStb();">
							 <option value=""><spring:message code="page.select"/></option>
							 <option value="gos_gn" <c:if test="${stb.queryversiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
			                 <option value="gos_pn" <c:if test="${stb.queryversiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
			             </select>
					</td>
					<td width="130px">
						<%-- <input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addStb();"/> --%>
						<a href="javascript:addStb();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="stb.stbno"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querystbno" id="querystbno" value="${stb.querystbno }">
					</td>
					<td align="right" width="120px"><spring:message code="stb.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" onchange="queryStb();">
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${stb.querystate == '0'}">selected</c:if>><spring:message code="stb.state.0"/></option>
			                   <option value="1" <c:if test="${stb.querystate == '1'}">selected</c:if>><spring:message code="stb.state.1"/></option>
			                   <option value="2" <c:if test="${stb.querystate == '2'}">selected</c:if>><spring:message code="stb.state.2"/></option>
			                   <option value="3" <c:if test="${stb.querystate == '3'}">selected</c:if>><spring:message code="stb.state.3"/></option>
			             </select>
					</td>
					<td>
		    			<%-- <input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryStb();"/> --%>
		    			<a href="javascript:queryStb();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
    			<td><spring:message code="server.versiontype"/></td>
    			<td><spring:message code="stb.model"/></td>
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="stb.state"/></td>
	          	<td><spring:message code="stb.incardflag"/></td>
	          	<td><spring:message code="stb.paircardid"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${stb.stblist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	    <td class="remarkClass" title="${dataList.network.netname }">${dataList.network.netname }&nbsp;</td>
	        	    <td><spring:message code="server.versiontype.${dataList.versiontype }"/>&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.provider.model }">${fn:substring(dataList.provider.model, 0, 30)}&nbsp;</td>
	        		<td >${dataList.stbno }</td>
	        		<td >
	        			<spring:message code="stb.state.${dataList.state}"/>
	        		</td>
	        		<td>
	        			<spring:message code="stb.incardflag.${dataList.incardflag}"/>
	        		</td>
	        		<td >${dataList.paircardid }</td>
	        		<td>
	        			<c:if test="${dataList.state ne '1'}">
	        				<a class="btn-edit" href="javascript:updateStb('${dataList.id}');"><spring:message code="page.update"/></a>
	        				<a class="btn-del" href="javascript:deleteStb(${dataList.id });" ><spring:message code="page.delete"/></a>
	        			</c:if>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="stb/findByList"
			    items="${stb.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${stb.querynetid}"/>
				<pg:param name="queryversiontype" value="${stb.queryversiontype}"/>
				<pg:param name="querystate" value="${stb.querystate}"/>
				<pg:param name="querystbno" value="${stb.querystbno}"/>
				<pg:index>
					<spring:message code="page.total"/>:${stb.pager_count}
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
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryStb(){
		$("#searchForm").attr("action", "stb/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addStb(){
		$("#searchForm").attr("action", "stb/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateStb(id){
		$("#searchForm").attr("action", "stb/updateInit?id="+id+"&pager_offset="+'${stb.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteStb(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "stb/delete?id="+id+"&pager_offset="+'${stb.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
	   initNetwork();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
    	var data = {
			    t: new Date().getTime()
		     };
    	$.getJSON('network/initNetworkJson', data, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${stb.querynetid}');
		     //initServer();
	   });
    }
    
    function initServer() {
	  var data = {
	    querynetid: $('#querynetid').val(),
	    queryservertype: 'cas'
	  };
	  
	  $.getJSON('server/initServerJson', data, function (serverJson) {
	     var options = '<option value=""><spring:message code="page.select"/></option>';
	     for (var key in serverJson) {
	        options += '<option value="' + key + '">' + serverJson[key] + '</option>';
	     }
	     $('#queryserverid').children().remove();
	     $('#queryserverid').append(options);
	     $('#queryserverid').val('${stb.queryserverid}');
	  });
  }
</script>
</body>
</html>

