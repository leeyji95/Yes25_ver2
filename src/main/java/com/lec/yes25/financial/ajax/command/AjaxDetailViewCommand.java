package com.lec.yes25.financial.ajax.command;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;
import com.lec.yes25.financial.bean.FinancialDTO;


public class AjaxDetailViewCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		FinancialDTO dto = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 매개변수 받아오기
		int stmt_uid = Integer.parseInt(request.getParameter("stmt_uid"));
		
		// 유효성 검사
		if(stmt_uid == 0) {
			message.append("[유효하지 않은 전표번호]");
		} else {
			
			try {
				// 트랜잭션 수행
				dto = dao.selectByStmt_uid(stmt_uid);
				
				// 정상적으로 트랜잭션 작동했는지 검사
				if(dto == null) {
					message.append("[기존 자료 불러오기 실패]");
				} else {
					status = "OK";
				}
				
			} catch (NumberFormatException e) {
				message.append("[유효하지 않은 parameter:" + e.getMessage() + "]");
			} catch (Exception e) {  
				//e.printStackTrace();
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			} // end try
			
		} // end if
		
		request.setAttribute("list", Arrays.asList(dto));
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute()

} // end Command