-- 사용하는 쿼리문
SELECT * FROM tb_statement
ORDER BY stmt_uid DESC 
;

-- 전표 데이터만 삭제하는 쿼리
DELETE FROM tb_statement;

INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, 
 stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2015-05-05', 101,
	'현금', 5000, 20070001, 20070012, 20070012);

SELECT count(*) 
FROM tb_statement
WHERE stmt_writer=20070001;


SELECT 
	stmt_uid, 
	account_uid, 
	stmt_summary, 
	stmt_sum, 
	stmt_manager, 
	stmt_approver, 
	stmt_writer,
	stmt_proceed
FROM 
(SELECT ROWNUM AS RNUM, T.* FROM 
	(SELECT * FROM tb_statement ORDER BY stmt_uid DESC) T) 
WHERE 
	stmt_writer=20070001 AND RNUM >= 2 AND RNUM < 2 + 10;

SELECT 
	stmt_uid,
	stmt_date regDate,
	account_uid,
	stmt_summary summary,
	stmt_sum money,
	stmt_writer writer,
	stmt_manager manager,
	stmt_approver approver,
	stmt_proceed proceed
FROM 
	tb_statement;
	

UPDATE tb_statement
	set
		stmt_date = '2020-01-01',
		account_uid = 101,
		stmt_summary = '변경하기',
		stmt_sum = 1000,
		stmt_manager = 24,
		stmt_approver = 24,
		stmt_proceed = 1
	WHERE
		stmt_uid = 1;
	
SELECT *
FROM tb_account;
WHERE account_name LIKE '%현%';

INSERT INTO tb_account
(account_uid, account_name)
VALUES
(105, '현징');

SELECT *
FROM tb_account
WHERE account_uid = 101;

SELECT * FROM users;
SELECT * FROM TB_DEPT;

SELECT 
	stmt_uid,
	stmt_date regDate,
	account_uid,
	stmt_summary summary,
	stmt_sum money,
	stmt_writer writer,
	stmt_manager manager,
	stmt_approver approver,
	stmt_proceed proceed
FROM 
	tb_statement
WHERE stmt_writer=20070001;

SELECT 
	*
FROM 
	(SELECT ROWNUM AS RNUM, T.* FROM 
		(SELECT * FROM tb_statement WHERE stmt_manager=20070001 OR stmt_approver=20070001 ORDER BY stmt_uid DESC) T) 
WHERE 
	RNUM >= 2 AND RNUM < (2 + 10);

SELECT * FROM tb_statement
;

SELECT 
	stmt_uid, 
	account_uid, 
	stmt_summary, 
	stmt_sum, 
	stmt_manager, 
	stmt_approver, 
	stmt_proceed
FROM 
(SELECT ROWNUM AS RNUM, T.* FROM 
	(SELECT * FROM tb_statement ORDER BY stmt_uid DESC) T) 
WHERE 
	stmt_manager=20070001 OR stmt_approver=20070001 OR RNUM >= 1 AND RNUM < 1 + 5;

SELECT 
	count(*)
FROM
	tb_statement
WHERE 
	stmt_writer=20070001;

SELECT * FROM tb_statement;

SELECT 
		stmt_uid, 
		stmt_date regDate,
		account_uid, 
		stmt_summary summary, 
		stmt_sum money,
		stmt_writer writer,
		stmt_manager manager, 
		stmt_approver approver, 
		stmt_proceed proceed
	FROM 
		(SELECT ROWNUM AS RNUM, T.* FROM 
			(SELECT * FROM tb_statement ORDER BY stmt_uid DESC) T) 
	WHERE 
		(stmt_manager='20070001' OR stmt_approver='20070001') AND RNUM >= 2 AND RNUM < (2 + 10);
	
SELECT * FROM tb_statement
WHERE 
	(stmt_manager='20070001' OR stmt_approver='20070001') AND stmt_proceed IN (1,2);

SELECT *
FROM tb_statement
WHERE
stmt_date >= '2020-01-01' AND stmt_date <= '2020-01-31';





