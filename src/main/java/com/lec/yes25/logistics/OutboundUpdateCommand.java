package com.lec.yes25.logistics;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



public class OutboundUpdateCommand implements Command {
	


	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
	
		int cnt = 0;
		
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		

		
		String params = request.getParameter("jsonData");
		
		JSONArray arr = JSONArray.fromObject(params);
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		
		if(arr == null || arr.size() == 0) {
			message.append("[유효하지 않은 parameter 0 or null]");
		} else {

			try {
				
				for (int i = 0; i < arr.size(); i++) {
					JSONObject obj = (JSONObject) arr.get(i);
					
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("book_isbn", Long.valueOf(String.valueOf(obj.get("book_isbn"))));
					map.put("price", Integer.valueOf(String.valueOf(obj.get("price"))));
					map.put("stock_quantity", Integer.valueOf(String.valueOf(obj.get("stock_quantity"))));
					
					list.add(map);
				}
				
				for (int i = 0; i < list.size(); i++) {
					System.out.println(list.get(i));
				}
				
				
				cnt = dao.insertIntoOutbound(list);
				dao.updateByUidInStockFromOutbound(list);
				
				if(cnt == 0) {
					message.append("[0 inserted]");
				}  else {
					status = "OK";					
				} // end if

			} catch (Exception e) {
				message.append("[트렌잭션 에러:"+ e.getMessage() + "]");
				e.printStackTrace();
			} // end try
		} // end if
		
		request.setAttribute("result", cnt);
		request.setAttribute("status", status);
		request.setAttribute("message", message.toString());
		
	
	} // end execute

} // end OutboundUpdateCommand
