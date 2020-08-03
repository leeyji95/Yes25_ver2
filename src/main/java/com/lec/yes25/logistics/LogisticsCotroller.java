package com.lec.yes25.logistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;


@Controller
@RequestMapping("/logistics")
public class LogisticsCotroller {
	
	private Command command;
	private SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		C.sqlSession = sqlSession;
	}
	
	@RequestMapping("/inventory")
	public String inventory(Model model) {
		return "logistics/inventory";
	}
	
	@RequestMapping("/inbound")
	public String inbound(Model model) {
		return "logistics/inbound";
	}
	
	@RequestMapping("/outbound")
	public String outbound(Model model) {
		return "logistics/outbound";
	}
	
	@RequestMapping("/stock")
	public String stock(Model model) {
		return "logistics/stock";
	}
	
	@RequestMapping("/kpi")
	public String kpi(Model model) {
		return "logistics/kpi";
	}
	

}
