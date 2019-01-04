<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!doctype html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title></title>
  <link type="text/css" rel="stylesheet" href="style/user.css">
  <link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
  <link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
  <style>
    .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="user.businessinfoquery"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="querynetid" id="querynetid" value="${user.querynetid }"/>
    <input type="hidden" name="queryareacode" id="queryareacode" value="${user.queryareacode }"/>
    <input type="hidden" name="queryusercode" id="queryusercode" value="${user.queryusercode }"/>
    <input type="hidden" name="queryusername" id="queryusername" value="${user.queryusername }"/>
    <input type="hidden" name="querydocumentno" id="querydocumentno" value="${user.querydocumentno }"/>
    <input type="hidden" name="querystbno" id="querystbno" value="${user.querystbno }"/>
    <input type="hidden" name="querycardid" id="querycardid" value="${user.querycardid }"/>
    <input type="hidden" name="querymobile" id="querymobile" value="${user.querymobile }"/>
    <input type="hidden" name="querystate" id="querystate" value="${user.querystate }"/>
    <input type="hidden" name="queryaddress" id="queryaddress" value="${user.queryaddress }"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${user.pager_offset }"/>
    <div class="form-box">
<!--       <div class="fb-tit"><spring:message code="user.businessinfoquery"/></div> -->
      <div class="fb-con">
    	<table>
          <tr class="fbc-tit">
            <td colspan="7" style="font-weight: bold;"><spring:message code="user.userinfo"/></td>
            <td><%-- 
		         <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
		          --%>
            	 <a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="network.netname"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.network.netname}">${fn:substring(user.user.network.netname, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="area.areacode"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.area.areaname}(${user.user.area.areacode})</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.usercode"/>：</td>
            <td width="15%" style="font-weight: bold;">${user.user.usercode}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.username"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.username}">${fn:substring(user.user.username, 0, 20)}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.mobile"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.mobile}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.telephone"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.telephone}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documenttype"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.documenttype}">${fn:substring(user.user.documenttype, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.documentno"/>：</td>
            <td width="15%" style="font-weight: bold;" title="${user.user.documentno}">${fn:substring(user.user.documentno, 0, 20)}</td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.email"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.email}">${fn:substring(user.user.email, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.score"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.score}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.account"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r">${user.user.account}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="user.state"/>：</td>
            <td width="15%" style="font-weight: bold;">
				  <c:choose>  
		               <c:when test="${user.user.state == '0' || user.user.state == '3'}">
		               		<span class="red"><spring:message code="user.state.${user.user.state}"/></span>
		               </c:when>
		               <c:otherwise>
		               		<spring:message code="user.state.${user.user.state}"/>
		               </c:otherwise>
	               </c:choose>
            </td>
          </tr>
          <tr>
            <td width="10%" align="right" class="line-r"><spring:message code="user.address"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" colspan="3" title="${user.user.address}">${fn:substring(user.user.address, 0, 70)}</td>
          	<td width="10%" align="right" class="line-r"><spring:message code="user.userlevel"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.userlevel.levelname}">${fn:substring(user.user.userlevel.levelname, 0, 20)}</td>
            <td width="10%" align="right" class="line-r"><spring:message code="systempara.remark"/>：</td>
            <td width="15%" style="font-weight: bold;" class="line-r" title="${user.user.remark}">${fn:substring(user.user.remark, 0, 10)}</td>
          </tr>
        </table>
    	
    	<%-- <table>
          <tr class="fbc-tit">
            <td colspan="8" style="font-weight: bold;"><spring:message code="user.stbinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td><spring:message code="stb.stbno"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="userstb.state"/></td>
	          	<td><spring:message code="userstb.incardflag"/></td>
	          	<td><spring:message code="userstb.mothercardflag"/></td>
	          	<td><spring:message code="userstb.mothercardid"/></td>
         </tr>
         <c:forEach items="${user.user.userstblist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.stbno }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="userstb.state.${dataList.state }"/></td>
	        		<td ><spring:message code="userstb.incardflag.${dataList.incardflag }"/></td>
	        		<td >
		        		<c:if test="${dataList.incardflag=='2'}">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        	</tr>
        	</c:forEach>
        </table>
    	<table>
          <tr class="fbc-tit">
            <td colspan="9" style="font-weight: bold;"><spring:message code="user.cardinfo"/></td>
          </tr>
          <tr class="lb-tit">
          		<td><spring:message code="card.cardid"/></td>
	          	<td><spring:message code="user.buytime"/></td>
	          	<td><spring:message code="usercard.state"/></td>
	          	<td><spring:message code="usercard.mothercardflag"/></td>
	          	<td><spring:message code="usercard.mothercardid"/></td>
	          	<td><spring:message code="usercard.stbno"/></td>
         </tr>
         <c:forEach items="${user.user.usercardlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.cardid }</td>
	        		<td >${fn:substring(dataList.addtime, 0, 19)}</td>
	        		<td ><spring:message code="usercard.state.${dataList.state }"/></td>
	        		<td >
		        		<c:if test="${dataList.mothercardflag != null && dataList.mothercardflag != '' }">
		        			<spring:message code="userstb.mothercardflag.${dataList.mothercardflag }"/>
		        		</c:if>
	        		</td>
	        		<td >${dataList.mothercardid }</td>
	        		<td >${dataList.stbno }</td>
	        	</tr>
        	</c:forEach>
        </table>
        <div>
        	<iframe id="main" scrolling="auto" frameborder="0" style="width:100%;height:230px;" src="userproduct/findByList?userid=${user.user.id }"></iframe>
        </div> --%>
      </div>
    </div>
    <div id="userstblist" style="width:auto"></div>
    <div id="stbtools">
	  <div style="margin-bottom:5px">
			 <spring:message code="stb.stbno"/>：<input type="text"  class="inp w200" name="stbno" id="stbno"  onkeydown="if(event.keyCode==13){queryUserstblist();}" >
			<span style="display: none">
				<input type="text"  class="inp w200" >
			</span>
	  </div>
  	</div>
    <div id="usercardlist" style="width:auto"></div>
    <div id="cardtools">
	  <div style="margin-bottom:5px">
			 <spring:message code="card.cardid"/>：<input type="text"  class="inp w200" name="cardid" id="cardid"  onkeydown="if(event.keyCode==13){queryUsercardlist();}" >
			<span style="display: none">
				<input type="text"  class="inp w200" >
			</span>
	  </div>
  	</div>
    <div id="userproductlist" style="width:auto"></div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

 //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }

  function goBack() {
      $("#updateform").attr("action", "user/businessUnit?businesstype=queryUser");
      $("#updateform").submit();
  }
  
  
 $(function () {
 	   initUserstblist();
 	   initUsercardlist();
 	   initUserproductlist();
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  function initUserstblist(){
	    $('#userstblist').datagrid({
	         title: '<spring:message code="user.stbinfo" />',
	         url:'user/userstbJson',
	         queryParams: userstbparamsJson(),
	         pageSize:5,
             singleSelect: true,
             pageList: [5,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         onClickRow: onClickRowstb,
	         toolbar:'#stbtools',
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'stbno', title: '<spring:message code="stb.stbno"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },
	             },
	        	 { field: 'state', title: '<spring:message code="userstb.state" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="userstb.state.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="userstb.state.1"/>';
	         			}else if(val ==2){
	         				return	'<spring:message code="userstb.state.2"/>';
	         			}else if(val ==3){
	         				return	'<spring:message code="userstb.state.3"/>';
	         			}else if(val ==4){
	         				return	'<spring:message code="userstb.state.4"/>';
	         			}
           	        },
	        	 },
	        	 { field: 'incardflag', title: '<spring:message code="userstb.incardflag" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="userstb.incardflag.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="userstb.incardflag.1" />';
						 	}else if(val == '2'){
						 		return '<spring:message code="userstb.incardflag.2" />';
						 	}
     	              },
	        	 },
	        	 { field: 'mothercardflag', title: '<spring:message code="userstb.mothercardflag" />',align:"center",width:100,
	        	 	formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="userstb.mothercardflag.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="userstb.mothercardflag.1" />';
						 	}
     	              },
	        	 },
	        	 { field: 'mothercardid', title: '<spring:message code="userstb.mothercardid" />',align:"center",width:100}
	        	 
	         ]],
	     });
	     var p = $('#userstblist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//将表单数据转为json
	function userstbparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
	
	//选择智能卡列表
	function queryUserstblist(){
		var stbno = $('#stbno').val();
		//刷新
		$('#userstblist').datagrid('clearSelections');
		$('#userstblist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			querystbno:stbno
		});	
		$('#userproductlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			querystbno:stbno
		});	
	}
	
	//点击表格某一条
	function onClickRowstb(index, data){
		var terminalid = data.stbno;
		$('#userproductlist').datagrid('reload',{
			queryuserid: '${user.user.id}',
			terminalid: terminalid,
		});	
	}
	
	function initUsercardlist(){
	    $('#usercardlist').datagrid({
	         title: '<spring:message code="user.cardinfo" />',
	         url:'user/usercardJson',
	         queryParams: usercardparamsJson(),
	         pageSize:5,
             singleSelect: true,
             pageList: [5,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         onClickRow: onClickRowcard,
	         toolbar:'#cardtools',
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'cardid', title: '<spring:message code="card.cardid"/>',align:"center",width:100},
	             { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
						 	return val==null?val:val.substring(0,19);
           	         },
	             },
	        	 { field: 'state', title: '<spring:message code="usercard.state" />',align:"center",width:100,
	            	 formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="usercard.state.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="usercard.state.1"/>';
	         			}else if(val ==2){
	         				return	'<spring:message code="usercard.state.2"/>';
	         			}else if(val ==3){
	         				return	'<spring:message code="usercard.state.3"/>';
	         			}else if(val ==4){
	         				return	'<spring:message code="usercard.state.4"/>';
	         			}
           	        },
	        	 },
	        	 { field: 'mothercardflag', title: '<spring:message code="usercard.mothercardflag" />',align:"center",width:100,
	        		 formatter:function(val, row, index){ 
						 	if(val == '0'){
						 		return '<spring:message code="usercard.mothercardflag.0" />';
						 	}else if(val == '1'){
						 		return '<spring:message code="usercard.mothercardflag.1" />';
						 	}
     	              },
	        	 },
	        	 { field: 'mothercardid', title: '<spring:message code="usercard.mothercardid" />',align:"center",width:100,},
	        	 { field: 'stbno', title: '<spring:message code="usercard.stbno" />',width:80,align:"center",}
	         ]],
	         onLoadSuccess:function(data){  
	        	 //默认选择第一条
	        	 //$('#usercardlist').datagrid("selectRow", 0);
	        	 //加载第一条智能卡的产品信息
	        	 //initUserproductlist();
	         },
	     });
	     var p = $('#usercardlist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
	
	//点击表格某一条
	function onClickRowcard(index, data){
		var terminalid = data.cardid;
		var rows = $('#usercardlist').datagrid("getSelections");
		var terminalids = rows.cardid;
		/* for(var i = 0;i < rows.length;i++){
			terminalids =terminalids + rows[i].cardid + ",";
		} */
		$('#userproductlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			terminalid:terminalid,
		});	
	}
 
    //将表单数据转为json
	function usercardparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
	
	//选择智能卡列表
	function queryUsercardlist(){
		var cardid = $('#cardid').val();
		//刷新
		$('#usercardlist').datagrid('clearSelections');
		$('#usercardlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			querycardid:cardid
		});	
		$('#userproductlist').datagrid('reload',{
			queryuserid:'${user.user.id}',
			querycardid:cardid
		});	
	}
	
	function initUserproductlist(){
	    $('#userproductlist').datagrid({
	         title: '<spring:message code="user.productinfo" />',
	         url:'user/userproductJson',
	         queryParams: userproductparamsJson(),
	         pageSize:5,
             singleSelect: true,
             pageList: [5,25,50], 
	         scrollbar:true,
	         pagination: true,
	         fitColumns:true,
	         rownumbers:true,
	         idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
	         loadMsg:'loading...',
	         columns: [[
	             { field: 'terminalid', title: '<spring:message code="user.terminalid"/>',align:"center",width:140},
	             { field: 'terminaltype', title: '<spring:message code="user.terminaltype" />',align:"center",width:80,
	             	formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="user.terminaltype.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="user.terminaltype.1"/>';
	         			}
           	        },
	             },
	        	 { field: 'productid', title: '<spring:message code="product.productid" />',align:"center",width:80},
	        	 { field: 'productname', title: '<spring:message code="product.productname" />',align:"center",width:80},
	        	 { field: 'addtime', title: '<spring:message code="user.buytime" />',align:"center",width:120,
	        	 	formatter:function(val, row, index){ 
         				return val==null?val:val.substring(0,19);
           	        },
	        	 },
	        	 { field: 'type', title: '<spring:message code="userproduct.type" />',width:80,align:"center",
	        	 	formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="userproduct.type.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="userproduct.type.1"/>';
	         			}
           	        },
	        	 },
	        	 { field: 'starttime', title: '<spring:message code="userproduct.starttime" />',width:120,align:"center",
	        	 	formatter:function(val, row, index){ 
         				return val==null?val:val.substring(0,19);
           	        },
	        	 },
	        	 { field: 'endtime', title: '<spring:message code="userproduct.endtime" />',width:120,align:"center",
	        	 	formatter:function(val, row, index){ 
         				return val==null?val:val.substring(0,19);
           	        },
	        	 },
	        	 { field: 'source', title: '<spring:message code="userproduct.source" />',width:80,align:"center",
	        	 	formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="userproduct.source.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="userproduct.source.1"/>';
	         			}else if(val ==2){
	         				return	'<spring:message code="userproduct.source.2"/>';
	         			}
           	        },
	        	 },
	        	 { field: 'state', title: '<spring:message code="userproduct.state" />',width:80,align:"center",
	        	 	formatter:function(val, row, index){ 
	            		if(val==0){
	         				return	'<spring:message code="userproduct.state.0"/>';
	         			}else if(val ==1){
	         				return	'<spring:message code="userproduct.state.1"/>';
	         			}else if(val ==4){
	         				return	'<spring:message code="userproduct.state.4"/>';
	         			}
           	        },
	        	 }
	         ]],
	         onLoadSuccess:function(data){  
	        	 //默认选择第一条
	        	 //$('#usercardlist').datagrid("selectRow", 0);
	        	 //加载第一条智能卡的产品信息
	        	 //initUserproductlist();
	         },
	     });
	     var p = $('#userproductlist').datagrid('getPager');
	     $(p).pagination({
	         beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
	         afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
	    	 displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
	     });
	}
 
    //将表单数据转为json
	function userproductparamsJson(){
		var json = {
				queryuserid:'${user.user.id}',
		};
		return json;
	}
  
</script>
</body>
</html>
