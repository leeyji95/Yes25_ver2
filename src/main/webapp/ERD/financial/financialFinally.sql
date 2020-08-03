/* 테이블, 시퀀스 삭제 */
-- 전표
DROP TABLE tb_statement;
DROP SEQUENCE statement_seq;
-- 계정과목
DROP TABLE tb_account;




/* 테이블, 시퀀스 생성 */
-- 전표
CREATE TABLE tb_statement
(
    stmt_uid         NUMBER    NOT NULL, 
    stmt_date        DATE      NOT NULL, 
    account_uid      NUMBER    NOT NULL, 
    stmt_summary     CLOB      NOT NULL, 
    stmt_sum         NUMBER    NOT NULL, 
    stmt_manager     NUMBER    NOT NULL, 
    stmt_approver    NUMBER    NOT NULL, 
    stmt_proceed     NUMBER    DEFAULT 1 NOT NULL,
    stmt_writer      NUMBER    NOT NULL,
    CONSTRAINT TB_STATEMENT_PK PRIMARY KEY (stmt_uid)
);
CREATE SEQUENCE statement_seq;
-- 계정과목
CREATE TABLE tb_account
(
    account_uid     NUMBER           NOT NULL, 
    account_name    VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_ACCOUNT_PK PRIMARY KEY (account_uid)
);




/* FK 설정 */
-- 계정과목과 전표 테이블 FK 설정
ALTER TABLE tb_statement
    ADD CONSTRAINT FK_tb_statement_account_uid_tb FOREIGN KEY (account_uid)
        REFERENCES tb_account (account_uid);
-- 작성자 FK 설정
ALTER TABLE tb_statement
    ADD CONSTRAINT FK_tb_statement_stmt_writer_t FOREIGN KEY (stmt_writer)
        REFERENCES users (username);
-- 담당자 FK 설정
ALTER TABLE tb_statement
    ADD CONSTRAINT FK_tb_statement_stmt_manager_t FOREIGN KEY (stmt_manager)
        REFERENCES users (username);
-- 결제자 FK 설정
ALTER TABLE tb_statement
    ADD CONSTRAINT FK_tb_statement_stmt_approver_ FOREIGN KEY (stmt_approver)
        REFERENCES users (username);




/* 계정과목 Insert */
-- 당좌자산 
INSERT INTO tb_account(account_uid, account_name) VALUES (101, '현금');
-- 검색 기능을 시연하기 위한 추가
INSERT INTO tb_account(account_uid, account_name) VALUES (102, '현금');
INSERT INTO tb_account(account_uid, account_name) VALUES (103, '현감');
INSERT INTO tb_account(account_uid, account_name) VALUES (104, '현검');
INSERT INTO tb_account(account_uid, account_name) VALUES (105, '현질');
-- 재고자산
INSERT INTO tb_account(account_uid, account_name) VALUES (146, '상품');
-- 유동부채
INSERT INTO tb_account(account_uid, account_name) VALUES (251, '외상매입금');
INSERT INTO tb_account(account_uid, account_name) VALUES (253, '미지급금');
-- 자본금
INSERT INTO tb_account(account_uid, account_name) VALUES (331, '자본금');
-- 손익계산서를 위한 계정과목---------------------------------------------------------------
-- 매출/매출원가(401)
INSERT INTO tb_account(account_uid, account_name) VALUES (401, '상품매출');
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_account(account_uid, account_name) VALUES (802, '직원급여');
INSERT INTO tb_account(account_uid, account_name) VALUES (811, '복리후생비');
INSERT INTO tb_account(account_uid, account_name) VALUES (812, '여비교통비');
INSERT INTO tb_account(account_uid, account_name) VALUES (813, '접대비');
INSERT INTO tb_account(account_uid, account_name) VALUES (814, '통신비');
INSERT INTO tb_account(account_uid, account_name) VALUES (815, '수도광열비');
INSERT INTO tb_account(account_uid, account_name) VALUES (816, '전력비');
INSERT INTO tb_account(account_uid, account_name) VALUES (817, '세금과공과금');
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_account(account_uid, account_name) VALUES (901, '이자수익');
INSERT INTO tb_account(account_uid, account_name) VALUES (930, '잡이익');
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_account(account_uid, account_name) VALUES (931, '이자비용');
INSERT INTO tb_account(account_uid, account_name) VALUES (933, '기부금');
INSERT INTO tb_account(account_uid, account_name) VALUES (960, '잡손실');
-- 법인세비용 (998)
INSERT INTO tb_account(account_uid, account_name) VALUES (998, '법인세비용');
        




