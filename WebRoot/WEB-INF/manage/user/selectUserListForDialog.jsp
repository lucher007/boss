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
</head>

<body>
	<div id="body">
       	<div class="easyui-panel" title="<spring:message code="user.userquery"/>" style="width:900px">
        <form action="" method="post" id="searchForm" name="searchForm">
            <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
		      <table width="100%">
				<tr height="30px">
					<td align="right"><spring:message code="search.searchtype"/>：</td>
					<td align="left">
						 <select id="searchtype" name="searchtype" class="select" onchange="initSearchForm();">
						 	 <option value="0" <c:if test="${user.searchtype == '0' }">selected</c:if>><spring:message code="user.searchtype.0"/></option>
			             	 <option value="1" <c:if test="${user.searchtype == '1' }">selected</c:if>><spring:message code="user.searchtype.1"/></option>
			             	 <option value="2" <c:if test="${user.searchtype == '2' }">selected</c:if>><spring:message code="user.searchtype.2"/></option>
			             </select>
					</td>
					<td align="right"><spring:message code="network.netname"/>：</td>
					<td align="left">
						 <input id="querynetid" name="querynetid" style="width: 150px;">
					</td>
					<td align="right"><spring:message code="area.areacode"/>：</td>
					<td align="left">
						<input id="queryareacode" name="queryareacode" style="width: 150px;">
					</td>
				</tr>
				<tr class="serachtype1">
					<td align="right" class="serachtype1"><spring:message code="stb.stbno"/>：</td>
					<td align="left" class="serachtype1">
						 <input type="text"  class="inp w200" name="querystbno" id="querystbno" value="${user.querystbno }">
					</td>
				</tr>
				<tr class="serachtype2">
					<td align="right"class="serachtype2"><spring:message code="card.cardid"/>：</td>
					<td align="left" class="serachtype2">
						 <input type="text"  class="inp w200" name="querycardid" id="querycardid" value="${user.querycardid }">
					</td>
				</tr>
				<tr height="30px" class="serachtype0">
					<td align="right"><spring:message code="user.usercode"/>：</td>
					<td align="left">
						 <input type="text"  class="inp w200" name="queryusercode" id="queryusercode" value="${user.queryusercode }">
					</td>
				
					<td align="right"><spring:message code="user.username"/>：</td>
					<td align="left">
						 <input type="text"  class="inp w200" name="queryusername" id="queryusername" value="${user.queryusername }">
					</td>
					
					<td align="right"><spring:message code="user.documentno"/>：</td>
					<td align="left">
						 <input type="text"  class="inp w200" name="querydocumentno" id="querydocumentno" value="${user.querydocumentno }">
					</td>
				</tr>
				
				<tr height="30px" class="serachtype0">
					<td align="right"><spring:message code="user.mobile"/>：</td>
					<td align="left">
						 <input type="text"  class="inp w200" name="querymobile" id="querymobile" value="${user.querymobile }">
					</td>
			
					<td align="right"><spring:message code="user.address"/>：</td>
					<td >
							<input type="text" class="inp" style="width:220px;" name="queryaddress" id="queryaddress" 
							value="${user.queryaddress }">
					</td>
					<td align="right"><spring:message code="user.state"/>：</td>
					<td>
						 <select id="querystate" name="querystate" class="select" >
						 	   <option value=""><spring:message code="page.select"/></option>
			                   <option value="0" <c:if test="${user.querystate == '0'}">selected</c:if>><spring:message code="user.state.0"/></option>
			                   <option value="1" <c:if test="${user.querystate == '1'}">selected</c:if>><spring:message code="user.state.1"/></option>
			             </select>
					</td>
				</tr>
				
				<tr height="30px">
					<td colspan="6" align="center">
						<a href="javascript:queryUser();" class="easyui-linkbutton" style="width:120px"><spring:message code="page.query"/></a>                                                                                                                                                                                  
						<a href="javascript:clearAll();" style="width:120px" class="easyui-linkbutton"><spring:message code="search.clear"/></a>                                                                                                                                                                                  
					</td>				
				</tr>
    	    </table>
    	 </form>
	</div>
		<div style="margin:20px 0;"></div>
   
   			<div id="userlist" style="width:900px"></div>
	
</div>
    
<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="js/form.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/treeTable/jquery.treetable.js"></script>
<script type="text/javascript" language="javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	
//控制页面默认第一次加载JSON数据用的，由于页面参数还没初始化完成，EASYUI加载表格数据时，不能访问页面参数的控件值
var flag = true;
	
  function initSearchForm(){
		clearAll();
		$(".serachtype0").hide();
		$(".serachtype1").hide();
		$(".serachtype2").hide();
		var searchtype= $("#searchtype").val();
		if(searchtype=="0"){
				$(".serachtype0").show();
		}else if (searchtype=="1"){
				$(".serachtype1").show();
		}else if (searchtype=="2"){
				$(".serachtype2").show();
		}
	}

	function queryUser() {
		 var searchtype= $("#searchtype").val();
		    	if(searchtype=="0"){   //0-用户 1-STB 2-CARD
				    	$('#userlist').datagrid('reload',{
							searchtype: $('#searchtype').val(),
							querynetid: $('#querynetid').combobox('getValue'),
						    queryareacode: $('#queryareacode').combotree('getValue'),
				            queryusercode: $('#queryusercode').val(),
				            queryusername:$('#queryusername').val(),
				            querydocumentno:$('#querydocumentno').val(),
				            querymobile:$('#querymobile').val(),
				            querystate:$('#querystate').val(),
				            queryaddress:$('#queryaddress').val()
						});	
				}else if (searchtype=="1"){
						$('#userlist').datagrid('reload',{
					         	searchtype: $('#searchtype').val(),
					         	querynetid: $('#querynetid').combobox('getValue'),
						    	queryareacode: $('#queryareacode').combotree('getValue'),
					            querystbno:$('#querystbno').val()
						});	
				}else if (searchtype=="2"){
						$('#userlist').datagrid('reload',{
					            searchtype: $('#searchtype').val(),
					            querynetid: $('#querynetid').combobox('getValue'),
						    	queryareacode: $('#queryareacode').combotree('getValue'),
					            querycardid:$('#querycardid').val()
						});	
				}	    
	}
    
    function initUserlist(){
          $('#userlist').datagrid({
               title: '<spring:message code="user.userinfo" />',
               url:'user/queryUserlist',
               pagination: true,
               queryParams: {
					searchtype: $('#searchtype').val(),
					querynetid: '${Operator.netid}',
				    queryareacode: '${Operator.areacode}',
		            queryusercode: $('#queryusercode').val()     ,
		            queryusername:$('#queryusername').val()    ,
		            querydocumentno:$('#querydocumentno').val(),
		            querystbno:$('#querystbno').val(),
		            querycardid:$('#querycardid').val(),
		            querymobile:$('#querymobile').val(),
		            querystate:$('#querystate').val(),
		            queryaddress:$('#queryaddress').val()
			   },
               pageSize: 10,
               singleSelect: true,
               pageList: [10,25,50], 
               fitColumns:true,
               idField:'id',   //idField 属性已设置，数据网格（DataGrid）的选择集合将在不同的页面保持。
               loadMsg:'loading...',
               columns: [[
                  { field: 'netname', title: '<spring:message code="network.netname" />',align:"center",width:100 },
                  { field: 'usercode', title: '<spring:message code="user.usercode" />',align:"center",width:100},
              	  { field: 'username', title: '<spring:message code="user.username" />',align:"center",width:100},
      		      { field: 'mobile', title: '<spring:message code="user.mobile" />',align:"center",width:100},	  		      
                  { field: 'state', title: '<spring:message code="user.state" />',align:"center",width:100,formatter:formatUserState},
      		      { field: 'address', title: '<spring:message code="user.address" />',align:"center",width:100,
      		       			formatter: function (value) {
					                    return "<span title='" + value + "'>" + value + "</span>";
					                }
      		      },
                  { field: 'id', title: '<spring:message code="page.operate" />',align:"center",width:100,formatter:formatUserOperation }
               ]]
           });
      var p = $('#userlist').datagrid('getPager');
         $(p).pagination({
          beforePageText: "<spring:message code='easyui.page.beforePageText'/>",
          afterPageText: "<spring:message code='easyui.page.afterPageText' arguments='{pages}'/>",
       	displayMsg:	"<spring:message code='easyui.page.displayMsg' arguments='{from},{to},{total}'/>"
         });
  }
  
  //EASYUI FORMATTER
	function formatUserOperation(value,row,index){
		var formatter = '<a class="btn-look" href="javascript:selectUserInfo('+ index +')"><spring:message code="page.look"/></a>';
		return formatter;
	}
  
  function selectUserInfo(index){
	    //先选中该行
	 	$("#userlist").datagrid('selectRow',index);
	 	
	 	//获取选中的行
	 	var row = $("#userlist").datagrid('getSelected');
	 	
	 	//将row转换成json字符串
	 	var event = JSON.stringify(row);
	 	//中文进行编码转换，防止乱码
		var o = JSON.parse(event); 
		//将Json字符串赋值给event
		eval("var event = '"+JSON.stringify(o)+"';"); 
		
		parent.closeUserDialog(event);
  }
  
  function formatUserState(value,row,index){
		if(value==0){
			return	'<spring:message code="user.state.0"/>';
		}else if(value ==1){
			return	'<spring:message code="user.state.1"/>';
		}else if(value ==2){
			return	'<spring:message code="user.state.2"/>';
		}else if(value ==3){
			return	'<spring:message code="user.state.3"/>';
		}
	}

	function clearAll(){
		 $('#querynetid').val("");
	     $('#queryusercode').val("");
	  	 $('#queryusername').val("");
	 	 $('#querydocumentno').val("");
	     $('#querystbno').val("");
	     $('#querycardid').val("");
	 	 $('#querymobile').val("");
	 	 $('#querystate').val("");
		 $('#queryaddress').val("");
		 initNetwork();
	}
    
    $(function () {
	   initSearchForm();
	   
	   initNetwork();
       
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
    });
    
    function initNetwork(){
		   $('#querynetid').combobox({    
				url:'user/initNetworkJson?rid='+Math.random(),
			    valueField:'id',    
			    //limitToList:true,
			    editable:false, //不可编辑，只能下拉选择值
			    textField:'netname',
		        onSelect: function(rec){    
	               initArea(rec.id);//默认加载区域
	        	},
			    onLoadSuccess:function(node, data){
				    	//初始化营业厅列表框的默认选择值
				    	
				    	if('${Operator.netid}' != '' && '${Operator.netid}' != null){
						  	  $(this).combobox('select',parseInt('${Operator.netid}'));
						}else{//默认选择第一个
							var val = $('#querynetid').combobox("getData");  
		                    for (var item in val[0]) {  
		                        if (item == "id") {  
		                            $(this).combobox("select", val[0][item]);  
		                        }  
		                     }  	
						} 
	                    initArea($("#querynetid").combobox("getValue")); //默认加载区域
		    			//initStore('${operator.netid}');//默认加载营业厅 
				    }
			});  
		   
	    }

	    function initArea(netid) {
		  $('#queryareacode').combotree({   
			    url:'user/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
			    //数据执行之后才加载
			    onLoadSuccess:function(node, data){
			    	if('${Operator.areacode}' != '' && '${Operator.areacode}' != null){
					  	  var node = $('#queryareacode').combotree('tree').tree('find', '${Operator.areacode}');
					  	  if(node != null){
					  	  	$('#queryareacode').combotree('setValue', node.id);
					  	  }else{
					  	  	$('#queryareacode').combotree('setValue', '');
					  	  }
				     }else{
				     	$('#queryareacode').combotree('setValue', '');
				     }
			    	
			    	//初始化区域之后，再加载默认页面查询数据
			    	if(flag){
			    		initUserlist();
			      		flag = false;
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
			           //$("#queryareacode").treegrid("unselect");
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
    
</script>
</body>
</html>

