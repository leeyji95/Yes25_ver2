package com.lec.yes25.financial.ajax.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.*;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;
import com.lec.yes25.financial.bean.FinancialDTO;

public class AjaxFinancialDeptListCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);

		List<FinancialDTO> arr = null;

		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 날짜 검색을 위한 세팅
		String startDate = "";
		String endDate = "";

		// 페이징 관련 세팅값들
		int page = 1;			// 현재 페이지 (디폴트는 1 page)
		int pageRows = 10;		// 한 '페이지' 에 몇개의 글을 리스트? (디폴트 10개)
		int writePages = 10;	// 한 [페이징] 에 몇개의 '페이지' 를 표시? (디폴트 10)
		int totalCnt = 0;		// 글은 총 몇개인지?
		int totalPage = 0;		// 총 몇 '페이지' 분량인지?
		
		String param;

		// page 값 : 현재 몇 페이지?
		param = request.getParameter("page");
		if(param != null && param.trim().length() != 0) {
			try {				
				page = Integer.parseInt(param);
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		// 시작값 받기
		param = request.getParameter("startDate");
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
			// 글 전체 개수 구하기
			totalCnt = dao.countAllFinancialDept(startDate, endDate);
			
			// 총 몇 페이지 분량인가?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// 몇번재 row 부터 ?
			int fromRow = (page - 1) * pageRows + 1;  // ORACLE은 1부터 ROWNUM시작
			
			arr = dao.selectFromRowFinancialDept(startDate, endDate, fromRow);

			if(arr == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				status = "OK";
			}
			
		} catch(Exception e) {
			//e.printStackTrace();
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		} // end try

		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		request.setAttribute("list", arr);

		request.setAttribute("page", page);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("writePages", writePages);
		request.setAttribute("totalCnt", totalCnt);
		
	} // end execute()

} // end Command