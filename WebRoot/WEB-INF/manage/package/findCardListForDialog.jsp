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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.card"/> &gt; <spring:message code="card.cardquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="state" id="state" value="${card.state}"/>
        	<input type="hidden" name="stbno" id="stbno" value="${card.stbno}"/>
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${card.network.netname }">
						<input type="hidden" name="querynetid" id="querynetid" value="${card.querynetid }"/>
					</td>
					<td align="right" width="120px"><spring:message code="server.versiontype"/>：</td>
					<td width="130px" colspan="2">
						 <select id="queryversiontype" name="queryversiontype" class="select" onchange="queryStb();">
							 <option value=""><spring:message code="page.select"/></option>
							 <option value="gos_gn" <c:if test="${card.queryversiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
			                 <option value="gos_pn" <c:if test="${card.queryversiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
			             </select>
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="card.cardid"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querycardid" id="querycardid" value="${card.querycardid }">
					</td>
					<td align="right" width="120px"><spring:message code="card.state"/>：</td>
					<td width="130px" colspan="2">
						 <select id="queryversiontype" name="queryversiontype" class="select">
							 <option value=""><spring:message code="page.select"/></option>
							 <option value="gos_gn" <c:if test="${card.queryversiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
			                 <option value="gos_pn" <c:if test="${card.queryversiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
			             </select>
					</td>
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryCard();"/>
		    		</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    		    <td width="60"><spring:message code="page.select"/></td>
    		   	<td><spring:message code="network.netname"/></td>
    			<td><spring:message code="card.serverid"/></td>
    			<td><spring:message code="card.model"/></td>
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="card.state"/></td>
	          	<td><spring:message code="card.incardflag"/></td>
	          	<td><spring:message code="card.stbno"/></td>
        	</tr>
        	<c:forEach items="${card.cardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.netid }+${dataList.serverid}+${dataList.cardid }+${dataList.incardflag }">
	        	    </td>
	        	    <td>${dataList.network.netname }&nbsp;</td>
	        		<td>${dataList.server.servername }&nbsp;</td>
	        		<td class="remarkClass" title="${dataList.provider.model }">${fn:substring(dataList.provider.model, 0, 30)}&nbsp;</td>
	        		<td >${dataList.cardid }</td>
	        		<td >
	        			<spring:message code="card.state.${dataList.state}"/>
	        		</td>
	        		<td>
	        			<spring:message code="stb.incardflag.${dataList.incardflag}"/>
	        		</td>
	        		<td >${dataList.stbno }</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="package/findCardListForDialog"
			    items="${card.pager_count}"
			    index="center"
			    maxPageItems="5"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${card.querynetid}"/>
				<pg:param name="queryversiontype" value="${card.queryversiontype}"/>
				<pg:param name="querystate" value="${card.querystate}"/>
				<pg:param name="querycardid" value="${card.querycardid}"/>
				<pg:param name="stbno" value="${card.stbno}"/>
				<pg:index>
					<spring:message code="page.total"/>:${card.pager_count}
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
<script type="text/javascript">
	
    //查询操作员
	function queryCard(){
		$("#searchForm").attr("action", "user/findCardListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
	   //initServer();
       var returninfo = '${card.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
    	var data = {
			    rid: new Date().getTime()
		     };
    	
    	$.getJSON('network/initNetworkJson', data, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${card.querynetid}');
		     initServer();
	   });
    }
    
    function initServer() {
	  var data = {
	    querynetid: $('#querynetid').val(),
	    queryservertype: 'cas',
	     rid: new Date().getTime()
	  };
	  
	  $.getJSON('server/initServerJson', data, function (serverJson) {
	     var options = '<option value=""><spring:message code="page.select"/></option>';
	     for (var key in serverJson) {
	        options += '<option value="' + key + '">' + serverJson[key] + '</option>';
	     }
	     $('#queryserverid').children().remove();
	     $('#queryserverid').append(options);
	     $('#queryserverid').val('${card.queryserverid}');
	  });
  }
  
  $(".lb-list").click(function(){
		var data = $(this).find("input[type=radio]").val();
		//data:   netid + serverid + cardid
		parent.closeCardDialog(data);
  });
  
</script>
</body>
</html>

