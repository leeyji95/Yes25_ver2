package com.lec.yes25.financial.ajax.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.expression.ParseException;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;

public class AjaxIncomeView implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		
		int netSales = 0;			// 매출액
		int costOfGoodsSold = 0;	// 매출원가
		int maintenanceSales = 0;	// 판매비와관리비
		int etcIncome = 0;			// 기타수익
		int etcCost = 0;			// 기타비용
		int corporateTax = 0;		// 법인세비용

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
		
		//System.out.println(startDate + " " + endDate);
		
		try {
			// 매출액
			//netSales = 500000000;
			netSales = dao.netSales(startDate, endDate);
			// 매출원가
			costOfGoodsSold = dao.costOfGoodsSold(startDate, endDate);
			// 판매비와 관리비
			maintenanceSales = dao.maintenanceSales(startDate, endDate);
			// 기타수익
			etcIncome = dao.etcIncome(startDate, endDate);
			// 기타비용
			etcCost = dao.etcCost(startDate, endDate);
			// 법인세
			corporateTax = dao.corporateTax(startDate, endDate);

			if(costOfGoodsSold == 0 && netSales == 0
					&& maintenanceSales == 0 && etcIncome == 0
					&& etcCost == 0 && corporateTax == 0) {
				message.append("[손익계산서를 위한 금액이 검색되지 않았습니다]");
			} else {
				status = "OK";
			}
			
		} catch(Exception e) {
			//e.printStackTrace();
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		} // end try

		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
//		System.out.println(netSales + " " + costOfGoodsSold + " "
//				+ maintenanceSales + " " + etcIncome + " " + etcCost + " "
//				+ corporateTax + " ");
		
		request.setAttribute("netSales", netSales);
		request.setAttribute("costOfGoodsSold", costOfGoodsSold);
		request.setAttribute("maintenanceSales", maintenanceSales);
		request.setAttribute("etcIncome", etcIncome);
		request.setAttribute("etcCost", etcCost);
		request.setAttribute("corporateTax", corporateTax);

	} // end execute()

} // end Command