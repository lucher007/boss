<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
<style type="text/css">
.fb-con table {
	width: 100%;
}

.fb-con table tr td:first-child {
	height: 30px;
	width: 40%;
	text-align: right;
}

.inp {
	width: 150px;
}
</style>
</head>
<body>
	<div id="body">
		<form action="" method="post" id="searchform" name="searchform" autocomplete="off">
				<input type="hidden" name="id" id="id" value="${operator.operator.id }" /> 
				<input type="hidden" name="queryloginname" id="queryloginname" value="${operator.queryloginname}"/> 
				<input type="hidden" name="querystoreid" id="querystoreid" value="${operator.querystoreid}" />
				<input type="hidden" name="querystate" id="querystate" value="${operator.querystate}"/> 
				<input type="hidden" name="queryoperatorname" id="queryoperatorname" value="${operator.queryoperatorname}"/> 
				<input type="hidden" name="queryoperatorcode" id="queryoperatorcode" value="${operator.queryoperatorcode}"/> 
				<input type="hidden" name="pager_offset" id="pager_offset" value="${operator.pager_offset }" />
				<div class="form-box">
				<div class="fb-tit"><spring:message code="operator.passwordupdate" /></div>
				<div class="fb-con">
					<table>
							<tr>
								<td><spring:message code="operator.oldpassword" />：</td>
								<td><input type="password" class="inp" name="oldPassword" id="oldPassword" ></td>
							</tr>
						
						<tr>
							<td><spring:message code="operator.newpassword" />：</td>
							<td><input type="password" class="inp" name="password" id="password"></td>
						</tr>
						
						<tr>
							<td><spring:message code="operator.confirmpassword" />：</td>
							<td><input type="password" class="inp" name="confirmPassword" id="confirmPassword"></td>
						</tr>
					
				  </table>
				</div>
				
				<div class="fb-bom">
					<cite> 
					<input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()"> 
					<input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updatePassword();"/> 
					</cite> 
					<span class="red">${operator.returninfo }</span>
				</div>
			
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
	<script type="text/javascript">
		function updatePassword() {
			if (!checkVal()) {
				return false;
			}

			$("#searchform").attr("action", "menu/updatePassword").submit();
		}

		function checkVal() {
		        $("#oldPassword").val($.trim($("#oldPassword").val()));
				if ($("#oldPassword") != undefined && $("#oldPassword").val() == "") {
					$.dialog.tips(
							'<spring:message code="operator.oldpassword.empty"/>',
							1, "alert.gif", function() {
								$("#oldPassword").focus();
							});
					return false;
				}
			
			$("#password").val($.trim($("#password").val()));
			if ($("#password") != undefined && $("#password").val() == "") {
				$.dialog.tips(
						'<spring:message code="operator.newpassword.empty"/>',
						1, "alert.gif", function() {
							$("#password").focus();
						});
				return false;
			}
            
            $("#confirmPassword").val($.trim($("#confirmPassword").val()));
			if ($("#confirmPassword") != undefined
					&& $("#confirmPassword").val() == "") {
				$.dialog
						.tips(
								'<spring:message code="operator.confirmpassword.empty"/>',
								1, "alert.gif", function() {
									$("#confirmPassword").focus();
								});
				return false;
			}
			if ($("#password").val() != $("#confirmPassword").val()) {
				$.dialog
						.tips(
								'<spring:message code="operator.confirmpassword.difference"/>',
								1, "alert.gif", function() {
									$("#confirmPassword").focus();
								});
				return false;
			}

			return true;
		}

		$(function() {
			if ("${remark }" == "dialog") {
				$("body").css({
					"width" : "470px",
					"padding" : "0"
				});
				$(".cur-pos").css("display", "none");
				$(".form-box").css("margin-top", "15px");
				$("#goback").on("click", function() {
					closeDialog();
				});
				if ("${operator.returninfo }" != null
						&& "${operator.returninfo }" != "") {
					$.dialog.tips("${operator.returninfo }", 1, "alert.gif");
				}
			} else {
				if ("${operator.returninfo }" != null
						&& "${operator.returninfo }" != "") {
					$.dialog.tips("${operator.returninfo }", 1, "alert.gif");
				}
			}
		});

		function goBack() {
			$("#searchform").attr("action", "menu/updateInit").submit();
		}

		function closeDialog() {
			parent.passwordDialog.close();
		}
	</script>
</body>
</html>
