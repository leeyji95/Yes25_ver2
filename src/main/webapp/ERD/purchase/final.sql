-- table 삭제
DROP TABLE tb_publisher CASCADE CONSTRAINT purge;
DROP TABLE tb_book CASCADE CONSTRAINT purge;
DROP TABLE tb_category CASCADE CONSTRAINT purge;
DROP TABLE tb_attach CASCADE CONSTRAINT purge;
DROP TABLE tb_order CASCADE CONSTRAINT purge;

-- view 삭제
DROP VIEW v_PubAndBook;
DROP VIEW v_Order;

-- sequence 삭제
DROP SEQUENCE publisher_seq;
DROP SEQUENCE book_seq;
DROP SEQUENCE category_seq;
DROP SEQUENCE attach_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE order_set_seq;

-- sequence 생성
CREATE SEQUENCE publisher_seq;
CREATE SEQUENCE book_seq;
CREATE SEQUENCE attach_seq;
CREATE SEQUENCE category_seq;
CREATE SEQUENCE order_seq;
CREATE SEQUENCE order_set_seq;
------------------------------

-- 출판사 테이블
CREATE TABLE tb_publisher
(
    publisher_uid        NUMBER           NOT NULL, 
    publisher_name       VARCHAR2(100)    NOT NULL, 
    publisher_num        VARCHAR2(12)     NOT NULL, 
    publisher_rep        VARCHAR2(30)     NOT NULL, 
    publisher_contact    VARCHAR2(60)     NOT NULL, 
    publisher_address    VARCHAR2(200)    NOT NULL, 
    CONSTRAINT TB_PUBLISHER_PK PRIMARY KEY (publisher_uid)
);

ALTER TABLE tb_publisher
    ADD CONSTRAINT UC_publisher_num UNIQUE (publisher_num);
------------------------------

-- 카테고리 테이블
CREATE TABLE tb_category
(
    category_uid       NUMBER          NOT NULL, 
    category_name      VARCHAR2(30)    NULL, 
    category_parent    NUMBER          NULL, 
    CONSTRAINT TB_CATEGORY_PK PRIMARY KEY (category_uid)
);

ALTER TABLE tb_category
    ADD CONSTRAINT FK_tb_category_category_parent FOREIGN KEY (category_parent)
        REFERENCES tb_category (category_uid);
------------------------------ 

-- 도서 테이블
CREATE TABLE tb_book
(
    book_uid         NUMBER           NOT NULL, 
    book_subject     VARCHAR2(200)    NOT NULL, 
    book_author      VARCHAR2(100)    NOT NULL, 
    book_content     CLOB             NULL, 
    book_price       NUMBER           NULL, 
    book_pubdate     DATE             NULL, 
    book_regdate     DATE             DEFAULT SYSDATE NOT NULL, 
    book_isbn        NUMBER           NULL, 
    category_uid     NUMBER           NOT NULL, 
    publisher_uid    NUMBER           NOT NULL, 
    CONSTRAINT TB_BOOK_PK PRIMARY KEY (book_uid)
);

ALTER TABLE tb_book
    ADD CONSTRAINT FK_tb_book_category_uid_tb_cat FOREIGN KEY (category_uid)
        REFERENCES tb_category (category_uid);

ALTER TABLE tb_book
    ADD CONSTRAINT FK_tb_book_publisher_uid_tb_pu FOREIGN KEY (publisher_uid)
        REFERENCES tb_publisher (publisher_uid);
------------------------------

-- 첨부파일 테이블
CREATE TABLE tb_attach
(
    attach_uid           NUMBER           NOT NULL, 
    attach_oriname       VARCHAR2(200)    NOT NULL, 
    attach_servername    VARCHAR2(200)    NOT NULL, 
    attach_type          VARCHAR2(200)    NOT NULL, 
    attach_uri           VARCHAR2(200)    NULL, 
    attach_regdate       DATE             DEFAULT SYSDATE NOT NULL, 
    attach_size          NUMBER           NOT NULL, 
    book_uid             NUMBER           NULL, 
    CONSTRAINT TB_ATTACH_PK PRIMARY KEY (attach_uid)
);

ALTER TABLE tb_attach
    ADD CONSTRAINT FK_tb_attach_book_uid_tb_book_ FOREIGN KEY (book_uid)
        REFERENCES tb_book (book_uid);
------------------------------
   
-- 발주 테이블
CREATE TABLE tb_order
(
    order_uid          NUMBER    NOT NULL UNIQUE,
    order_set_uid	   NUMBER 	 NOT NULL,
    book_uid           NUMBER    NOT NULL, 
    publisher_uid      NUMBER    NOT NULL, 
    order_unit_cost    INT       NOT NULL, 
    order_quantity     INT       NOT NULL, 
    order_date         DATE      DEFAULT SYSDATE NOT NULL, 
    order_state        INT       DEFAULT 0 NOT NULL, 
    CONSTRAINT tb_order_pk PRIMARY KEY (order_set_uid, book_uid, publisher_uid)
);

ALTER TABLE tb_order
    ADD CONSTRAINT FK_tb_order_book_uid_tb_book_b FOREIGN KEY (book_uid)
        REFERENCES tb_book (book_uid);

ALTER TABLE tb_order
    ADD CONSTRAINT FK_tb_order_pub_uid_tb_pub FOREIGN KEY (publisher_uid)
        REFERENCES tb_publisher (publisher_uid);

SELECT * FROM tb_order;
------------------------------

-- view 생성
CREATE OR REPLACE VIEW view_book AS
SELECT  
		tbk.BOOK_UID bookUid, tbk.BOOK_SUBJECT subject, tbk.BOOK_AUTHOR author, 
		tbk.BOOK_CONTENT content, tbk.BOOK_PRICE price, tbk.BOOK_PUBDATE pubdate, tbk.BOOK_REGDATE regdate, 
		tbk.BOOK_ISBN isbn, tbk.CATEGORY_UID categoryUid, tbk.PUBLISHER_UID pubUid,
		tpb.PUBLISHER_NAME pubName, tct.CATEGORY_NAME categoryName,
		tat.ATTACH_SERVERNAME serName, tat.ATTACH_URI uri
	FROM tb_book tbk
	LEFT OUTER JOIN TB_PUBLISHER tpb 
	ON tbk.PUBLISHER_UID = tpb.PUBLISHER_UID 
	LEFT OUTER JOIN TB_CATEGORY tct 
	ON tbk.CATEGORY_UID = tct.CATEGORY_UID 
	LEFT OUTER JOIN TB_ATTACH tat
	ON tbk.BOOK_UID = tat.BOOK_UID 
	ORDER BY tbk.BOOK_UID DESC;

CREATE OR REPLACE VIEW view_category AS
SELECT root.CATEGORY_UID root_uid, root.CATEGORY_NAME root_name, 
down1.CATEGORY_UID down1_uid, down1.CATEGORY_NAME down1_name,  
down2.CATEGORY_UID down2_uid, down2.CATEGORY_NAME down2_name  
FROM TB_CATEGORY root 
LEFT OUTER JOIN TB_CATEGORY down1 ON down1.CATEGORY_PARENT = root.CATEGORY_UID
LEFT OUTER JOIN TB_CATEGORY down2 ON down2.CATEGORY_PARENT = down1.CATEGORY_UID 
WHERE root.CATEGORY_PARENT IS NULL 
ORDER BY root.CATEGORY_NAME, down1.CATEGORY_NAME, down2.CATEGORY_NAME;
------------------------------

-- 거래처, 도서 검색시 사용하는 view
CREATE OR REPLACE VIEW v_PubAndBook
AS SELECT
    p.publisher_uid pub_uid,
    p.publisher_name pub_name,
    p.publisher_num pub_num,
    p.publisher_rep pub_rep,
    p.publisher_contact pub_contact, 
    p.publisher_address pub_address,
	b.book_uid,
	b.book_subject,
	b.book_author,
	b.category_uid ctg_uid,
	c.category_name ctg_name, 
	b.book_content,
	b.book_price,
	b.book_isbn,
	b.book_pubdate,
	b.book_regdate
FROM
	tb_publisher p INNER JOIN tb_book b
	ON p.publisher_uid = b.publisher_uid
	INNER JOIN tb_category c
	ON b.category_uid = c.category_uid;

SELECT * FROM v_PubAndBook;
------------------------------

-- 발주 정보 보기에 사용되는 view
CREATE OR REPLACE VIEW v_Order
AS SELECT
	O.order_uid ord_uid,
	O.order_set_uid ord_set_uid,
	O.order_date ord_date,
	O.publisher_uid pub_uid,
	P.publisher_name pub_name,
	P.publisher_num pub_num,
	P.publisher_rep pub_rep,
	P.publisher_contact pub_contact,
	P.publisher_address pub_address,
	B.book_uid,
	B.book_subject,
	B.book_author,
	O.order_unit_cost ord_unit_cost,
	O.order_quantity ord_quantity,
	O.order_state ord_state
FROM
	tb_publisher P INNER JOIN tb_book B
	ON P.publisher_uid = B.publisher_uid
	INNER JOIN tb_order O
	ON B.publisher_uid = O.publisher_uid AND B.book_uid = O.book_uid;

SELECT * FROM v_order;
------------------------------

-- 시퀀스를 1 올려주는 함수
-- (foreach문 사용시 반복이 다 끝나고 마지막에 시퀀스가 1증가하는데 매회마다 시퀀스가 증가하도록 해주는 용도로 사용)
-- 영역을 블록 씌워준뒤 컨트롤+엔터 해주시면 생성 됩니다.. 
CREATE OR REPLACE FUNCTION get_seq(seq_name IN VARCHAR2) 
RETURN NUMBER 
IS
  v_num NUMBER;
  sql_stmt VARCHAR2(64);
BEGIN
  sql_stmt := 'select '||seq_name||'.nextval from dual';
  EXECUTE IMMEDIATE sql_stmt INTO v_num;
  RETURN v_num;
END;
------------------------------

-- 출판사 더미 데이터
DELETE FROM tb_publisher;


INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '길벗', '101-12-12653', '김재훈', '02-6522-6511', '서울 종로구  혜화동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '한빛', '101-64-11223', '이재훈', '02-1232-9261', '서울 종로구 부암동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '프리렉', '220-02-47863', '이재훈', '02-1332-0821', '서울 강남구 역삼동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '다락원', '220-28-45964', '이재훈', '02-1243-5571', '서울 강남구 역삼동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '도우출판', '120-28-39683', '이재훈', '02-1221-6511', '서울 강남구 삼성동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '제이펍', '120-12-95953', '이재훈', '02-1232-6521', '서울 강남구 삼성동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '나라원', '106-24-65412', '이재훈', '02-2932-2921', '서울 용산구 한남동');

INSERT INTO tb_publisher 
	(publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address) 
VALUES
	(publisher_seq.nextval, '넥서스', '106-12-93482', '이재훈', '02-1922-1246', '서울 용산구 남영동');
------------------------------

-- 카테고리 더미 데이터
INSERT INTO TB_CATEGORY VALUES(1, 'IT 모바일', null);
INSERT INTO TB_CATEGORY VALUES(2, '게임', 1);
INSERT INTO TB_CATEGORY VALUES(3, '그래픽', 1);
INSERT INTO TB_CATEGORY VALUES(4, '네트워크', 1);
INSERT INTO TB_CATEGORY VALUES(5, '프로그래밍 언어', 1);
INSERT INTO TB_CATEGORY VALUES(6, '오피스활용', 1);
INSERT INTO TB_CATEGORY VALUES(7, '웹사이트', 1);
INSERT INTO TB_CATEGORY VALUES(8, '게임 기획', 2);
INSERT INTO TB_CATEGORY VALUES(9, '게임 개발', 2);
INSERT INTO TB_CATEGORY VALUES(10, '3DS', 3);
INSERT INTO TB_CATEGORY VALUES(11, '포토샵', 3);
INSERT INTO TB_CATEGORY VALUES(12, '프리미어', 3);
INSERT INTO TB_CATEGORY VALUES(13, '네트워크 일반', 4);
INSERT INTO TB_CATEGORY VALUES(14, '보안/해킹', 4);
INSERT INTO TB_CATEGORY VALUES(15, 'Java', 5);
INSERT INTO TB_CATEGORY VALUES(16, 'C', 5);
INSERT INTO TB_CATEGORY VALUES(17, 'Python', 5);
INSERT INTO TB_CATEGORY VALUES(18, 'Ruby', 5);
INSERT INTO TB_CATEGORY VALUES(19, '엑셀', 6);
INSERT INTO TB_CATEGORY VALUES(20, '파워포인트', 6);
INSERT INTO TB_CATEGORY VALUES(21, '한글', 6);
INSERT INTO TB_CATEGORY VALUES(22, 'HTML/CSS', 7);
INSERT INTO TB_CATEGORY VALUES(23, '웹디자인', 7);
INSERT INTO TB_CATEGORY VALUES(24, '웹기획', 7);
INSERT INTO TB_CATEGORY VALUES(25, 'JavaScript', 7);
------------------------------

-- 도서 더미 데이터
DELETE FROM tb_book;

DECLARE num number := 1;
BEGIN
  WHILE (num <= 100) LOOP
	INSERT INTO tb_book VALUES (book_seq.nextval, '자바의 정석 기초편 '||book_seq.nextval, '남궁성', 'Java 책입니다.', 22500, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 15, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '자바의 정석 '||book_seq.nextval, '남궁성', 'Java 책입니다.', 27000, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 15, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '윤성우의 열혈 C 프로그래밍 '||book_seq.nextval, '윤성우', 'C 책입니다.', 22500, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 16, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '프로그래밍 루비 '||book_seq.nextval, '데이브 토머스,앤디 헌트,차드 파울러', 'Ruby 책입니다.', 24300, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 18, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '2020 시나공 GTQ 포토샵 1급 '||book_seq.nextval, '길벗알앤디', '포토샵 책입니다.', 17100, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 11, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '레트로의 유니티 게임 프로그래밍 에센스 '||book_seq.nextval, '이제민', '게임개발 책입니다.', 54000, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 9, CEIL(DBMS_RANDOM.VALUE(0, 8)));
	INSERT INTO tb_book VALUES (book_seq.nextval, 'Do it! HTML5+CSS3 웹 표준의 정석 '||book_seq.nextval, '고경희', '웹디자인 책입니다.', 22500, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(999999, 9999999)), 23, CEIL(DBMS_RANDOM.VALUE(0, 8)));
    num := num + 1;
  END LOOP;
END;
------------------------------

-- 발주 더미 데이터
DELETE FROM tb_order;

-- 최초 1회만 실행해주면 됩니다.
SELECT order_set_seq.nextval FROM dual;
------------------------------

-- 발주 더미 데이터
-- 영역을 블록 씌워준뒤 컨트롤+엔터 해주시면 생성 됩니다.. 
-- 무작위로 값이 들어가다가 중복값이 있으면 실패할 수도 있습니다.. 
DECLARE 
	num NUMBER := 1;
	orderSetUid NUMBER := order_set_seq.currval;
	pubUid NUMBER := CEIL(DBMS_RANDOM.VALUE(0, 8));
	YYYY NUMBER := CEIL(DBMS_RANDOM.VALUE(2017, 2020));
	MM NUMBER := CEIL(DBMS_RANDOM.VALUE(0, 7));
	DD NUMBER := CEIL(DBMS_RANDOM.VALUE(0, 28));
BEGIN
  WHILE (num <= 30) LOOP
  	INSERT INTO tb_order VALUES (order_seq.nextval, orderSetUid, (SELECT book_uid FROM (SELECT book_uid FROM tb_book WHERE publisher_uid = pubUid ORDER BY dbms_random.value) WHERE rownum = 1), pubUid, ROUND(CEIL(DBMS_RANDOM.VALUE(14000, 24000)),-3), CEIL(DBMS_RANDOM.VALUE(10, 100)), YYYY||'-'||MM||'-'||DD, 0); 
  	INSERT INTO tb_order VALUES (order_seq.nextval, orderSetUid, (SELECT book_uid FROM (SELECT book_uid FROM tb_book WHERE publisher_uid = pubUid ORDER BY dbms_random.value) WHERE rownum = 1), pubUid, ROUND(CEIL(DBMS_RANDOM.VALUE(14000, 24000)),-3), CEIL(DBMS_RANDOM.VALUE(10, 100)), YYYY||'-'||MM||'-'||DD, 0); 
    num := num + 1;
    orderSetUid := order_set_seq.nextval;
   	pubUid := CEIL(DBMS_RANDOM.VALUE(0, 8));
   	YYYY := CEIL(DBMS_RANDOM.VALUE(2017, 2020));
   	MM := CEIL(DBMS_RANDOM.VALUE(0, 7));
   	DD := CEIL(DBMS_RANDOM.VALUE(0, 28));
  END LOOP;
END;

SELECT * FROM tb_order;

