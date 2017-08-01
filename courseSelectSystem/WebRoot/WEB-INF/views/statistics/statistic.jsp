<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选课统计</title>
<link id="easyuiTheme" rel="stylesheet" href="/jslib/easyui1.4.2/themes/stategrid1/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="/jslib/easyui1.4.2/themes/icon.css" type="text/css">
<script src="/jslib/easyui1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/jslib/easyui1.4.2/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/jslib/easyui1.4.2/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="/jslib/echarts-2.2.5/source/echarts-all.js"></script>
 <script type="text/javascript">

 $(function(){
		search();
	});

	function search() {
	    var coursename=$('#coursename').combobox('getValue');
	    var myChart = echarts.init(document.getElementById('main'));
	    $.ajax( {    
	        url:"/statistics/getDate",
	        data:{    
	        	coursename:coursename
	        },    
	        type:'post',    
	        cache:false,    
	        dataType:'json', 
	        success:function(result) {  
	        	var _labels=result.key.split(","); 
	        	var _values=result.value.split(",");
	         	var option = {
	            	    title : {
	            	        text: '历年选课结果统计'
	            	    },
	            	    tooltip : {
	            	        trigger: 'axis'
	            	    },
	            	    legend: {
	            	        data:['人数' ]
	            	    },
	            	    toolbox: {
	            	        show : true,
	            	        feature : {
	            	            mark : {show: true},
	            	            dataView : {show: true, readOnly: false},
	            	            magicType : {show: true, type: ['line', 'bar']},
	            	            restore : {show: true},
	            	            saveAsImage : {show: true}
	            	        }
	            	    },
	            	    calculable : true,
	            	    xAxis : [
	            	        {
	            	            type : 'category',
	            	            data : _labels
	            	        }
	            	    ],
	            	    yAxis : [
	            	        {
	            	            type : 'value',
	            	            axisLabel : {
	            	                formatter: '{value} 人'
	            	            }
	            	        }
	            	    ],
	            	    series : [
	            	        {
	            	            name:'人数',
	            	            type:'bar',
	            	            data:_values,
	            	            markPoint : {
	            	                data : [
	            	                    {type : 'max', name: '最大值'},
	            	                    {type : 'min', name: '最小值'}
	            	                ]
	            	            }
	            	             
	            	        } 
	            	    ]
	            	};	         	
	        		myChart.setOption(option);

	        		
	        	
	         },    
	         error : function() {  
	              alert("异常！");    
	         }    
	    });  
	}
 </script>
</head>
<body class="easyui-layout" data-options="fit:true,border:true">
<div data-options="region:'north',split:true" style="height:45px">
	<table style="width: 100%;">
		<tr>
			<td style="white-space: nowrap;">
			<font style="font-size:16px;color:#005e5e">请选择课程：</font>
			<select  name="coursename" id="coursename" class="easyui-combobox"  style="width:120px;height:30px" data-options="prompt:'请选择',editable:false,panelHeight:'auto'" >
		       <option value ="高数">高数</option>
  				<option value ="英语">英语</option>
  				<option value="计算机">计算机</option>
 				 <option value="文学">文学</option>
 				 <option value="离散数学">离散数学</option>
		       </select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:search()" class="easyui-linkbutton" data-options="height:30,iconCls:'icon-search'">查询</a>
		   </td>
		</tr>
	</table>
	</div>
	<div id="main" data-options="region:'center'" style="height:100%;width:70%;overflow: scroll; ">
	</div>
</body>
</html>