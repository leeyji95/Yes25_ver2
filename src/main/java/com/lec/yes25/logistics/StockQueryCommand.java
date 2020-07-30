package com.lec.yes25.logistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;



public class StockQueryCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		List<BookDTO> list = null;
		
		StringBuffer message = new StringBuffer();
		String status ="FAIL";
		
		int param1 = Integer.parseInt(request.getParameter("classification"));
		String param2 = request.getParameter("keyword");
		int param3 = Integer.parseInt(request.getParameter("category_uid"));
		String param4 = request.getParameter("fromDate");
		String param5 = request.getParameter("toDate");
		
		int classification = 0;
		String keyword = null;
		int category_uid = 0;
		String fromDate = null;
		String toDate = null;
		
		try {
			classification = param1;
			keyword = param2;
			category_uid = param3;
			fromDate = param4;
			toDate = param5;
			
			System.out.println(classification +","+ keyword+","+category_uid+","+fromDate+","+toDate);
			
			list = dao.selectByFilter(classification, keyword, category_uid, fromDate, toDate);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				status = "OK";
			}
		} catch(Exception e) {
			message.append("[트랜잭션 에러:]" + e.getMessage() + "]");
			e.printStackTrace();
		} // end try
		
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		request.setAttribute("data", list);

	}

}
