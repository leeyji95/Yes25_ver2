package com.lec.yes25.financial.ajax.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.expression.ParseException;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;

public class AjaxMonthSalesCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		
		int netSales = 0;			// 매출액
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 날짜 검색을 위한 세팅
		String startDate = "";
		String endDate = "";
		
		// 매개변수 받기
		String param = request.getParameter("startDate");
		if(param != null && param.trim().length() != 0) {
			try {				
				startDate = param;
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		param = request.getParameter("endDate");
		if(param != null && param.trim().length() != 0) {
			try {				
				endDate = param;
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		try {
			// 매출액
			netSales = dao.netSales(startDate, endDate);
			status = "OK";
			
		} catch(Exception e) {
			//e.printStackTrace();
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
			
			// 해당 월이 아니라서 값이 나오지 않는 경우에도 에러 없이 출력하기 위해 만듦
			String word = message.toString();
			String equalsWord= "[트랜잭션 에러:Mapper method 'com.lec.yes25.financial.bean.AjaxFinancialDAO.netSales attempted to return null from a method with a primitive return type (int).]";
			
			if(word.equals(equalsWord)) {
				//System.out.println("들어오니??");
				netSales = 0;
				status = "OK";
			}
			//System.out.println(message);

		} // end try

		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());

		request.setAttribute("netSales", netSales);

	} // end execute()

} // end Command