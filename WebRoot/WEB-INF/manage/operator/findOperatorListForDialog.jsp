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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.system.operator" /> &gt; <spring:message code="operator.operatorquery" /></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
		    	<tr>
		    		<td align="right"><spring:message code="operator.operatorname" />：</td>
        			<td>
        				<input type="text" class="inp w200" name="queryoperatorname" id="queryoperatorname"  value="${operator.queryoperatorname }">
        			</td>
        			<td align="right"><spring:message code="operator.operatorcode" />：</td>
		    		<td>
		    			<input type="text"  class="inp w200" name="queryoperatorcode" id="queryoperatorcode" value="${operator.queryoperatorcode }">
		    		</td>
		    		<td width="130" align="right">
		    		</td>
		    		
		    		<td colspan="3" align="right">
        				<%-- 
        				<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryOperator();"/>
   		    			 --%>
   		    			<a href="javascript:queryOperator();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
   		    		</td>
		    		
		    	</tr>
        		
        		<%-- 	<tr>
        			<td align="right"><spring:message code="operator.state" />：</td>
        			<td>
        				<select id="querystate" name="querystate" class="select" onchange="queryOperator();">
			                   <option value="1" <c:if test="${operator.querystate == '1' }">selected</c:if>><spring:message code="operator.state.1"/></option>
			                   <option value="0" <c:if test="${operator.querystate == '0' }">selected</c:if>><spring:message code="operator.state.0"/></option>
			             </select>
        			</td>
		    		<td align="right"><spring:message code="operator.operatortype" />：</td>
        			<td>
        				<select id="queryoperatortype" name="queryoperatortype" class="select" onchange="queryOperator();">
			                   <option value="2" <c:if test="${operator.queryoperatortype == '2' }">selected</c:if>><spring:message code="operator.operatortype.2"/></option>
			             </select>
        			</td>
   		    	</tr> --%>
   		  
   		    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td width="60"><spring:message code="page.select"/></td>
            <td><spring:message code="operator.operatorname"/></td>
            <td><spring:message code="operator.operatorcode"/></td>
            <td><spring:message code="operator.operatortype"/></td>
            <td><spring:message code="operator.telephone"/></td>
            <td><spring:message code="operator.mobile"/></td>
            <td><spring:message code="operator.documenttype"/></td>
            <td><spring:message code="operator.documentno"/></td>
          </tr>
          <c:forEach items="${operator.operatorlist}" var="dataList" varStatus="vs">
	          <tr class="lb-list">
	          	<td width="" height="30">
	          		<input type="radio"  name="_selKey"   value="${dataList.id }+${dataList.operatorcode }+${dataList.operatorname }"/>
        	    </td>
				<td title="${dataList.operatorname}">${fn:substring(dataList.operatorname, 0, 30)}&nbsp;</td>
				<td>${dataList.operatorcode }&nbsp;</td>
				<td>
					<spring:message code="operator.operatortype.${dataList.operatortype}" />
				</td>
				
				<td>${dataList.telephone }&nbsp;</td>
				<td>${dataList.mobile}&nbsp;</td>
				<td title="${dataList.documenttype}">${fn:substring(dataList.documenttype, 0, 20)}&nbsp;</td>
				<td title="${dataList.documentno}">${fn:substring(dataList.documentno, 0, 20)}&nbsp;</td>
	          </tr>
          </c:forEach>
        </table>
        
        <div class="page">
        	<cite>
             <pg:pager
				    url="operator/findOperatorListForDialog"
				    items="${operator.pager_count}"
				    index="center"
				    maxPageItems="5"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">	
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="queryoperatorname" value="${operator.queryoperatorname }"/>
					<pg:param name="queryoperatorcode" value="${operator.queryoperatorcode }"/>
					<pg:param name="querystate" value="${operator.querystate }"/>
					<pg:param name="queryoperatortype" value="${operator.queryoperatortype }"/>
					<pg:index>
					
						<spring:message code="page.total"/>:${operator.pager_count}
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
    </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script language="javascript" type="text/javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	//查询操作员
	function queryOperator(){
		$("#searchForm").attr("action", "operator/findOperatorListForDialog?queryoperatortype=2");
		$("#searchForm").submit();
	}	
	//添加操作员
	function addOperator(){
		$("#searchForm").attr("action", "operator/addInit");
		$("#searchForm").submit();
	}	
	
	/**
	*编辑
	*/
	function updateOperator(id){
		$("#searchForm").attr("action", "operator/updateInit?id="+id+"&pager_offset="+'${operator.pager_offset}');
		$("#searchForm").submit();
	}
	
	/**
	*删除
	*/
	function deleteOperator(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>', 
			function(){ 
				$("#searchForm").attr("action", "operator/delete?id="+id+"&pager_offset="+'${operator.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
       var returninfo = '${operator.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    $(".lb-list").click(function(){
		var data =$(this).find("input[type=radio]").val();
		
    	var dataArray = data.split("+");
    	
		parent.closeDialog(dataArray);
	});
</script>
</body>
</html>