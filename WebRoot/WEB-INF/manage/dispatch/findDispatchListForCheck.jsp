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
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.dispatch.manage"/>  &gt; <spring:message code="menu.dispatch.dispatchcheck"/></div>
    <form action="" method="post" id="searchForm" name="searchForm">
    <div class="seh-box" >
		<table>		
			<tr>
				<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
				<td width="20%">
					<select id="querynetid" name="querynetid" class="select" onchange="initArea();">
			 	 		<option value=""><spring:message code="page.select"/></option>
			 	 	</select>
             	</td>
			    <td align="right" width="10%"><spring:message code="area.areaname"/>：</td>
				<td><input class="easyui-combotree inp w200"  data-options="" id="queryareacode" name="queryareacode" width="120px" onChange= "queryDispatch();"></td>
			    <td align="right" width="120px"><spring:message code="dispatch.dispatchcode"/>：</td>
				<td align="left"><input type="text" class="inp w200"  name="queryid" id="queryid" value="${dispatch.queryid}"></td>
			    <td align="center">
			    	<%-- 
			    	<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryDispatch();" />
			    	 --%>
			    	<a href="javascript:queryDispatch();" class="easyui-linkbutton" iconCls="icon-search" style="width:80px"><spring:message code="page.query"/></a>
			    </td>
		   </tr>
		   <tr>			
				<td align="right"><spring:message code="user.username"/>：</td>
				<td><input type="text" class="inp w200"  name="queryusername" id="queryusername" value="${dispatch.queryusername}"></td>	
				<td align="right" width="120px"><spring:message code="dispatch.problemtype"/>：</td>
				<td>
					<select id="queryproblemtype" name="queryproblemtype" class="select" onchange="queryDispatch();">
						<option value=""><spring:message code="page.select" /></option>
						<option value="0" <c:if test="${dispatch.queryproblemtype == '0'}">selected</c:if>>
							<spring:message code= "dispatch.problemtype.0"/>
						</option>
						<option value="1"<c:if test="${dispatch.queryproblemtype == '1'}">selected</c:if>>
							<spring:message code= "dispatch.problemtype.1"/>
						</option>
						<option value="2"<c:if test="${dispatch.queryproblemtype == '2'}">selected</c:if>>
							<spring:message code= "dispatch.problemtype.2"/>
						</option>
					</select>
				</td>
				<td align="right" width="120px"><spring:message code="dispatch.state"/>：</td>
				<td>
					<select id="querystate" name="querystate" class="select" onchange="queryDispatch();">
						<option value="34"><spring:message code="page.select" /></option>
						
						<option value="3"<c:if test="${dispatch.querystate == '3'}">selected</c:if>>
							<spring:message code= "dispatch.state.3"/>
						</option>
						<option value="4"<c:if test="${dispatch.querystate == '4'}">selected</c:if>>
							<spring:message code= "dispatch.state.4"/>
						</option>
					</select>
				</td>
				<td align="center">
						<a href="javascript:passSelected();" class="easyui-linkbutton" style="width:80px"><spring:message code="dispatch.passselected"/></a>
				</td>				
			</tr>
		</table>
    </div>
   	<div class="lst-box">
    <table id="treetable" class="treetable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    		<tr class="lb-tit">
    			<td><spring:message code="dispatch.dispatchcode"/></td>
	          	<td><spring:message code="dispatch.dispatchername"/></td>
	          	<td><spring:message code="user.username"/></td>
	          	<td><spring:message code="dispatch.problemtype"/></td>
	          	<td><spring:message code="dispatch.content"/></td>
	          	<td><spring:message code="dispatch.dealdate"/></td>     
	          	<td><spring:message code="dispatch.state"/></td>
		        <td><spring:message code="dispatch.result"/></td>
		        <td><spring:message code="dispatch.checkoperation"/></td>
		           <td style="white-space: nowrap;width: 51px"> 
		        	<input type="checkbox" id="checkall" onclick="checkAll();" style="vertical-align: middle;">
			        <label for="checkall"><spring:message code="page.select.all"/></label>
			    </td>		       
        	</tr>

        	<c:forEach items="${dispatch.dispatchlist }" var="dataList">
	        	<tr height="30"class="lb-list">
	        	 	<td >${dataList.dispatchcode}</td>
	        		<td>
	        			${dataList.worker.operatorname}
	        		</td>
	        		<td >${dataList.user.username}</td>
	        		<td><spring:message code= "dispatch.problemtype.${dataList.problemtype}"/></td>
	        		<td class="remarkClass" title="${dataList.content }">${fn:substring(dataList.content, 0, 9)}&nbsp;</td>
	        		<td >
	        			<c:choose>
	        				<c:when test="${empty dataList.dealdate}"><spring:message code="dispatch.notassigned"/></c:when>
	        				<c:otherwise>${fn:substring(dataList.dealdate, 0, 19)}</c:otherwise>
	        			</c:choose>
	        		</td>
	        		<td><spring:message code= "dispatch.state.${dataList.state}"/></td>
	        		
	       	<td class="remarkClass" title="${dataList.dealresult }">${fn:substring(dataList.dealresult, 0, 9)}&nbsp;</td>
	        		
	        		<td >
	        			<c:choose>
	        				<c:when test="${dataList.state == '3'}"><a href="javascript:checkPass(${dataList.id });" ><spring:message code="dispatch.pass"/></a></c:when>
	        				<c:otherwise>
	        				<a href="javascript:checkReassign(${dataList.id });" ><spring:message code="dispatch.reassign"/></a>
	        				<a href="javascript:checkReturn(${dataList.id });" ><spring:message code="dispatch.returnEdit"/></a>
	        				</c:otherwise>
	        			</c:choose>
	        		</td>
	        		<td>  
	            	    <input type="checkbox" class="checkbox" name="ids" id="ids" value="${dataList.id}" onclick="checkbox();" style="vertical-align: middle;">
		            </td>
	        	</tr>
        	</c:forEach>
    	</table>
    </div>
    <div class="page">
    	<cite>
        	<pg:pager
			    url="dispatch/findByList"
			    items="${dispatch.pager_count}"
			    index="center"
			    maxPageItems="10"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">	
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="querynetid" value="${dispatch.querynetid}"/>
				<pg:param name="queryareacode" value="${dispatch.queryareacode}"/>
				<pg:param name="queryid" value="${dispatch.queryid}"/>
				<pg:param name="queryusername" value="${dispatch.queryusername}"/>
				<pg:param name="queryproblemtype" value="${dispatch.queryproblemtype}"/>
				<pg:param name="querystate" value="${dispatch.querystate}"/>
				<pg:param name="jumping" value="${dispatch.jumping}"/>
				<pg:index>
					<spring:message code="page.total"/>:${dispatch.pager_count}
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
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	
	function checkPass(id){
		$.dialog.confirmMultiLanguage('<spring:message code="dispatch.confirmpass"/>', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "dispatch/savePass?id="+id+"&pager_offset="+'${dispatch.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
		});
		
	}
	
	function checkReassign(id){
		$.dialog.confirmMultiLanguage('<spring:message code="dispatch.confirmreassign"/>', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "dispatch/assignInit?id="+id+"&pager_offset="+'${dispatch.pager_offset}'+"&jumping=fromForCheck"+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
	}
	
	function checkReturn(id){
		$.dialog.confirmMultiLanguage('<spring:message code="dispatch.confirmreturnedit"/>', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "dispatch/saveReturn?id="+id+"&pager_offset="+'${dispatch.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
    //查询操作员
	function queryDispatch(){
	    $("#searchForm").attr("action", "dispatch/findByList?jumping=findDispatchListForCheck");
		$("#searchForm").submit();
	}	
	
	

 
	
	$(function () {
      
      initNetwork();
       var returninfo = '${dispatch.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
 
	  function initNetwork(){
	  
	     var data = {
			    t: new Date().getTime()
		     };
	  
    	$.getJSON('network/initNetworkJson', data, function (networkJson) {
		     var options = '<option value=""><spring:message code="page.select"/></option>';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#querynetid').children().remove();
		     $('#querynetid').append(options);
		     $('#querynetid').val('${dispatch.querynetid}');
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
		           //$("#queryareacode").treegrid("unselect");
		        }  
			    //if (node.children != undefined) {
			    // 	$("#areacode").treegrid("unselect");
			    //}
			},
		onChange:function(){
			//queryDispatch();		
		}
		    
	  }); 
  }
  
    //初始化区域列表框的默认选择值
  function initAreaValue(){
	  if('${dispatch.queryareacode}' != '' && '${dispatch.queryareacode}' != null){
	  	  var node = $('#queryareacode').combotree('tree').tree('find', '${dispatch.queryareacode}');
	  	  if(node != null){
	  	  	$('#queryareacode').combotree('setValue', node.id);
	  	  }
	  }
  }
	
   function passSelected(){
	    var checked = false;
	    $('.checkbox').each(function () {
	      if ($(this).attr('checked')) {
	        return checked = true;
	      }
	    });
	    
		if(checked){
		    $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			    '<spring:message code="page.confirm"/>',
				'<spring:message code="page.cancel"/>',
			    function(){ 
					$("#searchForm").attr("action", "dispatch/savePassSelected"+"?pager_offset="+'${dispatch.pager_offset}'+"&rid="+Math.random());
					$("#searchForm").submit();
				}, function(){
			});
		}else{
			$.dialog.tips('<spring:message code="page.select.empty"/>',1,'alert.gif');
		}
		
	}
	
	//全选
	function checkAll() {
	    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
	}
	
	function checkbox() {
	    var checked = true;
	    $('.checkbox').each(function () {
	      if (!$(this).attr('checked')) {
	        checked = false;
	      }
	    });
	    $('#checkall').attr('checked', checked);
	}
    
    
</script>
</body>
</html>

