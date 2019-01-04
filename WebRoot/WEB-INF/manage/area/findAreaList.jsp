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
<link rel="stylesheet" href="main/plugin/ztree/css/metroStyle/metroStyle.css"/>
</head>

<body>
	<div id="body">
	<div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.area"/> &gt; <spring:message code="area.areaquery"/></div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
				<tr>
					<td align="right" width="10%"><spring:message code="network.netname"/>：</td>
					<td width="20%">
						 <select id="netid" name="netid" class="select" onchange="initArea();">
							
			             </select>
					</td>
					<td align="right">
					    <!-- 
						<input type="button" class="btn-sch" value="<spring:message code="page.query"/>" onclick="queryArea();"/>
						 -->
				   </td>
					<td width="130px">
						<%-- 
						<input type="button" class="btn-add" value="<spring:message code="page.add"/>" onclick="addArea();"/>
						 --%>
						<a href="javascript:addArea();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.add"/></a>
					</td>
				</tr>
    	    </table>
   		</form>
    </div>
   <div class="easyui-layout" style="width:1020px;height:500px;">
	    <div data-options="region:'west',split:true" style="width:400px;">
		   <ul id="treeDemo" class="ztree"></ul>
		</div>
		<div data-options="region:'center'">
	    	<iframe id="areamain" scrolling="auto" frameborder="0" style="width:100%;height:99%;" src=""></iframe>
	    </div>
	</div>
   
    <div id="menu" class="easyui-menu" data-options="onClick:menuClick" style="display: none;">
	  <div id="add"       data-options="iconCls:'icon-add'"><spring:message code="page.add"/></div>
	  <div id="modify"    data-options="iconCls:'icon-edit'"><spring:message code="page.update"/></div>
	  <div id="delete"    data-options="iconCls:'icon-cancel'"><spring:message code="page.delete"/></div>
	</div>
	
	<div id="netmenu" class="easyui-menu" data-options="onClick:menuClick" style="display: none;">
	  <div id="add"       data-options="iconCls:'icon-add'"><spring:message code="page.add"/></div>
	</div>
	
 </div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" language="javascript" src="main/plugin/easyui/js/easyui.js"></script>
<script type="text/javascript" language="javascript" src="main/plugin/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    //查询
	function queryArea(){
		$("#searchForm").attr("action", "area/findByList");
		$("#searchForm").submit();
	}	
	
	//添加
	function addArea(){
		 var netid = $("#netid").val();
		 
	  	 if (netid != null && netid != '') {
	  	 	var url = 'area/addInit?netid=' + netid;
	  		var areamain = $('#areamain');
			areamain.attr('src', url);
	  	 }
	}	
    
    /**
	*编辑
	*/
	function updateArea(id){
		$("#searchForm").attr("action", "area/updateInit?id="+id+"&pager_offset="+'${area.pager_offset}');
		$("#searchForm").submit();
	}
    
    function initNetwork(){
    	$.getJSON('network/initNetworkJson?rid='+Math.random(), null, function (networkJson) {
		     var options = '';
		     for (var key in networkJson) {
		        options += '<option value="' + networkJson[key].id + '">' + networkJson[key].netname + '</option>';
		     }
		     $('#netid').children().remove();
		     $('#netid').append(options);
		     $('#netid').val('${area.netid}');
		     initArea();
	   });
    }
    
	/**
	*删除
	*/
	function deleteArea(id){
		$.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?', 
			'<spring:message code="page.confirm"/>',
			'<spring:message code="page.cancel"/>',
			function(){ 
				$("#searchForm").attr("action", "area/delete?id="+id+"&pager_offset="+'${area.pager_offset}'+"&rid="+Math.random());
				$("#searchForm").submit();
			}, function(){
						});
		
	}
	
	$(function () {
	   initNetwork();
       var returninfo = '${area.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    
    function initArea() {
	  var netid = $("#netid").val();
	  
	  if (netid != null && netid != '') {
	    loadTopology(netid);
	  }
	}
	
	/**
	 * 加载区域列表
	 */
	function loadTopology(netid) {
	    var setting = {
		    view: {
		      selectedMulti: false,
		      showTitle: false
		    },
		    async: {
		      enable: true,
		      autoParam: ['id'],
		      url: 'area/getNextMenu'
		    },
		    data: {
		      simpleData: {
		        enable: true
		      },
		      keep: {
		        parent: true
		      }
		    },
		    callback: {
		      beforeAsync: beforeAsync,
		      onClick: treeOnClick
		    }
	    };
	    
	    if (true) { // 菜单节点右边显示添加删除按钮
		    setting.view.addHoverDom = addHoverDom;
		    setting.view.removeHoverDom = removeHoverDom;
	    }
	    
	    var data = {
		    netid: netid,
		    t: new Date().getTime()
	    };
	    
	    var url = 'area/getTreeArea';
	    
		$.getJSON(url, data, function (jsonMsg) {
		    $.fn.zTree.init($('#treeDemo'), setting, jsonMsg);
		    initSelectedNode(netid);
	    });
	}
    
    //异步加载
    function beforeAsync (treeId,treeNode){
		if(treeNode == null){
			return false;
		}else{
			return true;
		}
	}
    
    //初始化选择节点
    function initSelectedNode(netid) {
	  var treeObj = $.fn.zTree.getZTreeObj('treeDemo');
	  var nodes = treeObj.getNodes();
	  if (null != nodes && nodes.length > 0) {
	    if (undefined != nodes[0].children && null != nodes[0].children && 0 < nodes[0].children.length) {
	      var node = nodes[0].children[0];
	      treeObj.selectNode(node);
	      if (undefined != node.path) {
	        $('#areamain').attr('src', '' + node.path);
	      }
	    } else {
	      treeObj.selectNode(nodes[0]);
	      if (undefined != nodes[0].path) {
	        $('#areamain').attr('src', '' + nodes[0].path);
	      }
	    }
	  }else{//无数据,右边变成添加界面
	  	   var url = 'area/addInit?netid=' + netid;
	  	   var areamain = $('#areamain');
		   areamain.attr('src', url);
	  }
	}
    
    
    function addHoverDom(treeId, treeNode) {
    	  var btn = $('#option_' + treeNode.tId);
    	  var nodeType = treeNode.type;
		  if (btn.length > 0) {
		    return;
		  }
		  
		  var nodeSpan = $('#' + treeNode.tId + '_span');
		  var addStr = '<span class="button option" title="<spring:message code="page.operate"/>"' + 'id="option_' + treeNode.tId + '" onfocus="this.blur();"></span>';
		  
		  nodeSpan.after(addStr);
		  btn = $('#option_' + treeNode.tId);
		  if (btn) {
		    btn.bind('click', function (e) {
		        showMenu(e, nodeType);
		    });
		  }
	}
	
	function removeHoverDom(treeId, treeNode) {
	 	$('#option_' + treeNode.tId).unbind().remove();
	}
	
	function treeOnClick(event, treeId, treeNode) {
	  selectNode($.fn.zTree.getZTreeObj(treeId), treeNode);
    }
	
	//操作项点击事件
	function menuClick(item) {
		 var treeObj = $.fn.zTree.getZTreeObj('treeDemo'),
		      node = treeObj.getSelectedNodes()[0];
		  if (node == undefined || node == null) {
		    $.dialog.tips('<spring:message code="page.select"/>', 1, 'alert.gif');
		    return;
		  }
		  var nodeType = node.type,
		      parentNode = node.getParentNode(),
		      id = node.id,
		      areamain = $('#areamain'),
		      url = '';
		  if (nodeType == 1) { // 网络
		      url = 'area/addInit?netid=' + id;
		      areamain.attr('src', url);
		  } else if (nodeType == 2) { //区域
			  if (item.id == 'add') {
			      url = 'area/addInit?pid=' + id;
			      areamain.attr('src', url);
			   } else if (item.id == 'delete') {
			      url = 'area/deleteBatchByCode';
			      $.dialog.confirmMultiLanguage('<spring:message code="page.confirm.execution"/>?',
			                       '<spring:message code="page.confirm"/>',
			                       '<spring:message code="page.cancel"/>',
			                       function () {
			                       
			                             var data = {
										    id: id,
										    t: new Date().getTime()
									     };
			                       
									      $.getJSON(url,  data, function (data) {
									        $.dialog.tips(data.info, 1, 'alert.gif');
									        if (data.deleteflag) {
									            treeObj.removeNode(node);
									            //treeObj.reAsyncChildNodes(parentNode, "refresh");
									            selectNode(treeObj, parentNode);
									        }
									      });
									    },
								   function () {
									    });
			   }
		  }
	}
	
	//点击操作弹出操作内容
	function showMenu(event, nodeType) {
	    if(nodeType =='1'){
	      $('#netmenu').menu('show', {
		     left: event.clientX,
		     top: event.clientY
		  });
	    }else if(nodeType =='2'){
	    	$('#menu').menu('show', {
		     left: event.clientX,
		     top: event.clientY
		  });
	    }
   }
   
   //选择节点
   function selectNode(treeObj, treeNode) {
	  treeObj.selectNode(treeNode);
	  
	  if (undefined != treeNode.path) {
	        $('#areamain').attr('src', '' + treeNode.path);
	  }
	}
	
	//添加节点刷新
	function addNode(newNode) {
	  if (newNode) {
	      //找到树
	  	  var treeObj = $.fn.zTree.getZTreeObj('treeDemo');
	  	  //如果新增节点没有父节点，即树根节点增加
		  if(newNode.pId == null || newNode.pId == ''){
		  	  treeObj.addNodes(null,newNode);
		  }else{
		  	  //在树中找到父节点位置
		  	  pNode = treeObj.getNodeByParam('id', newNode.pId);
		  	  if(pNode == null){
	        	  treeObj.addNodes(pNode, newNode);
		      }else{
			      treeObj.reAsyncChildNodes(pNode, 'refresh');
			      treeObj.expandNode(pNode, true);
			  }
		  }
	  }
	}
	
	//修改节点刷新
	function updateNode(node) {
	  if (node) {
	    var treeObj = $.fn.zTree.getZTreeObj('treeDemo'),
	        treeNode = treeObj.getNodeByParam('id', node.id),
	        nameNotEqual = treeNode.name != node.name,
	        pidNotEqual = treeNode.pId != node.pId;
	    if (nameNotEqual || pidNotEqual) {
	      treeNode.name = node.name;
	      if (pidNotEqual) {
	        treeNode.pId = node.pId;
	        var parentNode = treeObj.getNodeByParam('id', treeNode.pId);
	        if (true) {
	          treeObj.moveNode(parentNode, treeNode, 'inner');
	        } else {
	          treeObj.removeNode(treeNode);
	          treeObj.reAsyncChildNodes(parentNode, 'refresh');
	          return;
	        }
	      }
	      treeObj.updateNode(treeNode);
	    }
	  }
	}
</script>
</body>
</html>

