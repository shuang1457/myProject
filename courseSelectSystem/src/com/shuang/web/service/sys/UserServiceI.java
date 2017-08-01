package com.shuang.web.service.sys;

import java.util.List;

import com.shuang.web.pageModel.base.PageFilter;
import com.shuang.web.pageModel.base.SessionInfo;
import com.shuang.web.pageModel.sys.User;

public interface UserServiceI {

	public List<User> dataGrid(User user, PageFilter ph);

	public Long count(User user, PageFilter ph);

	public void add(User user);

	public void delete(Long id);

	public void edit(User user);

	public User get(Long id);

	public User login(User user);

	public List<String> listResource(Long id);

	public boolean editUserPwd(SessionInfo sessionInfo, String oldPwd, String pwd);

	public User getByLoginName(User user);

	public List<User> getUserListByUserType();

	public String[] getUserListNameByUserType();

}
