package com.lec.yes25.logistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;



public class OutboundQuery1Command implements Command {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		List<BookDTO> list = null;
		
		StringBuffer message = new StringBuffer();
		String status ="FAIL";
		
		String param = request.getParameter("book_isbn");
		
		String book_isbn = null;
		
		try {
			book_isbn = param;
			
			list = dao.searchByIsbnFromBook(book_isbn);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				status = "OK";
			}
		} catch(Exception e) {
			message.append("[트랜잭션 에러:]" + e.getMessage() + "]");
		} // end try
		
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		request.setAttribute("data", list);
		
		
		
		
		
		
		
	} // end execute
	
} // end InputCommand
