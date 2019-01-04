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
 <style>
    .seh-box table tr {
      height: 30px;
    }
  </style>
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.userquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <input type="hidden" name="pager_offset" id="pager_offset" value="${user.pager_offset }"/>
            <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
            <table>
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td width="20%">
						 <select id="querynetid" name="querynetid" class="select" onchange="initArea();">
						 	 <option value=""><spring:message code="page.select"/></option>
							 <c:forEach items="${user.networkmap}" var="networkMap" varStatus="s">
			                   <option value="${networkMap.key}" <c:if test="${user.querynetid == networkMap.key }">selected</c:if>>${networkMap.value}</option>
			                </c:forEach>
			             </select>
					</td>
					<!-- 
					<td width="10%" align="right"><spring:message code="server.servername"/>：</td>
		            <td width="20%">
		              <select id="queryserverid" name="queryserverid" class="select" onchange="initArea();queryUser();">
		                <c:forEach items="${user.servermap}" var="serverMap" varStatus="s">
		                  <option value="${serverMap.key}" <c:if test="${serverMap.key == user.queryserverid}">selected</c:if>>${serverMap.value}</option>
		                </c:forEach>
		              </select>
		              <span class="red">*</span>
		            </td>
		            -->
					<td align="right" width="10%"><spring:message code="area.areaname"/>：</td>
					<td colspan="3">
						<input class="easyui-combotree"  data-options="" id="queryareacode" name="queryareacode" style="width:40%">
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="user.usercode"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryusercode" id="queryusercode" value="${user.queryusercode }" >
					</td>
					<td align="right"><spring:message code="user.username"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="queryusername" id="queryusername" value="${user.queryusername }" >
					</td>
					<td align="right"><spring:message code="user.documentno"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querydocumentno" id="querydocumentno" value="${user.querydocumentno }" >
					</td>
				</tr>
				<tr>
					<td align="right"><spring:message code="stb.stbno"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querystbno" id="querystbno" value="${user.querystbno }" >
					</td>
					<td align="right"><spring:message code="card.cardid"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querycardid" id="querycardid" value="${user.querycardid }" >
					</td>
					<td align="right"><spring:message code="user.mobile"/>：</td>
					<td>
						 <input type="text"  class="inp w200" name="querymobile" id="querymobile" value="${user.querymobile }" >
					</td>
				</tr>
				<tr>
					<td align="right" width="120px"><spring:message code="user.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" >
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${user.querystate == '0'}">selected</c:if>><spring:message code="user.state.0"/></option>
			                   <option value="1" <c:if test="${user.querystate == '1'}">selected</c:if>><spring:message code="user.state.1"/></option>
			          		<option value="1" <c:if test="${user.querystate == '1'}">selected</c:if>><spring:message code="user.state.1"/></option>
			          			                   <option value="1" <c:if test="${user.querystate == '1'}">selected</c:if>><spring:message code="user.state.1"/></option>
			             </select>
					</td>
					<td align="right"><spring:message code="user.address"/>：</td>
					<td colspan="2">
						 <input type="text"  class="inp" style="width:320px;" name="queryaddress" id="queryaddress" value="${user.queryaddress }" >
					</td>
					<td>
		    			<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryUser();"/>
		    		</td>
				</tr>
    	    </table>
    	 </form>
    </div>
  <div class="lst-box">
    	<table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="network.netname"/></td>
          		<td><spring:message code="user.usercode"/></td>
	          	<td><spring:message code="user.username"/></td>
	          	<td><spring:message code="user.mobile"/></td>
	          	<td><spring:message code="user.state"/></td>
	          	<td><spring:message code="user.address"/></td>
		        <td><spring:message code="page.operate"/></td>
        	</tr>
        	<c:forEach items="${user.userlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        		<td >${dataList.network.netname }</td>
	        		<td >${dataList.usercode }</td>
	        		<td >${dataList.username }</td>
	        		<td >${dataList.mobile }</td>
	        		<td >
	        			<spring:message code="user.state.${dataList.state}"/>
	        		</td>
	        		<td >${dataList.address }</td>
	        		<td>
	        			<a class="btn-look" href="javascript:lookUserBusinessInfo('${dataList.id}');"><spring:message code="page.look"/></a>
	      				<a class="btn-look" href="javascript:lookUserBusinessInfo('${dataList.id}');"><spring:message code="审核通过"/></a>
	      			</td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="usercheck/findUncheckUserByList"
			    items="${user.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${user.querynetid}"/>
				<pg:param name="queryareacode" value="${user.queryareacode}"/>
				<pg:param name="queryusercode" value="${user.queryusercode}"/>
				<pg:param name="queryusername" value="${user.queryusername}"/>
				<pg:param name="querydocumentno" value="${user.querydocumentno}"/>
				<pg:param name="querystbno" value="${user.querystbno}"/>
				<pg:param name="querycardid" value="${user.querycardid}"/>
				<pg:param name="querymobile" value="${user.querymobile}"/>
				<pg:param name="querystate" value="${user.querystate}"/>
				<pg:param name="queryaddress" value="${user.queryaddress}"/>
				<pg:index>
					<spring:message code="page.total"/>:${user.pager_count}
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
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript">
	
	//添加
	function addUser(){
		$("#searchForm").attr("action", "user/addInit");
		$("#searchForm").submit();
	}	
	
	/**
	*删除
	*/
	function deleteUser(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "user/delete?id="+id+"&pager_offset="+'${user.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
	}
	
	$(function () {
	   initNetwork();
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
    
    	$.getJSON('network/initNetworkJson?rid='+Math.random(), null, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + key + '">' + networkJson[key] + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${user.querynetid}');
		     initArea();
	   });
    }
  
    function initArea() {
	  $('#queryareacode').combotree({   
		    url:'area/getAreaTreeJson?querynetid='+$('#querynetid').val()+'&rid='+Math.random(),
		    //数据执行之后才加载
		    onLoadSuccess:function(node, data){
		    	initAreaValue();
		    },
		    //选择之前运行
		    onBeforeSelect : function(node) {
		         //返回树对象  
		        var tree = $(this).tree;  
		        //选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
		        var isLeaf = tree('isLeaf', node.target);  
		        if (!isLeaf) {  
		            //清除选中  
		           $("#queryareacode").treegrid("unselect");
		        }  
			    //if (node.children != undefined) {
			    // 	$("#areacode").treegrid("unselect");
			    //}
			},
		    //绑定onchanger事件
		    onChange:function(){  
                //queryUser();
            }
		    
	  }); 
  }
  
  //初始化区域列表框的默认选择值
  function initAreaValue(){
	  if('${user.queryareacode}' != '' && '${user.queryareacode}' != null){
	  	  var node = $('#queryareacode').combotree('tree').tree('find', '${user.queryareacode}');
	  	  if(node != null){
	  	  	$('#queryareacode').combotree('setValue', node.id);
	  	  }
	  }
  }
</script>
</body>
</html>

