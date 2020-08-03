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

public class GoworkCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		int cntInsert = 0;
		int cntUpdate = 0;

		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);

		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		System.out.println("///////////////////////__여기는_GoworkCommand__////////////////////////////\n");

		// 파라미터 받아서
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap(); // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String) (map.get("username")));

		System.out.println("command username  :::::  " + username + "\n");

		// 출근시간 param 받아오기
		String paramDate = request.getParameter("paramDate"); // 출근 시간 Param 으로 받기
		Date curDate = new Date(); // 현재 Date
		String stdNine = "09:00:00";
		String stdTwelve = "12:00:00";

		// Date 타입으로 파싱
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
		SimpleDateFormat cmmtStartFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Date goworkDate = null;
		try {
			if (username == 0) {
				message.append("[유효하지 않은 parameter : usename 없다누]");
			} else if (paramDate == null || paramDate.trim().length() == 0) {
				message.append("[유효하지 않은 parameter : paramDate 없다누]");
			} else {

				// 이미 출근시간이 있는데 조회... 해당 사원번호의 출근 시간 (yyyy-mm-dd) 로 뽑기
				String cmmtStart = dao.GoworkDateByusername(username);
				Date realDate = dao.selectGowork(username);
				if (cmmtStart != null) {
					if (cmmtStartFormatter.parse(paramDate).compareTo(cmmtStartFormatter.parse(cmmtStart)) == 0) {
						message.append("이미  등록처리되었습니다. \n" + format1.format(realDate));
						status = "OK";
						System.out.println("이미 출근 했는데....");
					} else {
						message.append("이도저도 아님.. 어떻게 여기까지 왔노?");
						status = "OK";

					}
				} else if (cmmtStart == null) {

					// String 타입 출근시간(paramDate) -> Date 타입으로 파싱
					goworkDate = format1.parse(paramDate);
					// 출근시간에서 -> 시간 뽑기 (getTime)
					long goworkGetTime = goworkDate.getTime(); // 밀리 세컨즈 단위

					// SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
					String dateConcat9 = curFormat.format(curDate).concat(stdNine);
					String dateConcat12 = curFormat.format(curDate).concat(stdTwelve);

					SimpleDateFormat stdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date stdDate9 = stdFormat.parse(dateConcat9);
					Date stdDate12 = stdFormat.parse(dateConcat12);

					long stdGetTime9 = stdDate9.getTime();
					long stdGetTime12 = stdDate12.getTime();

					// 출근시간 insert
					cntInsert = dao.goworkinsert(username, goworkDate);

					if (cntInsert == 0) {
						message.append("[트랜잭션 실패: 0 insert");
					} else {
						String state = "";

						// 출근시간이 9시 이전 : 출근시간 < 9시_기준시간 (출근)
						if (goworkGetTime <= stdGetTime9) {
							System.out.println("출근");
							state = "출근";
							message.append("정상출근\n" + format1.format(goworkDate));
							// 해당 username 에 해당하는 행의 컬럼 commute_state 를 update 한다
							cntUpdate = dao.goworkState(username, state);
						} else if (stdGetTime9 < goworkGetTime && goworkGetTime <= stdGetTime12) {
							System.out.println("지각");
							state = "지각";
							cntUpdate = dao.goworkState(username, state);
							message.append("지각처리\n" + format1.format(goworkDate));
						} else if (goworkGetTime > stdGetTime12) {
							System.out.println("결근");
							state = "결근";
							cntUpdate = dao.goworkState(username, state);
							message.append(cmmtStartFormatter.format(cmmtStartFormatter.parse(paramDate)) + "\n결근처리");
						}

						System.out.println("cntUpdate ::: " + cntUpdate + "개 업데이트");

						if (cntUpdate == 0) {
							message.append("[트랜잭션 실패: 0 update");
						} else {
							status = "OK";// 얘가 최종적 성공
						}
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
