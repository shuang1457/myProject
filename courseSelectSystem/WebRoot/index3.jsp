<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>extjs</title>

<script src="/extjs/ext-all.js" type="text/javascript"></script>
<script src="/extjs/bootstrap.js" type="text/javascript"></script>
<link id="extjs" rel="stylesheet" href="/extjs/resources/css/ext-all.css" type="text/css">

<script type="text/javascript">

 //   Ext.require('Ext.tab.*');
	Ext.onReady(function(){
		
		/* Ext.MessageBox.alert("title:hellow","ok!!");
		
		var mypanel = new Ext.TabPanel({
			renderTo:Ext.getBody(),
			width:400,
			height:300,
			activeTab:2,
			items:[
			       new Ext.Panel({
			    	   title:"Tab1",
			    	   height:30,
			    	   html:"面板11"
			       }),
			       new Ext.Panel({
			    	   title:"Tab2",
			    	   height:30,
			    	   html:"面板22"
			       }),
			       new Ext.Panel({
			    	   title:"Tab3",
			    	   height:30,
			    	   html:"面板33"
			       }),
			       new Ext.Panel({
			    	   title:"Tab4",
			    	   height:30,
			    	   html:"面板444"
			       })
			       
			       ]
			
		}); */
		
		
		
		
		/*  var myPanel=new Ext.Panel({
			renderTo:Ext.getBody(),
			title:'test 面包',
			width:400,
			height:300,
			html:'title biaokjfijj'
			
		}); */
		 
		
		/*  var tabs = Ext.widget('tabpanel', {
		        renderTo: 'tabs1',
		        width: 450,
		        activeTab: 0,
		        defaults :{
		            bodyPadding: 10
		        },
		        items: [{
		            contentEl:'script', 
		            title: 'Short Text',
		            closable: true
		        },{
		            contentEl:'markup', 
		            title: 'Long Text'
		        }]
		    });
		    
		    // second tabs built from JS
		    var tabs2 = Ext.widget('tabpanel', {
		        renderTo: document.body,
		        activeTab: 0,
		        width: 600,
		        height: 250,
		        plain: true,
		        defaults :{
		            autoScroll: true,
		            bodyPadding: 10
		        },
		        items: [{
		                title: 'Normal Tab',
		                html: "My content was added during construction."
		            },{
		                title: 'Ajax Tab 1',
		                loader: {
		                    url: 'ajax1.htm',
		                    contentType: 'html',
		                    loadMask: true
		                },
		                listeners: {
		                    activate: function(tab) {
		                        tab.loader.load();
		                    }
		                }
		            },{
		                title: 'Ajax Tab 2',
		                loader: {
		                    url: 'ajax2.htm',
		                    contentType: 'html',
		                    autoLoad: true,
		                    params: 'foo=123&bar=abc'
		                }
		            },{
		                title: 'Event Tab',
		                listeners: {
		                    activate: function(tab){
		                        setTimeout(function() {
		                            alert(tab.title + ' was activated.');
		                        }, 1);
		                    }
		                },
		                html: "I am tab 4's content. I also have an event listener attached."
		            },{
		                title: 'Disabled Tab',
		                disabled: true,
		                html: "Can't see me cause I'm disabled"
		            }
		        ]
		    }); */
		
		    
		        var toolbar = new Ext.toolbar.Toolbar({
		            renderTo:'toolbar',
		            width:300
		        });
		        
		        var childrenMenu = new Ext.menu.Menu({
		            ignoreParentClicks:true,
		            items:[
		                {text:'open one'},
		                {text:'open two'}
		            ]            
		        });
		        
		        var fileMenu = new Ext.menu.Menu({
		            shadow:'frame',
		            allowOtherMenus:true,
		            items:[
		                new Ext.menu.Item({
		                    text:'new'
		                }),
		                {text:'open',menu:childrenMenu},
		                {text:'close'}
		            ]
		        });
		        
		        
		        toolbar.add(
		            {
		                text:'新建',
		                menu:fileMenu
		            },
		            {
		                text:'打开'
		            },
		            {
		                text:'保存'
		            },
		            '->',
		            '<a href="#">link</a>',
		            'text'
		        );
		        
		  

		    
		    
	});
	
	
	
</script>
</head>
<body >
spring_ extjs<br>
ext
		 <div id='toolbar'></div>

</body>
</html>