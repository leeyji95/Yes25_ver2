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
        



/* 손익계산서를 위한 비용 전표 INSERT */
-- 2019년 전표 자료, 36개
-- 1월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-01', 802, '직원급여', 500000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-05', 811, '복리후생비', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-10', 812, '여비교통비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-15', 813, '접대비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-20', 814, '통신비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-25', 815, '수도광열비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-30', 816, '전력비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-01-30', 817, '세금과공과', 50000, 20080001, 20080012, 20080013);
-- 2월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-02-25', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
-- 3월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-03-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-03-30', 933, '기부금', 50000, 20080001, 20080012, 20080013);
-- 4월, 5월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-04-01', 802, '직원급여', 500000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-05-05', 811, '복리후생비', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-04-10', 812, '여비교통비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-05-15', 813, '접대비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-04-20', 814, '통신비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-05-25', 815, '수도광열비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-04-30', 816, '전력비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-05-30', 817, '세금과공과', 50000, 20080001, 20080012, 20080013);
-- 6월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-06-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
-- 7월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-07-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-07-30', 933, '기부금', 50000, 20080001, 20080012, 20080013);
-- 8월, 9월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-08-01', 802, '직원급여', 500000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-09-05', 811, '복리후생비', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-08-10', 812, '여비교통비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-09-15', 813, '접대비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-08-20', 814, '통신비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-09-25', 815, '수도광열비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-08-30', 816, '전력비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-09-30', 817, '세금과공과', 50000, 20080001, 20080012, 20080013);
-- 10월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-10-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
-- 11월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-11-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-11-30', 933, '기부금', 50000, 20080001, 20080012, 20080013);
-- 12월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-12-31', 930, '잡이익', 100000, 20080001, 20080012, 20080013);
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-12-31', 960, '잡손실', 100000, 20080001, 20080012, 20080013);
-- 법인세비용 (998)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2019-12-31', 998, '법인세비용', 500000, 20080001, 20080012, 20080013);
-- 2018년 전표 자료, 36개
-- 1월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-01', 802, '직원급여', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-05', 811, '복리후생비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-10', 812, '여비교통비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-15', 813, '접대비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-20', 814, '통신비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-25', 815, '수도광열비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-30', 816, '전력비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-01-30', 817, '세금과공과', 10000, 20080001, 20080012, 20080013);
-- 2월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-02-25', 931, '이자비용', 10000, 20080001, 20080012, 20080013);
-- 3월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-03-30', 931, '이자비용', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-03-30', 933, '기부금', 10000, 20080001, 20080012, 20080013);
-- 4월, 5월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-04-01', 802, '직원급여', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-05-05', 811, '복리후생비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-04-10', 812, '여비교통비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-05-15', 813, '접대비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-04-20', 814, '통신비', 5000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-05-25', 815, '수도광열비', 5000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-04-30', 816, '전력비', 5000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-05-30', 817, '세금과공과', 5000, 20080001, 20080012, 20080013);
-- 6월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-06-30', 931, '이자비용', 10000, 20080001, 20080012, 20080013);
-- 7월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-07-30', 931, '이자비용', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-07-30', 933, '기부금', 10000, 20080001, 20080012, 20080013);
-- 8월, 9월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-08-01', 802, '직원급여', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-09-05', 811, '복리후생비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-08-10', 812, '여비교통비', 10000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-09-15', 813, '접대비', 1000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-08-20', 814, '통신비', 1000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-09-25', 815, '수도광열비', 1000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-08-30', 816, '전력비', 1000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-09-30', 817, '세금과공과', 1000, 20080001, 20080012, 20080013);
-- 10월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-10-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
-- 11월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-11-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-11-30', 933, '기부금', 50000, 20080001, 20080012, 20080013);
-- 12월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-12-31', 930, '잡이익', 50000, 20080001, 20080012, 20080013);
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-12-31', 960, '잡손실', 50000, 20080001, 20080012, 20080013);
-- 법인세비용 (998)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2018-12-31', 998, '법인세비용', 300000, 20080001, 20080012, 20080013);




/* 시연을 위한 2020년 전표 생성, 197 */
-- 1월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-01', 802, '직원급여', 500000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-05', 811, '복리후생비', 100000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-10', 812, '여비교통비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-15', 813, '접대비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-20', 814, '통신비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-25', 815, '수도광열비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-30', 816, '전력비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-01-30', 817, '세금과공과', 50000, 20080001, 20080001, 20080012);
-- 2월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-02-25', 931, '이자비용', 50000, 20080001, 20080001, 20080012);
-- 3월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-03-30', 931, '이자비용', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-03-30', 933, '기부금', 50000, 20080001, 20080001, 20080012);
-- 4월
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-01', 802, '직원급여', 500000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-05', 811, '복리후생비', 100000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-10', 812, '여비교통비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-15', 813, '접대비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-20', 814, '통신비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-25', 815, '수도광열비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-30', 816, '전력비', 50000, 20080001, 20080001, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-04-30', 817, '세금과공과', 50000, 20080001, 20080001, 20080012);
-- 5월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-30', 931, '이자비용', 5000, 20080001, 20080001, 20080012);
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-01', 802, '직원급여', 500000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-05', 811, '복리후생비', 100000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-10', 812, '여비교통비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-15', 813, '접대비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-20', 814, '통신비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-25', 815, '수도광열비', 50000, 20080001, 20080001, 20080012);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-30', 816, '전력비', 50000, 20080001, 20080001, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-05-30', 817, '세금과공과', 50000, 20080001, 20080001, 20080012);
-- 6월
-- 영업외수익 (기타 수익으로 분류) (901, 930)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-06-30', 931, '이자비용', 5000, 20080001, 20080001, 20080012);
-- 7월, 8월
-- 영업외비용 (기타 비용으로 분류) (931, 933, 960)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-30', 931, '이자비용', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-30', 933, '기부금', 50000, 20080001, 20080012, 20080013);
-- 판매관리비(= 판관비) (802, 811, 812, 813, 814, 815, 816, 817)
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-08-01', 802, '직원급여', 500000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-05', 811, '복리후생비', 100000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-10', 812, '여비교통비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-15', 813, '접대비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-20', 814, '통신비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-25', 815, '수도광열비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-30', 816, '전력비', 50000, 20080001, 20080012, 20080013);
INSERT INTO tb_statement(stmt_uid, stmt_date, account_uid, stmt_summary, stmt_sum, stmt_writer, stmt_manager, stmt_approver)
VALUES(statement_seq.nextval, '2020-07-30', 817, '세금과공과', 50000, 20080001, 20080012, 20080013);




/* 매출 금액 */
-- 2020년은 월별 필요
-- 2019년
-- 2018년




/* 매입 금액*/
-- 2019년
-- 2018년