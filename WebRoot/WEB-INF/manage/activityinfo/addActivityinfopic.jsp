<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link type="text/css" rel="stylesheet" href="<%=basePath%>main/plugin/uploadify/uploadify.css" />
<link rel="stylesheet" type="text/css" href="style/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="main/plugin/easyui/themes/icon.css">
</head>
<body>
	<div id="body">
		<div class="cur-pos">
			<spring:message code="page.currentlocation" />：<spring:message code="menu.system.activityinfo" />&gt;<spring:message code="activityinfo.activityinfoadd" />
		</div>
		<form method="post" enctype="multipart/form-data" id="addForm" name="addForm">
		    <input type="hidden" name="querytitle" id="querytitle" value="${activityinfo.querytitle }"/>
			<input type="hidden" name="id" id="id" value="${activityinfo.activityinfo.id }"/>
		    <input type="hidden" name="pager_offset" id="pager_offset" value="${activityinfo.pager_offset }"/>
			<div class="form-box">
				<div class="fb-tit">
					<spring:message code="activityinfo.activityinfoadd" />
				</div>
				<div class="fb-con">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr height="auto">
							<td align=center>
								<div class="easyui-panel" title="<spring:message code="menu.system.activityinfo"/>" style="width:750px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr height="30px">
											<td align="right"><spring:message code="activityinfo.title" />：</td>
											<td>
												<input type="text" class="inp" name="title" readonly="readonly" style="background:#eeeeee;width: 250px;" id="title" value="${activityinfo.activityinfo.title }"
													maxlength="50"
												>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						
						<tr height="auto">
							<td>
								<div style="margin:20px 0;"></div>
							</td>
						</tr>
						
						<tr height="auto">
							<td align=center>
								<div class="easyui-panel" title="<spring:message code="promotion.uploadattachment"/>" style="width:750px">
									<table id="appendtr" width="100%" border="0" cellpadding="0" cellspacing="0">
										
										<tr height="auto">
											<td>
												<div style="margin:20px 0;"></div>
											</td>
										</tr>
										
										<tr class="uploadfiles" height="40px">
											<td align="center">
												<input name="file_upload" id="file_upload"  style="display: none" />
											</td>
										</tr>
										
										<tr height="40px">
											<td align="center" id="uploadlimit" class="red"></td>
										</tr>
									
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="fb-bom">
					<cite> 
						<%-- 
						<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack();" /> 
						<input type="button" class="btn-save uploadfiles" value="<spring:message code="page.save"/>" onclick="uploadifybutton();"/> 
						 --%>
						<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        	  		<a href="javascript:uploadifybutton();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
					</cite> 
					<span class="red" id="resultinfo"></span>
				</div>
			
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>main/plugin/uploadify/jquery.uploadify.js"></script>
	<script type="text/javascript">

  var replaceQueueItem_i18n = '<spring:message code="uploadify.file.exist"/>';
  var fileinqueue=0;
  $(function () {
       var returninfo = '${activityinfo.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }

	  var extendinfocount = ${activityinfo.activityinfopiccount};
	  //var extendinfocount = 0;
	  var uploadLimit= 10 - extendinfocount;//不能超过10张图片
			if(uploadLimit > 0){
			          $("#uploadlimit").html("<spring:message code='uploadify.notification.product.leftspot' arguments='" +(extendinfocount)+ "," +(uploadLimit)+ "' />");  	   
					  $('#file_upload').uploadify({
					          uploader: '<%=basePath%>activityinfo/saveActivityinfopic',            // 服务器处理地址
					          swf: '<%=basePath%>main/plugin/uploadify/uploadify.swf',
					          auto:false,
					          preventCaching :'true',   //防止浏览器缓存
					          method:'post',                     //提交方式
					          buttonText: '<spring:message code="uploadify.selectfile"/>',                  //按钮文字
					          height: 20,                             //按钮高度
					          width: 200,                              //按钮宽度
					          uploadLimit:uploadLimit,
					          fileObjName: 'uploadfile',   //文件对象名称,用于后台获取文件对象时使用
					          fileSizeLimit:'10240kb',
				          	  //fileTypeExts: "*.jpg;*.xls;*.png;",           //允许的文件类型  
				 			  fileTypeDesc: '<spring:message code="page.select.empty"/>',           //文件说明
					          formData: { "activityinfoid": '${activityinfo.activityinfo.id}',"title": '${activityinfo.activityinfo.title}',}, //提交给服务器端的参数
							  overrideEvents: ['onSelectError', 'onDialogClose'],
							        //返回一个错误，选择文件的时候触发
							onSelect:function(file){
								fileinqueue++;
							},
							onCancel:function(file){
								fileinqueue--;
							}, 
							  onSelectError: function (file, errorCode, errorMsg) {
							            switch (errorCode) {
							                case -100:   //超出限制数量
							                    alert("<spring:message code='uploadify.onselecterror.100' arguments='" +(uploadLimit)+ "' />");
							                    break;
							                case -110:   //超出限制大小
							                var fileSizeLimit =  $('#file_upload').uploadify('settings', 'fileSizeLimit');
							                 alert( "<spring:message code='uploadify.onselecterror.110' arguments='" +(file.name)+ "," +(fileSizeLimit)+ "' />");
							                    break;
							                case -120:    //空文件
							                 alert("<spring:message code='uploadify.onselecterror.120' arguments='" +(file.name)+ "' />");
							                    break;
							                case -130:  //格式不和要求
							                 alert("<spring:message code='uploadify.onselecterror.130' arguments='" +(file.name)+ "' />");
							                    break;
							            }
							            return false;
							        },
							  onUploadStart:function(file){
								 $("#file_upload").uploadify("settings","formData",{'netid': $("#netid").val(), 'activityinfoid':$("#activityinfoid").val(),'type':$("#type").val(),'description':$("#description").val()});
							   },
							 
							   onFallback: function() {//检测FLASH失败调用  
							     alert('<spring:message code="uploadify.flash.undetected"/>');  
							   },  
					           onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
				  					fileinqueue--;
				  					var json_data=eval("("+data+")");
				                  	var result = json_data.result;
				                    $("#resultinfo").html(result);  	   
				                    $.dialog.tips(result, 1, 'alert.gif');
									//$('#file_upload').uploadify('settings','uploadLimit', ++uploadLimit);
			   				 		$("#uploadlimit").html("<spring:message code='uploadify.notification.product.leftspot' arguments='" +(++extendinfocount)+ "," +(--uploadLimit)+ "' />");  	   
				         	  		if(uploadLimit==0){
				         	  			     $(".uploadfiles").hide();
				         	  			     $("#uploadlimit").html("<spring:message code='uploadify.notification.product.nospot' arguments='" +(extendinfocount)+"' />");  	   
				         	  		}
				         	   }
					     });
		     }else{
		     	 $(".uploadfiles").hide();
				 $("#uploadlimit").html("<spring:message code='uploadify.notification.product.nospot' arguments='" +extendinfocount+"' />");  	   
		     }
  });
  
  
	  function checkLength(object, maxlength) {
	    var obj = $('#' + object),
	        value = $.trim(obj.val());
	    if (value.length > maxlength) {
	      obj.val(value.substr(0, maxlength));
	    } else {
	      $('#validNum' + object).html(maxlength - value.length);
	    }
	  }
  	  
	  function goBack() {
	      $("#addForm").attr("action", "activityinfo/queryActivityinfopic");
	      $("#addForm").submit();
	  }
	  
	  function uploadifybutton(){
		    
		  
  			if(fileinqueue>0){		
  				$('#file_upload').uploadify('upload','*');
  			}else{
  				alert('<spring:message code="uploadify.selectfile"/>');
  			}
  	  }
  
</script>
</body>
</html>
