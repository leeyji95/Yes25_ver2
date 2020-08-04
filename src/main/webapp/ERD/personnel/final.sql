-- 부서 테이블
DROP TABLE tb_dept CASCADE CONSTRAINT purge;
DROP SEQUENCE dept_seq;

CREATE SEQUENCE dept_seq
START WITH 10
INCREMENT BY 10
MAXVALUE 1000;

CREATE TABLE tb_dept
(
    dept_uid     NUMBER          NOT NULL, 
    dept_name    VARCHAR2(10)    NOT NULL, 
    CONSTRAINT TB_DEPT_PK PRIMARY KEY (dept_uid)
);
SELECT * FROM TB_DEPT ORDER BY DEPT_UID ;
DELETE FROM  TB_DEPT ;
-- 데이터
INSERT INTO tb_dept  VALUES (dept_seq.nextval, '인사팀');
INSERT INTO tb_dept  VALUES (dept_seq.nextval, '재무팀');
INSERT INTO tb_dept  VALUES (dept_seq.nextval, '제품팀');
INSERT INTO tb_dept  VALUES (dept_seq.nextval, '물류팀');
INSERT INTO tb_dept  VALUES (dept_seq.nextval, '구매팀');


-- 직급 테이블
DROP TABLE tb_position CASCADE CONSTRAINT purge;
DROP SEQUENCE position_seq;

CREATE SEQUENCE position_seq
START WITH 300
INCREMENT BY 100
MAXVALUE 1000;

CREATE TABLE tb_position
(
    position_uid     NUMBER          NOT NULL, 
    position_name    VARCHAR2(10)    NOT NULL, 
    CONSTRAINT TB_POSITION_PK PRIMARY KEY (position_uid)
);
SELECT * FROM tb_position ORDER BY POSITION_UID ;
DELETE FROM TB_POSITION ;
-- 데이터
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '사원');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '대리');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '과장');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '부장'); -- 부관리자로 임명(전표 승인 담당)
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '대표'); -- 대표 관리자로 임명(결재담당, 근태신청 승인/거절 담당)



-- 신규 사원 테이블(시큐리티 user 테이블)
DROP TABLE users CASCADE CONSTRAINTS;
DROP SEQUENCE user_seq;

CREATE SEQUENCE user_seq;
CREATE TABLE users(
	username 		 NUMBER 			  NOT NULL UNIQUE , 
	password 		 VARCHAR2(100)	  NOT NULL,
	enabled 		    char(1) 		  DEFAULT '1',
 	emp_name        VARCHAR2(20)    NOT NULL, 
   emp_email       VARCHAR2(30)    NOT NULL UNIQUE, 
   dept_uid        NUMBER          NOT NULL REFERENCES tb_dept (dept_uid), 
   position_uid    NUMBER          NOT NULL REFERENCES tb_position (position_uid), 
   emp_phone       VARCHAR2(15)    NOT NULL, 
   emp_hiredate    DATE            DEFAULT SYSDATE NOT NULL, 
   emp_admin       VARCHAR(50)     NOT NULL
);
SELECT u.USERNAME 사원번호, u.PASSWORD 비밀번호, 
			u.ENABLED , u.EMP_NAME 사원이름, 
			u.EMP_EMAIL 이메일, u.DEPT_UID 부서번호, 
			u.POSITION_UID 직급번호, u.EMP_PHONE 전화번호, 
			u.EMP_HIREDATE 입사일, u.EMP_ADMIN 권한
FROM users u
;

DELETE FROM USERS;
--일반직원
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '이예지', 'leeyji96@naber.cn', 10, 300, '0102234589', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '임상빈', 'lkerhu21@naber.cn', 20, 600, '0102445589', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '홍성용', 'qwe6@naber.cn', 30, 700, '01020763529', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '한수빈', 'bferg32@naber.cn', 40, 600, '0102012389', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '장수영', 'suejw99@naber.cn', 50, 600, '010254389', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김예진', 'yehinf99@naber.cn', 50, 600, '01022345789', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김광진', 'lkjsdf00@naber.cn', 10, 600, '01022343389', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '강사님', 'zidfhe7@naber.cn', 10, 600, '01022235439', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)),
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김호룡', 'dfhejf@nabe.com', 20, 600, '010222356689', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김국주', 'dfhwbcu98@daum.net', 30, 300, '0102123569', 'ROLE_MEMBER');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '스타벅', 'dfjlwekv972@naver.com', 30, 600, '0102324559', 'ROLE_MEMBER');

-- 관리자
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '방탄지민', 'lebcnd9@naber.cn', 20, 500, '010234221', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '정우성', 'cbdf96@daum.net', 20, 400, '01234325891', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '전지현', 'zzxcds96@daum.net', 50, 500, '010244352676', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '현빈', 'cvcxv@daum.net', 40, 500, '010245875556', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '정지훈', 'couts96@daum.net', 50, 500, '0102455864562', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '에릭남', 'clklkp6@daum.net', 30, 600, '010212453266', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '송강호', 'csuiuy96@daum.net', 40, 600, '01024733572', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김혜수', 'ctryh96@daum.net', 40, 500, '01024466843', 'ROLE_ADMIN');

INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '김태희', 'cssdwsx96@daum.net', 40, 500, '01024511345', 'ROLE_ADMIN');


-- 관리자 테이블
DROP TABLE authorities CASCADE CONSTRAINTS;
DROP SEQUENCE auth_seq;

CREATE SEQUENCE auth_seq;
CREATE TABLE authorities(
	username NUMBER REFERENCES users(username),
	authority varchar2(50) NOT NULL
);
SELECT a.USERNAME 사원번호, a.AUTHORITY 권한
FROM authorities a;
DELETE FROM AUTHORITIES ;
-- 예시

INSERT INTO AUTHORITIES 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(auth_seq.nextval, 4, 0)), 'ROLE_MEMBER');
INSERT INTO AUTHORITIES 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(auth_seq.nextval, 4, 0)), 'ROLE_ADMIN');


SELECT * FROM users;
SELECT * FROM authorities;





-- 근태 조회 테이블
DROP TABLE tb_commute CASCADE CONSTRAINTS;
DROP SEQUENCE cmmt_seq;
CREATE SEQUENCE cmmt_seq;

CREATE TABLE tb_commute
(
    commute_uid         NUMBER          NOT NULL PRIMARY KEY, 
    username            NUMBER   		NOT NULL REFERENCES users (username), 
    commute_date        DATE            DEFAULT SYSDATE NULL, 
    commute_start       DATE       		NULL,  	
    commute_end         DATE       		 NULL, 	
    commute_overtime    NUMBER          NULL, 	
    commute_total       NUMBER          NULL,  	
    commute_state       VARCHAR2(10)    NULL,  
    commute_is_apply    VARCHAR2(10)   DEFAULT '미신청' NULL
);
DELETE FROM TB_COMMUTE WHERE username = 20080002 AND TO_DATE(SYSDATE , 'yyyy-mm-dd') = TO_DATE(COMMUTE_START , 'yyyy-mm-dd');
SELECT commute_uid 고유번호, username 사원번호, commute_date 근무일자, commute_start 출근시각,
		commute_end 퇴근시각, commute_overtime 초과근무시간, commute_total 총근무시간, 
		commute_state 근무상태, commute_is_apply 신청여부
FROM tb_commute ; 

-- 20080001 번 사원의 근태현황 데이터 
INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-06', 'yyyy-mm-dd') , TO_DATE('2020-07-06 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-06 18:20:22', 'YYYY-MM-DD hh24:mi:ss'),0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-07', 'yyyy-mm-dd'), TO_DATE('2020-07-07 08:23:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-07 18:28:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-08', 'yyyy-mm-dd'), TO_DATE('2020-07-08 08:40:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-08 19:20:22', 'YYYY-MM-DD hh24:mi:ss'), 1, 9, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-09', 'yyyy-mm-dd'), TO_DATE('2020-07-09 12:59:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-10', 'yyyy-mm-dd'), TO_DATE('2020-07-10 09:12:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-10 20:20:22', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-11', 'yyyy-mm-dd'), TO_DATE('2020-07-11 11:44:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-11 18:50:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-12', 'yyyy-mm-dd'), TO_DATE('2020-07-12 08:12:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-12 16:20:48', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-13', 'yyyy-mm-dd'), TO_DATE('2020-07-13 09:19:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-13 17:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-14', 'yyyy-mm-dd'), TO_DATE('2020-07-14 08:30:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-14 20:46:14', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-15', 'yyyy-mm-dd'), TO_DATE('2020-07-15 15:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-16', 'yyyy-mm-dd'), TO_DATE('2020-07-16 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-16 19:01:32', 'YYYY-MM-DD hh24:mi:ss'), 1, 8,  '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-17', 'yyyy-mm-dd'), TO_DATE('2020-07-17 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-17 16:17:17', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-18', 'yyyy-mm-dd'), TO_DATE('2020-07-18 08:50:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-18 18:49:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 9, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-19', 'yyyy-mm-dd'), TO_DATE('2020-07-19 08:55:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-19 18:18:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-20', 'yyyy-mm-dd'), TO_DATE('2020-07-20 14:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0 ,'결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-21', 'yyyy-mm-dd'), TO_DATE('2020-07-21 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-21 22:22:22', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-22', 'yyyy-mm-dd'), TO_DATE('2020-07-22 09:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-22 15:30:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-23', 'yyyy-mm-dd'), TO_DATE('2020-07-23 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-23 18:56:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-24', 'yyyy-mm-dd'), TO_DATE('2020-07-24 15:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0 ,'결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-25', 'yyyy-mm-dd'), TO_DATE('2020-07-25 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-25 19:10:24', 'YYYY-MM-DD hh24:mi:ss'), 1, 7,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-26', 'yyyy-mm-dd'), TO_DATE('2020-07-26 09:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-26 16:48:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-27', 'yyyy-mm-dd'), TO_DATE('2020-07-27 10:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-27 18:00:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-28', 'yyyy-mm-dd'), TO_DATE('2020-07-28 17:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-29', 'yyyy-mm-dd'), TO_DATE('2020-07-29 12:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-30', 'yyyy-mm-dd'), TO_DATE('2020-07-30 09:20:22', 'YYYY-MM-DD hh24:mi:ss'),
		TO_DATE('2020-07-30 18:10:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 7,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080001, TO_DATE('2020-07-31', 'yyyy-mm-dd'), TO_DATE('2020-07-31 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-31 18:34:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '퇴근');

-- 20080012 번 사원의 근태현황 데이터 
INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-06', 'yyyy-mm-dd') , TO_DATE('2020-07-06 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-06 18:20:22', 'YYYY-MM-DD hh24:mi:ss'),0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-07', 'yyyy-mm-dd'), TO_DATE('2020-07-07 08:23:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-07 18:28:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-08', 'yyyy-mm-dd'), TO_DATE('2020-07-08 08:40:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-08 19:20:22', 'YYYY-MM-DD hh24:mi:ss'), 1, 9, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-09', 'yyyy-mm-dd'), TO_DATE('2020-07-09 12:59:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-10', 'yyyy-mm-dd'), TO_DATE('2020-07-10 09:12:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-10 20:20:22', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-11', 'yyyy-mm-dd'), TO_DATE('2020-07-11 11:44:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-11 18:50:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-12', 'yyyy-mm-dd'), TO_DATE('2020-07-12 08:12:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-12 16:20:48', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-13', 'yyyy-mm-dd'), TO_DATE('2020-07-13 09:19:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-13 17:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-14', 'yyyy-mm-dd'), TO_DATE('2020-07-14 08:30:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-14 20:46:14', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-15', 'yyyy-mm-dd'), TO_DATE('2020-07-15 15:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-16', 'yyyy-mm-dd'), TO_DATE('2020-07-16 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-16 19:01:32', 'YYYY-MM-DD hh24:mi:ss'), 1, 8,  '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-17', 'yyyy-mm-dd'), TO_DATE('2020-07-17 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-17 16:17:17', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-18', 'yyyy-mm-dd'), TO_DATE('2020-07-18 08:50:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-18 18:49:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 9, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-19', 'yyyy-mm-dd'), TO_DATE('2020-07-19 08:55:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-19 18:18:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-20', 'yyyy-mm-dd'), TO_DATE('2020-07-20 14:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0 ,'결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-21', 'yyyy-mm-dd'), TO_DATE('2020-07-21 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-21 22:22:22', 'YYYY-MM-DD hh24:mi:ss'), 2, 10, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-22', 'yyyy-mm-dd'), TO_DATE('2020-07-22 09:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-22 15:30:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-23', 'yyyy-mm-dd'), TO_DATE('2020-07-23 08:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-23 18:56:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 8, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-24', 'yyyy-mm-dd'), TO_DATE('2020-07-24 15:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0 ,'결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-25', 'yyyy-mm-dd'), TO_DATE('2020-07-25 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-25 19:10:24', 'YYYY-MM-DD hh24:mi:ss'), 1, 7,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-26', 'yyyy-mm-dd'), TO_DATE('2020-07-26 09:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-26 16:48:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '조퇴');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-27', 'yyyy-mm-dd'), TO_DATE('2020-07-27 10:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-27 18:00:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start,commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-28', 'yyyy-mm-dd'), TO_DATE('2020-07-28 17:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-29', 'yyyy-mm-dd'), TO_DATE('2020-07-29 12:20:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 0, '결근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-30', 'yyyy-mm-dd'), TO_DATE('2020-07-30 09:20:22', 'YYYY-MM-DD hh24:mi:ss'),
		TO_DATE('2020-07-30 18:10:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 7,'퇴근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_end, commute_overtime, commute_total, commute_state) 
VALUES (cmmt_seq.nextval, 20080012, TO_DATE('2020-07-31', 'yyyy-mm-dd'), TO_DATE('2020-07-31 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), 
		TO_DATE('2020-07-31 18:34:22', 'YYYY-MM-DD hh24:mi:ss'), 0, 6, '퇴근');


SELECT u.USERNAME 사원번호, c.commute_start 출근시간, c.COMMUTE_STATE 근무상태
FROM USERS u JOIN TB_COMMUTE c
ON u.USERNAME = c.username;


