package com.shuang.web.controller.sys;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shuang.web.controller.base.BaseController;
import com.shuang.web.framework.constant.GlobalConstant;
import com.shuang.web.pageModel.base.Json;
import com.shuang.web.pageModel.base.SessionInfo;
import com.shuang.web.pageModel.sys.User;
import com.shuang.web.service.sys.OrganizationServiceI;
import com.shuang.web.service.sys.ResourceServiceI;
import com.shuang.web.service.sys.UserServiceI;

@Controller
@RequestMapping("/admin")
public class IndexController extends BaseController {

	@Autowired
	private UserServiceI userService;

	@Autowired
	private ResourceServiceI resourceService;
	
	@Autowired
	private OrganizationServiceI organizationService;

	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		if ((sessionInfo != null) && (sessionInfo.getId() != null)) {
			return "/index";
		}
		return "/login";
	}

	@ResponseBody
	@RequestMapping("/login")
	public Json login(User user, HttpSession session) {
		Json j = new Json();
		if("".equals(user.getLoginname())||"".equals(user.getPassword())){
			j.setMsg("error1");
			return j;
		}
		User sysuser = userService.login(user);
		if (sysuser != null) {
			j.setSuccess(true);
			j.setMsg("登陆成功！");

			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setId(sysuser.getId());
			sessionInfo.setLoginname(sysuser.getLoginname());
			sessionInfo.setName(sysuser.getName());
			// user.setIp(IpUtil.getIpAddr(getRequest()));
			sessionInfo.setResourceList(userService.listResource(sysuser.getId()));
			sessionInfo.setResourceAllList(resourceService.listAllResource());
			session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);	
			
			Long orgid=userService.get(sessionInfo.getId()).getOrganizationId();
			String  orgName=organizationService.get(orgid).getName();
			String rolename=userService.get(sessionInfo.getId()).getRoleNames();
			
			session.setAttribute("rolename",rolename);
			session.setAttribute("orgid",orgid);
			session.setAttribute("orgName",orgName);
			
			
		} else {
			j.setMsg("error2");
		}
		return j;
	}

	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session) {
		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
		j.setSuccess(true);
		j.setMsg("注销成功！");
		return j;
	}

}
