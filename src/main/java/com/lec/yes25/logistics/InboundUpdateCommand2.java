package com.lec.yes25.logistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;


public class InboundUpdateCommand2 implements Command {

	TransactionTemplate transactionTemplate;
	
	@Autowired
	public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
		this.transactionTemplate = transactionTemplate;
	}
	
	
	
	@Override
	@Transactional
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int cnt = 0;
		
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		String [] params = request.getParameterValues("order_uid");
		int [] order_uids = null;
		
		if(params == null || params.length == 0) {
			message.append("[유효하지 않은 parameter 0 or null]");
		} else {
			order_uids = new int[params.length];
			
			try {
				
				for (int i = 0; i < params.length; i++) {
					order_uids[i]= Integer.parseInt(params[i]);
				}
				
				dao.insertIntoInbound2(order_uids);
				dao.updateByUidInStockFromInbound2(order_uids);
				cnt = dao.updateByUidIntoOrder2(order_uids);
				
				if(cnt==0) {
					message.append("[0 update]");
				} else {
					status = "OK";					
				}
	
			} catch (NumberFormatException e) {
				message.append("[유효하지 않은 parameter]"+ params);
			} catch (Exception e) {
				message.append("[트렌잭션 에러:"+ e.getMessage() + "]");
			}
		}
		
		
		request.setAttribute("result", cnt);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute
 
}// end UpdateCommand
