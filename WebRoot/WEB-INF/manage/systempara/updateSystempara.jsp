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
  <style type="text/css">
	.fb-con table tr {
	      height: 30px;
	    }
  </style>
</head>

<body>
<div id="body">
  <div class="cur-pos"><spring:message code="page.currentlocation"/>：<spring:message code="menu.system.systempara"/> &gt; <spring:message code="systempara.systemparaupdate"/></div>
  <form action="" method="post" id="updateform" name="updateform">
    <input type="hidden" name="id" id="id" value="${systempara.systempara.id}"/>
    <input type="hidden" name="querystoreid" id="querystoreid" value="${systempara.querycode}"/>
    <input type="hidden" name="pager_offset" id="pager_offset" value="${systempara.pager_offset }"/>
    <div class="form-box">
      <div class="fb-tit"><spring:message code="systempara.systemparaupdate"/></div>
      <div class="fb-con">
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="15%" align="right"><spring:message code="systempara.code"/>：</td>
            <td width="25%">
            	<input type="text"  class="inp" name="code" id="code"  readonly="readonly" style="background:#eeeeee; width: 300px;" value="${systempara.systempara.code }"> 
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="systempara.name"/>：</td>
            <td>
              <input type="text"  class="inp" name="name1" id="name1"  readonly="readonly" style="background:#eeeeee; width: 300px;" value="<spring:message code="systempara.code.${systempara.systempara.code}"/>"> 
            </td>
          </tr>
          <tr>
            <td align="right"><spring:message code="systempara.value"/>：</td>
            <td>
            	<c:choose>  
		        	<c:when test="${systempara.systempara.code eq 'mps_extend_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.mps_extend_flag.1"/></option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'client_auth_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.client_auth_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.client_auth_flag.1"/></option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'currency_code'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="156" <c:if test="${systempara.systempara.value eq '156'}">selected</c:if>><spring:message code="systempara.code.currency_code.156"/>(156)</option>
			                   <option value="356" <c:if test="${systempara.systempara.value eq '356'}">selected</c:if>><spring:message code="systempara.code.currency_code.356"/>(356)</option>
			                   <option value="380" <c:if test="${systempara.systempara.value eq '380'}">selected</c:if>><spring:message code="systempara.code.currency_code.380"/>(380)</option>
			                   <option value="392" <c:if test="${systempara.systempara.value eq '392'}">selected</c:if>><spring:message code="systempara.code.currency_code.392"/>(392)</option>
			                   <option value="586" <c:if test="${systempara.systempara.value eq '586'}">selected</c:if>><spring:message code="systempara.code.currency_code.586"/>(586)</option>
			                   <option value="643" <c:if test="${systempara.systempara.value eq '643'}">selected</c:if>><spring:message code="systempara.code.currency_code.643"/>(643)</option>
			                   <option value="724" <c:if test="${systempara.systempara.value eq '724'}">selected</c:if>><spring:message code="systempara.code.currency_code.724"/>(724)</option>
			                   <option value="764" <c:if test="${systempara.systempara.value eq '764'}">selected</c:if>><spring:message code="systempara.code.currency_code.764"/>(764)</option>
			                   <option value="826" <c:if test="${systempara.systempara.value eq '826'}">selected</c:if>><spring:message code="systempara.code.currency_code.826"/>(826)</option>
			                   <option value="840" <c:if test="${systempara.systempara.value eq '840'}">selected</c:if>><spring:message code="systempara.code.currency_code.840"/>(840)</option>
			                   <option value="910" <c:if test="${systempara.systempara.value eq '910'}">selected</c:if>><spring:message code="systempara.code.currency_code.910"/>(910)</option>
			                   <option value="999" <c:if test="${systempara.systempara.value eq '999'}">selected</c:if>><spring:message code="systempara.code.currency_code.999"/>(999)</option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'currency_conversion_denominator'}">   
	       				<input type="text" id="value" name="value" class="inp" style="width:400px;" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5"/>
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'operators_areaid'}">   
	       				<input type="text" id="value" name="value" class="inp" style="width:400px;" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5"/>
				    </c:when>  
				    <c:when test="${systempara.systempara.code eq 'operators_netid'}">   
	       				<input type="text" id="value" name="value" class="inp" style="width:400px;" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5"/>
				    </c:when>  
				    <c:when test="${systempara.systempara.code eq 'operators_bouquetid'}">   
	       				<input type="text" id="value" name="value" class="inp" style="width:400px;" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5"/>
				    </c:when>  
				    <c:when test="${systempara.systempara.code eq 'auth_expired_time'}">   
	       				<input type="text" id="value" name="value" value="${systempara.systempara.value }" onclick="WdatePicker({lang:'${locale}',skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});" class="Wdate inp w150" />
				    </c:when>
				    <c:when test="${systempara.systempara.code eq 'master_slave_card_interval_time'}">   
	       				<input type="text" id="value" name="value" class="inp" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="3" />
				        (<spring:message code="para.unit.day"/>)
				    </c:when>  
				    <c:when test="${systempara.systempara.code eq 'user_vip_class'}">   
	       				<input type="text" id="value" name="value" class="inp" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="1" />
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'maturity_rating'}">   
	       				<input type="text" id="value" name="value" class="inp" value="${systempara.systempara.value }" onkeyup="checkNum(this)" onkeypress="checkNum(this)" onblur="checkNum(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="1" />
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'sub_hold_main_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.sub_hold_main_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.sub_hold_main_flag.1"/></option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'send_stbcardpair_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.send_stbcardpair_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.send_stbcardpair_flag.1"/></option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'only_sell_card_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.only_sell_card_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.only_sell_card_flag.1"/></option>
			             </select>	 
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'print_taxpayer_flag'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.print_taxpayer_flag.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.print_taxpayer_flag.1"/></option>
			             </select>	 
				    </c:when>   
				    <c:when test="${systempara.systempara.code eq 'auto_add_installation_workorder'}">   
	       				<select id="value" name="value" class="select">
			                   <option value="0" <c:if test="${systempara.systempara.value eq '0'}">selected</c:if>><spring:message code="systempara.code.auto_add_installation_workorder.0"/></option>
			                   <option value="1" <c:if test="${systempara.systempara.value eq '1'}">selected</c:if>><spring:message code="systempara.code.auto_add_installation_workorder.1"/></option>
			             </select>	 
				    </c:when>   
				    <c:when test="${systempara.systempara.code eq 'stb_binding_card_num'}">   
	       				<input type="text" id="value" name="value" class="inp" value="${systempara.systempara.value }" onkeyup="checkNumRange(this,1,1)" onkeypress="checkNumRange(this,1,1)" onblur="checkNumRange(this,1,1)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="1" />
				    </c:when> 
				    <c:when test="${systempara.systempara.code eq 'number_subdevice_allowed_per_main'}">   
	       				<input type="text" id="value" name="value" class="inp" value="${systempara.systempara.value }" onkeyup="checkNumRange(this,1,5)" onkeypress="checkNum(this,1,5)" onblur="checkNum(this,1,5)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="1" />
				    </c:when>    
				    <c:otherwise>
				    	<input type="text" class="inp" style="width:400px;" name="value" id="value" maxlength="50" value="${systempara.systempara.value }">
				    </c:otherwise>  
				 </c:choose>
             	 <span class="red">*</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="fb-bom">
        <cite>
            <%-- 
            <input type="button" class="btn-back" value="<spring:message code="page.goback"/>" onclick="goBack()" >
            <input type="button" class="btn-save" value="<spring:message code="page.save"/>" onclick="updateComputer();" id="btnfinish">
        	 --%>
        	<a href="javascript:goBack();" class="easyui-linkbutton" iconCls="icon-back" style="width:80px"><spring:message code="page.goback"/></a>
	        <a href="javascript:updateComputer();" class="easyui-linkbutton" iconCls="icon-save" style="width:80px"><spring:message code="page.save"/></a>
        </cite>
        <span class="red">${systempara.returninfo }</span>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="js/common/jquery.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/common/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.js?self=true&skin=iblue"></script>
<script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

  function updateComputer() {
     if ($('#value').val() == '') {
          $.dialog.tips('<spring:message code="systempara.value.empty"/>', 1, 'alert.gif');
          $('#value').focus();
         return;
      }

      $('#updateform').attr('action', 'systempara/update');
      $("#updateform").submit();
  }
  
  function goBack() {
      $("#updateform").attr("action", "systempara/findByList");
      $("#updateform").submit();
  }
  
  
  $(function () {
      var returninfo = '${systempara.returninfo}';
      if (returninfo != '') {
          $.dialog.tips(returninfo, 1, 'alert.gif');
      }
  });
</script>
</body>
</html>
