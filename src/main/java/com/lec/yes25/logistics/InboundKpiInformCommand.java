package com.lec.yes25.logistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;



public class InboundKpiInformCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		List<InboundQtyDTO> list = null;
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
	
		try {
			//Date today = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("today"));
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			
			list =dao.sumInboundQtyByDay(year, month);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else { 
				status = "OK";
			}
			
		} catch(Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		} // end try
		
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		request.setAttribute("data", list);
		
	} // end execute

	
	
	
	
	
	
	
	
	
} // end ListCommand
