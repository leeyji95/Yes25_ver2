package com.lec.yes25.logistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;



public class OutboundUpdateCommand implements Command {

	@Override
	@Transactional
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		Long param1 = Long.parseLong(request.getParameter("book_isbn"));
		int param2 = Integer.parseInt(request.getParameter("price"));
		int param3 = Integer.parseInt(request.getParameter("stock_quantity"));
		
		if(param1 == 0 || param2 == 0 || param3 == 0){
			message.append("[유효하지 않은 parameter: 0]");
		} else {
			Long book_isbn = param1;
			int outbound_unit_price = param2;
			int outbound_quantitiy = param3;
			
			try {
				cnt = dao.insertIntoOutbound(book_isbn, outbound_unit_price, outbound_quantitiy);
				dao.updateByUidInStockFromOutbound(book_isbn, outbound_quantitiy);
				
				if(cnt == 0) {
					message.append("[0 inserted]");
				}  else {
					status = "OK";					
				} // end if

			} catch (Exception e) {
				message.append("[트렌잭션 에러:"+ e.getMessage() + "]");
				e.printStackTrace();
			} // end try
		} // end if
		
		request.setAttribute("result", cnt);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
	} // end execute

} // end OutboundUpdateCommand
