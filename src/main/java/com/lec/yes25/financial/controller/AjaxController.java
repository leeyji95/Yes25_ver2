package com.lec.yes25.financial.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.financial.ajax.*;
import com.lec.yes25.financial.ajax.command.AjaxAccountNameCommand;
import com.lec.yes25.financial.ajax.command.AjaxDeleteCommand;
import com.lec.yes25.financial.ajax.command.AjaxDetailViewCommand;
import com.lec.yes25.financial.ajax.command.AjaxFinancialDeptListCommand;
import com.lec.yes25.financial.ajax.command.AjaxIncomeView;
import com.lec.yes25.financial.ajax.command.AjaxMonthSalesCommand;
import com.lec.yes25.financial.ajax.command.AjaxProceedListCommand;
import com.lec.yes25.financial.ajax.command.AjaxSearchCommand;
import com.lec.yes25.financial.ajax.command.AjaxUpdateCommand;
import com.lec.yes25.financial.ajax.command.AjaxWriteCommand;
import com.lec.yes25.financial.ajax.command.AjaxWriteListCommand;
import com.lec.yes25.financial.bean.AccountDTO;
import com.lec.yes25.financial.bean.FinancialDTO;

@RestController
@RequestMapping("/financial/*.ajax")
public class AjaxController {
	
	// AjaxWriteResult 리턴용
	public AjaxWriteResult buildResult(HttpServletRequest request) { 
		AjaxWriteResult result = new AjaxWriteResult(); 
		
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		result.setCount((Integer)request.getAttribute("result")); 
		return result; 
	} // end buildResult()
	
	
	// 결재 목록
	@RequestMapping(value="financial/proceedList.ajax")
	public AjaxWriteList proceedList(HttpServletRequest request, HttpServletResponse response) {
		new AjaxProceedListCommand().execute(request, response);
		
		List<FinancialDTO> list = (List<FinancialDTO>) request.getAttribute("list");
		
		AjaxWriteList result = new AjaxWriteList(); 
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setLise(list);
		}
		
		// 페이징 할때만 필요한 것들.
		try { 
			result.setPage((Integer)request.getAttribute("page")); 
			result.setTotalPage((Integer)request.getAttribute("totalPage")); 
			result.setWritePages((Integer)request.getAttribute("writePages")); 
			result.setPageRows((Integer)10); 
			result.setTotalCnt((Integer)request.getAttribute("totalCnt")); 
		} catch(Exception e) { 
			//e.printStackTrace(); 
		} 
		
		return result; 
	} // end proceedList();
	
	// 작성 목록
	@RequestMapping(value="financial/writeList.ajax")
	public AjaxWriteList writeList(HttpServletRequest request, HttpServletResponse response) {
		new AjaxWriteListCommand().execute(request, response);
		
		List<FinancialDTO> list = (List<FinancialDTO>) request.getAttribute("list");
		
		AjaxWriteList result = new AjaxWriteList(); 
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setLise(list);
		}
		
		// 페이징 할때만 필요한 것들.
		try { 
			result.setPage((Integer)request.getAttribute("page")); 
			result.setTotalPage((Integer)request.getAttribute("totalPage")); 
			result.setWritePages((Integer)request.getAttribute("writePages")); 
			result.setPageRows((Integer)10); 
			result.setTotalCnt((Integer)request.getAttribute("totalCnt")); 
		} catch(Exception e) { 
			//e.printStackTrace(); 
		} 
		
		return result; 
	} // end proceedList();
	
	
	// 글작성
	@RequestMapping(value = "/financial/writeOk.ajax", method = RequestMethod.POST)
	public AjaxWriteResult writeOk(HttpServletRequest request, HttpServletResponse response) {
		new AjaxWriteCommand().execute(request, response);
		return buildResult(request);
	} // end writeOk()
	
	// 계정과목 검색, 사용자 검색시
	@RequestMapping("/financial/search.ajax")
	public AjaxWriteResult search(HttpServletRequest request, HttpServletResponse response) {
		new AjaxSearchCommand().execute(request, response);
		
		List<AccountDTO> list = (List<AccountDTO>) request.getAttribute("list");
		
		AjaxAccountResult result = new AjaxAccountResult();
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setList(list);
		}
		
		return result;
	} // end search()
	// 계정과목 검색, 보여주기용
	@RequestMapping("/financial/searchName.ajax")
	public AjaxWriteResult searchAccountName(HttpServletRequest request, HttpServletResponse response) {
		new AjaxAccountNameCommand().execute(request, response);
		
		List<com.lec.yes25.financial.bean.AccountDTO> list = (List<AccountDTO>) request.getAttribute("list");
		
		AjaxAccountResult result = new AjaxAccountResult();
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setList(list);
		}
		
		return result;
	} // end search()

	// 글 수정 불러오기
	@RequestMapping("/financial/viewDetail.ajax")
	public AjaxWriteList view(HttpServletRequest request, HttpServletResponse response) {
		new AjaxDetailViewCommand().execute(request, response);
		
		List<FinancialDTO> list = (List<FinancialDTO>) request.getAttribute("list");
		
		AjaxWriteList result = new AjaxWriteList(); 
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setLise(list);
		}
		
		return result;
	} // end view()
	// 글 수정
	@RequestMapping(value = "/financial/updateOk.ajax", method = RequestMethod.POST)
	public AjaxWriteResult updateOk(HttpServletRequest request, HttpServletResponse response) {
		new AjaxUpdateCommand().execute(request, response);
		return buildResult(request);
	} // end updateOk()
	
	// 글 삭제
	@RequestMapping("/financial/delete.ajax")
	public AjaxWriteResult deleteOk(HttpServletRequest request, HttpServletResponse response) {
		new AjaxDeleteCommand().execute(request, response);
		return buildResult(request);
	} // end deleteOk()
	
	// 재무 부서용 리스트
	@RequestMapping(value="financial/financialDeptList.ajax")
	public AjaxWriteList financialDeptList(HttpServletRequest request, HttpServletResponse response) {
		new AjaxFinancialDeptListCommand().execute(request, response);
		
		List<FinancialDTO> list = (List<FinancialDTO>) request.getAttribute("list");
		
		AjaxWriteList result = new AjaxWriteList(); 
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message")); 
		
		if(list != null) { 
			result.setCount(list.size());
			result.setLise(list);
		}
		
		// 페이징 할때만 필요한 것들.
		try { 
			result.setPage((Integer)request.getAttribute("page")); 
			result.setTotalPage((Integer)request.getAttribute("totalPage")); 
			result.setWritePages((Integer)request.getAttribute("writePages")); 
			result.setPageRows((Integer)10); 
			result.setTotalCnt((Integer)request.getAttribute("totalCnt")); 
		} catch(Exception e) { 
			//e.printStackTrace(); 
		} 
		
		return result; 
	} // end proceedList();
	
	// 손익계산서 로딩
	@RequestMapping("/financial/incomeView.ajax")
	public AjaxIcomeResult incomeView(HttpServletRequest request, HttpServletResponse response) {
		new AjaxIncomeView().execute(request, response);
		
		AjaxIcomeResult result = new AjaxIcomeResult();
		
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message"));
		
		result.setNetSales((Integer)request.getAttribute("netSales"));
		result.setCostOfGoodsSold((Integer)request.getAttribute("costOfGoodsSold"));
		result.setMaintenanceSales((Integer)request.getAttribute("maintenanceSales"));
		result.setEtcIncome((Integer)request.getAttribute("etcIncome"));
		result.setEtcCost((Integer)request.getAttribute("etcCost"));
		result.setCorporateTax((Integer)request.getAttribute("corporateTax"));
		
		return result;
	} // end deleteOk()

	// 차트 월별 매출액
	@RequestMapping("/financial/monthSales.ajax")
	public AjaxWriteResult monthSales(HttpServletRequest request, HttpServletResponse response) {
		new AjaxMonthSalesCommand().execute(request, response);
		
		AjaxWriteResult result = new AjaxWriteResult();
		
		result.setStatus((String)request.getAttribute("status")); 
		result.setMessage((String)request.getAttribute("message"));
		result.setCount((Integer)request.getAttribute("netSales"));
		
		return result;
	} // end deleteOk()
	
} // end Controller