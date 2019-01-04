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
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/> &gt; <spring:message code="dispatch.dispatcherquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				
    	    </table>
    	    
    	    
    	    <tr>
			<td align="right"><spring:message code="dispatch.dispatcherid"/>：</td>
			<td align="left"><input type="text" class="inp" name="dispatcherid" id="dispatcherid" /></td>
			<td><input  type="button" class="btn-add" value="确定" onclick="confirm();" id="btnfinish">
			<input  type="button" class="btn-add" value="取消" onclick="cancel();" id="btnfinish">
			</td>
			</tr>
    	    
   		</form>
    </div>
   
</div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
    
     function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }
    
    
    //查询操作员
	
	
	$(function () {
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    
    function confirm(){
			     		
 		 if (!checkNumberChar($("#dispatcherid").val())) {
        $.dialog.tips('<spring:message code="dispatch.dispatcherid.number"/>', 1, 'alert.gif');
        $("#dispatcherid").focus();
        return false;
      }
    
    
    		if ($('#dispatcherid').val() == '') {
	      $.dialog.tips('<spring:message code="dispatch.dispatcherid.empty"/>', 1, 'alert.gif');
	      $('#dispatcherid').focus();
	      return;
	    }
    
			var data = $("#dispatcherid").val();
			parent.passSelected(data);
	}	
	
	function cancel(){
	parent.closeDialog();
	}
    
    
  $(".lb-list").click(function(){
	var data =$(this).find("input[type=radio]").val();
    var dataArray = data.split("+");
	parent.closeDialog(dataArray);
  });
  
</script>
</body>
</html>

