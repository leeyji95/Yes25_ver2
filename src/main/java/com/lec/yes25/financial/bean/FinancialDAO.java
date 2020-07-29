package com.lec.yes25.financial.bean;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface FinancialDAO {
	// 승인을 위한 View
	public FinancialDTO readByStmt_uid(
			@Param("stmt_uid") int stmt_uid
			);
	
	// 결재 라인 update
	public int updateProceed(
			@Param("proceed") int proceed,
			@Param("stmt_uid") int stmt_uid
			); 
	
}