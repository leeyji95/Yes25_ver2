package com.lec.yes25.financial.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.yes25.common.C;
import com.lec.yes25.financial.command.FUpdateCommand;
import com.lec.yes25.financial.command.FViewCommand;

@Controller
@RequestMapping("/financial")
public class FinancialController {
	
	// MyBatis
	private SqlSession sqlSession;

	public FinancialController() {
		super();
		System.out.println("FinancialController() 생성");
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		C.sqlSession = sqlSession;
	}
	
	
	// 메인 리스트는 Ajax에서 정보 로딩
	@RequestMapping("/financialMain.bn")
	public String list() {
		return "financial/financialMain";
	}
	
	// 결제를 위한 View
	@RequestMapping("/financialView.bn")
	public String proceedView(int stmtUid, Model model) {
		model.addAttribute("stmtUid", stmtUid);
		new FViewCommand().execute(model);
		return "financial/proceedView";
	}
	// 결제 처리 라인 
	@RequestMapping("/financialupdateOk.bn")
	public String updateOK(int stmtUid, int proceed, Model model) {
		model.addAttribute("stmtUid", stmtUid);
		model.addAttribute("proceed", proceed);
		new FUpdateCommand().execute(model);
		return "financial/proceedUpdateOk";
	}
	
	// 재무부서용 목록 리스트 -> Ajax에서 정보 로딩
	@RequestMapping("/financialDeptList.bn")
	public String financialDepTList() {
		return "financial/financialDepTList";
	}
	
	// 손익계산서
	@RequestMapping("/incomeView.bn")
	public String income() {
		return "financial/incomeView";
	}
	

	
} // end Controller