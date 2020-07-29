package com.lec.yes25.financial.ajax.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;
import com.lec.yes25.financial.bean.AjaxFinancialDAO;


public class AjaxUpdateCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 0;
		AjaxFinancialDAO dao = C.sqlSession.getMapper(AjaxFinancialDAO.class);
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		// 매개변수 받아오기
		int stmt_uid = Integer.parseInt(request.getParameter("Ustmt_uid"));
		String regDate = request.getParameter("UregDate");
		int account_uid = Integer.parseInt(request.getParameter("Uaccount_uid"));
		String summary = request.getParameter("Usummary");
		int money = Integer.parseInt(request.getParameter("Umoney"));
		int manager = Integer.parseInt(request.getParameter("Umanager"));
		int approver = Integer.parseInt(request.getParameter("Uapprover"));
		
		// 유효성 체크
		if (stmt_uid == 0) {
			message.append("[유효하지 않은 전표 번호 : 전표 존재 여부 확인 요망]");
		} else if(regDate == null || regDate.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 날짜 입력 필수]");
		} else if (account_uid == 0) {
			message.append("[유효하지 않은 parameter : 계정과목 선택 필수]");
		} else if (summary == null || summary.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 적요 입력 필수]");
		} else if (manager == 0) {
			message.append("[유효하지 않은 parameter : 담당자 선택 필수]");
		} else if (approver == 0) {
			message.append("[유효하지 않은 parameter : 결재자 선택 필수]");
		} else {
		
			try {
				// 글 수정 트랜젝션 수행
				cnt = dao.update(regDate, account_uid, summary, money, manager, approver, stmt_uid);
				
				// 정상적으로 트랜잭션 작동했는지 검사
				if(cnt == 0) {
					message.append("[트랙잰셕 실패: 0 insert");
				} else {
					status = "OK";
				}
				
			} catch (NumberFormatException e) {
				message.append("[유효하지 않은 전표 번호] " + stmt_uid);
			} catch (Exception e) {
				//e.printStackTrace();
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			}
			
		} // end if
		
		request.setAttribute("result", cnt);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	} // end execute()

} // end Command