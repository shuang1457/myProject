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
@RequestMapping("/pin")
public class StatisticsPinController {
	@Autowired
	private CommServiceI commService;
	
	@RequestMapping("/manager")
	public String chouShui() {
		return "/statistics/statisticPin";
	}
	
	@RequestMapping("/getDate")
	@ResponseBody
	public Map<String, Object> getDate(HttpServletRequest request) {
		Map<String, Object> rs = new HashMap<String, Object>();
		String year2="2016";
		String year = request.getParameter("year");

		String sql="SELECT id,courseName name,COUNT(courseName)value  FROM t_course_select  WHERE 1=1 ";    

		if(year==null || year.equals("")){
			sql+= " AND year='"+year2+"'";
		}else {
			sql+= " AND year='"+year+"'";
		}
		sql+=" GROUP BY courseName";
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
			key += list.get(i).get("name");
//			value +="{value:"+ list.get(i).get("value")+",name:'"+list.get(i).get("name")+"'}";
			value +=list.get(i).get("value");
		}
		rs.put("key", key);
		rs.put("value", value);
		return rs;
	}

	
}
