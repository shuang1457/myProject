<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon" href="${ctx}/style/images/index/favicon.jpg" />

<!-- [my97日期时间控件] -->
<script type="text/javascript" src="${ctx}/jslib/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<!-- [jQuery] -->
<script src="${ctx}/jslib/easyui1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>

<!-- [EasyUI] -->
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/stategrid1/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/icon.css" type="text/css">
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<!-- [扩展JS] -->
<script type="text/javascript" src="${ctx}/jslib/extJs.js" charset="utf-8"></script>

<!-- [扩展样式] -->
<link rel="stylesheet" href="${ctx}/style/css/framework.css" type="text/css">




<script type="text/javascript">
	function makeEasyTree(data,_root,_pararoottext){  
	    if(!data)  
	        return [];  
	    var _newData = []; //最终返回结果  
	    var _treeArray = {}; //记录一级节点  
	   // var _root = 0; //最顶层fid  
	    var _idKey = "id"; //主键的键名  
	    var _fidKey = "pid"; //父ID的键名 
	    var _ftextKey = "text"; //父text的键名  
	    _getChildren(_root,_pararoottext);  
	    function _getChildren($root,$roottext){  
	        var $children = [];  
	        for (var i in data){  
	      
	        	if( ""!=_root)
	        	{  
	        		if($root == data[i][_fidKey]){  
	 	                data[i]["children"] = _getChildren(data[i][_idKey]);  
	 	                $children.push(data[i]);  
	 	            }  
	 	            //只要一级节点  
	 	            if(_root == data[i][_fidKey] && !_treeArray[data[i][_idKey]]){  
	 	                _treeArray[data[i][_idKey]] = data[i];  
	 	                _newData.push(data[i]);  
	 	            }  
	        	}
	        	else if(""!=_pararoottext)
	        	{
	        		if($roottext == data[i][_ftextKey]){  
	 	                data[i]["children"] = _getChildren(data[i][_idKey]);  
	 	                $children.push(data[i]);  
	 	            }  
	 	            //只要一级节点  
	 	            if(_pararoottext == data[i][_ftextKey] && !_treeArray[data[i][_idKey]]){  
	 	                _treeArray[data[i][_idKey]] = data[i];  
	 	                _newData.push(data[i]);  
	 	            }  
	        		
	        	}
	        		
	           
	        }  
	        return $children;  
	    }  
	    return _newData;  
	}  
</script>
