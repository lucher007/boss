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
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
       		  <input type="hidden" id="operatorid" name="operatorid" value="${businessReport.operatorid}" />
              <input type="hidden" id="operatorname" name="operatorname" value="${businessReport.operatorname}" />
       
       <table width="100%">
				<tr>
					<td align="right"><spring:message code="statistic.querytime.range" />：</td>
					<td>
						<select id="querydatetype" name="querydatetype" class="select" onChange="queryDateType()">
								<option value="1" <c:if test="${businessReport.querydatetype == '1'}">selected</c:if>><spring:message code="statistic.querytime.byyear" /></option>
								<option value="2" <c:if test="${businessReport.querydatetype == '2'}">selected</c:if>><spring:message code="statistic.querytime.bymonth" /></option>
								<option value="3" <c:if test="${businessReport.querydatetype == '3'}">selected</c:if>><spring:message code="statistic.querytime.byday" /></option>
						</select>
					</td>
									
					<td align="right"><spring:message code="statistic.querydate" />：</td>
					<td>
                 		 <input value="${businessReport.queryyear}" type="text" id="queryyear" name="queryyear" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy'});" class="Wdate inp w150" />
					     <input value="${businessReport.querymonth}" type="text" id="querymonth" name="querymonth" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowClear:true,dateFmt:'yyyy-MM'});" class="Wdate inp w150" />
					     <input value="${businessReport.queryday}" type="text" id="queryday" name="queryday" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});" class="Wdate inp w150" />
					</td>
				
					<td><input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryDate();"/></td>
		    		<td>
		    			<a onclick="saveDownloadEventFile();" class="btn-add3"><span><spring:message code="statistic.exportexcel" /></span></a>
		    		</td>
				</tr>
			
    	    </table>
   		</form>
    </div>


	<div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td><spring:message code="business.type" /></td>
            <td><spring:message code="statistic.count" /></td>
            <td><spring:message code="statistic.totalprice" /></td>
          </tr>
          <c:forEach items="${businessReport.businessReportList}" var="dataList" varStatus="vs">
	          <c:if test="${dataList.businesstypekey ne 'transferusered'}">
		          <tr class="lb-list">	          
					<td height="30"> <spring:message code="business.type.${dataList.businesstypekey }" />&nbsp;</td>
					<td>${dataList.count }&nbsp;</td>
					<td>${dataList.totalprice}&nbsp;</td>				
		          </tr>
	          </c:if>
          </c:forEach>
    	 </table>
    </div>
    	    
 
    	    
    	    
   
</div>
    
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript">
	
    
	function saveDownloadEventFile(){
		$("#searchForm").attr("action", "statistic/findExportOperatorReportExcel");
		$("#searchForm").submit();
	}
    
    function queryDateType(){
	  	$("#queryyear").hide();
		$("#querymonth").hide();
		$("#queryday").hide();  
		if($("#querydatetype").val() =="1"){
			$("#queryyear").show(); 
		}else if ($("#querydatetype").val() == "2"){
			$("#querymonth").show(); 
		}else if ($("#querydatetype").val() == "3"){
			$("#queryday").show(); 
		}
	}
    
    
	
	function queryDate(){
	$("#searchForm").attr("action", "statistic/operatorReportForDialog");
	$("#searchForm").submit();
	}
	
	
	$(function () {
       queryDateType();
       var returninfo = '${stb.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    
 
    

  
</script>
</body>
</html>

