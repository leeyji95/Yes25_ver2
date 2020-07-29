package com.lec.yes25.financial.ajax.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AccountDTO;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;


public class AjaxSearchCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		List<AccountDTO> arr = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "OK";   // 기본 OK
								// 왜냐하면 사용자가 입력한 검색어가 검색이 안될 수도 있기 때문에
		
		// 매개변수 받아오기
		String word = request.getParameter("word");
		
		System.out.println(word);
		
		// 유효성 검사
		if(word == null || word.length() == 0) {
			message.append("[유효하지 않은 parameter]");
		} else {
		
			try {
				// 트랜잭션 수행
				arr = dao.searchAccount(word);
				
				// 정상적으로 트랜잭션 작동했는지 검사
				if(arr == null) {
					message.append("[유효하지 않은 parameter]");
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