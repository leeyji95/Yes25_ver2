package com.lec.yes25.personnel.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.lec.yes25.common.BCommand;
import com.lec.yes25.common.C;
import com.lec.yes25.personnel.PersonnelDAO;
import com.lec.yes25.personnel.UserDTO;

public class EmpListCommand implements BCommand {

	@Override
	public void execute( Model model)  {
		// Model 안에 있는 값(attribute) 꺼내기
		Map<String, Object> map = model.asMap();  // model 안에 있는 어트리뷰트 애들 어차피 이름 밸류 쌍으로 -> map으로 변환 가능하다
		int username = Integer.parseInt((String)(map.get("username")));
		
		PersonnelDAO dao = C.sqlSession.getMapper(PersonnelDAO.class);
		List<UserDTO> list = dao.selectByUid(username);
		
		model.addAttribute("list", list); // model  바구니에 담는다!
		System.out.println(list + "<---- list , UserDTO 가 담긴 친구");
	}

}
