package com.lec.yes25.personnel;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface PersonnelDAO {
	
	// 신규사원 등록 삽입 
	public int insert(
			@Param("name")String name, 
			@Param("email")String email, 
			@Param("deptno")int deptno, 
			@Param("positionno")int positionno, 
			@Param("phone")String phone, 
			@Param("hiredate")String hiredate, 
			@Param("admin")String admin);

	// 관리자 테이블에 권한 삽입
	public int authinsert(@Param("admin")String admin);
	
	// 해당 username (사원번호) 에 대한 사원정보 꺼내기 
	public List<UserDTO> selectByUid(@Param("username") final int username);
	
//------------------ ㅊ  ㄱ  --------------------------
//-------------------ㅜ  ㅡ  --------------------------
//-------------------ㄹ   ㄴ  --------------------------
	
	// 출근시간 등록 삽입 
	public int goworkinsert(
			@Param("username") int username,
			@Param("commute_start") Date goworkDate
			);
	
	// 출근시간에 따른 commute_state 값 update 로 컬럼 내용 수정 
	public int goworkState(
			@Param("username") int username, 
			@Param("commute_state") String state
			);
	
	// 출근 등록 시 해당 사원의 출근 등록 날짜가 이미 있는 경우 --> 출근을 눌러도  더이상 출근 등록이 insert 되지 않도록 Command 에서 검증하기  
	// 이를 위한 select 조회문 필요 
	public String GoworkDateByusername(@Param("username") int username); 
	
	
//-------------------- 퇴근 관련 --------------------------
	
	// 반대로 퇴근시간 이미 찍혔는지 조회 
	public String OutworkDateByusername(@Param("username") int username);
	
	// 퇴근시간에 따른 commute_state 값 update
	// 퇴근시간 등록 삽입
	public int outworkUpdate(
			@Param("username") int username,
			@Param("commute_end") Date outworkDate
			);
		
	public int outworkState(
			@Param("username") int username,
			@Param("commute_state") String state
			);
	
	// 초과근무시간 있는지 여부 select 
	public String selectOverwork(
			@Param("username") int username,
			@Param("commute_end") String outworkDate
			);
	
	// 초과근무시간 update
	public int overWorkUpdate(
			@Param("username") int username,
			@Param("commute_overtime") int hours,
			@Param("commute_end") Date outworkDate
			);
	
}
