<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    .fb-con table { 
    	width: 100%; border: 0; border-spacing: 0; border-collapse: collapse; 
    }
    .fb-con table tr {
      height: 25px;
    }
    .service table tr td {
      height: 30px;
      width: 12.5%;
    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.business.manage"/> &gt; <spring:message code="menu.business.businessquery"/></div>
  <form action="" method="post" id="addform" name="addform">
   	<input type="hidden" name="id" id="id" value="${user.user.id}"/>
    <input type="hidden" name="businesstype" id="businesstype" value="${user.businesstype }"/>
    <div class="form-box">
<!--       <div class="fb-tit"><spring:message code="user.businessinfoquery"/></div> -->
      <div class="fb-con">
    	<div id="userInfo"></div>
        <div>
        	<iframe id="main" scrolling="auto" frameborder="0" style="width:100%;height:430px;" src=""></iframe>
        </div>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript">

 //判断是否为数字
  function checkNumberChar(ob) {
    if (/^\d+$/.test(ob)) {
      return true;
    } else {
      return false;
    }
  }
  
  function loadUserInfo() {
     var data = {
       id: '${user.user.id}',
       tag: 'userInfo'
     };
     var url = 'user/getUserInfo .' + data.tag;
     $('#userInfo').load(url, data, function () {
     	//动态渲染加载的easyui组件样式
	   	$.parser.parse($('#switchButton').parent());
     });
     
     $("#main").attr("src","<%=request.getContextPath()%>/userbusiness/findBusinessdetailByList?userid=${user.user.id }");
 }
  
 $(function () {
       loadUserInfo();
       var returninfo = '${user.returninfo}';
       if (returninfo != '') {
        	$.dialog.tips(returninfo, 1, 'alert.gif');
       }
  });
  
</script>
</body>
</html>
