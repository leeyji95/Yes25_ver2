package com.lec.yes25.purchase;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.common.C;

@RestController
@RequestMapping(value = "/purchasing/order/*.ajax")
public class OrderAjaxController {
	@RequestMapping(value = "/purchasing/order/pubList.ajax", method = RequestMethod.POST)
	public AjaxDTOList pubList(String pub_name, String book_subject, int page, int pageRows) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList AjaxPublisherList = new AjaxDTOList();
		List<PublisherDTO> list = null;
		
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
			totalCnt = dao.order_countPub(pub_name, book_subject);
			
			// 총 몇 페이지 분량인가?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// 몇번재 row 부터 ?
			int fromRow = (page - 1) * pageRows + 1; // ORACLE 은 1부터 ROWNUM시작
			
			list = dao.order_selectPubFromRow(pub_name, book_subject, fromRow, pageRows);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				count = list.size();
				status = "OK";
			}
			
		} catch(Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		} // end try
		
		AjaxPublisherList.setCount(count);
		AjaxPublisherList.setStatus(status);
		AjaxPublisherList.setMessage(message.toString());
		AjaxPublisherList.setPage(page);
		AjaxPublisherList.setList(list);
		AjaxPublisherList.setTotalPage(totalPage);
		AjaxPublisherList.setTotalCnt(totalCnt);
		AjaxPublisherList.setWritePages(writePages);
		AjaxPublisherList.setPageRows(pageRows);
		
		return AjaxPublisherList;
	}
	
	@RequestMapping(value = "/purchasing/order/bookList.ajax", method = RequestMethod.POST)
	public AjaxDTOList bookList(String pub_name, String book_subject, int page, int pageRows) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList ajaxDTOList = new AjaxDTOList();
		List<BookDTO> list = null;
		
		// Ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 페이징 관련 세팅값들
		int writePages = 10; // 한 '페이징' 에 몇개의 '페이지' 를 표시? (디폴트 10)
		int totalCnt = 0; // 데이터는 총 몇개인지?
		int totalPage = 0; // 총 몇 '페이지' 분량인지?
		int count = 0;
		
		// page 값 : 현재 몇 페이지?
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
			totalCnt = dao.order_countBook(pub_name, book_subject);
			
			// 총 몇 페이지 분량인가?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// 몇번재 row 부터 ?
			int fromRow = (page - 1) * pageRows + 1;  // ORACLE 은 1부터 ROWNUM시작
			
			list = dao.order_selectBookFromRow(pub_name, book_subject, fromRow, pageRows);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				count = list.size();
				status = "OK";
			}
			
		} catch(Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		}
		
		ajaxDTOList.setCount(count);
		ajaxDTOList.setStatus(status);
		ajaxDTOList.setMessage(message.toString());
		ajaxDTOList.setPage(page);
		ajaxDTOList.setList(list);
		ajaxDTOList.setTotalPage(totalPage);
		ajaxDTOList.setTotalCnt(totalCnt);
		ajaxDTOList.setWritePages(writePages);
		ajaxDTOList.setPageRows(pageRows);
		
		return ajaxDTOList;
	}

	@RequestMapping(value = "/purchasing/order/viewPub.ajax")
	public AjaxDTOList viewPub(int pub_uid) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList ajaxPublisherList = new AjaxDTOList();
		List<PublisherDTO> list  = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		String param = Integer.toString(pub_uid);
		
		// 유효성 검사
		if(param == null) {
			message.append("[유효하지 않은 parameter 0 or null]");
		} else {			
			try {
				pub_uid = Integer.parseInt(param);
				
				list = dao.selectPubByUid(pub_uid); // 읽기
				
				if(list == null) {
					message.append("[해당 데이터가 없습니다]");
				} else {
					status = "OK";
				}
				
			} catch (Exception e) {  
				message.append("[예외발생:" + e.getMessage() + "]");
			}
		}
		
		ajaxPublisherList.setStatus(status);
		ajaxPublisherList.setMessage(message.toString());
		ajaxPublisherList.setList(list);
		
		return ajaxPublisherList;
	}
	
	@RequestMapping(value = "/purchasing/order/viewBook.ajax")
	public AjaxDTOList viewBook(int book_uid) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList ajaxDTOList = new AjaxDTOList();
		List<BookDTO> list  = null;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		String param = Integer.toString(book_uid);
		
		// 유효성 검사
		if(param == null) {
			message.append("[유효하지 않은 parameter 0 or null]");
		} else {			
			try {
				book_uid = Integer.parseInt(param);
				
				list = dao.selectBookByUid(book_uid); // 읽기
				
				if(list == null) {
					message.append("[해당 데이터가 없습니다]");
				} else {
					status = "OK";
				}
				
			} catch (Exception e) {  
				message.append("[예외발생:" + e.getMessage() + "]");
			}
		}
		
		ajaxDTOList.setStatus(status);
		ajaxDTOList.setMessage(message.toString());
		ajaxDTOList.setList(list);
		
		return ajaxDTOList;
	}

	@RequestMapping(value = "/purchasing/order/insertOrder.ajax", method = RequestMethod.POST)
	public AjaxDTOList insertPub(@RequestBody List<OrderDTO> orderList) {
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
        
		AjaxDTOList ajaxDTOList = new AjaxDTOList();
		
		int count = 0;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		try {
			count = dao.insertOrder(orderList);
			if(count == 0) {
				message.append("[트랙잭션 실패: 0 insert]");
			} else {
				status = "OK";
			}				
		} catch(Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage() + "]");
		}
		
		ajaxDTOList.setCount(count);
		ajaxDTOList.setStatus(status);
		ajaxDTOList.setMessage(message.toString());
		
		return ajaxDTOList;
	}
}
