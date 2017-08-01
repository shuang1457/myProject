package com.shuang.web.controller.statistics;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;






import com.shuang.web.service.comm.CommServiceI;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {
	@Autowired
	private CommServiceI commService;
	
	@RequestMapping("/manager")
	public String chouShui() {
		return "/statistics/statistic";
	}
	
	@RequestMapping("/getDate")
	@ResponseBody
	public Map<String, Object> getDate(HttpServletRequest request) {
		Map<String, Object> rs = new HashMap<String, Object>();
		String coursename2="高数";
		String coursename = request.getParameter("coursename");

		String sql="SELECT id,CONCAT(YEAR,'学年')xvalue,COUNT(id)yvalue  FROM t_course_select  WHERE 1=1 ";    

		if(coursename==null || coursename.equals("")){
			sql+= " AND coursename='"+coursename2+"'";
		}else {
			sql+= " AND coursename='"+coursename+"'";
		}
		sql+=" GROUP BY YEAR";
		List<Map<String, Object>> list = commService.findListBySql(sql);
		String key = "";
		String value = "";
		for (int i = 0; i < list.size(); i++) {
			if (key.length() > 0) {
				key += ",";
			}
			if (value.length() > 0) {
				value += ",";
			}
			key += list.get(i).get("xvalue");
			value += list.get(i).get("yvalue");
		}
		rs.put("key", key);
		rs.put("value", value);
		return rs;
	}

	
}
