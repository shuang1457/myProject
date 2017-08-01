package com.shuang.web.service.comm;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface CommServiceI {

	public List<Object[]> findArrayBySql(String sql);
	public List<Map<String,Object>> findListBySql(String sql);

	public List<Object[]> findArrayBySql(String sql, int page, int rows);
	public List<Map<String,Object>> findListBySql(String sql, int page, int rows);

	public List<Object[]> findArrayBySql(String sql, Map<String, Object> params);
	public List<Map<String,Object>> findListBySql(String sql, Map<String, Object> params);

	public List<Object[]> findArrayBySql(String sql, Map<String, Object> params, int page, int rows);
	public List<Map<String,Object>> findListBySql(String sql, Map<String, Object> params, int page, int rows);
	public  Map<String,Object>  findMapBySql(String sql, Map<String, Object> params);
	
	public int executeSql(String sql) ;
	public int executeSql(String sql, Map<String, Object> params);
	public BigInteger countBySql(String sql);
	public BigInteger countBySql(String sql, Map<String, Object> params);

}
