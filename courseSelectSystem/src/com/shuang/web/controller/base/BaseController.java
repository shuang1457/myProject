package com.shuang.web.controller.base;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shuang.web.utils.StringEscapeEditor;

@Controller
@RequestMapping("/base")
public class BaseController {

	protected int page = 1;// 当前页
	protected int rows = 10;// 每页显示记录数
	protected String sort;// 排序字段
	protected String order = "asc";// asc/desc

	protected String ids;// 主键集合，逗号分割

	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		/**
		 * 自动转换日期类型的字段格式
		 */
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));

		/**
		 * 防止XSS攻击
		 */
		binder.registerCustomEditor(String.class, new StringEscapeEditor(true,
				false));
	}

	/**
	 * 用户跳转JSP页面
	 * 
	 * 此方法不考虑权限控制
	 * 
	 * @param folder
	 *            路径
	 * @param jspName
	 *            JSP名称(不加后缀)
	 * @return 指定JSP页面
	 */
	@RequestMapping("/{folder}/{jspName}")
	public String redirectJsp(@PathVariable String folder,
			@PathVariable String jspName) {
		return "/" + folder + "/" + jspName;
	}

	public String autoQueryCondition(String sql, Object[] whereCondition,
			java.util.HashMap<String, Object> _param) {

		String _sql = sql;

		Object[] qc = query_build_fromFrontConditions(whereCondition);

		if (qc != null && qc.length == 2) {
			_sql = "select * from (" + _sql + " ) _query_auto_alias where "
					+ qc[0].toString();

			Object[] sql_paras_value = (Object[]) qc[1];
			for (int i = 0; i < sql_paras_value.length; i++) {
				_param.put("_query_para_alias" + i, sql_paras_value[i]);
			}
		}
		return _sql;
	}

	public String autoQueryCondition(String sql, Object[] whereCondition,
			String sortby, java.util.HashMap<String, Object> _param) {

		String _sql = sql;

		Object[] qc = query_build_fromFrontConditions(whereCondition);

		if (qc != null && qc.length == 2) {

			if (qc[0] != null && qc[0].toString().length() > 0) {
				_sql = "select * from (" + _sql + " ) _query_auto_alias where "
						+ qc[0].toString();

				Object[] sql_paras_value = (Object[]) qc[1];
				for (int i = 0; i < sql_paras_value.length; i++) {
					_param.put("_query_para_alias" + i, sql_paras_value[i]);
				}
			}

		}

		if (sortby != null && sortby.length() > 0) {
			_sql += (" order by " + sortby);
		}

		return _sql;
	}

	/**
	 * 获取前台页面传来的查询条件，便于自动组装sql 返回值包括 需要追加到where后的条件语句（以参数化形式）及 参数的传值
	 * 
	 * @param where
	 *            前台查询框传过来的值 格式： new Object[]{"person_lightId like  ? "}
	 *            key1是前台查询框设置的name属性，后台通过request.getParameter获取值
	 * @param request
	 * @return 包括两部分，格式是：object[0]=" cc=? and dd=?" object[1]是个数据组 值是前面参数值的集合 如
	 *         new Object[]{"11","22"}
	 */
	private Object[] query_build_fromFrontConditions(Object[] where) {
		// where 格式 ：

		if (where != null && where.length > 0) {

			java.util.List<Object> rs = new java.util.ArrayList<Object>();

			StringBuffer buf = new StringBuffer();
			int m = 0;
			for (int i = 0; i < where.length; i++) {
				if (i % 2 == 0) {
					if (where[i + 1] != null && where[i + 1].toString() != null
							&& where[i + 1].toString().length() > 0) {
						if (buf.length() > 0) {
							buf.append(" and ");
						}
						buf.append(where[i].toString().replaceAll("\\?",
								":_query_para_alias" + (m++)));
					}
				} else {
					if (where[i] != null && where[i].toString() != null
							&& where[i].toString().length() > 0) {
						rs.add(where[i].toString());
					}

				}
			}

			if (buf.length() > 0) {
				return new Object[] { buf.toString(), rs.toArray() };
			}
		}

		return null;
	}

}
