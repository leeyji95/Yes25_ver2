package com.lec.yes25.financial.command;

import java.util.Map;

import org.springframework.ui.Model;

import com.lec.yes25.common.BCommand;
import com.lec.yes25.common.C;
import com.lec.yes25.financial.bean.FinancialDAO;

public class FUpdateCommand implements BCommand {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		int stmt_uid = (Integer)map.get("stmtUid");
		int proceed = (Integer)map.get("proceed");
		
		FinancialDAO dao = C.sqlSession.getMapper(FinancialDAO.class);
		int cnt = dao.updateProceed(proceed, stmt_uid);
		
		model.addAttribute("result", cnt);
		model.addAttribute("proceed", proceed);
		
	} // end execute()

} // end Command