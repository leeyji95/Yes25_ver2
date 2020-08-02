package com.lec.yes25.financial.ajax.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;


public class AjaxWriteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		
		int writer = 0;	// 작성자
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 매개변수 받아오기
		String regDate = request.getParameter("regDate");
		int account_uid = Integer.parseInt(request.getParameter("account_uid"));
		String summary = request.getParameter("summary");
		int money = Integer.parseInt(request.getParameter("money"));
		int manager = Integer.parseInt(request.getParameter("manager"));
		int approver = Integer.parseInt(request.getParameter("approver"));
		
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		System.out.println(username);
		
		if(username != null && username.trim().length() != 0) {
			
			try {
				writer = Integer.parseInt(username);
			} catch(NumberFormatException e) {
				// 예외 처리 안함
			}
		}
		
		// 유효성 체크
		if(regDate == null || regDate.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 날짜 입력 필수]");
		} else if (account_uid == 0) {
			message.append("[유효하지 않은 parameter : 계정과목 선택 필수]");
		} else if (summary == null || summary.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 적요 입력 필수]");
		} else if (writer == 0) {
			message.append("[연동되지 않은 parameter : 작성자 연동 오류]");
		} else if (manager == 0) {
			message.append("[유효하지 않은 parameter : 담당자 선택 필수]");
		} else if (approver == 0) {
			message.append("[유효하지 않은 parameter : 결재자 선택 필수]");
		} else {
		
			try {
//				System.out.println("regDate : " + regDate + ", accountuid : " + account_uid
//						+ ", summary : " +  summary + ", money : " + money
//						+ ", writer : " + writer + ", manager : " + manager 
//						+ ", approber : " + approver);
				// 글 삽입 트랜잭션 수행
				cnt = dao.insert(regDate, account_uid, summary,
						money, writer, manager, approver);
				
				// 정상적으로 트랜잭션 작동했는지 검사
				if(cnt == 0) {
					message.append("[트랙잰셕 실패: 0 insert");
				} else {
					status = "OK";
				}
				
			} catch(Exception e) {
				//e.printStackTrace();
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			}
			
		} // end if
		
		request.setAttribute("result", cnt);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute()

} // end Command