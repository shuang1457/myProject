<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<title>选课记录</title>
<script type="text/javascript">
	
 function addFun() {
		parent.$.modalDialog({
			title : '--添加数据--',
			width : 600,
			height : 540,
			href : '${ctx}/courselect/addPage',
			buttons : [ {
				text : '保&nbsp&nbsp&nbsp存',
				width: 80,
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#zbjsAddForm');
					  f.submit();
					  top.$.messager.alert('提示','数据添加成功','info',function(){parent.$.modalDialog.handler.dialog('close');progressClose();});	
				       //top.$.modalDialog.openner_dataGrid.datagrid('reload');
				}
			} ]
		});
		top.dataGrid=$('#dataGrid');
	}
	function viewFun() {
	  var row =  $('#dataGrid').datagrid('getSelections');
	 if(row.length<=0){
	   top.$.messager.alert('提示','请先选中一行数据！');
	   return;
	 }
	 else{
	    var id = row[0].id;	   
		parent.$.modalDialog({
			title : '--查看数据--',
			width : 600,
			height : 540,
			href : '${ctx}/courselect/viewPage?id=' + id
		  });
		}
	}
	function deleteFun() {
	  	 var row =  $('#dataGrid').datagrid('getSelections');
		 if(row.length<=0){
		    top.$.messager.alert('提示','请先选中一行数据！');
		   return;
		 }
		  else{
			parent.$.messager.confirm('询问', '您确定要删除吗？', function(b) {
				if (b) {
					progressLoad();
					 var id = row[0].id;	
					$.post('${ctx}/courselect/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							$("#dataGrid").datagrid('reload');
						}
						progressClose();
					}, 'JSON');
				}
			});
		
		}
	}
	function searchData() {
		$("#dataGrid").datagrid('load', $.serializeObject($('#ActiviteSerchForm')));
	}
	
	function resetQuery() {
		$('#coursename').textbox('reset');  
		$('#starttime').textbox('reset');  
		$('#endtime').textbox('reset');
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
<div style="padding: 5px 5px 5px 5px;">
	<div data-options="region:'north'" id="action"
		style="padding: 5px 5px 5px 5px;">
		<form action="#" id="ActiviteSerchForm">
			<table border="0" style="width: 100%;">
				<tr>
					<td align="left">
					<a id="add" href="javaScript:addFun()" 
						class="easyui-linkbutton" data-options="iconCls:'icon-add'"
						style="width: 80px; height: 30px">增加选课</a> &nbsp;
						<a id="detail"
						href="javaScript:viewFun()" class="easyui-linkbutton"
						data-options="iconCls:'icon-more'"
						style="width: 80px; height: 30px">查看详情</a> &nbsp;
						<a id="delete"
						href="javaScript: deleteFun()" class="easyui-linkbutton"
						data-options="iconCls:'icon-del'"
						style="width: 80px; height: 30px">删除数据</a> 
				<td  align="right">
				<font style="font-size:14px;color:#005e5e">请选择课程：</font>
		       <select  name="coursename" id="coursename" class="easyui-combobox"  style="width:120px;height:30px" data-options="prompt:'请选择',editable:false,panelHeight:'auto'" >
		       <option value ="高数">高数</option>
  				<option value ="英语">英语</option>
  				<option value="计算机">计算机</option>
 				 <option value="文学">文学</option>
 				 <option value="离散数学">离散数学</option>
		       </select>
				  <font style="font-size:14px;color:#005e5e">时间：</font> <input name="starttime" id="starttime" data-options="prompt:'起始时间'" style="width:120px;height: 30px" class="easyui-datebox"  editable="editable" ></input>  
		         <font style="font-size:14px;color:#005e5e">至</font> <input name="endtime" id="endtime" data-options="prompt:'截止时间'" style="width: 120px;height: 30px" class="easyui-datebox"  editable="editable"  ></input>  
		         <a id="query"   href="#" onclick="searchData()"  class="easyui-linkbutton" data-options="iconCls:'icon-search'"  style="width:60px;height:30px">查询</a> &nbsp;
		         <a id="clean"   href="#" onclick="resetQuery()"  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"  style="width:60px;height:30px">重置</a> 
		 	 	</td>
		 	 </tr>
			</table>
		</form>
	</div>
	<div id="operate_area"    style="padding:0px 5px 5px 5px;">
	  <table id="dataGrid" class="easyui-datagrid"  style="width:100%;height:auto"
			data-options="pagination:true,singleSelect:true,remoteSort:true,multiSort:true,rownumbers:true,
			url:'${ctx}' + '/courselect/dataGrid',method:'post',striped:true,fitColumns: true,scrollbarSize:0">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true" ></th>
				<th data-options="field:'date' ,sortable:true,align:'center',width:20" >记录时间</th>
				<th data-options="field:'year' ,sortable:true,align:'center',width:20" >选课年度</th>
				<th data-options="field:'coursename' ,sortable:true,align:'center',width:20" >课程名</th>
				<th data-options="field:'teachername' ,sortable:true,align:'center',width:20" >代课教师</th>
				<th data-options="field:'studentname' ,sortable:true,align:'center',width:20" >选课学生</th>
				<th data-options="field:'other1' ,sortable:true,align:'center',width:20" >备注</th>
			</tr>
		</thead>
		</table>
	</div>
	<div id="toolbar" style="background: #fff;height:30px;">
	</div>	
		</div>	
		
		<script type="text/javascript">	 
		var _topHeight=180;
		var _tableRowHeight=27;
		
		var style1="margin:20px 15px 15px 15px;border: 1px solid #72b4af;background: #e5f9f2;height:130px";
		var style2="margin:20px 0px 0px 35px;height:auto;width:auto";
		var style3="0px 15px 0px 15px;";
		var style4="padding:0px 0px 15px 0px;";
		 
		var _tableRows=Math.round( (top.document.body.scrollHeight-_topHeight)/_tableRowHeight-1);//-1是表头
		$('#dataGrid').datagrid({
			pageSize: _tableRows,
			pageList:[_tableRows,_tableRows+5,_tableRows+10]
		});
		 
	</script>
</body>
</html>