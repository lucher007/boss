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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.product.product"/> &gt; <spring:message code="product.productquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	<input type="hidden" name="cardid" id="cardid" value="${product.cardid}"/>
        	<input type="hidden" name="stbno" id="stbno" value="${product.stbno}"/>
            <table width="100%">
				<tr>
			
					<td align="right"><spring:message code="product.productid"/>：</td>
					<td>
						 <input type="text" class="inp w200" name="queryproductid" id="queryproductid" value="${product.queryproductid }">
					</td>
					<td colspan="2" align="center">
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryProduct();"/>
		    		</td>
				
				</tr>
				<tr>
					<td align="right"><spring:message code="product.productname"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryproductname" id="queryproductname" value="${product.queryproductname }">
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
          		<td><spring:message code="product.productid"/></td>
	          	<td><spring:message code="product.productname"/></td>
	          	<td><spring:message code="product.pricepermonth"/>(/<spring:message code="para.unit.month"/>)</td>
	          	<td><spring:message code="product.state"/></td>
        	</tr>
        	<c:forEach items="${product.productlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	    <td width="" height="30">
	        	    	<input type="radio"  name="_selKey"  value="${dataList.productid }">
	        	    </td>
	        	    <td >${dataList.network.netname }</td>
	        		<td >${dataList.productid }</td>
	        		<td >${dataList.productname }</td>
	        		<td >${dataList.pricepermonth }</td>
	        		<td >
	        			<spring:message code="product.state.${dataList.state}"/>
	        		</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="authorize/findProductListForDialog"
			    items="${product.pager_count}"
			    index="center"
			    maxPageItems="5"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="queryproductid" value="${product.queryproductid}"/>
				<pg:param name="queryproductname" value="${product.queryproductname}"/>
				<pg:param name="cardid" value="${product.cardid}"/>
				<pg:index>
					<spring:message code="page.total"/>:${product.pager_count}
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
    <div class="pop-box" id="pop-div">
			<table width="400" border="0" cellpadding="0" cellspacing="0">
	          <tr>
	            <td height="30" width="30%" align="right"><spring:message code="userproduct.starttime"/>：</td>
	            <td width="60%">
	            	<input type="text" id="starttime" name="starttime" class="Wdate inp" onblur="unitendtime();"><span class="red">*</span>
	            </td>
	          </tr>
	          <tr>
	            <td height="30" width="30%" align="right"><spring:message code="userproduct.buymonths"/>：</td>
	            <td width="60%">
	            	<input type="text" id="buymonths" name="buymonths" class="inp" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);" onblur="onkeyupNum(this);unitendtime();" maxlength="3"><span class="red">*</span>
	            </td>
	          </tr>
	          <tr>
	          	<td height="30" width="30%" align="right"><spring:message code="userproduct.endtime"/>：</td>
	            <td width="60%">
	            	<input type="text" id="endtime" name="endtime"  class="inp" readonly="readonly" style="background:#eeeeee;"><span class="red">*</span>
	            </td>
	          </tr>
			</table>
		</div>
  </div>
    
<script type="text/javascript"  src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">
	
    //查询产品
	function queryProduct(){
		$("#searchForm").attr("action", "authorize/findProductListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${product.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
  
  $(".lb-list").click(function(){
        var productid = $(this).find("input[type=radio]").val();
        $(this).find("input[type=radio]").attr('checked', 'true');
        parent.closeDialog(productid);
    });

	
	
	

</script>
</body>
</html>

