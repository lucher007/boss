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
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.operator"/> &gt; <spring:message code="operator.operatorupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${operator.operator.id}"/>
    <input type="hidden" name="queryloginname" id="queryloginname" value="${operator.queryloginname}"/>
    <input type="hidden" name="queryoperatorlevel" id="queryoperatorlevel" value="${operator.queryoperatorlevel}"/>
    <input type="hidden" name="querystate" id="querystate" value="${operator.querystate}"/>
    <input type="hidden" name="queryoperatorname" id="queryoperatorname" value="${operator.queryoperatorname}"/>
    <input type="hidden" name="queryoperatorcode" id="queryoperatorcode" value="${operator.queryoperatorcode}"/>
    <input type="hidden" name="queryoperatortype" id="queryoperatortype" value="${operator.queryoperatortype}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${operator.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="operator.operatorupdate"/></div>
      <div class="fb-con">
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
			<td height="30" width="15%" align="right"><spring:message code="operator.operatortype" />：</td>
			<td width="25%">
					<select id="operatortype" name="operatortype" class="select" style="width: 200px;" onchange="changerOperatortype();">
						<option value="1" <c:if test="${operator.operator.operatortype == '1'}">selected</c:if> ><spring:message code="operator.operatortype.1" /></option>
						<option value="2" <c:if test="${operator.operator.operatortype == '2'}">selected</c:if>><spring:message code="operator.operatortype.2" /></option>
						<option value="3" <c:if test="${operator.operator.operatortype == '3'}">selected</c:if>><spring:message code="operator.operatortype.3" /></option>
					</select>
			</td>
			 <td height="30" width="15%" align="right"><spring:message code="role.rolename"/>：</td>
           	 <td width="25%">
            	<select id="roleid" name="roleid" class="select" style="width: 200px;">
	                <c:forEach items="${operator.rolemap}" var="roleMap" varStatus="s" >
	                  <option value="${roleMap.key}" <c:if test="${roleMap.key == operator.roleid}">selected</c:if>>
	                  		<c:choose>
						   		<c:when test="${roleMap.key=='1'}">
						   			<spring:message code='role.rolecode.00000001'/>
						   		</c:when>
						   		<c:otherwise>
							    	${roleMap.value}
							    </c:otherwise>  
					   </c:choose>
                  </option>
                </c:forEach>
              </select>
            </td>
		  </tr>
         <tr>
         	<td height="30" width="15%" align="right"><spring:message code="operator.operatorlevel" />：</td>
			<td width="25%">
				<select id="operatorlevel" name="operatorlevel" class="select" onchange="changeOperatorlevel();" style="width: 200px;">
					<!-- 
					<option value="0" <c:if test="${operator.operator.operatorlevel == '0'}">selected</c:if> ><spring:message code="operator.operatorlevel.0" /></option>
					<option value="1" <c:if test="${operator.operator.operatorlevel == '1'}">selected</c:if> ><spring:message code="operator.operatorlevel.1" /></option>
					<option value="2" <c:if test="${operator.operator.operatorlevel == '2' || operator.operator.operatorlevel == null}">selected</c:if> ><spring:message code="operator.operatorlevel.2" /></option>
					 -->
				</select>
			</td>
			<div class="netidClass">
				<td height="30" width="15%" align="right" class="netidClass"><spring:message code="network.netname"/>：</td>
	            <td width="25%" class="netidClass">
	                <input id="netid" name="netid" style="width: 200px;"><span class="red">*</span>
	            </td>
			</div>
          </tr>
          <tr class="netidClass">
		   		<td height="30" width="15%" align="right" class="areacodeClass"><spring:message code="area.areaname" />：</td>
				<td width="25%" class="areacodeClass">
					<input id="areacode" name="areacode" style="width: 200px;"><span class="red">*</span>
				</td>
		   		<td height="30" width="15%" align="right" class="storeidClass"><spring:message code="store.storename" />：</td>
				<td width="25%" class="storeidClass">
					<input id="storeid" name="storeid" style="width: 200px;"> <span class="red" id="storeflag">*</span>
				</td>
		</tr>
          <tr>
            <td align="right"><spring:message code="operator.loginname"/>：</td>
            <td style="width: 25%; font-weight: bold;">${operator.operator.loginname }</td>
            <td align="right"><spring:message code="operator.operatorname"/>：</td>
          	<td>
				<input type="text" class="inp" name="operatorname" id="operatorname" 
				maxlength="50" style="width: 200px;"
				value="${operator.operator.operatorname }">
			</td>
          </tr>
          <tr>
			<td align="right"><spring:message code="operator.telephone"/>：</td>
          	<td>
				<input type="text" class="inp" name="telephone" id="telephone" 
				maxlength="15" style="width: 200px;"
				onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
				onafterpaste="this.value=this.value.replace(/[^-\d]/g,'')" 
				value="${operator.operator.telephone }">
			</td>
            <td align="right"><spring:message code="operator.mobile"/>：</td>
          	<td>
				<input type="text" class="inp" name="mobile" id="moblie" 
				maxlength="15" style="width: 200px;"
				onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
				onkeyup="this.value=this.value.replace(/\D/g,'')"
				value="${operator.operator.mobile}">
			</td>
		  </tr>
          <tr>
		  	<td align="right"><spring:message code="operator.documenttype"/>：</td>
          	<td>
				<input type="text" class="inp" maxlength="50" style="width: 200px;" name="documenttype" id="documenttype" value="${operator.operator.documenttype }">
			</td>
			<td align="right"><spring:message code="operator.documentno"/>：</td>
          	<td>
				<input type="text" class="inp"  style="width: 200px;" name="documentno" id="documentno" 
				maxlength="50"
				value="${operator.operator.documentno }">
			</td>
		  </tr>
          <tr>
          	<td align="right"><spring:message code="operator.email"/>：</td>
          	<td>
				<input type="text" class="inp" maxlength="50" style="width: 200px;" name="email" id="email" value="${operator.operator.email }">
			</td>
          	<td align="right"><spring:message code="operator.address"/>：</td>
          	<td>
				<input type="text" class="inp" style="width: 200px;" maxlength="100" name="address" id="address" value="${operator.operator.address}">
			</td>
		  </tr>
		 <tr>
		 	<td align="right"><spring:message code="operator.state"/>：</td>
          	<td>
			  <select name="state" id="state" class="select" style="width: 200px;">
              	  <option value="1" <c:if test="${operator.operator.state == '1' }">selected</c:if>><spring:message code="store.state.1"/></option>
                  <option value="0" <c:if test="${operator.operator.state == '0' }">selected</c:if>><spring:message code="store.state.0"/></option>
              </select>
			</td>
          	<td colspan="2">
          		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn-edit" href="javascript:updatePasswordInit();"><spring:message code="operator.passwordupdate"/></a>
			</td>
			</tr>

        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateOperator();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateOperator();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${operator.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">

  function updateOperator() {
  	 var operatorlevel = $('#operatorlevel').val();
     if(operatorlevel == '0'){//系统级别
    	
     }else if(operatorlevel == '1'){//网络级别
        //网络
	    if ( $('#netid').combobox('getValue')=='') {
	          	$.dialog.tips("<spring:message code="network.netname.empty"/>", 1, "alert.gif", function() {
	        	$('#netid').next('span').find('input').focus();
			});
	        return false;
	    }
     }else if(operatorlevel == '2'){//区域级别
    	//网络
	    if ( $('#netid').combobox('getValue')=='') {
	          	$.dialog.tips("<spring:message code="network.netname.empty"/>", 1, "alert.gif", function() {
	        	$('#netid').next('span').find('input').focus();
			});
	        return false;
	    }
	    //区域
	    if ( $('#areacode').combotree('getValue')=='') {
	            $.dialog.tips("<spring:message code="area.areaname.empty"/>", 1, "alert.gif", function() {
	        	$('#areacode').next('span').find('input').focus();
			});
	        return false;
	    }
	    
	    //如果是操作员，必须要选择营业厅
	    var operatortype = $('#operatortype').val();
	    if(operatortype == '1'){
	      if ( $('#storeid').combobox('getValue')=='') {
	 	        $.dialog.tips('<spring:message code="operator.storename.empty"/>', 1, 'alert.gif');
	 	     	$('#storeid').next('span').find('input').focus();
	           return;
	       }
	    }
     } 

      $('#updateform').attr('action', 'operator/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "operator/findByList");
      $("#updateform").submit();
  }
  
  function updatePasswordInit() {
      $("#updateform").attr("action", "operator/updatePasswordInit");
      $("#updateform").submit();
  }
  
  
  $(function () {
 	var operatortype = $('#operatortype').val();
	if(operatortype == '1'){//选择操作员类型，必须选择区域级别
	     //营业厅必须选项标签
		 $("#storeflag").show();
	}else{
		$("#storeflag").hide();
	}
	  //初始化操作员等级的权限
  	  initOperatorlevel();
	  //初始化网络
	  initNetwork();
      var returninfo = '${operator.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
  });
     
  //初始化营业厅列表框的默认选择值
  function initStoreValue(){
	  if('${operator.operator.storeid}' != '' && '${operator.operator.storeid}' != null){
			if('${operator.operator.netid}' == $('#netid').val()){
		  	  $('#storeid').combobox('select','${operator.operator.storeid}');
		  	}
	  }
  } 
  
  //改变操作员等级
  function changeOperatorlevel(){
    	var operatorlevel =  $("#operatorlevel").val();
    	if(operatorlevel=="0"){ //系统级别，网络、区域、营业厅都不出现
    		//$("#netid").attr("disabled","disabled");
    		$(".netidClass").hide();
    		$(".areacodeClass").hide();
    		$(".storeidClass").hide();
    	}else if(operatorlevel=="1"){//网络级别，请选择网络和营业厅
    		$(".netidClass").show();
    		$(".areacodeClass").hide();
    		$(".storeidClass").show();
    	}else if(operatorlevel=="2"){
    		$(".netidClass").show();
    		$(".areacodeClass").show();
    		$(".storeidClass").show();
    	}
    }
    
  function initNetwork(){
  	$('#netid').combobox({    
			url:'statreport/initNetworkJson',
		    valueField:'id',    
		    //limitToList:true,
		    textField:'netname',
	        onSelect: function(rec){    
            	initStore(rec.id);//默认加载营业厅 
                initArea(rec.id);//默认加载区域
      	    },
		    onLoadSuccess:function(node, data){
			    	//初始化营业厅列表框的默认选择值
			    	if('${operator.operator.netid}' != '' && '${operator.operator.netid}' != null){
					  	  $(this).combobox('select','${operator.operator.netid}');
					  	  //$('#netid').combobox('disable');
					}else{//默认选择第一个
						var val = $('#netid').combobox("getData");  
	                    for (var item in val[0]) {  
	                        if (item == "id") {  
	                            $(this).combobox("select", val[0][item]);  
	                        }  
	                     }  	
					} 
                  initArea($("#querynetid").combobox("getValue")); //默认加载区域
	    		  initStore($("#querynetid").combobox("getValue"));//默认加载营业厅 
			    }
		});  
    }
    
    function initArea(netid) {
	  $('#areacode').combotree({   
		    url:'operator/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
		    //数据执行之后才加载
		    onLoadSuccess:function(node, data){
		    	if('${operator.operator.areacode}' != '' && '${operator.operator.areacode}' != null){
				  	  var node = $(this).tree('find', '${operator.operator.areacode}');
				  	  if(node != null){
				  	  	$('#areacode').combotree('setValue', node.id);
				  	  	//$('#areacode').combotree('disable');
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
		        // 选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
		        var isLeaf = tree('isLeaf', node.target);  
		        if (!isLeaf) {  
		           //清除选中  
		           //$("#areacode").treegrid("unselect");
		           //return false;
		        }  
// 			    if (node.children != undefined) {
// 			     	$("#areacode").treegrid("unselect");
// 			    }
			}
	  }); 
  }
    
  function initStore(netid) {
	   $('#storeid').combobox({    
		url:'store/getStore?querystate=1&querynetid='+netid,
	    valueField:'id',    
	    //limitToList:true,
	    textField:'storename',
	    onLoadSuccess:function(node, data){
		    	//初始化营业厅列表框的默认选择值
		    	if('${operator.operator.storeid}' != '' && '${operator.operator.storeid}' != null){
				  	if('${operator.operator.netid}' == netid){//防止选择的网络不包括默认的营业厅ID，直接把ID显示在输入库里
					  	$('#storeid').combobox('select','${operator.operator.storeid}');
					}
				}else{//默认选择第一个
					var val = $('#storeid').combobox("getData");  
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $('#storeid').combobox("select", val[0][item]);  
                        }  
                     }  	
				} 
		    }
		});  
	}
  
    //初始化修改者的操作权限
	function initOperatorlevel(){
		//判断修改的对象的等级
		var operatortype = '${operator.operator.operatortype}';
		if(operatortype == '1'){//操作员，只能选择区域级别
			 var html = "";
	           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		}else{//不是普通操作员，那权限不能超过本身操作的操作员权限
			var level = '${Operator.operatorlevel}';
			if(level == '0'){
				   var html = "";
			           html += "<option value=\"0\" " + ('${operator.operator.operatorlevel}' == '0' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.0"/></option>";
			           html += "<option value=\"1\" " + ('${operator.operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
			           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
				       $('#operatorlevel').html(html);
			}else if(level == '1'){
			   var html = "";
		           html += "<option value=\"1\" " + ('${operator.operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
		           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
			       $('#operatorlevel').html(html);
			}else if(level == '2'){
			   var html = "";
		           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
			       $('#operatorlevel').html(html);
			}
		}
		//刷新操作员等级变化，页面数据变化
		changeOperatorlevel();
	}
    
    //改变选择的操作员类型
	function changerOperatortype(){
		var operatortype = $('#operatortype').val();
		if(operatortype == '1'){//选择操作员类型，必须选择区域级别
			var html = "";
	           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		     //营业厅必须选项标签
			 $("#storeflag").show();
		}else{
			//去掉营业厅必须选项标签
		    $("#storeflag").hide();
			//出现的页面操作区域不能超过操作员本身的
			var level = '${Operator.operatorlevel}';
			if(level == '0'){
				   var html = "";
			           html += "<option value=\"0\" " + ('${operator.operator.operatorlevel}' == '0' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.0"/></option>";
			           html += "<option value=\"1\" " + ('${operator.operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
			           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
				       $('#operatorlevel').html(html);
			}else if(level == '1'){
			   var html = "";
		           html += "<option value=\"1\" " + ('${operator.operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
		           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
			       $('#operatorlevel').html(html);
			}else if(level == '2'){
			   var html = "";
		           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
			       $('#operatorlevel').html(html);
			}
		}
		//初始化页面操作区域
		changeOperatorlevel();
	}
</script>
</body>
</html>
