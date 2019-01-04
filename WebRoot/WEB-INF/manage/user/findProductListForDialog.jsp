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
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
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
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td style="font-weight: bold;" height="30px">
						<input type="text" class="inp" name="netname" id="netname" readonly="readonly" style="background:#eeeeee;" value="${Operator.user.network.netname }">
					</td>
					<td align="right"><spring:message code="product.productid"/>：</td>
					<td>
						 <input type="text" class="inp w200" name="queryproductid" id="queryproductid" value="${product.queryproductid }">
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="product.productname"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryproductname" id="queryproductname" value="${product.queryproductname }">
					</td>
					<td colspan="2" align="center">
		    			<%-- 
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryProduct();"/>
		    			 --%>
		    			<a href="javascript:queryProduct();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
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
	          	<td><spring:message code="product.priceperday"/>(/<spring:message code="para.unit.day"/>)</td>
	          	<td><spring:message code="product.subpricepermonth"/>(/<spring:message code="para.unit.month"/>)</td>
	          	<td><spring:message code="product.subpriceperday"/>(/<spring:message code="para.unit.day"/>)</td>
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
	        		<td >${dataList.priceperday }</td>
	        		<td >${dataList.subpricepermonth }</td>
	        		<td >${dataList.subpriceperday }</td>
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
			    url="user/findProductListForDialog"
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
				<pg:param name="querynetid" value="${product.querynetid}"/>
				<pg:param name="queryproductid" value="${product.queryproductid}"/>
				<pg:param name="queryproductname" value="${product.queryproductname}"/>
				<pg:param name="cardid" value="${product.cardid}"/>
				<pg:param name="stbno" value="${product.stbno}"/>
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
	            	<input type="text" id="starttime" name="starttime" class="Wdate inp" onkeyup="unitendtime();" onkeypress="unitendtime();" onblur="unitendtime();" readonly="readonly" style="background:#eeeeee;" ><span class="red">*</span>
	            </td>
	          </tr>
	          <tr>
	            <td height="30" width="30%" align="right"><spring:message code="para.unit"/>：</td>
	            <td width="60%">
	            	<select id="unit" name="unit" class="select" onchange="unitendtime();">
					 	 <option value="month"><spring:message code="para.unit.month"/></option>
		             	 <option value="day"><spring:message code="para.unit.day"/></option>
		             </select>
	            </td>
	          </tr>
	          <tr>
	            <td height="30" width="30%" align="right"><spring:message code="userproduct.buyamount"/>：</td>
	            <td width="60%">
	            	<input type="text" id="buyamount" name="buyamount" class="inp" onkeyup="onkeyupNum(this);unitendtime();" onkeypress="onkeyupNum(this);unitendtime();" onblur="onkeyupNum(this);unitendtime();" onpaste="return false"  maxlength="3"><span class="red">*</span>
	            </td>
	          </tr>
	          <tr>
	          	<td height="30" width="30%" align="right"><spring:message code="userproduct.endtime"/>：</td>
	            <td width="60%">
	            	<input type="text" id="endtime" name="endtime"  class="inp" 
	            	onkeyup="unitbuyamount();" onkeypress="unitbuyamount();" onblur="unitbuyamount();"
	            	readonly="readonly" style="background:#eeeeee;"><span class="red">*</span>
	            </td>
	          </tr>
			</table>
		</div>
  </div>
    
<script type="text/javascript"  src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">
	
    //查询产品
	function queryProduct(){
		$("#searchForm").attr("action", "user/findProductListForDialog");
		$("#searchForm").submit();
	}	
	
	$(function () {
       var returninfo = '${product.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
  
  var cardDialog;
  $(".lb-list").click(function(){
        var productid = $(this).find("input[type=radio]").val();
        //查询当前订户该产品的授权结束时间
        var data = {
				     productid: productid,
				        cardid: '${product.cardid}',
				         stbno: '${product.stbno}',
				          type: '1'
				   };
		var url="userproduct/findLastEndTimeByProductid?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			    $('#starttime').val(jsonMsg.endtime);
			    /* $('#starttime').on('click', function(){
				    WdatePicker({lang:'${locale}',skin:'blueFresh',dateFmt:'yyyy-MM-dd',minDate:jsonMsg.lastendtime});
				}); */
			    $('#endtime').on('click', function(){
			    	var unit = $('#unit').val();
			    	if(unit == 'day'){
			    		 WdatePicker({lang:'${locale}',skin:'blueFresh',dateFmt:'yyyy-MM-dd',minDate:$('#starttime').val()});
			    	}
				});
		});
        
	    cardDialog = $.dialog({
		    title: '<spring:message code="userproduct.authorizedate"/>',
		    lock: true,
		    width: 400,
		    height:120,
		    top: 200,
		    drag: false,
		    resize: false,
		    max: false,
		    min: false,
		    content: $("#pop-div").html(),
		   	ok: function(){
		   		   if($('#starttime').val() == '') {
				      	$.dialog.tips('<spring:message code="userproduct.starttime.empty"/>', 1, 'alert.gif');
				      	$('#starttime').focus();
				      return false;
				   }
				   if($('#unit').val() == ''){
				   		$('#unit').focus();
				      	return false;
				   }
				   if($('#buyamount').val() == ''){
				   		$('#buyamount').focus();
				      	return false;
				   }
				   if($('#endtime').val() == '') {
				      	$.dialog.tips('<spring:message code="userproduct.endtime.empty"/>', 1, 'alert.gif');
				      	$('#endtime').focus();
				      return false;
				   }
		   		   addBuyingProduct(productid);
		   		},
		   	okVal:'<spring:message code="page.confirm"/>',
		   	cancel:function(){/* cardDialog.close(); */},
		   	cancelVal:'<spring:message code="page.cancel"/>'
	   });
    });
  
    function addBuyingProduct(productid){
		var data = {
				     productid: productid,
			         cardid: '${product.cardid}',
			         stbno: '${product.stbno}',
			         mothercardflag: '${product.mothercardflag}',
			         mothercardid: '${product.mothercardid}',
				     starttime: $('#starttime').val(),
				     unit: $('#unit').val(),
				     buyamount: $('#buyamount').val(),
				     endtime: $('#endtime').val()
				   };
		var url="user/addBuyingProduct?rid="+Math.random();
		$.getJSON(url,data,function(jsonMsg){
			if(jsonMsg.flag=="0"){
			    $.dialog.tips(jsonMsg.error, 2, 'alert.gif');
			}else if(jsonMsg.flag=="1"){
				parent.closeProductDialog();
			}
		});
    }
	
	function onkeyupNum(obj){ 
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined'){
			obj.value='';
		}
			
		//大于0
		if(obj.value <1 && obj.value.length==1) {
			obj.value = "";
		}	
	}
	
	function unitendtime() {
	    var starttime = $("#starttime").val();
	    var unit = $("#unit").val();
	    var buyamount = $("#buyamount").val();
	    
	    if(starttime != '' && buyamount != '' ){
	        if(unit == 'month'){//按月购买
	        	var endtime = addmulMonth(starttime,parseInt(buyamount));
			    //alert(endtime);
			    $("#endtime").val(endtime);
	        }else if(unit == 'day'){ //按天购买
	            buyamount = (buyamount)-1;
	        	var endtime = addmulDay(starttime,parseInt(buyamount));
			    //alert(endtime);
			    $("#endtime").val(endtime);
	        }
	        
	    }
	 }
     
    //增加月数
    function  addmulMonth(dtstr,month){   // n个月后 (数字型)
	   var s=dtstr.split("-");
	   var yy=parseInt(s[0]); 
	   var mm=parseInt(s[1]-1);
	   var dd=parseInt(s[2]);
	   var dt=new Date(yy,mm,dd);
	   dt.setMonth(dt.getMonth()+month);
	   if( (dt.getYear()*12+dt.getMonth()) > (yy*12+mm + month)){
	      dt=new Date(dt.getYear(),dt.getMonth(),0);
	   }
	   var year = dt.getFullYear();
	   var month = dt.getMonth()+1;
	   if (month < 10) month = "0" + month;  
	   var days = dt.getDate();
	   if (days < 10) days = "0" + days;  
	   var dd = year+"-"+month+"-"+days;
	   
	   return getPreDay(dd,1);
	} 
	
    //获取当天日期的前几天
    function getPreDay(dtstr,preDays){
    	var s=dtstr.split("-");
 	    var y=parseInt(s[0]); 
 	    var m=parseInt(s[1]-1);
 	    var d=parseInt(s[2]);
	    var dt = new Date(y, m, d-preDays);
	    y = dt.getFullYear();
	    m = dt.getMonth()+1;
	    d = dt.getDate();
	    m = m<10?"0"+m:m;
	    d = d<10?"0"+d:d;
	    return y + "-" + m + "-" + d;
	}
    
	//日期加上天数得到新的日期  
	//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD  
	function addmulDay(dtstr, days) {  
	    var dateTemp = dtstr.split("-");  
	    var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式    
	    var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);  
	    var rDate = new Date(millSeconds);  
	    var year = rDate.getFullYear();  
	    var month = rDate.getMonth() + 1;  
	    if (month < 10) month = "0" + month;  
	    var days = rDate.getDate();  
	    if (days < 10) days = "0" + days;  
	    return (year + "-" + month + "-" + days);  
	}  
	
	function unitbuyamount() {
	    var starttime = $("#starttime").val();
	    var unit = $("#unit").val();
	    var endtime = $("#endtime").val();
	    
	    if(starttime > endtime){
	    	return;
	    }
	    
	    if(starttime != '' && endtime != '' ){
	        if(unit == 'day'){ //按天购买
	        	var days = getDaysBetweenTwoDates(starttime,endtime);
			    //alert(endtime);
			    $("#buyamount").val(days+1);
	        }
	        
	    }
	 }
	 
	 //获取俩个日期之间的天数
	//starttime 开始日期（YYYY-MM-DD），endtime 结束日期（YYYY-MM-DD）
	function getDaysBetweenTwoDates(starttime, endtime) {  
		var startdate = new Date(starttime.replace(/-/g, "/"));
		var enddate = new Date(endtime.replace(/-/g, "/"));
		var times = enddate.getTime() - startdate.getTime();
		var days = parseInt(times / (1000 * 60 * 60 * 24));
	    return days;
	} 
</script>
</body>
</html>

