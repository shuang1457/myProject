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
	    var year=$('#year').combobox('getValue');
	    var myChart = echarts.init(document.getElementById('main'));
	    $.ajax( {    
	        url:"/pin/getDate",
	        data:{    
	        	year:year
	        },    
	        type:'post',    
	        cache:false,    
	        dataType:'json', 
	        success:function(result) {  
	        	var course=result.key.split(","); 
	        	var values=result.value.split(",");
	        	option = {
	        		    title : {
	        		        text: '课程占比统计',
	        		        subtext: year+'学年数据分析',
	        		        x:'center'
	        		    },
	        		    tooltip : {
	        		        trigger: 'item',
	        		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	        		    },
	        		    legend: {
	        		        orient : 'vertical',
	        		        x : 'left',
	        		        data:course
	        		    },
	        		    toolbox: {
	        		        show : true,
	        		        feature : {
	        		            mark : {show: true},
	        		            dataView : {show: true, readOnly: false},
	        		            magicType : {
	        		                show: true, 
	        		                type: ['pie', 'funnel'],
	        		                option: {
	        		                    funnel: {
	        		                        x: '25%',
	        		                        width: '50%',
	        		                        funnelAlign: 'left',
	        		                        max: 1548
	        		                    }
	        		                }
	        		            },
	        		            restore : {show: true},
	        		            saveAsImage : {show: true}
	        		        }
	        		    },
	        		    calculable : true,
	        		    series : [
	        		        {
	        		            name:'访问来源',
	        		            type:'pie',
	        		            radius : '55%',
	        		            center: ['50%', '60%'],
	        		            data:[
	        		                   {value:values[0], name:course[0]},
	        		                   {value:values[1], name:course[1]},
	        		                   {value:values[2], name:course[2]},
	        		                   {value:values[3], name:course[3]},
	        		                   {value:values[4], name:course[4]}
	        		               ]
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
			<select  name="year" id="year" class="easyui-combobox"  style="width:120px;height:30px" data-options="prompt:'请选择',editable:false,panelHeight:'auto'" >
		       		<option value="2013">2013学年</option>
					<option value="2014">2014学年</option>
					<option value="2015">2015学年</option>
				     <option value="2016" selected="selected">2016学年</option>
				     <option value="2017">2017学年</option>
				     <option value="2018">2018学年</option>
				     <option value="2019">2019学年</option>
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