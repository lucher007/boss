<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<style type="text/css">
    body {
      padding: 10px 0;
    }

    .form-box table {
      width: 100%;
    }

    .form-box table tr td:FIRST-CHILD {
      text-align: right;
      width: 25%;
    }

    .form-box table tr td {
      white-space: nowrap;
      height: 30px;
      font-size: 12px;
    }

    .readonly {
      background-color: #eeeeee;
    }

  </style>
</head>
<body>
	<div class="form-box">
	  <form method="post" id="paramForm" name="paramForm">
	    <div class="cur-pos"><spring:message code="page.currentlocation" />：<spring:message code="menu.authorize.manage" />&gt;<spring:message code="menu.authorize.productplayallow"/></div>
	    <div class="fb-con">
	      <div class="cur-pos">
	       
	        <table>
	          <tr>
	            <td align="right"><spring:message code="server.versiontype"/>：</td>
	             <td>
	             	<select name="versiontype" id="versiontype" class="select" onchange="changeVersiontype()">
		                <option value="gos_pn" <c:if test="${caspnproductplay.versiontype == 'gos_pn' }">selected</c:if>><spring:message code="server.versiontype.gos_pn"/></option>
		                <option value="gos_gn" <c:if test="${caspnproductplay.versiontype == 'gos_gn' }">selected</c:if>><spring:message code="server.versiontype.gos_gn"/></option>
		            </select>
	             </td>
	          </tr>
	        </table>
	        </div>
	      </div>
	      <div id="info">
	      	<iframe id="productplay" scrolling="auto" frameborder="0" style="width:100%;height:580px;"></iframe>
	      </div>
	       </form>
	    </div>
	    <!--
	    <div class="fb-bom">
	      <cite>
	        <input type="button" class="btn-back" onclick="goBack()" value="<spring:message code="page.reback"/>">
	        <input type="button" class="btn-save" onclick="saveDescriptor()" value="<spring:message code="authorize.sendcommand"/>">
	      </cite>
	    </div>
	      -->
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript">

		$(function() {
			changeVersiontype();
		});
		
		function changeVersiontype() {
		    $("#productplay").attr("src","<%=request.getContextPath()%>/cascommand/add_productplayallow_Info?versiontype=" + $('#versiontype').val());
		}
		
	</script>
</body>
</html>