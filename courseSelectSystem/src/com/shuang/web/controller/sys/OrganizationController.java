package com.shuang.web.controller.sys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shuang.web.controller.base.BaseController;
import com.shuang.web.pageModel.base.Grid;
import com.shuang.web.pageModel.base.Json;
import com.shuang.web.pageModel.base.SessionInfo;
import com.shuang.web.pageModel.base.Tree;
import com.shuang.web.pageModel.sys.Organization;
import com.shuang.web.service.base.ServiceException;
import com.shuang.web.service.comm.CommServiceI;
import com.shuang.web.service.sys.OrganizationServiceI;

@Controller
@RequestMapping("/organization")
public class OrganizationController extends BaseController {
	@Autowired
	private CommServiceI commService;
	
	@Autowired
	private OrganizationServiceI organizationService;

	@RequestMapping("/manager")
	public String manager() {
		return "/admin/organization";
	}

	@RequestMapping("/treeGrid")
	@ResponseBody
	public List<Organization> treeGrid() {
		return organizationService.treeGrid();
	}

	@RequestMapping("/tree")
	@ResponseBody
	public List<Tree> tree() {
		return organizationService.tree();
	}

	@RequestMapping("/addPage")
	public String addPage() {
		return "/admin/organizationAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(Organization organization) {
		Json j = new Json();
		try {
			organizationService.add(organization);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/get")
	@ResponseBody
	public Organization get(Long id) {
		return organizationService.get(id);
	}

	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Long id) {
		Organization o = organizationService.get(id);
		request.setAttribute("organization", o);
		return "/admin/organizationEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Organization org) throws InterruptedException {
		Json j = new Json();
		try {
			organizationService.edit(org);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Long id) {
		Json j = new Json();
		try {
			organizationService.delete(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (ServiceException e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/GetOrgByLoginAndRole")
	@ResponseBody
	public Grid GetOrgByLoginAndRole(HttpServletRequest request) { //修改机制
		SessionInfo  user=(SessionInfo)request.getSession().getAttribute("sessionInfo");//获取当前用户名
		String strlogid=user.getId().toString();
		
		String strOrgid=request.getSession().getAttribute("orgid").toString();//登录用户的单位
		String strRoleName=request.getSession().getAttribute("rolename").toString();//登录用户的角色集
		
			
		
		Map<String, Object> params = new HashMap<String, Object>();
		Grid grid = new Grid();
		String sql=" select id,name from sys_organization  where 1=1  "; 
		if(strRoleName.indexOf("leaderadmin")<0)
		{
			sql+= " AND id=:ORGID ";
			params.put("ORGID", strOrgid);
		}
		else
		{
			sql+= " AND pid=:ORGID ";
			params.put("ORGID", strOrgid);
			List<Map<String,Object>> list=commService.findListBySql(sql,params);
			
			sql=" select id,name from sys_organization  where 1=1  "; 
			if(null==list || list.size()<=0)
			{
				sql+= " AND id=:ORGID ";
				params.put("ORGID", strOrgid);
			}
			else
			{
				sql+= " AND pid=:ORGID ";
				params.put("ORGID", strOrgid);
				
			}
			
		}
		
		grid.setRows(commService.findListBySql(sql,params));
		grid.setTotal(commService.countBySql(sql,params).longValue());
		return grid;
	}
	
	@RequestMapping("/GetTeamByLoginAndRole")
	@ResponseBody
	public Grid GetTeamByLoginAndRole(HttpServletRequest request) { //修改机制
		SessionInfo  user=(SessionInfo)request.getSession().getAttribute("sessionInfo");//获取当前用户名
		String strlogid=user.getId().toString();
		
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		Grid grid = new Grid();
		String sql0=" select TEAMID,TEAMNAME from am_teams  "; 
        sql0+= "where MEMBER1=:strlogid or MEMBER1=:strlogid or TEAMLEADER =:strlogid" ;
        param.put("strlogid", strlogid);
        List<Map<String, Object>>  list =commService.findListBySql(sql0,param);
        String TEAMID = "";
        if(list.size()>0){
        	
        	TEAMID=list.get(0).get("TEAMID").toString();
        }
		String sql=" select TEAMID,TEAMNAME from am_teams  where 1=1  "; 
        sql+= " AND TEAMID=:TEAMID ";
		params.put("TEAMID", TEAMID);
		grid.setRows(commService.findListBySql(sql,params));
		grid.setTotal(commService.countBySql(sql,params).longValue());
		return grid;
	}
}
