package com.lec.yes25.personnel.command;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.lec.yes25.common.C;
import com.lec.yes25.common.RCommand;
import com.lec.yes25.personnel.PersonnelDAO;

public class TotalworkCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request,  Model model) {

		int cntUpdate = 0;

		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);

		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		System.out.println("///////////////////////__여기는 TotalworkCommand__///////////////////////\n");

		// 파라미터 받아서
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap(); // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String) (map.get("username")));

		String paramDate = request.getParameter("paramDate");

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
		Date outworkDate = null;
		Date goworkDate = dao.selectGowork(username); // Date 타입 출근시간
		System.out.println("goworkDate 출근시간  ::: " + goworkDate);
		try {
			if (paramDate == null || goworkDate == null || paramDate.trim().length() == 0) {
				message.append("출근시간 or 퇴근시간 이 없습니다.");
				status = "OK";
			} else { // 출퇴근 시각 모두 있을 경우에만 아래 수행된다.

				// 근데 근무상태가 "출근"일 경우 와 "지각"일 경우 총근무시간 뽑아내는 것이 달라야한다.
				// 출근인 경우 오전 9시부터 근무시간 시작으로 정한다.
				// 지각인 경우 해당 시간부터 근무시간 시작으로 정한다. 
				
				outworkDate = format.parse(paramDate); // Date 타입 퇴근시간
				System.out.println("outworkDate 퇴근시간  ::: " + outworkDate);

				long outworkGetTime = outworkDate.getTime(); // 퇴근 Time
				long goworkGetTime = goworkDate.getTime(); // 출근 Time
				long totalTime = outworkGetTime - goworkGetTime; // 시간 차이(퇴근 - 출근)
				
				System.out.println("outworkGetTime : " + outworkGetTime 
							+ "\ngoworkGetTime  : " + goworkGetTime
							+ "\ntotalTime   : " + totalTime);

				int totalHours = (int) ((totalTime / (1000 * 60 * 60)) % 24); // 시간으로 변환
				System.out.println("총근무시간 : " + totalHours + "시간");

				// 퇴근날짜와 오늘날짜가 같은 날, 해당 사원의 총근무시간 update
				cntUpdate = dao.totalWorkUpdate(username, totalHours);
				message.append("총근무시간 : " + totalHours + "시간");

				System.out.println("cntUpdate ::: " + cntUpdate + "개 업데이트");

				if (cntUpdate == 0) {
					message.append("[트랜잭션 실패: 0 update");
				} else {
					status = "OK";// 얘가 최종적 성공
				}
			}

		} catch (ParseException e) {
			e.printStackTrace();
			message.append("[파싱 에러:" + e.getMessage() + "]");
		}
		int cntInsert = 0;
		request.setAttribute("insertResult", cntInsert);
		request.setAttribute("updateResult", cntUpdate);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
	}

}
