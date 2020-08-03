package com.lec.yes25.personnel.command;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.lec.yes25.common.C;
import com.lec.yes25.common.RCommand;
import com.lec.yes25.personnel.CmmtDTO;
import com.lec.yes25.personnel.PersonnelDAO;

public class CmmtListCommand implements RCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap(); // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String) (map.get("username")));
		String startParam = (String) map.get("start");
		String endParam = (String) map.get("end");
		Date start, end;

		//System.out.println("startParam :::: " + startParam + "\n\nendParam  :::::  " + endParam);
		
		// ajax response 에 필요한 값들
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL

		// 페이징 관련 세팅값들
		int page = 1; // 현재 페이지(디폴트는 1page)
		int pageRows = 8; // 한 ' 페이지' 에 몇 개의 글을 리스트? (디폴트 8개)
		int writePages = 10; // 한 [페이징] 에 몇개의 '페이지' 를 표시? (디폴트 10)
		int totalCnt = 0; // 글은 총 몇개인지?
		int totalPage = 0; // 총 몇 '페이지' 분량인지?

		// 두개의 매개변수 받아옴
		String param;
		List<CmmtDTO> arr = null;
		// page 값 : 현재 몇 페이지?
		param = request.getParameter("page");
		System.out.println("\npage Param :::: "  + param);
		
		// 만약에 여기서 page 가 잘못 들어오거나 엉뚱한게 들어오면 -> 익셉션 처리 따로 하지 않고, page 1로 가도록 할 것.
		if (param != null && param.trim().length() != 0) {

			// 정상적으로 수행되었는지 아닌지 확인해보기 위해 try-catch 로 감싸줌
			try {
				page = Integer.parseInt(param); // 파싱하는 과정에서 null 이나 0이 나와도 -> page 1 로
//				System.out.println(page);
			} catch (NumberFormatException e) {
				// 예외처리 하지 않음.
			}
		}

		// pageRows 값 : '한 페이지' 에 몇개의 글?
		param = request.getParameter("pageRows");
		System.out.println("\npageRows Param :::: "  + param);
		if (param != null && param.trim().length() != 0) {
			try {
				pageRows = Integer.parseInt(param);
			} catch (NumberFormatException e) {
				// 예외처리 하지 않음.
			}
		}
		
		try {
			SimpleDateFormat fomatter = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA); // 날짜값들 date벼환
			start = fomatter.parse(startParam);
			end = fomatter.parse(endParam);

			//System.out.println("Date start :::: " + start + "\nDate end ::: " + end);
			
			PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);

			// 몇 번째 row 부터?
			int fromRow = (page - 1) * pageRows + 1; // ORACLE 은 1부터 ROWNUM 시작

			arr = dao.selectFromRowBetweenDate(fromRow, pageRows, username, start, end);
			
			if (arr == null) {
				message.append("[조회할 데이터가 없습니다]");
			} else if(arr.size() == 0){
				status = "OK";
				//page = 0;
				message.append("[조회할 데이터가 없습니다]");
			} else{
				// 총 몇 페이지 분량인가?
				totalPage = (int) Math.ceil(arr.size() / (double) pageRows);
				status = "OK";
				message.append(arr.size() + "개의 근태를 조회합니다.");
			}
		} catch (Exception e) {
			message.append("[트랜젝션 에러: " + e.getMessage() + " ]");
		}

		// 얘네들의 결과(arr)가 AjaxListCommand 로 넘어감
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		request.setAttribute("list", arr);
		
		request.setAttribute("page", page);
		request.setAttribute("pageRows", pageRows);
		request.setAttribute("writePages", writePages);
		request.setAttribute("totalCnt", totalCnt);
		request.setAttribute("totalPage", totalPage);
	}

}
