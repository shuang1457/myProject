package com.shuang.web.service.sys;

import java.util.List;

import com.shuang.web.pageModel.base.Tree;
import com.shuang.web.pageModel.sys.Organization;

public interface OrganizationServiceI {

	public List<Organization> treeGrid();

	public void add(Organization organization);

	public void delete(Long id);

	public void edit(Organization organization);

	public Organization get(Long id);

	public List<Tree> tree();

}
