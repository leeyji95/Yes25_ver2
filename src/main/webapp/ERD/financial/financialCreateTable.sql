DROP TABLE tb_statement;
DROP SEQUENCE statement_seq;
DROP TABLE tb_account;


-- 전표테이블 생성   
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

-- 계정과목 테이블      
CREATE TABLE tb_account
(
    account_uid     NUMBER           NOT NULL, 
    account_name    VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_ACCOUNT_PK PRIMARY KEY (account_uid)
);

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