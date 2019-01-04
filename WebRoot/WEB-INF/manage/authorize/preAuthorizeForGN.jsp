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
</head>

<body>
<div id="body">
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
				<table width="100%">
					<tr  height="40px">
							<td align="right"><spring:message code="product.productid"/>：</td>
							<td>
								 <input type="text"  class="inp w200" name="queryproductid" id="queryproductid" value="${authorizeParamForPages.queryproductid }">
							</td>
							<td align="right"><spring:message code="product.productname"/>：</td>
							<td>
								 <input type="text"  class="inp w200" name="queryproductname" id="queryproductname" value="${authorizeParamForPages.queryproductname }">
							</td>
							<td><input type="button" class="btn-sch" value="<spring:message code="page.search"/>" onclick="queryProduct();" /></td>
					</tr>
					
					<tr height="40px">
								<td align="right"><spring:message code="userproduct.starttime"/>：</td>
								<td>
			                 			<input type="text" id="starttime" name="starttime" value="${authorizeParamForPages.starttime}" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
								</td>
								
								<td align="right"><spring:message code="userproduct.endtime"/>：</td>
								<td>
			                 			<input type="text" id="endtime" name="endtime"  value="${authorizeParamForPages.endtime}" onfocus="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
								</td>
								
								<td width="130px">
										<input type="button" class="btn-add" value="<spring:message code="authorize.preauth"/>" onclick="preAuth();" />
								</td>
					</tr>
					
					<tr  height="40px">
							<td align="right"><spring:message code="authorize.addressingmode"/>：</td>
							<td>
								 <select id="addressing_mode" name="addressing_mode" class="select" onchange="setForm();">
					                   <option value="0"><spring:message code="authorize.addressingmode.0"/></option>
					                   <option value="1"><spring:message code="authorize.addressingmode.1"/></option>
					             </select>						
					        </td>
					        
					<!-- 		<td align="right">CA object:</td>
						<td>
							<select class="select" name="caobject" id="caobject">
									<option value="4">gospell高安</option>
									<option value="5">gospell普安</option>
									<option value="6">NVOD服务器安</option>
									<option value="7">MPS服务器</option>
							</select>
						</td> -->
					</tr>
					
					<tr id = "singletag"  height="40px">
							<td align="right"><spring:message code="stb.stbno"/>：</td>
							<td><input type="text" class="inp w200"  name="stbno" id="stbno" value="${authorizeParamForPages.stbno}"></td>										
					</tr>
					
					<tr id = "rangetag"  height="40px">
							<td align="right"><spring:message code="authorize.startstbno"/>：</td>
							<td><input type="text" class="inp w200"  name="startstbno" id="startstbno" value="${authorizeParamForPages.startstbno}"></td>										
							<td align="right"><spring:message code="authorize.endstbno"/>：</td>
							<td><input type="text" class="inp w200"  name="endstbno" id="endstbno" value="${authorizeParamForPages.endstbno}"></td>										
					</tr>
				</table>
				
			    <div class="lst-box">
			    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
			    		<tr class="lb-tit">
			    			<td><spring:message code="network.netname"/></td>
			    			<td><spring:message code="product.productname"/></td>
			    			<td><spring:message code="product.productid"/></td>
				          	<td><spring:message code="product.state"/></td>
					        <td style="white-space: nowrap;width: 51px"> 
					        	<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
						        <label for="checkall"><spring:message code="page.select.all"/></label>
						    </td>
			        	</tr>
			        	
			        	<c:forEach items="${authorizeParamForPages.product.productlist }" var="dataList">
				        	<tr height="30"class="lb-list">
				        		<td >${dataList.network.netname }</td>
				        		<td >${dataList.productname }</td>
				        		<td >${dataList.productid}</td>
				        		<td >
	        							 <spring:message code="product.state.${dataList.state}"/>
				        		</td>
				      			<td>  
				            	    <input type="checkbox" class="checkbox" name="ids" value="${dataList.id}"
					                     onclick="checkbox();"
					                     style="vertical-align: middle;">
					            </td>
				        	</tr>
			        	</c:forEach>
			    	</table>
			    </div>
			    
			    <div class="page">
			    	<cite>
			        	<pg:pager
						    url="authorize/preAuthorizeForGN"
						    items="${authorizeParamForPages.product.pager_count}"
						    index="center"
						    maxPageItems="10"
						    maxIndexPages="5"
						    isOffset="<%= true %>"
						    export="offset,currentPageNumber=pageNumber"
						    scope="request">	
							<pg:param name="index"/>
							<pg:param name="maxPageItems"/>
							<pg:param name="maxIndexPages"/>
							<pg:param name="queryproductid" value="${authorizeParamForPages.queryproductid}"/>
							<pg:param name="queryproductname" value="${authorizeParamForPages.queryproductname}"/>
							<pg:param name="starttime" value="${authorizeParamForPages.starttime}"/>
							<pg:param name="endtime" value="${authorizeParamForPages.endtime}"/>
							<pg:param name="stbno" value="${authorizeParamForPages.stbno}"/>
							<pg:param name="startstbno" value="${authorizeParamForPages.startstbno}"/>
							<pg:param name="endstbno" value="${authorizeParamForPages.endstbno}"/>
							<pg:index>
								<spring:message code="page.total"/>:${authorizeParamForPages.product.pager_count}
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

<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">
    
    //查询操作员
	function queryProduct(){
		$("#searchForm").attr("action", "authorize/preAuthorizeForGN");
		$("#searchForm").submit();
	}	
	
		function preAuth(){
	     if ($("#starttime").val() == "") {
	      $.dialog.tips('<spring:message code="authorize.starttime.empty"/>', 1, 'alert.gif');
	      return;
	    }
	    if ($("#endtime").val() == "") {
	      $.dialog.tips('<spring:message code="authorize.endtime.empty"/>', 1, 'alert.gif');
	      return;
	    } 
	   	if($("#addressing_mode").val() == "0" && $("#stbno").val() == "" ){
		   $.dialog.tips('<spring:message code="authorize.stbno.empty"/>', 1, 'alert.gif');
		   $("#cardid").focus();
		   return;
		}else if($("#addressing_mode").val() == "1"&& ( $("#startstbno").val() == ""|| $("#endstbno").val() == "")){
			$.dialog.tips('<spring:message code="authorize.addressingrange.empty"/>', 1, 'alert.gif');
			return;
		}
	   var ifcheck =  false;
	   $('.checkbox').each(function () { if ($(this).attr('checked')) {ifcheck = true;}});
	   if(!ifcheck){
	   $.dialog.tips('<spring:message code="authorize.product.empty"/>', 1, 'alert.gif');
	   return; 
	   }
	    $("#searchForm").attr("action", "authorize/savePreAuthorizeForGN");
		$("#searchForm").submit();
	}
	
	function setForm(){
		if($("#addressing_mode").val()=="0"){
		    $("#singletag").show();
		    $("#rangetag").hide();
		}else{
		    $("#rangetag").show();
		    $("#singletag").hide();
		}
	}
	

    
    
    	$(function() {
      setForm();
			var returninfo = '${authorizeParamForPages.returninfo}';
	       if (returninfo != '') {
	        	$.dialog.tips(returninfo, 1, 'alert.gif');
	       }
			
		});

	//全选
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () { if (!$(this).attr('checked')) {checked = false;}});
	    $('#checkall').attr('checked', checked);
	};
</script>
</body>
</html>

