package com.shuang.web.controller.courselect;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shuang.web.controller.base.BaseController;
import com.shuang.web.pageModel.base.Grid;
import com.shuang.web.pageModel.base.Json;
import com.shuang.web.service.comm.CommServiceI;



@Controller
@RequestMapping("/courselect")
public class CourselectController extends BaseController {
	@Autowired 
	private CommServiceI commService;

	@RequestMapping("/manager")
	public String manager() { 
		return "/courselect/select";
	}
	@RequestMapping("/addPage")
	public String addPage() {
		return "/courselect/selectAdd";
	}
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public Grid dataGrid(HttpServletRequest request) {
		Grid grid = new Grid();
		Map<String, Object> params = new HashMap<String, Object>();
		String sql="SELECT id,date,year,coursename,studentname,teachername,other1  FROM t_course_select  WHERE 1=1 ";    

		if(request.getParameter("starttime")!=null && request.getParameter("starttime").toString().length()>0)
		{
			sql+=" AND date >= :starttime";
			params.put("starttime", request.getParameter("starttime") );
		}
		
		if(request.getParameter("endtime")!=null && request.getParameter("endtime").toString().length()>0)
		{
			sql+=" AND date <= :endtime";
			params.put("endtime", request.getParameter("endtime") );
		}
		if(request.getParameter("coursename")!=null && request.getParameter("coursename").toString().length()>0)
		{
			sql+=" AND coursename = :coursename";
			params.put("coursename", request.getParameter("coursename") );
		}
			
		sql+=" ORDER BY date DESC ";

		grid.setRows(commService.findListBySql(sql, params,Integer.parseInt(request.getParameter("page")),Integer.parseInt(request.getParameter("rows"))));
		grid.setTotal( commService.countBySql(sql,params).longValue());

		return grid;
		
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(HttpServletRequest request,HttpSession session){
		Json j = new Json();
		HashMap<String,Object> params=new HashMap<String,Object>();
		String date = request.getParameter("date").toString();
		String year = request.getParameter("year").toString();
		String coursename = request.getParameter("coursename").toString();
		String studentname = request.getParameter("studentname").toString();
		String teachername = request.getParameter("teachername").toString();
		String other1 = request.getParameter("other1").toString();
		
		String sql = " insert into t_course_select(date,year,coursename,studentname,teachername,other1) "
				+ "values(:date,:year,:coursename,:studentname,:teachername,:other1)";

		params.put("date", date);
		params.put("year", year);
		params.put("coursename", coursename);
		params.put("studentname", studentname);
		params.put("teachername", teachername);
		params.put("other1", other1);
		
		try {
			commService.executeSql(sql, params);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	

	@RequestMapping("/viewPage")
	public String viewPage(HttpServletRequest request) {
		String id = request.getParameter("id");
		String sql="SELECT id,date,year,coursename,studentname,teachername,other1  FROM t_course_select  WHERE 1=1  ";    
		sql+=" AND id = '"+id+"' ";
		@SuppressWarnings("rawtypes")
		List  list =commService.findListBySql(sql);
		if(list.size()>0)
		{
			Map map = (Map)list.get(0);
			request.setAttribute("select", map);
		}
		return "/courselect/selectView";
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(HttpServletRequest request) {
		String id = request.getParameter("id");
    	String  sql="DELETE FROM  t_course_select WHERE id ='"+id+"'";
		Json j = new Json();
		try {
			commService.executeSql(sql);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
