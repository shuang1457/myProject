<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="inc.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
<script type="text/javascript">
	var index_layout;
	var index_tabs;
	var index_tabsMenu;
	var layout_west_tree;
	var layout_west_tree_url = '';
	
	var sessionInfo_userId = '${sessionInfo.id}';
	if (sessionInfo_userId) {//如果没有登录,直接跳转到登录页面
		layout_west_tree_url = '${ctx}/resource/tree';
	}else{
		window.location.href='${ctx}/admin/index';
	}
	$(function() {
		index_layout = $('#index_layout').layout({
			fit : true
		});
		
		index_tabs = $('#index_tabs').tabs({
			fit : true,
			border : false,
			 
			tabHeight:38,
			tools : [{
				iconCls : 'icon-home',
				handler : function() {
					index_tabs.tabs('select', 0);
				}
			},
			{
				iconCls : 'icon-del',
				handler : function() {
					var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
					var tab = index_tabs.tabs('getTab', index);
					if (tab.panel('options').closable) {
						index_tabs.tabs('close', index);
					}
				}
			} ]
		});
		
		layout_west_tree = $('#layout_west_tree').tree({
			url : layout_west_tree_url,
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				if (node.attributes && node.attributes.url) {
					var url = '${ctx}' + node.attributes.url;
					addTab({
						url : url,
						title : node.text,
						iconCls : node.iconCls
					});
				}
			}
		});
	});
	
	function addTab(params) {
		var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:99.5%;"></iframe>';
		var t = $('#index_tabs');
		var opts = {
			title : params.title,
			closable : true,
			iconCls : params.iconCls,
			content : iframe,
			border : false,
			fit : true
		};
		if (t.tabs('exists', opts.title)) {
			t.tabs('select', opts.title);
		} else {
			t.tabs('add', opts);
		}
	}
	
	function logout(){
		$.messager.confirm('提示','确定要退出?',function(r){
			if (r){
				progressLoad();
				$.post( '${ctx}/admin/logout', function(result) {
					if(result.success){
						progressClose();
						window.location.href='${ctx}/admin/index';
					}
				}, 'json');
			}
		});
	}
	

	function editUserPwd() {
		parent.$.modalDialog({
			title : '修改密码',
			width : 300,
			height : 250,
			href : '${ctx}/user/editPwdPage',
			buttons : [ {
				text : '修改',
				handler : function() {
					var f = parent.$.modalDialog.handler.find('#editUserPwdForm');
					f.submit();
				}
			} ]
		});
	}

 

	
</script>
</head>
<body>
	<div id="loading" style="position: fixed;top: -50%;left: -50%;width: 200%;height: 200%;background: #fff;z-index: 100;overflow: hidden;">
	<img src="${ctx}/style/images/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
	</div>
	<div id="index_layout">
		<div data-options="region:'north',border:false" style=" overflow: hidden;" >
			<div id="header">
			<span style="float: right; padding-right: 20px;">欢迎 <b>${sessionInfo.name}</b>&nbsp;&nbsp; <a href="javascript:void(0)" onclick="editUserPwd()" style="color: #fff">修改密码</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="logout()" style="color: #fff">退出</a>
        	&nbsp;&nbsp;
    		</span>
    		<span class="header"></span>
    		</div>
		</div>
		<div id="leftNavArea"  data-options="region:'west',split:true" title="主导航" style="width: 200px;overflow: hidden;overflow-y:auto;">
			<div class="well well-small" style="padding: 5px 5px 5px 5px;">
				<ul id="layout_west_tree"></ul>
			</div>
		</div> 
		<div data-options="region:'center'" style="overflow: hidden;">
			<div id="index_tabs" style="overflow: hidden;">
				<div title="首页" data-options="border:false" style="overflow: hidden;">
						<img alt="" src="../../style/images/main_back.png" width="100%" height="100%">
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false" style="height: 30px;line-height:30px; overflow: hidden;text-align: center;background-color: #eee" >© 2016 LiangXue.com. 软件工程专业  XX级XX班 雪著 </div>
	</div>
</body>
</html>