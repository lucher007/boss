<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
    .fb-con table tr {
      height: 30px;
    }
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.useradd"/></div>
  <form method="post" id="addForm" name="addForm">
    <div class="form-box">
      <div class="fb-tit"><spring:message code="menu.business.useradd"/></div>
      <div class="fb-con">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="15%" align="right"><spring:message code="network.netname"/>：</td>
            <td width="35%">
	             <input id="netid" name="netid" style="width: 200px;">
	              <span class="red">*</span>
            </td>
            <td height="30" width="15%" align="right"><spring:message code="area.areacode"/>：</td>
			<td width="35%" >
				<input id="areacode" name="areacode" style="width:200px;" >
				<span class="red">*</span>
			</td>
          </tr>
          <tr>
          	<%-- <td height="30" width="15%" align="right"><spring:message code="user.usertype"/>：</td>
            <td width="15%" style="font-weight: bold;">
            	<select id="usertype" name="usertype" class="select" style="width:200px;">
					<option value="0" ><spring:message code="user.usertype.0"/></option>
	                <option value="1" ><spring:message code="user.usertype.1"/></option>
	            </select>
            </td> --%>
            <td align="right"><spring:message code="user.username"/>：</td>
          	<td>
				<input type="text" class="inp" name="username"  id="username" 
				maxlength="50" style="width:200px;"
				value="${user.username }">
				<span class="red">*</span>
			</td>
			<td align="right"><spring:message code="user.userlevel"/>：</td>
            <td>
            	<input id="userlevelid" name="userlevelid" style="width:200px;" >
            	<span class="red">*</span>
            </td>
            <!-- 
			<td align="right"><spring:message code="user.mobile"/>：</td>
            <td >
            	<input type="text" class="inp" name="mobile" id="mobile" 
            	maxlength="15" style="width:200px;"
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')" 
            	value="${user.mobile }">
            </td>
             -->
          </tr>
          <tr>
			<td align="right"><spring:message code="user.telephone"/>：</td>
            <td >
            	<input type="text" class="inp" name="telephone" id="telephone" 
            	maxlength="15" style="width:200px;"
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')" 
            	value="${user.telephone }">
            </td>
            <td align="right"><spring:message code="user.email"/>：</td>
          	<td>
				<input type="text" class="inp" maxlength="50" name="email" id="email" style="width:200px;" value="${user.email }">
			</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.documenttype"/>：</td>
            <td >
            	<input type="text" class="inp" maxlength="30" name="documenttype" id="documenttype" style="width:200px;" value="${user.documenttype }">
            </td>
            <td align="right"><spring:message code="user.documentno"/>：</td>
          	<td>
				<input type="text" class="inp" name="documentno" id="documentno"  
				maxlength="50" style="width:200px;"
				value="${user.documentno }">
			</td>
          </tr>
          <tr>
            <td align="right"><spring:message code="user.address"/>：</td>
            <td >
            	<input type="text" class="inp" style="width:400px;" name="address" id="address" 
            	maxlength="100" 
                value="${user.address }">
            </td>
            <td align="right"><spring:message code="systempara.remark"/>：</td>
          	<td>
				<input type="text" class="inp" name="remark" id="remark" 
				maxlength="100" style="width:200px;"
				value="${user.remark }">
			</td>
          </tr>
         
        </table>
      </div>
      <div class="fb-bom">
        <cite>
       
          <c:if test="${user.id == null || user.id == ''}">
          	<%-- 
          	<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveUser();"/>
          	 --%>
          	<a href="javascript:saveUser();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
          </c:if>
          <c:if test="${user.id != null}">
          	<%-- 
          	<input type="button" class="btn-next" value="<spring:message code="page.next"/>" onclick="nextStep();"/>
          	 --%>
          	<a href="javascript:nextStep();" class="easyui-linkbutton" style="width:80px"><spring:message code="page.next"/></a>
          </c:if>
          <!-- 
          <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveUser();"/>
          -->
        </cite>
        <span class="red">${user.returninfo}</span>
      </div>
    </div>
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
  
  function checkAll() {
    $(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
  }

  function checkbox() {
    var checked = true;
    $('.checkbox').each(function () {
      if (!$(this).attr('checked')) {
        return checked = false;
      }
    });
    $('#checkall').attr('checked', checked);
  }
  
  //
  function changeNetwork(){
	$("#addForm").attr("action", "user/addInit");
	$("#addForm").submit();
  }	
  
  function nextStep(){
	$("#addForm").attr("action", "user/businessUnit?businesstype=buyDevice");
	$("#addForm").submit();
  }	
  
  function saveUser() {
        if ($('#netid').combobox('getValue') == '') {
	      $.dialog.tips('<spring:message code="user.netid.empty"/>', 2, 'alert.gif');
	      $('#netid').focus();
	      return;
	    }
	    if ($('#areacode').combotree('getValue') == '') {
	      $.dialog.tips('<spring:message code="user.areacode.empty"/>', 2, 'alert.gif');
	      $('#areacode').focus();
	      return;
	    }
	    if ($('#username').val() == '') {
		      $.dialog.tips('<spring:message code="user.username.empty"/>', 2, 'alert.gif');
		      $('#username').focus();
		      return;
		}
	    if ($('#userlevelid').combobox('getValue') == '') {
		      $.dialog.tips('<spring:message code="user.userlevel.empty"/>', 2, 'alert.gif');
		      $('#userlevelid').next('span').find('input').focus();
		      return;
		}
	    $("#addForm").attr("action", "user/save");
	    $("#addForm").submit();
  }
  
  function goBack() {
      $("#addForm").attr("action", "user/findByList");
      $("#addForm").submit();
  }
  
  $(function () {
       initNetwork();
       initUserlevel();
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
  function initNetwork(){
		   $('#netid').combobox({    
				url:'user/initNetworkJson?rid='+Math.random(),
			    valueField:'id',   
			    editable:false,
			    //limitToList:true,
			    textField:'netname',
		        onSelect: function(rec){    
	               initArea(rec.id);//默认加载区域
	        	},
			    onLoadSuccess:function(node, data){
				    	//初始化营业厅列表框的默认选择值
				    	
				    	if('${Operator.netid}' != '' && '${Operator.netid}' != null){
						  	  $(this).combobox('select',parseInt('${Operator.netid}'));
						}else{//默认选择第一个
							var val = $('#netid').combobox("getData");  
		                    for (var item in val[0]) {  
		                        if (item == "id") {  
		                            $(this).combobox("select", val[0][item]);  
		                        }  
		                     }  	
						} 
	                    //initArea($("#querynetid").combobox("getValue")); //默认加载区域
		    			//initStore('${operator.netid}');//默认加载营业厅 
				    }
			});  
		   
	    }
  
	    function initArea(netid) {
		  $('#areacode').combotree({   
			    url:'user/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
			    //数据执行之后才加载
			    onLoadSuccess:function(node, data){
			    	if('${user.areacode}' != '' && '${user.areacode}' != null){
					  	  var node = $('#areacode').combotree('tree').tree('find', '${user.areacode}');
					  	  if(node != null){
					  	  	$('#areacode').combotree('setValue', node.id);
					  	  }else{
					  	  	$('#areacode').combotree('setValue', '');
					  	  }
				     }else{
				     	$('#areacode').combotree('setValue', '');
				     }
			    },
			    //选择之前运行
			    onBeforeSelect : function(node) {
			         //返回树对象  
			        var tree = $(this).tree;  
			        //选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
			        var isLeaf = tree('isLeaf', node.target);  
			        if (!isLeaf) {  
			            //清除选中  
			           //$("#areacode").treegrid("unselect");
			           return false;
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
	    
    function initUserlevel(){
		   $('#userlevelid').combobox({    
				url:'user/initUserlevelJson?rid='+Math.random(),
			    valueField:'id',   
			    editable:false,
			    //limitToList:true,
			    textField:'name',
		        onSelect: function(rec){    
	        	},
			    onLoadSuccess:function(node, data){
				    	//初始化默认选择值
						var val = $('#userlevelid').combobox("getData");  
	                    for (var item in val[0]) {  
	                        if (item == "id") {  
	                            $(this).combobox("select", val[0][item]);  
	                        }  
	                     }  	
				    }
			});  
		   
	    }
  
</script>
</body>
</html>
