package com.lec.yes25.financial.bean;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.lec.yes25.personnel.UserDTO;

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
	
	// 결제라인 담당자, 결재자 선택을 위한 사원 전체 조회
	public List<UserDTO> memberSelectAll();
	
	// 현재 로그인한 사용자의 부서정보 추출
	public int selectLoginDept(
			@Param("username") int username
			);
	
	
}