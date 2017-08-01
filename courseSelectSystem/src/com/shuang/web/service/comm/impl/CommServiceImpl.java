package com.shuang.web.service.comm.impl;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shuang.web.dao.BaseDaoI;
import com.shuang.web.service.comm.CommServiceI;

@Service
public class CommServiceImpl implements CommServiceI {

	@Autowired
	private BaseDaoI<Object> commDao;

	@Override
	public List<Object[]> findArrayBySql(String sql)
	{
		return commDao.findArrayBySql(sql);
	}
	
	@Override
	public List<Map<String,Object>> findListBySql(String sql)
	{
		return commDao.findListBySql(sql);
	}

	@Override
	public List<Object[]> findArrayBySql(String sql, int page, int rows)
	{
		return commDao.findArrayBySql(sql,page,rows);
	}
	
	@Override
	public List<Map<String,Object>> findListBySql(String sql, int page, int rows)
	{
		return commDao.findListBySql(sql,page,rows);
	}
	
	@Override
	public List<Object[]> findArrayBySql(String sql, Map<String, Object> params)
	{
		return commDao.findArrayBySql(sql,params);
	}
	
	@Override
	public List<Map<String,Object>> findListBySql(String sql, Map<String, Object> params)
	{
		return commDao.findListBySql(sql,params);
	}
	
	@Override
	public List<Object[]> findArrayBySql(String sql, Map<String, Object> params, int page, int rows)
	{
		return commDao.findArrayBySql(sql,params,page,rows);
	}
	
	@Override
	public List<Map<String,Object>> findListBySql(String sql, Map<String, Object> params, int page, int rows)
	{
		return commDao.findListBySql(sql,params,page,rows);
	}
	
	@Override
	public  Map<String,Object>  findMapBySql(String sql, Map<String, Object> params)
	{
		return commDao.findMapBySql(sql,params);
	}
	
	
	@Override
	public int executeSql(String sql) {
		return commDao.executeSql(sql);
	}
	
	@Override
	public int executeSql(String sql, Map<String, Object> params) {
		return commDao.executeSql(sql,params);
	}
	
	@Override
	public BigInteger countBySql(String sql) {
		return commDao.countBySql(sql);
	}
	
	@Override
	public BigInteger countBySql(String sql, Map<String, Object> params) {
		return commDao.countBySql(sql,params);
	}

}
