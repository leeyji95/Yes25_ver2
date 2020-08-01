package com.lec.yes25.financial.command;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;

import com.lec.yes25.common.BCommand;
import com.lec.yes25.common.C;
import com.lec.yes25.financial.bean.FinancialDAO;

public class FSelectLoginDeptCommand implements BCommand {

	@Override
	public void execute(Model model) {
		// 현재 로그인한 사용자
		int curUsername = 0;

		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		curUsername = Integer.parseInt(username);

		// 부서번호 추출 트랜잭션 실행
		FinancialDAO dao = C.sqlSession.getMapper(FinancialDAO.class);
		int curDept = dao.selectLoginDept(curUsername);
		
		model.addAttribute("curDept", curDept);
	
	} // end execute()
	
} // end Command