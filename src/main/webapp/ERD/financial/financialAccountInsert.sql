-- 당좌자산
INSERT INTO tb_account(account_uid, account_name) VALUES (101, '현금');

-- 재고자산
INSERT INTO tb_account(account_uid, account_name) VALUES (146, '상품');

-- 유동부채
INSERT INTO tb_account(account_uid, account_name) VALUES (251, '외상매입금');
INSERT INTO tb_account(account_uid, account_name) VALUES (253, '미지급금');

-- 자본금
INSERT INTO tb_account(account_uid, account_name) VALUES (331, '자본금');

-- 매출/매출원가
INSERT INTO tb_account(account_uid, account_name) VALUES (401, '상품매출');

-- 판매관리비
INSERT INTO tb_account(account_uid, account_name) VALUES (802, '직원급여');
INSERT INTO tb_account(account_uid, account_name) VALUES (813, '접대비');
INSERT INTO tb_account(account_uid, account_name) VALUES (814, '통신비');
INSERT INTO tb_account(account_uid, account_name) VALUES (815, '수도광열비');
INSERT INTO tb_account(account_uid, account_name) VALUES (816, '전력비');
INSERT INTO tb_account(account_uid, account_name) VALUES (817, '세금과공과금');

-- 영업외수익
INSERT INTO tb_account(account_uid, account_name) VALUES (901, '이자수익');

-- 영업외비용
INSERT INTO tb_account(account_uid, account_name) VALUES (931, '이자비용');
INSERT INTO tb_account(account_uid, account_name) VALUES (933, '기부금');
INSERT INTO tb_account(account_uid, account_name) VALUES (960, '잡손실');


-- 회원 삽입
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '민준', 'cssds91@daum.net', 10, 500, '01088059601', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '서준', 'cssds92@daum.net', 30, 500, '01088059601', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '도준', 'cssds93@daum.net', 50, 500, '01088059601', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '예준', 'cssds94@daum.net', 50, 500, '01088059601', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '샤인', 'every5116@naver.com', 20, 500, '01064134954', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '채원', 'cssds95@daum.net', 10, 500, '01088059601', 'ROLE_MEMBER');
INSERT INTO users(username, password, emp_name, emp_email, dept_uid, position_uid, emp_phone, emp_admin) 
VALUES (CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), 
   CONCAT(TO_CHAR(sysdate, 'YYMM'), LPAD(user_seq.nextval, 4, 0)), '지후', 'cssds97@daum.net', 10, 500, '01088059601', 'ROLE_MEMBER');
   