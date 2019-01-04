$(document).ready(function(e) {
	$(".inp").live('focus',function(){ $(this).css("color","#333");});
	//让父框架自适应子框架高度
	resetH();
	$(".lb-list,.fb-list").hover(function(){
		$(this).find("td").css("background","#e9e9dd");
	},function(){
		$(this).find("td").css("background","#FFF");
	});
	/*$(".fbt-tab a").click(function(){
		$(this).addClass("act").siblings().removeClass("act");
		$(".fbc-box").hide();
		$(".fbc-box").eq($(".fbt-tab a").index(this)).show();
	});*/
	$("#searchform").submit(function(){
		if($(this).attr("action")==""){
			return false;
		};
	});
	
	if($('.remarkClass').length > 0){
		//标题title浮动样式
		$('.remarkClass').poshytip({
			className: 'tip-yellowsimple',
			alignTo: 'target',
			alignX: 'center',
			alignY: 'bottom',
			offsetX: 0,
			offsetY: 3,
			fade: false,
			slide: false
		}); 
	};
	
	//函数作用：验证输入框只能输入数字
	$(".onlynum").keyup(function(){
		checkNumValue($(this));
	}).keypress(function(){
		checkNumValue($(this));
	}).blur(function(){
		checkNumValue($(this));
	}).live('keyup',function(){
		checkNumValue($(this));
	}).live('keypress',function(){
		checkNumValue($(this));	
	}).live('blur',function(){
		checkNumValue($(this));
	});
	
	
	if($.dialog){$.dialog.setting.drag = false;};
});
//控制搜索词效果
function inp(obj,str){
	$(obj).focus(function(){
		$(this).css("color","#333");
		if($(this).val()==str){
			$(this).val('');
		}
	}).blur(function(){
		if($(this).val()==str||$(this).val()==''){
			$(this).css("color","#999");
			$(this).val(str);
		}
	});
}
//根据子框架高度重新设置父框架高度
function resetH(){
	var h = $("#body").height();
	if(h>420){
		h=h+40;
	}else{
		h=460;
	}
	$('#MainFrame',window.parent.document).height(h);
}
//实现Tab切换效果
function showTab(thi,menu,list,cls){
	$(thi).addClass(cls).siblings().removeClass(cls);
	$(list).eq($(menu).index(thi)).show().siblings().hide();
}
//验证查询框不能输入以下字符
function checkquotmarks(str){
	return /[\·\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
}

//营业执照验证
function checkquotmarks_businesscode(str){
	return /[\'\"\!\$\%]/.test(str);
}
//控制父框架菜单样式
function cMenu(n1,n2){
	/*$("#menu .m-list div a",parent.document).removeClass("act");
	$("#menu .m-list div a",parent.document).eq(n1).addClass("act");
	$("#main .ml-menu",parent.document).removeClass("hide").addClass("hide");
	$("#main .ml-menu",parent.document).eq(n1).removeClass("hide");
	$("#main .ml-menu",parent.document).eq(n1).find("a").removeClass("act");
	$("#main .ml-menu",parent.document).eq(n1).find("a").eq(n2).addClass("act");*/
}

//查询药材批次信息
function openCpc(cpc){
	var index = cpc.lastIndexOf('=');
	var type = cpc.substring(index+1); //根据type值来判断弹出的是药材CPC还是饮片CPC
	var height = 500;
	if('medicine' == type){
		height = '450';
	}else if('pieces' == type){
		height = '650';
	}
	$.dialog({
		title:'查询批次',
		id:'cpc',
		lock:true,
		content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="720" height="'+ height +'" src="'+cpc+'"></iframe>'
	});
}

function checkNumValue(obj){
	if(!checkNumberChar(obj.val())){
    	obj.val("");
    }
}
//1.js验证只能输入数字.
function checkNumberChar(ob){
	if(/^\d+$/.test(ob)){
		return true;
	}else{
		return false;
	}
}

/**
*获取字节数
*/
function getBytesLength(str) {
	return str.replace(/[^\x00-\xff]/g, 'xx').length;
}

/**
*切换订户功能-弹出用户查询界面
*
*/
var userDialog;
function switchUser(title) {
	userDialog = $.dialog({
	    title: title,
	    lock: true,
	    width: 950,
	    height: 600,
	    top: 0,
	    drag: false,
	    resize: false,
	    max: false,
	    min: false,
	    content: 'url:user/queryUserForDialog?rid='+Math.random()
	});
}

/**
*切换订功能-关闭用户查询界面
*
*/
function closeUserInfoDialog(){
	
	userDialog.close();
	$("#addform").attr("action", "user/businessUnit");
  	$("#addform").submit();
}

/////////////////////对必要的输入框进行数字合法验证，最多3位小数//////////////////////////
function onkeypressCheck(obj){
	if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
		obj.value = obj.t_value;
	} else {
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
		obj.o_value = obj.value;
	}
	if(obj.value.match(/^\d+\.\d{3}?$/)){
	   obj.value = obj.value.substr(0,obj.value.length-1);
	}
}

function onkeyupCheck(obj){
	if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
			obj.o_value = obj.value;
		}
		if (obj.value.match(/^\.$/)) {
			obj.value = "";
		}
		if (obj.value.match(/^\-$/)) {
			obj.value = "";
		}
		if (obj.value.match(/^00+/)) {
			obj.value = "";
		}
		if (obj.value.match(/^0\.00/)) {
			obj.value = "";
		}
		if (obj.value.match(/^0[1-9]/)) {
			obj.value = "";
		}
		if(obj.value.match(/^\d+\.\d{3}?$/)){
			obj.value = obj.value.substr(0,obj.value.length-1);
		} 
		if(obj.value == 'undefined'){
			obj.value='';
		}
}

function onkeyblurCheck(obj){
//	if(obj.value==0){
//		obj.value='';
//	}
	if(obj.value==''){
		obj.value = 0;
	}
	if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
		obj.value = obj.o_value;
	}else {
		if (obj.value.match(/^\.\d+$/)) {
			obj.value = 0 + obj.value;
		}
		obj.o_value = obj.value;
	}
	if(!obj.value.match(/^\d+(\.\d{3})?$/)){
		obj.value = obj.value.substr(0,obj.value.indexOf(".")+3);
	} 
}

//屏蔽网页的退格键返回前一页的操作 
function forbidBackSpace(e) {
	   var ev = e || window.event; //获取event对象 
	   var obj = ev.target || ev.srcElement; //获取事件源 
	   var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
	   //获取作为判断条件的事件类型 
	   var vReadOnly = obj.readOnly;
	   var vDisabled = obj.disabled;
	   //处理undefined值情况 
	   vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
	   vDisabled = (vDisabled == undefined) ? true : vDisabled;
	   //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
	   //并且readOnly属性为true或disabled属性为true的，则退格键失效 
	   var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
	   //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
	   var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
	   //判断 
	   if (flag2 || flag1) return false;
	}
	//禁止后退键 作用于Firefox、Opera
	document.onkeypress = forbidBackSpace;
	//禁止后退键  作用于IE、Chrome
	document.onkeydown = forbidBackSpace;

//////////////////////////////////////////////////////////////////////
	
//输入数字字符串
function checkNum(obj){
	if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
		obj.value = obj.t_value;
	} else {
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
		obj.o_value = obj.value;
	}
	if(obj.value == 'undefined'){
		obj.value='';
	}
}
//输入1~255的数字字符串
function checkNumRange(obj,min,max){
	if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
		obj.value = obj.t_value;
	} else {
		if(!(obj.value>=min && obj.value<=max)){
			obj.value = "";
		}
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
		obj.o_value = obj.value;
	}
	if(obj.value == 'undefined'){
		obj.value='';
	}
}

//输入十六进制字符串
function checkHex(obj){
	if (!obj.value.match(/^[0-9a-fA-F]?[0-9a-fA-F]*?[0-9a-fA-F]*?$/)) {
		obj.value = obj.t_value;
	} else {
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[0-9a-fA-F]?[0-9a-fA-F])?$/)) {
		obj.o_value = obj.value;
	}
	if(obj.value == 'undefined'){
		obj.value='';
	}
}

