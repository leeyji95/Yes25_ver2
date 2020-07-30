package com.lec.yes25.purchase;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.common.C;

@RestController
@RequestMapping(value = "/purchasing/vendor/*.ajax")
public class VendorAjaxController {
	@RequestMapping(value = "/purchasing/vendor/pubList.ajax", method = RequestMethod.POST)
	public AjaxDTOList pubList(String searchType, String keyword, int page, int pageRows) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList AjaxDTOList = new AjaxDTOList();
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
			totalCnt = dao.vendor_countPub(searchType, keyword);
			
			// 총 몇 페이지 분량인가?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// 몇번재 row 부터 ?
			int fromRow = (page - 1) * pageRows + 1; // ORACLE 은 1부터 ROWNUM시작
			
			list = dao.vendor_selectPubFromRow(searchType, keyword, fromRow, pageRows);
			
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
	
	@RequestMapping(value = "/purchasing/vendor/insertPub.ajax", method = RequestMethod.POST)
	public AjaxDTOList insertPub(@ModelAttribute("PublisherDTO") @Valid PublisherDTO dto, BindingResult bindingResult) {
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);

		AjaxDTOList ajaxPublisherList = new AjaxDTOList();
		
		int count = 0;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		// 유효성 체크
		if(bindingResult.hasErrors()) { // 에러 있으면
		    List<FieldError> errors = bindingResult.getFieldErrors();
		    for (FieldError error : errors ) {
		        System.out.println (error.getField() + " - " + error.getDefaultMessage());
		    }
		    
		} else {
			try {
				count = dao.insertPub(dto);
				
				if(count == 0) {
					message.append("[트랙잭션 실패: 0 insert]");
					
				} else {
					status = "OK";
				}
				
			} catch(Exception e) {
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			}
		}
		
		ajaxPublisherList.setCount(count);	
		ajaxPublisherList.setStatus(status);
		ajaxPublisherList.setMessage(message.toString());
		
		return ajaxPublisherList;
	}
	
	@RequestMapping(value = "/purchasing/vendor/viewPub.ajax")
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
	
	@RequestMapping(value = "/purchasing/vendor/updatePubOk.ajax", method = RequestMethod.POST)
	public AjaxDTOList upatePub(@ModelAttribute("PublisherDTO") @Valid PublisherDTO dto, BindingResult bindingResult) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList ajaxPublisherList = new AjaxDTOList();
		
		int count = 0;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		// 유효성 체크
		if(bindingResult.hasErrors()) { // 에러 있으면
		    List<FieldError> errors = bindingResult.getFieldErrors();
		    for (FieldError error : errors ) {
		        System.out.println (error.getField() + " - " + error.getDefaultMessage());
		    }
		    
		} else {
			try {			
				count = dao.updatePub(dto);
				status = "OK";
				
				if(count == 0) {
					message.append("[0 update]");
				}
				
			} catch (Exception e) {
				
			}
		}

		ajaxPublisherList.setCount(count);
		ajaxPublisherList.setStatus(status);
		ajaxPublisherList.setMessage(message.toString());
		
		return ajaxPublisherList;
	}
	
	@RequestMapping(value = "/purchasing/vendor/deletePubOk.ajax", method = RequestMethod.POST)
	public AjaxDTOList deletePub(HttpServletRequest request) {
		// MyBatis 사용
		PurchaseDAO dao = C.sqlSession.getMapper(PurchaseDAO.class);
		
		AjaxDTOList ajaxPublisherList = new AjaxDTOList();
		
		int count = 0;
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		// 유효성 검증
		String[] params = request.getParameterValues("pub_uid");
		int[] pub_uids = null;
		
		if(params == null || params.length == 0) {
			message.append("[유효하지 않은 parameter 0 or null]");
		} else {
			pub_uids = new int[params.length];
			try {			
				for(int i = 0; i < params.length; i++) {
					pub_uids[i] = Integer.parseInt(params[i]);
				}
				count = dao.deletePubByUid(pub_uids);
				status = "OK";
				
			} catch (Exception e) {
				message.append("[유효하지 않은 parameter]" + Arrays.toString(params));
			}
		}
		
		ajaxPublisherList.setCount(count);
		ajaxPublisherList.setStatus(status);
		ajaxPublisherList.setMessage(message.toString());
		
		return ajaxPublisherList;
	}
}
