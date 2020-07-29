package com.lec.yes25.financial.ajax.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AccountDTO;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;

public class AjaxAccountNameCommand implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		List<AccountDTO> arr = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";		// 기본 FAIL
		
		// 매개변수 받아오기
		int account_uid = Integer.parseInt(request.getParameter("account_uid"));
		
		// 유효성 검사
		if(account_uid == 0) {
			message.append("[유효하지 않은 parameter]");
		} else {
		
			try {
				// 트랜잭션 수행
				arr = dao.searchAccountName(account_uid);
				
				// 정상적으로 트랜잭션 작동했는지 검사
				if(arr == null) {
					message.append("[트랙잰셕 실패: 검색 실패]");
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
		
		request.setAttribute("list", arr);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute()

} // end Command