package com.lec.yes25.purchase;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.common.C;

@RestController
@RequestMapping(value = "/purchasing/status/*.ajax")
public class StatusAjaxController {
	@RequestMapping(value = "/purchasing/status/orderList.ajax", method = RequestMethod.POST)
	public AjaxDTOList pubList(String pub_name, String book_subject, String startDate, String endDate, int page, int pageRows) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList AjaxDTOList = new AjaxDTOList();
		List<OrderDTO> list = null;
		
		// Ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 디폴트 FAIL
		
		// 페이징 관련 세팅값들
		int writePages = 10; // 한 '페이징' 에 몇개의 '페이지' 를 표시? (디폴트 10)
		int totalCnt = 0; // 데이터는 총 몇개인지?
		int totalPage = 0; // 총 몇 '페이지' 분량인지?
		int count = 0;
		
		String param = Integer.toString(page);
		if(param != null && param.trim().length() != 0) {
			try {				
				page = Integer.parseInt(param); // 현재 몇 페이지?
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		param = Integer.toString(pageRows);
		if(param != null && param.trim().length() != 0) {
			try {				
				pageRows = Integer.parseInt(param); // 한 '페이지' 에 몇개의 데이터?
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		try {
			// 데이터 전체 개수 구하기
			totalCnt = dao.status_countOrder(pub_name, book_subject, startDate, endDate);
			
			// 총 몇 페이지 분량인가?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// 몇번재 row 부터 ?
			int fromRow = (page - 1) * pageRows + 1; // ORACLE 은 1부터 ROWNUM시작
			
			list = dao.status_selectOrderFromRow(pub_name, book_subject, startDate, endDate, fromRow, pageRows);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				count = list.size();
				status = "OK";
			}
			
		} catch(Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		}
		
		AjaxDTOList.setCount(count);
		AjaxDTOList.setStatus(status);
		AjaxDTOList.setMessage(message.toString());
		AjaxDTOList.setPage(page);
		AjaxDTOList.setList(list);
		AjaxDTOList.setTotalPage(totalPage);
		AjaxDTOList.setTotalCnt(totalCnt);
		AjaxDTOList.setWritePages(writePages);
		AjaxDTOList.setPageRows(pageRows);
		
		return AjaxDTOList;
	}
}
