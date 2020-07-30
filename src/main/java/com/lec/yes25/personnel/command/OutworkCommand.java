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

public class OutworkCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		int cntInsert = 0;
		int cntUpdate = 0;

		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);

		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		System.out.println("///////////////////////__여기는 \\Out_workCommand__////////////////////////////\n");

		// 파라미터 받아서
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap(); // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String) (map.get("username")));


		// 퇴근시간 param 받아오기
		String paramDate = request.getParameter("paramDate"); // 퇴근시간 Param 으로 받기
		Date curDate = new Date(); // 현재 Date
		String std18 = "18:00:00";
//		OutworkDateByusername
		// Date 타입으로 파싱
		SimpleDateFormat stdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
		SimpleDateFormat cmmtEndFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Date outworkDate = null;
		try {
			if (username == 0) {
				message.append("[유효하지 않은 parameter : usename 없다누]");
			} else if (paramDate == null || paramDate.trim().length() == 0) {
				message.append("[유효하지 않은 parameter : paramDate 없다누]");
			} else {
				// 이미 퇴근시간이 있는지 조회...    해당 사원번호의 퇴근 시간 (yyyy-mm-dd) 로 뽑기
				String cmmtEnd = dao.OutworkDateByusername(username);
				if (cmmtEnd != null) {
					if (cmmtEndFormatter.parse(paramDate).compareTo(cmmtEndFormatter.parse(cmmtEnd)) == 0) {
						message.append("이미 퇴근 등록을 하셨습니다.");
						status = "OK";
						System.out.println("아까 퇴근 하셨어유!" + "\n");
					} else {
						message.append("이도저도 아님.. 어떻게 여기까지 왔노?");
						status = "OK";
					}
				} else if (cmmtEnd == null) { // 해당 username 에 퇴근 시간 안 찍혀있으
					
					// String 타입 퇴근시간(paramDate) -> Date 타입으로 파싱
					outworkDate = stdFormat.parse(paramDate);
					// 퇴근시간에서 -> 시간 뽑기 (getTime)
					long outworkGetTime = outworkDate.getTime(); // 밀리 세컨즈 단위

					// SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
					String dateConcat18 = curFormat.format(curDate).concat(std18); // 현재시간 + 오후 6시 기준

					
					Date stdDate18 = stdFormat.parse(dateConcat18);

					long stdGetTime18 = stdDate18.getTime();

					// 퇴근시간 insert --> 이미 한 번 insert 했기 때문에 퇴근시간 삽입은 udpate 로 한다. 
					cntInsert = dao.outworkUpdate(username, outworkDate);

					if (cntInsert == 0) {
						message.append("[트랜잭션 실패: 0 insert");
					} else {
						status = "OK";
					}

					String state = "";

					// 퇴근시간이 18시 이전 : 퇴근시간 < 18시_기준시간 (조퇴)
					if (outworkGetTime < stdGetTime18) {
						System.out.println("조퇴");
						state = "조퇴";
						// 해당 username 에 해당하는 행의 컬럼 commute_state 를 update 한다
						cntUpdate = dao.outworkState(username, state);
						message.append("조퇴"); 
						
					} else if (outworkGetTime >= stdGetTime18) {
						System.out.println("정상퇴근");
						state = "퇴근";
						cntUpdate = dao.outworkState(username, state);
						message.append("퇴근 처리");
					}

					System.out.println("cntUpdate ::: " + cntUpdate + "개 업데이트");

					if (cntUpdate == 0) {
						message.append("[트랜잭션 실패: 0 update");
					} else {
						status = "OK";// 얘가 최종적 성공
					}
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
			message.append("[트랜잭션 에러:" + e.getMessage() + "]");
		}

		request.setAttribute("insertResult", cntInsert);
		request.setAttribute("updateResult", cntUpdate);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());

	}

}
