<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/user/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/user/delete')}">
	<script type="text/javascript">
	    $.canDelete = true;
	</script>
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
	<script type="text/javascript">
	var dataGrid;
	var organizationTree;
	$(function() {
	
		organizationTree = $('#organizationTree').tree({
			url : '${ctx}/organization/tree',
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				dataGrid.datagrid('load', {
				    organizationId: node.id
				});
			}
		});
	
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}/user/dataGrid',
			fit : true,
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'createdatetime',
			sortOrder : 'asc',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			columns : [ [ {
				width : '80',
				title : '登录名',
				field : 'loginname',
				sortable : true
			}, {
				width : '80',
				title : '姓名',
				field : 'name',
				sortable : true
			},{
				width : '80',
				title : '部门ID',
				field : 'organizationId',
				hidden : true
			},{
				width : '80',
				title : '所属部门',
				field : 'organizationName'
			},{
				width : '120',
				title : '创建时间',
				field : 'createdatetime',
				sortable : true
			},  {
				width : '40',
				title : '性别',
				field : 'sex',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '男';
					case 1:
						return '女';
					}
				}
			}, {
				width : '40',
				title : '年龄',
				field : 'age',
				sortable : true
			},{
				width : '60',
				title : '电话',
				field : 'phone',
				sortable : true
			}, {
				width : '60',
				title : '用户类型',
				field : 'usertype',
				sortable : true,
				formatter : function(value, row, index) {
					if(value==0){
						return "管理员";
					}else if(value==1){
						return "用户";
					}
					return "未知类型";
				}
			},{
				width : '60',
				title : '是否默认',
				field : 'isdefault',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '默认';
					case 1:
						return '否';
					}
				}
			},{
				width : '60',
				title : '状态',
				field : 'state',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '正常';
					case 1:
						return '停用';
					}
				}
			} , {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					//if(row.isdefault!=0){
						if ($.canEdit) {
							str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" style="color:#993300" onmouseover="this.style.cssText=\'color:#0b806f; text-decoration:none;\'" onmouseout="this.style.cssText=\'color:#993300;text-decoration:none\'" >编辑</a>', row.id);
						}
						if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
							str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" style="color:#993300" onmouseover="this.style.cssText=\'color:#0b806f; text-decoration:none;\'" onmouseout="this.style.cssText=\'color:#993300;text-decoration:none\'" >删除</a>', row.id);
						}
					//}
					return str;
				}
			}] ],
			toolbar : '#toolbar'
		});
	});
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 500,
			height : 300,
			href : '${ctx}/user/addPage',
			buttons : [ {
				text : '保&nbsp&nbsp&nbsp存',
				width: 80,
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#userAddForm');
					f.submit();
				}
			} ]
		});
	}
	
	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
			if (b) {
				var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					progressLoad();
					$.post('${ctx}/user/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						progressClose();
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}
	
	function editFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '-编辑数据-',
			width : 500,
			height : 300,
			href : '${ctx}/user/editPage?id=' + id,
			buttons : [ {
				text : '保&nbsp&nbsp&nbsp存',
				width: 80,
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#userEditForm');
					f.submit();
				}
			} ]
		});
	}
	
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
//		dataGrid.datagrid('load', {});
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="height: 50px; overflow: hidden;background-color: #fff">
		<form id="searchForm">
			<table style="margin-top:10px;margin-left:5px;">
				<tr>
					<th width="70px" align=center>姓名:</th>
					<td><input class="easyui-textbox" name="name"  data-options="prompt:'请输入姓名'" /></td>
					<th width="70px" align=center>创建时间:</th>
					<td><input class="easyui-datetimebox" name="createdatetimeStart" data-options="prompt:'起始时间'"  />&nbsp;&nbsp;至&nbsp;&nbsp;<input class="easyui-datetimebox"  name="createdatetimeEnd"  data-options="prompt:'截止时间'"  />
					&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchFun();" style="width:80px;">查询</a>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cleanFun();" style="width:80px;">重置</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:true,title:'用户列表'" >
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div data-options="region:'west',border:true,split:false,title:'组织机构'"  style="width:180px;overflow: hidden; ">
		<ul id="organizationTree"  style="width:160px;margin: 10px 10px 10px 10px">
		</ul>
	</div>
	<div id="toolbar" style="background: #fff;height:30px;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/user/add')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:100px;height:20px;margin-top :5px;margin-left :5px;">添加</a>
		</c:if>
	</div>
 
</body>
</html>