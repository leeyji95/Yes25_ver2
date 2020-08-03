-- table 삭제
DROP TABLE tb_order CASCADE CONSTRAINT purge;

-- view 삭제
DROP VIEW v_PubAndBook;
DROP VIEW v_Order;

-- sequence 삭제
DROP SEQUENCE publisher_seq;
DROP SEQUENCE book_seq;

-- sequence 생성
CREATE SEQUENCE publisher_seq;
CREATE SEQUENCE book_seq;

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

SELECT * FROM tb_order;
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

DECLARE num number := 1;
BEGIN
  WHILE (num <= 10) LOOP
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'A출판사'||publisher_seq.nextval, CEIL(DBMS_RANDOM.VALUE(100, 999))||'-'||CEIL(DBMS_RANDOM.VALUE(10, 99))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), 'A대표자'||publisher_seq.nextval, '010-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), '주소'||publisher_seq.nextval);
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'B출판사'||publisher_seq.nextval, CEIL(DBMS_RANDOM.VALUE(100, 999))||'-'||CEIL(DBMS_RANDOM.VALUE(10, 99))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), 'B대표자'||publisher_seq.nextval, '010-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), '주소'||publisher_seq.nextval);
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'C출판사'||publisher_seq.nextval, CEIL(DBMS_RANDOM.VALUE(100, 999))||'-'||CEIL(DBMS_RANDOM.VALUE(10, 99))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), 'C대표자'||publisher_seq.nextval, '010-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999))||'-'||CEIL(DBMS_RANDOM.VALUE(1000, 9999)), '주소'||publisher_seq.nextval);
    num := num + 1;
  END LOOP;
END;
------------------------------

-- 도서 더미 데이터
DELETE FROM tb_book;

DECLARE num number := 1;
BEGIN
  WHILE (num <= 300) LOOP
	INSERT INTO tb_book VALUES (book_seq.nextval, '기억1'||book_seq.nextval, '베르나르 베르베르', '소설입니다.', 14800, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 2, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '기억2'||book_seq.nextval, '베르나르 베르베르', '소설입니다.', 14800, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 2, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '라플라스의 마녀'||book_seq.nextval, '히가시노 게이고', '소설입니다.', 13320, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 2, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '마력의 태동'||book_seq.nextval, '히가시노 게이고', '소설입니다.', 12600, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 2, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '자바의 정석 기초편'||book_seq.nextval, '남궁성', 'Java 책입니다.', 22500, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 1, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '자바의 정석'||book_seq.nextval, '남궁성', 'Java 책입니다.', 27000, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 1, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '윤성우의 열혈 C 프로그래밍'||book_seq.nextval, '윤성우', 'C 책입니다.', 22500, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 1, CEIL(DBMS_RANDOM.VALUE(1, 30)));
	INSERT INTO tb_book VALUES (book_seq.nextval, '윤성우의 열혈 C++ 프로그래밍'||book_seq.nextval, '윤성우', 'C 책입니다.', 24300, sysdate, sysdate, CEIL(DBMS_RANDOM.VALUE(1000000, 9999999)), 1, CEIL(DBMS_RANDOM.VALUE(1, 30)));
    num := num + 1;
  END LOOP;
END;
------------------------------
