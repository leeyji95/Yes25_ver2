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


-- 사원 테이블
DROP TABLE tb_emp CASCADE CONSTRAINT purge;
DROP SEQUENCE emp_seq;
CREATE SEQUENCE emp_seq;
CREATE TABLE tb_emp
(
    emp_uid         NUMBER          NOT NULL PRIMARY KEY, 
    emp_number      NUMBER          NULL REFERENCES users (username) ,  -- 사원번호 (username)
    emp_pw			VARCHAR2(200)   NULL, -- 비밀번호 -> 사원번호와 같음(default)
    emp_name        VARCHAR2(20)    NOT NULL, 
    emp_email       VARCHAR2(30)    NOT NULL UNIQUE, 
    dept_uid        NUMBER          NOT NULL REFERENCES tb_dept (dept_uid), 
    position_uid    NUMBER          NOT NULL REFERENCES tb_position (position_uid), 
    emp_phone       VARCHAR2(50)    NOT NULL, 
    emp_hiredate    DATE            DEFAULT SYSDATE NOT NULL, 
    emp_admin       VARCHAR(70)     NOT NULL
);
DELETE FROM TB_EMP ;
SELECT * FROM tb_emp ORDER BY EMP_NUMBER  ;

----------------------------------------------------------------------------------------------------------
-- 로그인에 필요한 테이블~
DROP TABLE authorities CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;

CREATE SEQUENCE user_seq;
CREATE TABLE users(
	username 		NUMBER 			NOT NULL PRIMARY KEY, 
	password 		VARCHAR2(100)	NOT NULL,
	enabled 		char(1) 		DEFAULT '1',
	emp_name        VARCHAR2(20)    NOT NULL, 
    emp_email       VARCHAR2(30)    NOT NULL UNIQUE, 
    dept_uid        NUMBER          NOT NULL REFERENCES tb_dept (dept_uid), 
    position_uid    NUMBER          NOT NULL REFERENCES tb_position (position_uid), 
    emp_phone       VARCHAR2(30)    NOT NULL, 
    emp_hiredate    DATE            DEFAULT SYSDATE NOT NULL, 
    emp_admin       VARCHAR(50)     NOT NULL
	
);
SELECT * FROM users;
DELETE FROM USERS WHERE username=200700;
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '조셉', 'leeyji96@naber.cn', 10, 300, '01010101', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
	CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '루시', 'cssds96@daum.net', 20, 500, '01088059601', 'ROLE_ADMIN');


CREATE TABLE authorities(
	username NUMBER ,
	authority varchar2(50) NOT NULL
);
SELECT * FROM authorities;
DELETE FROM AUTHORITIES ;
INSERT INTO authorities SELECT username , emp_admin FROM users;

-------------------------------------------------------------------------------------------------------

--예시데이터
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'이예지', 'RLAAUDWLS@daum.com', 10, 300, '01089743645', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ROLE_MEMBER' );
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'건돼에', 'ejir@daum.com', 20, 400, '01065983212', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ROLE_MEMBER' );
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'뚱땅보', 'wrjk@daum.com', 30, 700, '01078451223', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ADMIN_MEMBER' );
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'유뚱땅', 'tjlk@daum.com', 40, 600, '01056897845', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ROLE_MEMBER' );
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'동남씨', '2qewqf@daum.com', 50, 700, '01023154848', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ADMIN_MEMBER' );
INSERT INTO TB_EMP VALUES (emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)), 
'기계맨', 'kljvioid@daum.com', 20, 500, '01098652154', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'ROLE_MEMBER' );


SELECT emp_number username, emp_pw password, emp_admin auth FROM TB_EMP WHERE emp_number = 20070001;


-- 관리자 테이블
DROP TABLE tb_emp_auth CASCADE CONSTRAINT purge;
CREATE TABLE tb_emp_auth
(
    emp_number    NUMBER    	NOT NULL REFERENCES tb_emp (emp_number), 
    emp_admin	  VARCHAR2(50)  NOT NULL 
);
DELETE FROM tb_emp_auth ;
SELECT * FROM tb_emp_auth ORDER BY emp_number ;
-- 예시
INSERT INTO TB_EMP_AUTH VALUES (20070002, 'ADMIN_MEMBER');
INSERT INTO TB_EMP_AUTH VALUES (20070003, 'ADMIN_MEMBER');


SELECT emp_number username, emp_admin authority FROM TB_EMP_AUTH WHERE emp_number = 20070002;



SELECT EMP .EMP_NUMBER "사원번호", EMP .EMP_PW "비밀번호", AUTH .auth "권한"
FROM TB_EMP emp, TB_EMP_AUTH auth
WHERE emp.EMP_NUMBER = AUTH .EMP_NUMBER 
ORDER BY EMP .EMP_NUMBER 
;






-- 근태 조회 테이블
CREATE TABLE tb_commute
(
    commute_uid         NUMBER          NOT NULL PRIMARY KEY, 
    emp_uid             NUMBER          NOT NULL REFERENCES tb_emp (emp_uid), 
    commute_date        DATE            DEFAULT SYSDATE NULL, 
    commute_start       TIMESTAMP       NULL, 
    commute_end         TIMESTAMP       NULL, 
    commute_overtime    NUMBER          NULL, 
    commute_total       NUMBER          NULL, 
    commute_state       VARCHAR2(10)    NOT NULL, 
    commute_is_apply    NUMBER          DEFAULT 0 NULL
);
DELETE FROM tb_commute ;
SELECT * FROM tb_commute ;


-- 근태 신청 테이블
CREATE TABLE tb_apply
(
    apply_uid            NUMBER           NOT NULL PRIMARY KEY, 
    emp_uid              NUMBER           NOT NULL REFERENCES tb_emp (emp_uid), 
    apply_date           DATE             DEFAULT SYSDATE NOT NULL, 
    apply_holiyperiod    DATE             NULL, 
    apply_extra          NUMBER           NULL, 
    apply_outplace       VARCHAR2(200)    NULL, 
    commute_uid          NUMBER           NOT NULL REFERENCES tb_commute (commute_uid)
);
DELETE FROM tb_apply ;
SELECT * FROM tb_apply ;




CREATE TABLE tb_password
(
    pw_uid       NUMBER           NOT NULL PRIMARY KEY, 
    pw_origin    VARCHAR2(200)    NOT NULL, 
    pw_change    VARCHAR2(200)    NOT NULL, 
    emp_uid      NUMBER           NOT NULL REFERENCES tb_emp (emp_uid), 
);
DELETE FROM tb_password ;
SELECT * FROM tb_password ;
 



---------------------------------------------------------------------------------------------------------------------
DROP TABLE tb_emp CASCADE CONSTRAINT purge;
DROP TABLE tb_emp_auth CASCADE CONSTRAINT purge;

DROP SEQUENCE dept_seq;
CREATE SEQUENCE dept_seq;
CREATE SEQUENCE position_seq;
CREATE SEQUENCE commute_seq;
CREATE SEQUENCE apply_seq;
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 9999;
DROP SEQUENCE emp_seq;

--테이블 생성
CREATE TABLE tb_emp
(
    emp_uid              NUMBER           NOT NULL PRIMARY KEY, 
    emp_number           NUMBER           NOT NULL UNIQUE, 
    emp_name             VARCHAR2(20)     NOT NULL, 
    emp_email            VARCHAR2(30)     NOT NULL UNIQUE, 
    dept_uid             NUMBER           NOT NULL, 
    position_uid         NUMBER           NOT NULL, 
    emp_pw               VARCHAR2(200)    NOT NULL, 
    emp_phone            VARCHAR2(15)     NOT NULL, 
    emp_hiredate         DATE             DEFAULT SYSDATE NOT NULL,
    emp_admin            NUMBER           NOT NULL   
);


INSERT INTO TB_EMP VALUES (
emp_seq.nextval, 
CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , 
'이예지', 'rlaaudwk@daum.com', 5, 5, 'EMP_NUMBER','01089785645', SYSDATE, 0 );

INSERT INTO TB_EMP VALUES (emp_seq.nextval, CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) , '김예진', 'RLAAUDWLS@daum.com', 6, 7, 'eDFjke', '01089743645', TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 0 );

DELETE FROM TB_EMP ;
SELECT * FROM tb_emp ;

SELECT LPAD(emp_seq.nextval, 8, TO_CHAR(sysdate, 'YYMM')) -- 20072021
FROM DUAL;

SELECT SUBSTR(LPAD(22, 8, TO_CHAR(sysdate, 'YYMM')), 5, 4) FROM DUAL;  -- 2022 20072022 에서 2022 만 잘라냄(5번째 글자부터 4자리 자르기)

-- 사원번호 완성
SELECT CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(emp_seq.nextval, 4, 0)) FROM DUAL; 

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual;


INSERT INTO TB_EMP (emp_pw) VALUES ();


------------------------------
DROP TABLE authorities CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;

CREATE TABLE users(
	username number NOT NULL REFERENCES tb_emp(emp_number),
	password varchar2(50) NOT NULL,
	enabled char(1) DEFAULT '1',
	PRIMARY KEY (username)
);


CREATE TABLE authorities(
	username varchar2(50) REFERENCES users(username),
	authority varchar2(50) NOT NULL,
	PRIMARY KEY (username, authority)
);


/* 데이터 DML */
INSERT INTO users (username, password) VALUES ();
INSERT INTO users (username, password) VALUES ('20070002', '20070002');
INSERT INTO users (username, password) VALUES ('admin00', '1234');

INSERT INTO authorities VALUES ('20070001', 'ROLE_ADMIN');
INSERT INTO authorities VALUES ('20070002', 'ROLE_MEMBER');
INSERT INTO authorities VALUES ('admin00', 'ROLE_MEMBER');
INSERT INTO authorities VALUES ('admin00', 'ROLE_ADMIN');

-- 확인
SELECT u.username, u.password ,u.enabled, a.authority
FROM users u, authorities a
WHERE u.username = a.username;













