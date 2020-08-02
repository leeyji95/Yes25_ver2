package com.lec.yes25.financial.ajax.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;
import com.lec.yes25.personnel.UserDTO;

public class UserInfoCommand implements Command {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		UserDTO list = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 매개변수 받아오기
		int username = Integer.parseInt(request.getParameter("username"));
		
		// 유효성 검사
		if(username == 0) {
			message.append("[유효하지 않은 전표번호]");
		} else {
			
			try {
				list = dao.userInfo(username);
				status = "OK";
			} catch (NumberFormatException e) {
				message.append("[유효하지 않은 parameter:" + e.getMessage() + "]");
			} catch (Exception e) {  
				//e.printStackTrace();
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			} // end try
			
		} // end if
		
		request.setAttribute("list", list);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute()
	
} // end Command