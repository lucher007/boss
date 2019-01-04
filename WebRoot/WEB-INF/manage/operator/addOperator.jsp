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
<base href="<%=basePath%>">
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<style type="text/css">
.fb-con table tr {
	height: 30px;
}
</style>
</head>
<body>
	<div id="body">
		<div class="cur-pos">
			<spring:message code="page.currentlocation" />
			：
			<spring:message code="menu.system.operator" />
			&gt;
			<spring:message code="operator.operatoradd" />
		</div>
		<form method="post" id="addForm" name="addForm">
			<div class="form-box">
				<div class="fb-tit">
					<spring:message code="operator.operatoradd" />
				</div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="30" width="15%" align="right"><spring:message code="operator.operatortype" />：</td>
							<td width="25%">
								<select id="operatortype" name="operatortype" class="select"   onchange="changerOperatortype();" style="width: 200px;">
									<option value="1" <c:if test="${operator.operatortype == '1'}">selected</c:if> ><spring:message code="operator.operatortype.1" /></option>
									<option value="2" <c:if test="${operator.operatortype == '2'}">selected</c:if> ><spring:message code="operator.operatortype.2" /></option>
									<option value="3" <c:if test="${operator.operatortype == '3'}">selected</c:if> ><spring:message code="operator.operatortype.3" /></option>
								</select>
							</td>
							<td height="30" width="15%" align="right"><spring:message code="role.rolename" />：</td>
							<td width="25%">
								<select id="roleid" name="roleid" class="select" style="width: 200px;">
									<c:forEach items="${operator.rolemap}" var="roleMap" varStatus="s">
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
<!-- 									<option value="0" <c:if test="${operator.operatorlevel == '0'}">selected</c:if> ><spring:message code="operator.operatorlevel.0" /></option> -->
<!-- 									<option value="1" <c:if test="${operator.operatorlevel == '1'}">selected</c:if> ><spring:message code="operator.operatorlevel.1" /></option> -->
<!-- 									<option value="2" <c:if test="${operator.operatorlevel == '2' || operator.operatorlevel == null}">selected</c:if> ><spring:message code="operator.operatorlevel.2" /></option> -->
								</select>
							</td>
							<div class="netidClass">
								<td height="30" width="15%" align="right" class="netidClass"><spring:message code="network.netname"/>：</td>
					            <td width="35%" class="netidClass">
					                <input id="netid" name="netid" style="width: 200px;"><span class="red">*</span>
					            </td>
							</div>
							
						</tr>
						<tr class="netidClass">
							<td height="30" width="15%" align="right" class="areacodeClass"><spring:message code="area.areaname" />：</td>
							<td width="25%" class="areacodeClass">
								<input class="easyui-combotree" id="areacode" name="areacode" style="width: 200px;"> <span class="red">*</span>
							</td>
							<td height="30" width="15%" align="right" class="storeidClass"><spring:message code="store.storename" />：</td>
							<td width="25%" class="storeidClass">
								<input id="storeid" name="storeid" style="width: 200px;"> <span class="red" id="storeflag">*</span>
							</td>
					   		
						</tr>
						<tr>
							<td align="right"><spring:message code="operator.loginname" />：</td>
							<td><input type="text" class="inp"  maxlength="15" name="loginname" id="loginname" value="${operator.loginname }"> <span class="red">*</span></td>
							<td align="right"><spring:message code="operator.operatorname" />：</td>
							<td><input type="text" class="inp" name="operatorname" id="operatorname" style="width: 200px;"
							maxlength="50" value="${operator.operatorname }">
							<span class="red">*</span>
							</td>
						</tr>
						<tr>
							<td align="right"><spring:message code="operator.password" />：</td>
							<td><input type="password" class="inp" name="password" id="password" 
							 maxlength="15" style="width: 200px;"
							value="${operator.password }"> <span class="red">*</span></td>
							
							<td align="right"><spring:message code="operator.confirmpassword" />：</td>
							<td><input type="password" class="inp" name="confirmpassword" id="confirmpassword" 
							 maxlength="15" style="width: 200px;"
							value="${operator.confirmpassword }"> 
							<span class="red">*</span></td>
						</tr>	
						<tr>
							<td align="right"><spring:message code="operator.telephone" />：</td>
							<td><input type="text" class="inp" name="telephone" id="telephone" 
							maxlength="15" style="width: 200px;"
							onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
							onafterpaste="this.value=this.value.replace(/[^-\d]/g,'')" 
							value="${operator.telephone }">
							</td>
							<td align="right"><spring:message code="operator.mobile" />：</td>
							<td><input type="text" class="inp" name="mobile" id="moblie"
							maxlength="15" style="width: 200px;"
							onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
							 value="${operator.mobile}">
							 </td>
						</tr>
						<tr>
							<td align="right"><spring:message code="operator.documenttype" />：</td>
							<td><input type="text" class="inp" name="documenttype" id="documenttype" 
							maxlength="50" style="width: 200px;"
							value="${operator.documenttype }"></td>
							<td align="right"><spring:message code="operator.documentno" />：</td>
							<td><input type="text" class="inp" name="documentno" id="documentno" 
							maxlength="50" style="width: 200px;"
							value="${operator.documentno }"></td>
						</tr>
						<tr>
							<td align="right"><spring:message code="operator.email" />：</td>
							<td><input type="text" maxlength="50"  class="inp" style="width: 200px;" name="email" id="email" value="${operator.email }"></td>
							<td align="right"><spring:message code="operator.address" />：</td>
							<td><input type="text"  maxlength="100" class="inp" style="width: 200px;" name="address" id="address" value="${operator.address}"></td>
						</tr>
					</table>
				</div>
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.reback"/>" onclick="goback();" />
						<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="saveOperator();"/> 
						 --%>
						<a href="javascript:goback();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:saveOperator();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red">${operator.returninfo}</span>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/form.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript">
	
	function checkVal() {
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
	    
	    
	    //营业厅
// 	    if ( $('#storeid').combobox('getValue')=='') {
// 	          $.dialog.tips("<spring:message code="store.storename.empty"/>", 1, "alert.gif", function() {
// 				$('#storeid').focus();
// 			});
// 	        return false;
// 	    }

	    //登录名称
	    $("#loginname").val($.trim($("#loginname").val()));
		if ($("#loginname") != undefined && ($("#loginname").val() == "" || $("#loginname").val() == null )) {
			$.dialog.tips("<spring:message code='operator.loginname.empty'/>", 1, "alert.gif", function() {
				$("#loginname").focus();
			});
			return false;
		}
		//操作员名称
	    $("#operatorname").val($.trim($("#operatorname").val()));
		if ($("#operatorname") != undefined && ($("#operatorname").val() == "" || $("#operatorname").val() == null )) {
			$.dialog.tips("<spring:message code='operator.operatorname.empty'/>", 1, "alert.gif", function() {
				$("#operatorname").focus();
			});
			return false;
		}
		//登录密码
		$("#password").val($.trim($("#password").val()));
		if ($("#password") != undefined && ($("#password").val() == "" || $("#password").val() == null)) {
			$.dialog.tips("<spring:message code='operator.password.empty'/>", 1, "alert.gif", function() {
				$("#password").focus();
			});
			return false;
		}
		$("#confirmpassword").val($.trim($("#confirmpassword").val()));
		if ($("#confirmpassword") != undefined && ($("#confirmpassword").val() == "" || $("#confirmpassword").val() == null)) {
			$.dialog.tips("<spring:message code='operator.confirmpassword.empty'/>", 1, "alert.gif", function() {
				$("#confirmpassword").focus();
			});
			return false;
		} else if ($("#password").val() != $("#confirmpassword").val()) {
			$.dialog.tips("<spring:message code='operator.confirmpassword.difference'/>", 1, "alert.gif", function() {
				$("#confirmpassword").focus();
			});
			return false;
		}
		
		return true;
	}
	
	function saveOperator() {
		if (!checkVal()) {
			return;
		}
		$("#addForm").attr("action", "operator/save");
	    $("#addForm").submit();
	}
	
	function goback(){
		$("#addForm").attr("action", "operator/findByList");
		$("#addForm").submit();
	}
	
	$(function () {
		//初始化操作员等级的权限
	  	  initOperatorlevel();
		  //初始化网络
		  initNetwork();
	      var returninfo = '${operator.returninfo}';
	       if (returninfo != '') {
	        	$.dialog.tips(returninfo, 1, 'alert.gif');
	       }
    });
    
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
			    	if('${operator.netid}' != '' && '${operator.netid}' != null){
					  	  $(this).combobox('select','${operator.netid}');
					  	  //$('#netid').combobox('disable');
					}else{//默认选择第一个
						var val = $('#netid').combobox("getData");  
	                    for (var item in val[0]) {  
	                        if (item == "id") {  
	                            $(this).combobox("select", val[0][item]);  
	                        }  
	                     }  	
					} 
                    //initArea('${operator.netid}'); //默认加载区域
	    			//initStore('${operator.netid}');//默认加载营业厅 
			    }
		});  
    }
    
    function initArea(netid) {
	    	$('#areacode').combotree({   
		    url:'operator/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
		    //数据执行之后才加载
		    onLoadSuccess:function(node, data){
		    	if('${operator.areacode}' != '' && '${operator.areacode}' != null){
		    		  var node = $('#areacode').combotree('tree').tree('find', '${operator.areacode}');
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
		    	if('${operator.storeid}' != '' && '${operator.storeid}' != null){
					if('${operator.netid}' == netid){//防止选择的网络不包括默认的营业厅ID，直接把ID显示在输入库里
				  	  $('#storeid').combobox('select','${operator.storeid}');
				  	}
				}else{//默认选择第一个
					var val = $(this).combobox("getData");  
                    for (var item in val[0]) {  
                        if (item == "id") {  
                            $('#storeid').combobox("select", val[0][item]);  
                        }  
                     }  	
				} 
		    }
		});  
	}
	//判断添加者的操作权限
	function changerOperatorlevel(){
		var level = '${Operator.operatorlevel}';
		if(level == '0'){
		   var html = "";
	           html += "<option value=\"0\" " + ('${Operator.operatorlevel}' == '0' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.0"/></option>";
	           html += "<option value=\"1\" " + ('${Operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
	           html += "<option value=\"2\" " + ('${Operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		}else if(level == '1'){
		   var html = "";
	           html += "<option value=\"1\" " + ('${Operator.operatorlevel}' == '1' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.1"/></option>";
	           html += "<option value=\"2\" " + ('${Operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		}else if(level == '2'){
		   var html = "";
	           html += "<option value=\"2\" " + ('${Operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		}
		
	}
	
	//初始化修改者的操作权限
	function initOperatorlevel(){
		//判断修改的对象的等级
		var operatortype = '${operator.operatortype}';
		if(operatortype == ''){
			operatortype = $("#operatortype").val();
		}
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
	
	 //改变选择的操作员类型
	function changerOperatortype(){
		var operatortype = $('#operatortype').val();
		if(operatortype == '1'){//选择操作员类型，必须选择区域级别
			var html = "";
	           html += "<option value=\"2\" " + ('${operator.operator.operatorlevel}' == '2' ? 'selected':'') + " ><spring:message code="operator.operatorlevel.2"/></option>";
		       $('#operatorlevel').html(html);
		     //去掉营业厅必须选项标签
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
