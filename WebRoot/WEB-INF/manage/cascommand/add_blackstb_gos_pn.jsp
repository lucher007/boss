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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="style/user.css">
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
<link rel="stylesheet" href="colorpicker/css/colorpicker.css" type="text/css" />
<style type="text/css">
</style>
</head>
<body  style="padding:0px; width:99%; ">
	<div id="body">
		<div class="seh-box" align="center">
			<form action="" method="post" id="paramForm" name="paramForm">
				<input type="hidden"  name="conditioncontent" id="conditioncontent" readonly="readonly" />
				<input type="hidden" name="versiontype" id="versiontype" value="${caspnblackstb.versiontype }"/>
				<input type="hidden"  name="cardids" id="cardids"/>
				<input type="hidden"  name="unselectedcardids" id="unselectedcardids"/>
				<table>
				<tr height="40px">
						<td align="right"><spring:message code="network.netname"/>：</td>
						<td align="left">
				              <select id="netid" name="netid" class="select">
					                <c:forEach items="${caspnblackstb.networkmap}" var="dataMap" varStatus="s">
					                  <option value="${dataMap.key}" <c:if test="${dataMap.key == caspnblackstb.netid}">selected</c:if>>${dataMap.value}</option>
					                </c:forEach>
				              </select>
			            </td>
				</tr>
				
				<tr height="40px">
					<td align="right"><spring:message code="stb.stbno" />：</td>
						<td align="left">
						<input type="text" class="inp w200" name="stbno" id="stbno" readonly="readonly" style="background:#eeeeee;" value="${caspnblackstb.stbno }">
						<%-- 
						<input  type="button" class="btn-add"  id="btnfinish" value="<spring:message code="page.select"/>" onclick="chooseStb();">
						 --%>
						<a href="javascript:chooseStb();" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><spring:message code="page.select"/></a>
					</td>
				</tr>
					
				<tr height="40px">
					<td align="right"><spring:message code="authorize.flag.sendnow"/>：</td>
						<td align="left">
						<select id="send_now_flag" name="send_now_flag" class="select">
							<option value="1"><spring:message code="systempara.code.cas_send_auto.1"/></option>
			                <option value="0"><spring:message code="systempara.code.cas_send_auto.0"/></option>
			             </select>
					</td>
				</tr>
					
				<tr height="40px">
					<td align="right"><spring:message code="authorize.expiretime" />：</td>
						<td align="left">
						<input type="text" id="expired_Time" name="expired_Time" value="${caspnblackstb.expired_Time }" readonly="readonly" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150"/>
					<span class="red"> *</span>
					</td>
				</tr>
				
				</table>
				      
		      	 <div id="stbCardInfo"></div>
				<%-- 
				<input type="button" class="btn-back" value="<spring:message code="page.reback"/>" onclick="goBack();" />
				<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="goSend();" />
				 --%>
				<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	<a href="javascript:goSend();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="colorpicker/js/colorpicker.js"></script>
	<script type="text/javascript">
	   $(function() {
			loadUserCardInfo();
			var returninfo = '${caspnblackstb.returninfo}';
			if (returninfo != '') {
				$.dialog.tips(returninfo, 1, 'alert.gif');
			};
		});
		
		function goBack(){
			$("#paramForm", parent.document).attr("action", "cascommand/find_blackstb_List");
			$("#paramForm", parent.document).submit();
		}
		
		function goSend(){
			getSelectedCards();
			if ($('#stbno').val() == '') {
				$.dialog.tips('<spring:message code="stb.stbno.empty"/>', 1,
						'alert.gif');
				$('#stbno').focus();
				return;
			}

			if ($('#expired_Time').val() == '') {
				$.dialog.tips(
						'<spring:message code="authorize.expiredtime.empty"/>',
						1, 'alert.gif');
				return;
			}

			if ($('#cardids').val() == '') {
				$.dialog.tips('<spring:message code="authorize.selectone"/>', 1,
						'alert.gif');
				return;
			}

			$("#paramForm").attr("action", "cascommand/send_blackstb");
			$("#paramForm").submit();
		}

		function getSelectedCards() {
			$("#cardids").val("");
			$("#unselectedcardids").val("");
			var nameArray = document.getElementsByName("ids");
			for ( var i = 0; i < nameArray.length; i++) {
					var val = nameArray[i].value;
				if (nameArray[i].checked) {//得到
						
						if ($("#cardids").val() == "") {
							$("#cardids").val(val);
						} else {
							$("#cardids").val($("#cardids").val() + "," + val);
						}
						
				}else{
					
						if ($("#unselectedcardids").val() == "") {
							$("#unselectedcardids").val(val);
						} else {
							$("#unselectedcardids").val($("#unselectedcardids").val() + "," + val);
						}
				}
			}
		};

		function loadUserCardInfo() {
		    
		    var stbno = $("#stbno").val();
		    
		    if(stbno == null || stbno == ''){
		    	return ;
		    }
		     
			var data = {
				stbno : $("#stbno").val(),
				tag : 'stbCardInfo'
			};
			var url = 'authorize/getStbCardInfo .' + data.tag;
			$('#stbCardInfo').load(url, data, function() {
			});
		}

		var stbDialog;
		function chooseStb() {
		    var netid = $("#netid").val();
		    var versiontype = $("#versiontype").val();
		    
			stbDialog = $.dialog({
				title : '<spring:message code="authorize.userstb.choose"/>',
				lock : true,
				width : 900,
				height : 500,
				top : 0,
				drag : false,
				resize : false,
				max : false,
				min : false,
				content : 'url:authorize/findUserstbListForDialog?rid='+Math.random()+'&netid='+netid+'&versiontype=' + versiontype
			});
		}

		function closeDialog(stbno) {
			stbDialog.close();
			$("#stbno").val(stbno);
			loadUserCardInfo();
		}

		//全选
		function checkAll() {
			$(':checkbox').attr('checked', !!$('#checkall').attr('checked'));
		}

		function checkbox() {
			var checked = true;
			$('.checkbox').each(function() {
				if (!$(this).attr('checked')) {
					checked = false;
				}
			});
			$('#checkall').attr('checked', checked);
		}
	</script>
</body>
</html>