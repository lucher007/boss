<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr height="30px">
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
          <tr height="30px">
            <td align="right"><spring:message code="user.username"/>：</td>
          	<td>
				<input type="text" class="inp" name="username"  id="username" 
				maxlength="50" style="width:200px;"
				value="${user.username }">
			</td>
			<td align="right"><spring:message code="user.mobile"/>：</td>
            <td >
            	<input type="text" class="inp" name="mobile" id="mobile" 
            	maxlength="15" style="width:200px;"
            	onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)"
            	onafterpaste="this.value=this.value.replace(/\D/g,'')" 
            	value="${user.mobile }">
            </td>
          </tr>
          <tr height="30px">
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
          <tr height="30px">
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
          <tr height="30px">
            <td align="right"><spring:message code="user.address"/>：</td>
            <td colspan="3">
            	<input type="text" class="inp" style="width:400px;" name="address" id="address" 
            	maxlength="100" 
                value="${user.address }">
            </td>
          </tr>
          <tr height="30px">
          	<td align="right"><spring:message code="user.password"/>：</td>
          	<td colspan="3">
				<input type="text" class="inp" name="password" id="password" 
				maxlength="6" style="width:200px;"
				value="${user.password }">
			</td>
          </tr>
    </table>

<script type="text/javascript">
    $(function() {
   		initNetwork();
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
                    //initArea('${operator.netid}'); //默认加载区域
	    			//initStore('${operator.netid}');//默认加载营业厅 
			    }
		});  
	   
    }
 
    function initArea(netid) {
	  $('#areacode').combotree({   
		    url:'user/getAreaTreeJson?querynetid='+netid+'&rid='+Math.random(),
		    //数据执行之后才加载
		    onLoadSuccess:function(node, data){
		    	if('${Operator.areacode}' != '' && '${Operator.areacode}' != null){
				  	  var node = $('#areacode').combotree('tree').tree('find', '${Operator.areacode}');
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
		           $("#areacode").treegrid("unselect");
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


