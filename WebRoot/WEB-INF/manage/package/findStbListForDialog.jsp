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
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.stb"/> &gt; <spring:message code="stb.stbquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="state" id="state" value="${stb.querystate}"/>
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${stb.network.netname }">
						<input type="hidden" name="querynetid" id="querynetid" value="${stb.querynetid}"/>
					</td>
					<td align="right" width="120px"><spring:message code="server.versiontype"/>：</td>
					<td width="130px" colspan="2">
						 <select id="queryversiontype" name="queryversiontype" class="select" onchange="queryStb();">
							 <option value=""><spring:message code="page.select"/></option>
							 <option value="gos_gn" <c:if test="${stb.queryversiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
			                 <option value="gos_pn" <c:if test="${stb.queryversiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
			             </select>
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
			                   <option value="0" <c:if test="${stb.querystate == '0'}">selected</c:if>><spring:message code="stb.state.0"/></option>
			             </select>
					</td>
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryStb();"/>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		    <td width="60"><spring:message code="page.select"/></td>
    			<td><spring:message code="server.versiontype"/></td>
    			<td><spring:message code="stb.model"/></td>
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="stb.state"/></td>
	          	<td><spring:message code="stb.incardflag"/></td>
	          	<td><spring:message code="stb.paircardid"/></td>
        	</tr>
        	<c:forEach items="${stb.stblist }" var="dataList">
	        	<tr height="30" class="lb-list">
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.netid}+${dataList.serverid}+${dataList.stbno}+${dataList.incardflag}+${dataList.paircardid}" >
	        	    </td>
	        	    <td><spring:message code="server.versiontype.${dataList.versiontype }"/>&nbsp;</td>
	        	    <td class="remarkClass" title="${dataList.provider.model }">${fn:substring(dataList.provider.model, 0, 30)}&nbsp;</td>
	        		<td >${dataList.stbno }</td>
	        		<td >
	        			<spring:message code="stb.state.${dataList.state}"/>
	        		</td>
	        		<td><spring:message code="stb.incardflag.${dataList.incardflag }"/></td>
	        		<td>${dataList.paircardid }</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="package/findStbListForDialog"
			    items="${stb.pager_count}"
			    index="center"
			    maxPageItems="5"
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
<script type="text/javascript">
	
    //查询操作员
	function queryStb(){
		$("#searchForm").attr("action", "package/findStbListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
	   //initServer();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    /*
    function initNetwork(){
    	$.getJSON('network/initNetworkJson', null, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + key + '">' + networkJson[key] + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${stb.querynetid}');
		     initServer();
	   });
    }
    */
    
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
  
  $(".lb-list").click(function(){
	var data = $(this).find("input[type=radio]").val();
	//data:   netid + serverid + stbno + incardflag + cardid
	parent.closeStbDialog(data);
  });
  
</script>
</body>
</html>

