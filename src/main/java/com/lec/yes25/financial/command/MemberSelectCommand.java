package com.lec.yes25.financial.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.lec.yes25.common.BCommand;
import com.lec.yes25.common.C;
import com.lec.yes25.financial.bean.FinancialDAO;
import com.lec.yes25.personnel.UserDTO;

public class MemberSelectCommand implements BCommand {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		FinancialDAO dao = C.sqlSession.getMapper(FinancialDAO.class);
		List<UserDTO> list = dao.memberSelectAll();
		
		model.addAttribute("list", list);
		
	} // end execute()

} // end class