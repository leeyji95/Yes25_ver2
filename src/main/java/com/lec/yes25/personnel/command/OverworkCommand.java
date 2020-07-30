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

public class OverworkCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response, Model model) {
		int cntUpdate = 0;

		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);

		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		System.out.println("///////////////////////__여기는__OverworkCommand__초과근무누를_시////////////////////////////\n");

		// 파라미터 받아서
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap(); // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String) (map.get("username")));
		
		// 퇴근시간 가져오기 (TO_CHAR 타입)
		String cmmtEnd = dao.OutworkDateByusername(username);
		Date curDate = new Date(); // 현재 Date
		String std18 = "18:00:00";
		Date outworkDate = null;
		
		SimpleDateFormat stdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
		SimpleDateFormat cmmtEndFormatter = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			// 이미 초과근무 시간이 있는지 조회 
			String overtimeStr = dao.selectOverwork(username, cmmtEnd);
			
			if(overtimeStr != null) { // 이미 있으면
				message.append("이미 연장신청 완료 \n 관리자에게 문의하세요");
			} else if(overtimeStr == null) { // 초과근무시간 없으면  -> 초과근무시간 넣어줘야지
				// 퇴근시간을 Date 타입으로 파싱
				outworkDate = stdFormat.parse(cmmtEnd);
				
				// 퇴근시각 시간 얻기 
				long outworkGetTime = outworkDate.getTime();
				
				String dateConcat18 = curFormat.format(curDate).concat(std18); // 현재시간 + 오후 6시 기준
				
				Date stdDate18 = stdFormat.parse(dateConcat18);

				// 기준 18시 시간 얻기 
				long stdGetTime18 = stdDate18.getTime();

				// 초과근무시간 얻기
				long overtime = stdGetTime18 - outworkGetTime;
				// 시간으로 변환
				int hours = (int) ((overtime / (1000 * 60 * 60)) % 24); 
				System.out.println("초과근무시간 overtime  :::  " + overtime + "ms\n" + "hours ::: " + hours);
				
				// 퇴 근 날짜와 오늘날짜가 같은 날, 해당 사원의 -> 초과근무시간 update
				cntUpdate = dao.overWorkUpdate(username, hours, outworkDate);
				message.append("연장근무 신청완료");

				
				System.out.println("cntUpdate ::: " + cntUpdate + "개 업데이트");

				if (cntUpdate == 0) {
					message.append("[트랜잭션 실패: 0 update");
				} else {
					status = "OK";// 얘가 최종적 성공
				}
			}
		
		} catch (ParseException e) {
			e.printStackTrace();
			message.append("[트랜잭션 에러:" + e.getMessage() + "]");
		}
		int cntInsert = 0;
		request.setAttribute("insertResult", cntInsert);
		request.setAttribute("updateResult", cntUpdate);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());

		
	}

}
