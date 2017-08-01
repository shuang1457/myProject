<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="easyui-layout" data-options="fit:true,border:false" style="overflow: scroll;" >
	<div style="margin-left: 5px;margin-right: 5px;margin-bottom: 5px;"">
			<form id="zbjsAddForm" method="post">
			<table class="grid" style="text-align:right;">
			<tr>
					<td ><font color="red" id="bt123">*</font>时  间:
					</td>
					<td align="left">
				 	<input data-options="" name="date"  id="date" placeholder="请输入时间" style="width: 150px;" class="easyui-textbox" data-options=""  value="${select.date}" readonly="readonly"  >	
				 	</td>
					<td ><font color="red" id="bt123">*</font>学年:</td>
					<td align="left">
					<input data-options="" name="year"  id="year" placeholder="请输入时间" style="width: 150px;" class="easyui-textbox" data-options=""  value="${select.year}" readonly="readonly"  >	
				 	</td>
			</tr>
			 <tr >
					<td ><font color="red" id="bt123">*</font>课程名:</td>
					<td align="left">
					<input data-options="" name="coursename"  id="coursename" placeholder="请输入时间" style="width: 150px;" class="easyui-textbox" data-options=""  value="${select.coursename}" readonly="readonly"  >	
					</td>
					<td ><font color="red" id="bt123">*</font>代课教师:</td>
					<td align="left">
					<input data-options="" name="teachername"  id="teachername" placeholder="请输入时间" style="width: 150px;" class="easyui-textbox" data-options=""  value="${select.teachername}" readonly="readonly"  >
				 	</td>
			
				</tr>
				<tr height="40px">
					<td ><font color="red" id="bt123">*</font>选课学生:</td>
					<td align="left" colspan="2">
					<input data-options="" name="studentname"  id="studentname" placeholder="请输入时间" style="width: 150px;" class="easyui-textbox" data-options=""  value="${select.studentname}" readonly="readonly"  >
				 	</td>				
				</tr>
				<tr height="40px">
				<td>备注:
			    </td>
				<td colspan="3" align="left">
				<textarea name="other1"  id="other1" style="width: 90%;height:70px"  class="easyui-textbox easyui-validatebox" data-options="validType:'length[0,1000]'">${select.other1}</textarea>
				</td>
				</tr>
			</table>
			<br>
		</form>
		</div>
	
</div>