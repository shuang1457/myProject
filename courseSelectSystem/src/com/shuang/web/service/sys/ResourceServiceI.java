package com.shuang.web.service.sys;

import java.util.List;

import com.shuang.web.pageModel.base.SessionInfo;
import com.shuang.web.pageModel.base.Tree;
import com.shuang.web.pageModel.sys.Resource;

public interface ResourceServiceI {

	public List<Resource> treeGrid();

	public void add(Resource resource);

	public void delete(Long id);

	public void edit(Resource resource);

	public Resource get(Long id);

	public List<Tree> tree(SessionInfo sessionInfo);

	public List<Tree> listAllTree(boolean flag);

	public List<String> listAllResource();

}
