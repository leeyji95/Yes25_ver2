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
		Date cmmtEnd2 = null;
		Date curDate = new Date(); // 현재 Date
		String std18 = "18:00:00";
		
		SimpleDateFormat stdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd ");
		SimpleDateFormat cmmtEndFormatter = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			// 이미 초과근무 시간이 있는지 조회 .. 
			String overtime = dao.selectoverwork(username, cmmtEnd);
			
			if(overtime != null) { // 이미 있으면
				cmmtEnd2 = stdFormat.parse(cmmtEnd);
				
			} else if(overtime == null) { // 연장근무시간 없으면 
				
			}
		
			
		
		} catch (ParseException e) {
			e.printStackTrace();
		}
		

		
	}

}
