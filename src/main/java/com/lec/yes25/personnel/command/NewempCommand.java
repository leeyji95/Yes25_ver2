package com.lec.yes25.personnel.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.expression.ParseException;
import org.springframework.ui.Model;

import com.lec.yes25.common.C;
import com.lec.yes25.common.RCommand;
import com.lec.yes25.personnel.PersonnelDAO;

public class NewempCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) throws ParseException {
		int cnt = 0;
		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);		
		// ajax response 에 필요한 값들 
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		// 매개변수 받아오기
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		// String -> Date 형변환
		String hiredate = request.getParameter("hiredate");
		System.out.println("param date: " + hiredate);
//		SimpleDateFormat transFormat = new SimpleDateFormat("YYYY-MM-dd");
//		Date to = transFormat.parse(hiredate);
//		System.out.println("date: " + to);

		String admin = request.getParameter("admin"); 
		int deptno = Integer.parseInt(request.getParameter("deptno"));
		int positionno = Integer.parseInt(request.getParameter("positionno"));

		// 유효성 체크
		if (name == null || name.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 이름 필수]");
		} else if (phone == null || phone.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 폰번호 필수]");
		} else if (email == null || email.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 이메일 필수]");
		} else if (admin == null || admin.trim().length() == 0) {
			message.append("[유효하지 않은 parameter : 관리자여부 필수]");
		} else {
			try {
				cnt = dao.insert(name, email, deptno, positionno, phone, hiredate, admin);
				dao.authinsert(admin);
				if(cnt == 0) {
					message.append("[트랜잭션 실패: 0 insert");
				}else {
					status = "OK";// 얘가 최종적 성공
				}
			} catch(Exception e)	{
				message.append("[트랜잭션 에러:" + e.getMessage() + "]");
			}
		} // end if

		
		// 이 결과를 result 라는 이름의 request 객체에 담는다.
		request.setAttribute("insertResult", cnt);
		request.setAttribute("updateResult", 0);

		// 얘네들의 결과가 AjaxListCommand 로 넘어감
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	}

}
