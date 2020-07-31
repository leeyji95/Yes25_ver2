package com.lec.yes25.financial.bean;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AjaxFinancialDAO {
	// 결제를 기다리고 있는 전표 목록, 페이징
	public List<FinancialDTO> selectFromRowProceed (
			@Param("from") int from,
			@Param("logId") int logId
			);
	public int countAllProceed (
			@Param("logId") int logId
			);
	
	// 작성한 전표 목록, 페이징
	public List<FinancialDTO> selectFromRowWrite (
			@Param("from") int from,
			@Param("logId") int logId
			);
	public int countAllWrite (
			@Param("logId") int logId
			);
	
	// 글작성, insert
	public int insert(
			@Param("regDate") String regDate,
			@Param("account_uid") int account_uid,
			@Param("summary") String summary,
			@Param("money") int money,
			@Param("writer") int writer,
			@Param("manager") int manager,
			@Param("approver") int approver
			);
	
	// 계정과목 검색, 사용자 검색시
	public List<AccountDTO> searchAccount(@Param("word") String word);
	// 계정과목 검색, 보여주기용
	public List<AccountDTO> searchAccountName(@Param("account_uid") int account_uid);
	
	// 수정을 위한 불러오기
	public FinancialDTO selectByStmt_uid (@Param("stmt_uid") int stmt_uid);
	// 수정하기, update
	public int update(
			@Param("regDate") String regDate,
			@Param("account_uid") int account_uid,
			@Param("summary") String summary,
			@Param("money") int money,
			@Param("manager") int manager,
			@Param("approver") int approver,
			@Param("stmt_uid") int stmt_uid
			);
	
	// 글 삭제
	public int delete(@Param("stmt_uid") int stmt_uid);
	
	// 재무부서용 전체 목록 보기, 리스트
	public List<FinancialDTO> selectFromRowFinancialDept (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate,
			@Param("from") int from
			);
	public int countAllFinancialDept (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	
	// 손익계산서 값 추출
	public int netSales(
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	public int costOfGoodsSold(
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	public int maintenanceSales (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	public int etcIncome (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	public int etcCost (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	public int corporateTax (
			@Param("startDate") String startDate,
			@Param("endDate") String endDate
			);
	
	
}