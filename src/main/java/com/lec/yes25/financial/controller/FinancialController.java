package com.lec.yes25.financial.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lec.yes25.common.C;
import com.lec.yes25.financial.command.FSelectLoginDeptCommand;
import com.lec.yes25.financial.command.FUpdateCommand;
import com.lec.yes25.financial.command.FViewCommand;
import com.lec.yes25.financial.command.MemberSelectCommand;

@Controller
@RequestMapping("/financial")
public class FinancialController {
	
	// MyBatis
	private SqlSession sqlSession;

	public FinancialController() {
		super();
		System.out.println("FinancialController() 생성");
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		C.sqlSession = sqlSession;
	}
	
	
	// 메인 리스트는 Ajax에서 정보 로딩
	// 목록보기 버튼은 재무부서만 보이게 설정
	@RequestMapping("/financialMain.bn")
	public String list(Model model) {
		new FSelectLoginDeptCommand().execute(model);
		return "financial/financialMain";
	}
	
	// 결제를 위한 View
	@RequestMapping("/financialView.bn")
	public String proceedView(int stmtUid, Model model) {
		model.addAttribute("stmtUid", stmtUid);
		new FViewCommand().execute(model);
		return "financial/proceedView";
	}
	// 결제 처리 라인 
	@RequestMapping("/financialupdateOk.bn")
	public String updateOK(int stmtUid, int proceed, Model model) {
		model.addAttribute("stmtUid", stmtUid);
		model.addAttribute("proceed", proceed);
		new FUpdateCommand().execute(model);
		return "financial/proceedUpdateOk";
	}
	
	// 재무부서용 목록 리스트 -> Ajax에서 정보 로딩
	@RequestMapping("/financialDeptList.bn")
	public String financialDepTList() {
		return "financial/financialDepTList";
	}
	
	// 손익계산서
	@RequestMapping("/incomeView.bn")
	public String income() {
		return "financial/incomeView";
	}
	

	// 손익계산서 엑셀 다운로드
	@RequestMapping(value="/excelDown.bn", method = RequestMethod.POST)
	public void excelDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("손익계산서");

	    Row row = null;
	    Cell cell = null;

	    int rowNo = 0;

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("과목");
	    cell = row.createCell(1);
	    cell.setCellValue("금액");
	    
	    
	    String value = "";
	    
	    // 데이터 부분 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅰ. 매출액");
	    value = request.getParameter("netSales");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅱ. 매출원가");
	    value = request.getParameter("costOfGoodsSold");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("판매비와관리비");
	    value = request.getParameter("maintenanceSales");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅲ. 매출총이익");
	    value = request.getParameter("grossProfit");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅳ. 영업이익");
	    value = request.getParameter("salesIcome");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("기타수익");
	    value = request.getParameter("etcIncome");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("기타비용");
	    value = request.getParameter("etcCost");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅴ. 법인세비용차감전순이익");
	    value = request.getParameter("corporateTaxIncome");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("법인세비용");
	    value = request.getParameter("corporateTax");
	    cell = row.createCell(1);
	    cell.setCellValue(value);
	    
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellValue("Ⅵ. 당기순이익");
	    value = request.getParameter("currentIncome");
	    cell = row.createCell(1);
	    cell.setCellValue(value);

	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=income_statement.xls");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	} // end excelDown()
	
	// 담당자 선택 새 창보기
	@RequestMapping("/writeManagerSelect.bn")
	public String writeManagerSelect(Model model) {
		new MemberSelectCommand().execute(model);
		return "financial/writeManagerSelect";
	}
	@RequestMapping("/writeApproverSelect.bn")
	public String writeApproverSelect(Model model) {
		new MemberSelectCommand().execute(model);
		return "financial/writeApproverSelect";
	}
	@RequestMapping("/updateManagerSelect.bn")
	public String updateManagerSelect(Model model) {
		new MemberSelectCommand().execute(model);
		return "financial/updateManagerSelect";
	}
	@RequestMapping("/updateApproverSelect.bn")
	public String updateApproverSelect(Model model) {
		new MemberSelectCommand().execute(model);
		return "financial/updateApproverSelect";
	}
	
	
} // end Controller