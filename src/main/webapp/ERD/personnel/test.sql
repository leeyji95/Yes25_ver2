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
-- 예시
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
-- 예시
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '사원');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '대리');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '과장');
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '부장'); -- 부관리자로 임명(전표 승인 담당)
INSERT INTO TB_POSITION VALUES (position_seq.nextval, '대표'); -- 대표 관리자로 임명(결재담당, 근태신청 승인/거절 담당)



-- 로그인에 필요한 테이블~
DROP TABLE users CASCADE CONSTRAINTS;
DROP SEQUENCE user_seq;

CREATE SEQUENCE user_seq;
CREATE TABLE users(
	username 		NUMBER 			NOT NULL UNIQUE , 
	password 		VARCHAR2(100)	NOT NULL,
	enabled 		char(1) 		DEFAULT '1',
 	emp_name        VARCHAR2(20)    NOT NULL, 
    emp_email       VARCHAR2(30)    NOT NULL UNIQUE, 
    dept_uid        NUMBER          NOT NULL REFERENCES tb_dept (dept_uid), 
    position_uid    NUMBER          NOT NULL REFERENCES tb_position (position_uid), 
    emp_phone       VARCHAR2(15)    NOT NULL, 
    emp_hiredate    DATE            DEFAULT SYSDATE NOT NULL, 
    emp_admin       VARCHAR(50)     NOT NULL
);
SELECT * FROM users;
DELETE FROM USERS;
--예시
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '조셉', 'leeyji96@naber.cn', 10, 300, '01010101', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin ) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '루시', 'cssds96@daum.net', 20, 500, '01088059601', 'ROLE_ADMIN');


-- 관리자 테이블
DROP TABLE authorities CASCADE CONSTRAINTS;
DROP SEQUENCE auth_seq;

CREATE SEQUENCE auth_seq;
CREATE TABLE authorities(
	username NUMBER REFERENCES users(username),
	authority varchar2(50) NOT NULL
);
SELECT * FROM authorities;
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
    commute_end         DATE       		NULL, 	
    commute_overtime    NUMBER          NULL, 	
    commute_total       NUMBER          NULL,  	
    commute_state       VARCHAR2(10)    NULL,  
    commute_is_apply    NUMBER          DEFAULT 0 NULL
);
DELETE FROM tb_commute WHERE username = 20070002 AND TO_DATE(SYSDATE , 'yyyy-mm-dd') = TO_DATE(COMMUTE_START , 'yyyy-mm-dd');
SELECT * FROM tb_commute ; 

-- 예시
INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-21', 'yyyy-mm-dd'), TO_DATE('2020-07-21 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-22', 'yyyy-mm-dd'), TO_DATE('2020-07-22 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-23', 'yyyy-mm-dd'), TO_DATE('2020-07-23 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-24', 'yyyy-mm-dd'), TO_DATE('2020-07-24 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-25', 'yyyy-mm-dd'), TO_DATE('2020-07-25 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-26', 'yyyy-mm-dd'), TO_DATE('2020-07-26 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-27', 'yyyy-mm-dd'), TO_DATE('2020-07-27 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-28', 'yyyy-mm-dd'), TO_DATE('2020-07-28 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-29', 'yyyy-mm-dd'), TO_DATE('2020-07-29 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-30', 'yyyy-mm-dd'), TO_DATE('2020-07-30 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');

INSERT INTO TB_COMMUTE (commute_uid, username, commute_date, commute_start, commute_state) 
VALUES (cmmt_seq.nextval, 20070001, TO_DATE('2020-07-31', 'yyyy-mm-dd'), TO_DATE('2020-07-31 11:20:22', 'YYYY-MM-DD hh24:mi:ss'), '출근');


--SELECT TO_CHAR(commute_date, 'yyyy-mm-dd') FROM TB_COMMUTE ORDER BY COMMUTE_DATE ;

SELECT u.USERNAME 사원번호, c.commute_start 출근시간, c.COMMUTE_STATE 근무상태
FROM USERS u JOIN TB_COMMUTE c
ON u.USERNAME = c.username
ORDER BY COMMUTE_START ;

-- test
UPDATE tb_commute 
SET commute_state = TO_DATE('2020-07-29 13:00:00', 'YYYY-MM-DD HH24:MI:SS') 
WHERE username = 20070002;

-- test
UPDATE tb_commute 
SET commute_state = '지각' 
WHERE username = 20070001
AND TO_DATE(SYSDATE , 'yyyy-mm-dd') = TO_DATE(COMMUTE_START , 'yyyy-mm-dd') ;


-- test
SELECT TO_CHAR(c.COMMUTE_START, 'yyyy-mm-dd') 출근시간 
FROM TB_COMMUTE c
WHERE USERNAME = 20070001;


SELECT * FROM tb_commute ORDER BY COMMUTE_DATE;
