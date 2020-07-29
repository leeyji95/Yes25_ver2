package com.lec.yes25.financial.command;

import java.util.Arrays;
import java.util.Map;

import org.springframework.ui.Model;

import com.lec.yes25.common.BCommand;
import com.lec.yes25.common.C;
import com.lec.yes25.financial.bean.FinancialDAO;
import com.lec.yes25.financial.bean.FinancialDTO;

public class FViewCommand implements BCommand {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		int stmt_uid = (Integer)map.get("stmtUid");
		
		FinancialDAO dao = C.sqlSession.getMapper(FinancialDAO.class);
		FinancialDTO dto = dao.readByStmt_uid(stmt_uid);
		
		model.addAttribute("list", Arrays.asList(dto));
	} // end execute()

} // end Command