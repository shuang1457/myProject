<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="inc.jsp"></jsp:include>
<meta charset="utf-8">
<title>用户登录</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link href="${ctx}/style/css/base.css" rel="stylesheet" type="text/css">
<link href="${ctx}/style/css/login.css" rel="stylesheet" type="text/css">

<script>

	var sessionInfo_userId = '${sessionInfo.id}';
	if (sessionInfo_userId) {//如果登录,直接跳转到index页面
		window.location.href='${ctx}/admin/index';
	}
	
	$(function() {
		
		$('#loginform').form({
		    url:'${ctx}/admin/login',
		    onSubmit : function() {
		    	progressLoad();
				var isValid = $(this).form('validate');
				if(!isValid){
					progressClose();
				} 
				return isValid;
			},
		    success:function(result){
		    	result = $.parseJSON(result);
		    	progressClose();
		    	if (result.success) {
		    		window.location.href='${ctx}/admin/index';
		    	}else if("error1"==result.msg){
		    		$.messager.show({
		    			title:'提示',
		    			msg:'<div class="light-info"><div class="light-tip icon-tip"></div><div>用户名或密码不能为空！</div></div>',
		    			showType:'show'
		    		});}
		    		else if("error2"==result.msg){
				    		$.messager.show({
				    			title:'提示',
				    			msg:'<div class="light-info"><div class="light-tip icon-tip"></div><div>用户名或密码不正确！</div></div>',
				    			showType:'show'
				    		});	}
		    		else{
			    		$.messager.show({
			    			title:'提示',
			    			msg:'<div class="light-info"><div class="light-tip icon-tip"></div><div>存在异常事故，请重新登陆</div></div>',
			    			showType:'show'
			    		});	}
		    }
		});
	});
	
	function submitForm(){
		$('#loginform').submit();
	}
	
	function clearForm(){
		$('#loginform').form('clear');
	}
	
	//回车登录
	function enterlogin(){
		if (event.keyCode == 13){
        	event.returnValue=false;
        	event.cancel = true;
        	$('#loginform').submit();
    	}
	}
	
</script>
</head>
<center><body onkeydown="enterlogin();" >
	<div class="login">
		<form  method="post" id="loginform">
		<div class="logo"></div>
	    <div class="login_form">
	    	<div class="user">
	        	<input class="text_value" type="text" name="loginname" data-options="required:true" value="admin" ></input>
	            <input class="text_value" type="password" name="password" value="" ></input>
	        </div>
	        <button class="button"  type="button" onclick="submitForm()">登录</button>
	    </div>
	    
	    <div id="tip"></div>
	    
	    </form>
	</div>
	</body></center>
</html>