<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
		$('#zbjsAddForm').form({
			url : '${pageContext.request.contextPath}/courselect/add',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
				    top.$.messager.alert('提示','必填项不能为空！');
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
				//	parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
					top.dataGrid.datagrid('reload');
					
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="overflow: scroll;" >
	<div style="margin-left: 5px;margin-right: 5px;margin-bottom: 5px;"">
		<form id="zbjsAddForm" method="post">
			<table class="grid" style="text-align:right;">
			<tr>
					<td ><font color="red" id="bt123">*</font>时  间:
					</td>
					<td align="left"><select  name="date" id="date" style="width:150px;" class="easyui-datetimebox" data-options="required:true,value:'today'" ></select>
				 	</td>
					<td ><font color="red" id="bt123">*</font>学年:</td>
					<td align="left">
					 <select id="year" name="year" class="easyui-combobox" data-options="width:100,editable:false,panelHeight:'auto'" style="width: 150px">
					<option value="2013">2013学年</option>
					<option value="2014">2014学年</option>
					<option value="2015">2015学年</option>
				     <option value="2016" selected="selected">2016学年</option>
				     <option value="2017">2017学年</option>
				     <option value="2018">2018学年</option>
				     <option value="2019">2019学年</option>
					</select>
				 	</td>
			</tr>
			 <tr >
					<td ><font color="red" id="bt123">*</font>课程名:</td>
					<td align="left">
					 <select id="coursename" name="coursename" class="easyui-combobox" data-options="width:100,editable:false,panelHeight:'auto'" style="width: 150px">
					<option value ="高数">高数</option>
  					<option value ="英语">英语</option>
  					<option value="计算机">计算机</option>
 					<option value="文学" selected="selected">文学</option>
 					<option value="离散数学">离散数学</option>
					</select>
				 	</td>
					<td ><font color="red" id="bt123">*</font>代课教师:</td>
					<td align="left">
					 <select id="teachername" name="teachername" class="easyui-combobox" data-options="width:100,editable:false,panelHeight:'auto'" style="width: 150px">
					<option value ="王立军">王立军</option>
  					<option value ="李丽梅">李丽梅</option>
  					<option value="汪洋">汪洋</option>
 					<option value="李刚">李刚</option>
 					<option value="王迅">王迅</option>
					</select>
				 	</td>
			
				</tr>
				<tr height="40px">
					<td ><font color="red" id="bt123">*</font>选课学生:</td>
					<td align="left" colspan="2">
					 <select id="studentname" name="studentname" class="easyui-combobox" data-options="width:100,editable:false,panelHeight:'auto'" style="width: 150px">
					<option value ="小明">小明</option>
  					<option value ="王涛">王涛</option>
  					<option value="小刚">小刚</option>
 					<option value="李四">李四</option>
 					<option value="张三">张三</option>
					</select>
				 	</td>				
				</tr>
				<tr height="40px">
				<td>备注:
			    </td>
				<td colspan="3" align="left">
				<textarea name="other1"  id="other1" style="width: 90%;height:70px"  class="easyui-textbox easyui-validatebox" data-options="validType:'length[0,1000]'">其他</textarea>
				</td>
				</tr>
			</table>
			<br>
		</form>
		</div>
	
</div>