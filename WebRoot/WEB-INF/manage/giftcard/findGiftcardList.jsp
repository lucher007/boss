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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.device.manage"/> &gt; <spring:message code="menu.device.giftcard"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="giftcard.batchno"/>：</td>
					<td width="20%">
                 		<input type="text" readonly="readonly" id="querybatchno" name="querybatchno" value="${giftcard.querybatchno}" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyyMMdd'});" class="Wdate inp w150" />
					</td>
					<td align="right" width="10%"><spring:message code="giftcard.giftcardno"/>：</td>
					<td width="20%">
						<input type="text"  class="inp w200" name="querygiftcardno" id="querygiftcardno" value="${giftcard.querygiftcardno }">
					</td>
					<td align="right" width="10%"><spring:message code="giftcard.usedflag"/>：</td>
					<td width="20%">
						 <select id="queryusedflag" name="queryusedflag" class="select">
						 	   <!--
						 	   <option value=""><spring:message code="page.select"/></option>
			                     -->
			                   <option value="0" <c:if test="${giftcard.queryusedflag == '0'}">selected</c:if>><spring:message code="giftcard.usedflag.0"/></option>
			                   <option value="1" <c:if test="${giftcard.queryusedflag == '1'}">selected</c:if>><spring:message code="giftcard.usedflag.1"/></option>
			             </select>
					</td>
					<td width="10%">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addGiftcard();"/>
						 --%>
						<a href="javascript:addGiftcard();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
				<tr>
					 <td width="10%" align="right"><spring:message code="giftcard.amountpara"/>：</td>
		             <td width="20%">
			              <select id="queryamountpara" name="queryamountpara" class="select">
			                <option value=""><spring:message code="page.select"/></option>
			                <c:forEach items="${giftcard.amountparalist}" var="amountpara" varStatus="s">
			                  <option value="${amountpara.parakey}" <c:if test="${amountpara.parakey == giftcard.queryamountpara}">selected</c:if>>${amountpara.amount}</option>
			                </c:forEach>
			              </select>
		            </td>
		            <td align="right" width="10%"><spring:message code="giftcard.state"/>：</td>
		            <td width="20%">
						 <select id="querystate" name="querystate" class="select">
						 	   <!--
						 	   <option value=""><spring:message code="page.select"/></option>
			                     -->
			                   <option value="0" <c:if test="${giftcard.querystate == '0'}">selected</c:if>><spring:message code="giftcard.state.0"/></option>
			                   <option value="1" <c:if test="${giftcard.querystate == '1'}">selected</c:if>><spring:message code="giftcard.state.1"/></option>
			             </select>
					</td>
					<td width="10%" align="right" colspan="3">
						<%-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryGiftcard();"/>
						<input type="button" class="btn-print" value="<spring:message code="statistic.exportexcel"/>" onclick="saveDownloadEventFile();"/>
						 --%>
						<a href="javascript:queryGiftcard();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
						<a href="javascript:saveDownloadEventFile();" class="easyui-linkbutton" iconCls="icon-print" style="width:80px"><spring:message code="statistic.exportexcel"/></a>
					</td>
				</tr>
    	    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="giftcard.giftcardno"/></td>
          		<td><spring:message code="giftcard.batchno"/></td>
	          	<td><spring:message code="giftcard.amount"/></td>
	          	<td><spring:message code="giftcard.usedflag"/></td>
	          	<td><spring:message code="giftcard.state"/></td>
	          	<td><spring:message code="giftcard.addtime"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${giftcard.giftcardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.giftcardno }&nbsp;</td>
	        		<td >${dataList.batchno }&nbsp;</td>
	        		<td >${dataList.amount }&nbsp;</td>
	        		<td >
	        			<spring:message code="giftcard.usedflag.${dataList.usedflag}"/>
	        		</td>
	        		<td >
	        			<spring:message code="giftcard.state.${dataList.state}"/>
	        		</td>
	        		<td >${fn:substring(dataList.addtime, 0, 11)}&nbsp;</td>
	        		<td>
	        			<!-- 
	        			<a class="btn-edit" href="javascript:updateGiftcard('${dataList.id}');"><spring:message code="page.update"/></a>
	           			 -->
	           			 <c:if test="${dataList.state == '1' }">
	           			 	<a class="btn-del" href="javascript:deleteGiftcard(${dataList.id });" ><spring:message code="page.delete"/></a>
	           			 </c:if>
	           			
	           			
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="giftcard/findByList"
			    items="${giftcard.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querybatchno" value="${giftcard.querybatchno}"/>
				<pg:param name="querygiftcardno" value="${giftcard.querygiftcardno}"/>
				<pg:param name="queryusedflag" value="${giftcard.queryusedflag}"/>
				<pg:param name="queryamountpara" value="${giftcard.queryamountpara}"/>
				<pg:param name="querystate" value="${giftcard.querystate}"/>
				<pg:index>
					<spring:message code="page.total"/>:${giftcard.pager_count}
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
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
    //查询操作员
	function queryGiftcard(){
		$("#searchForm").attr("action", "giftcard/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addGiftcard(){
		$("#searchForm").attr("action", "giftcard/addInit");
		$("#searchForm").submit();
	}	
    
    /**
	*编辑
	*/
	function updateGiftcard(id){
		$("#searchForm").attr("action", "giftcard/updateInit?id="+id+"&pager_offset="+'${giftcard.pager_offset}');
		$("#searchForm").submit();
	}
    
	/**
	*删除
	*/
	function deleteGiftcard(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "giftcard/delete?id="+id+"&pager_offset="+'${giftcard.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	//导出充值卡
	function saveDownloadEventFile(){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
 		        '<spring:message code="page.confirm"/>',
 				'<spring:message code="page.cancel"/>',
 		        function(){ 
 					$("#searchForm").attr("action", "giftcard/exportGiftcardForExcel");
					$("#searchForm").submit();
 				}, function(){
 							});
	}
	
	$(function () {
       var returninfo = '${giftcard.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
</script>
</body>
</html>

