--테이블 삭제
DROP TABLE tb_publisher_test CASCADE CONSTRAINT purge;
DROP TABLE tb_book_test CASCADE CONSTRAINT purge;
DROP TABLE tb_attach_test CASCADE CONSTRAINT purge;
DROP TABLE tb_category_test CASCADE CONSTRAINT purge;
DROP TABLE tb_order_test CASCADE CONSTRAINT purge;
DROP TABLE tb_stock_test CASCADE CONSTRAINT purge;
DROP TABLE tb_inbound_test CASCADE CONSTRAINT purge;
DROP TABLE tb_outbound_test CASCADE CONSTRAINT purge;


-- 시퀀스 삭제
DROP SEQUENCE publisher_test_seq;
DROP SEQUENCE book_test_seq;
DROP SEQUENCE category_test_seq;
DROP SEQUENCE order_test_seq;
DROP SEQUENCE stock_test_seq;
DROP SEQUENCE inbound_test_seq;
DROP SEQUENCE outbound_test_seq;



--시퀀스 생성
CREATE SEQUENCE publisher_test_seq;
CREATE SEQUENCE book_test_seq;
CREATE SEQUENCE category_test_seq;
CREATE SEQUENCE order_test_seq;
CREATE SEQUENCE stock_test_seq;
CREATE SEQUENCE inbound_test_seq; /*START WITH 1 INCREMENT BY 1;*/
CREATE SEQUENCE outbound_test_seq;


DROP VIEW v_inbound_test;
DROP VIEW v_outbound_test;
DROP VIEW v_book_stock_test;

--테이블 생성

CREATE TABLE tb_category_test
(
    category_uid       NUMBER          NOT NULL, 
    category_name      VARCHAR2(30)    NULL, 
    category_parent    NUMBER          NULL, 
    CONSTRAINT TB_CATEGORY_TEST_PK PRIMARY KEY (category_uid)
);

ALTER TABLE tb_category_test
    ADD CONSTRAINT FK_tb_category_parent FOREIGN KEY (category_parent)
        REFERENCES tb_category_test (category_uid);

       
CREATE TABLE tb_publisher_test
(
    publisher_uid        NUMBER           NOT NULL, 
    publisher_name       VARCHAR2(100)    NOT NULL, 
    publisher_num        VARCHAR2(12)     NOT NULL, 
    publisher_rep        VARCHAR2(30)     NOT NULL, 
    publisher_contact    VARCHAR2(60)     NOT NULL, 
    publisher_address    VARCHAR2(200)    NOT NULL, 
    CONSTRAINT TB_PUBLISHER_TEST_PK PRIMARY KEY (publisher_uid)
);

ALTER TABLE tb_publisher_test
    ADD CONSTRAINT UC_publisher_test_num UNIQUE (publisher_num);

       
CREATE TABLE tb_book_test
(
    book_uid         NUMBER           NOT NULL, 
    book_subject     VARCHAR2(200)    NOT NULL, 
    book_author      VARCHAR2(20)     NOT NULL, 
    book_content     CLOB             NULL, 
    book_pubdate     DATE             NOT NULL, 
    book_regdate     DATE             DEFAULT SYSDATE NOT NULL, 
    book_isbn        NUMBER           NULL, 
    category_uid     NUMBER           NOT NULL, 
    publisher_uid    NUMBER           NOT NULL,
    price            NUMBER           NOT NULL,
    CONSTRAINT TB_BOOK_TEST_PK PRIMARY KEY (book_uid)
);

ALTER TABLE tb_book_test
    ADD CONSTRAINT FK_tb_book_category_uid FOREIGN KEY (category_uid)
        REFERENCES tb_category_test (category_uid);

ALTER TABLE tb_book_test
    ADD CONSTRAINT FK_tb_book_publisher_uid FOREIGN KEY (publisher_uid)
        REFERENCES tb_publisher_test (publisher_uid);  
       
CREATE TABLE tb_order_test
(
    order_uid          NUMBER    NOT NULL, 
    book_uid           NUMBER    NOT NULL, 
    account_uid        NUMBER    NOT NULL, 
    order_unit_cost    INT       NOT NULL, 
    order_quantity     INT       NOT NULL, 
    order_date         DATE      NOT NULL, 
    order_state        INT       NOT NULL, 
    CONSTRAINT TB_ORDER_TEST_PK PRIMARY KEY (order_uid)
);

ALTER TABLE tb_order_test
    ADD CONSTRAINT FK_tb_order_book_uid_tb_book FOREIGN KEY (book_uid)
        REFERENCES tb_book_test (book_uid);



CREATE TABLE tb_stock_test
(
    stock_uid    NUMBER    NOT NULL, 
    book_uid     NUMBER    UNIQUE NOT NULL, 
    stock_quantity        NUMBER    DEFAULT 0 NOT NULL,
    CONSTRAINT TB_STOCK_TEST_PK PRIMARY KEY (stock_uid),
    CONSTRAINT check_stock_quantity CHECK (stock_quantity >= 0 )
);

ALTER TABLE tb_stock_test
    ADD CONSTRAINT FK_tb_stock_book_uid_tb FOREIGN KEY (book_uid)
        REFERENCES tb_book_test (book_uid);


CREATE TABLE tb_inbound_test
(
    inbound_uid         NUMBER    NOT NULL, 
    order_uid           NUMBER    NOT NULL,
/*  book_uid            NUMBER    NOT NULL,
    inbound_quantity    NUMBER    NOT NULL, */
    inbound_date        DATE      DEFAULT SYSDATE NOT NULL,
    CONSTRAINT TB_INBOUND_TEST_PK PRIMARY KEY (inbound_uid)
);


/*CREATE OR REPLACE TRIGGER tb_inbound_test_AI_TRG
BEFORE INSERT ON tb_inbound_test 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT inbound_test_seq.NEXTVAL
    INTO :NEW.inbound_uid 
    FROM DUAL;
END;*/

ALTER TABLE tb_inbound_test
    ADD CONSTRAINT FK_tb_inbound_order_uid FOREIGN KEY (order_uid)
        REFERENCES tb_order_test (order_uid);


/*ALTER TABLE tb_inbound_test
    ADD CONSTRAINT FK_tb_inbound_book_uid FOREIGN KEY (book_uid)
        REFERENCES tb_book_test (book_uid);*/

CREATE TABLE tb_outbound_test
(
    outbound_uid           NUMBER          NOT NULL,
    book_uid               NUMBER          NOT NULL,
    outbound_quantitiy     VARCHAR2(20)    DEFAULT '0' NOT NULL, 
    outbound_unit_price    VARCHAR2(20)    NOT NULL,
    outbound_state         NUMBER          NOT NULL,
    outbound_date          DATE            DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT TB_OUTBOUND_TEST_PK PRIMARY KEY (outbound_uid)
);

ALTER TABLE tb_outbound_test
    ADD CONSTRAINT FK_tb_outbound_book_uid FOREIGN KEY (book_uid)
        REFERENCES tb_book_test (book_uid);


CREATE OR REPLACE VIEW v_inbound_test
AS SELECT C.inbound_uid
			, A.order_uid
			, A.book_uid
			, A.order_unit_cost
			, A.order_quantity
			, A.order_date
			, A.order_state
			, B.book_subject
			, B.book_isbn
			, C.inbound_date
FROM tb_order_test A, tb_book_test B, tb_inbound_test C
WHERE A.book_uid = B.book_uid AND A.order_uid = C.order_uid;

CREATE OR REPLACE VIEW v_book_order_test
AS SELECT A.book_uid
		, A.book_subject
		, A.book_isbn
		, B.order_uid
		, B.order_unit_cost
		, B.order_quantity
		, B.order_date
		, B.order_state
FROM tb_book_test A, tb_order_test B
WHERE A.book_uid = B.book_uid;

CREATE OR REPLACE VIEW v_outbound_test
AS SELECT A.book_uid
			, C.outbound_uid
			, C.outbound_quantitiy
			, C.outbound_unit_price
			, C.outbound_state
			, C.outbound_date
			, B.price
			, B.book_subject
			, B.book_isbn
FROM tb_stock_test A, tb_book_test B, tb_outbound_test C
WHERE A.book_uid = B.book_uid AND A.book_uid = C.book_uid;

CREATE OR REPLACE VIEW v_book_stock_test
AS SELECT A.book_uid
		, A.book_subject
		, A.book_isbn
		, A.book_author
		, A.price
		, A.book_pubdate
		, B.stock_uid
		, B.stock_quantity
		, C.category_uid
		, C.category_name
		, D.PUBLISHER_UID
		, D.publisher_name
FROM tb_book_test A, tb_stock_test B, tb_category_test C, tb_publisher_test D
WHERE A.book_uid = B.book_uid
AND A.category_uid = C.CATEGORY_UID 
AND A.PUBLISHER_UID = D.PUBLISHER_UID 
;



SELECT * FROM tb_stock_test;
SELECT * FROM tb_inbound_test;
SELECT * FROM tb_outbound_test;
SELECT * FROM tb_book_test;
SELECT * FROM tb_category_test;
SELECT * FROM tb_publisher_test;
SELECT * FROM tb_order_test;
SELECT * FROM v_inbound_test;
SELECT * FROM v_outbound_test;
SELECT * FROM v_book_stock_test;

INSERT INTO tb_category_test (category_uid, category_name, category_parent)
	VALUES (category_test_seq.NEXTVAL, '문학', NULL);
INSERT INTO tb_category_test (category_uid, category_name, category_parent)
	VALUES (category_test_seq.NEXTVAL, '소설', 2);

INSERT INTO tb_publisher_test (publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address)
	VALUES (publisher_test_seq.NEXTVAL, '예경', 2, '김예경', 1, '서울시');

INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '서양미술사', '곰브리치', '서양 미술의 역사', to_date('2003-07-10', 'yyyy-mm-dd'), 9788970840659, 2, 1, 34200);
INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '동양미술사', '김동양', '동양 미술의 역사', to_date('2003-07-11', 'yyyy-mm-dd'), 9788970840658, 2, 1, 34201);
INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '서양화', '김서양', '서양화의 역사', to_date('2003-07-12', 'yyyy-mm-dd'), 9788970840657, 2, 1, 34202);
INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '미술사', '김미술', '미술의 역사', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840656, 2, 1, 34203);
INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '미술사2', '김미술2', '미술의 역사2', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840636, 2, 1, 34203);
INSERT INTO tb_book_test (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, price)
	VALUES (book_test_seq.NEXTVAL, '미술사3', '김미술3', '미술의 역사3', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840634, 2, 1, 34205);


INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 1, 1, 30000, 30, SYSDATE, 0);
INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 2, 1, 30010, 40, SYSDATE, 0);
INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 3, 1, 30030, 50, SYSDATE, 0);
INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 4, 1, 30040, 60, SYSDATE, 0);
INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 5, 1, 30040, 70, SYSDATE, 0);
INSERT INTO tb_order_test (order_uid, book_uid, account_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_test_seq.NEXTVAL, 1, 1, 30000, 70, SYSDATE, 0);



/*INSERT INTO tb_stock_test (stock_uid, book_uid)
	VALUES (stock_test_seq.NEXTVAL, 1);
INSERT INTO tb_stock_test (stock_uid, book_uid)
	VALUES (stock_test_seq.NEXTVAL, 2);
INSERT INTO tb_stock_test (stock_uid, book_uid)
	VALUES (stock_test_seq.NEXTVAL, 3);
INSERT INTO tb_stock_test (stock_uid, book_uid)
	VALUES (stock_test_seq.NEXTVAL, 4);*/



/*INSERT INTO tb_outbound_test (outbound_uid, book_uid, outbound_unit_price, outbound_quantitiy, outbound_state)
VALUES (outbound_test_seq.NEXTVAL, 
		(SELECT book_uid FROM tb_book_test WHERE book_isbn = 9788970840636), 
		3000, 
		(CASE WHEN 1 > (SELECT stock_quantity FROM v_book_stock_test WHERE book_isbn = 9788970840636)
		THEN (SELECT stock_quantity FROM v_book_stock_test WHERE book_isbn = 9788970840636) 
		ELSE 1 END)
		, 1)*/

/*SELECT 
			*       
		FROM 
			v_inbound_test
		WHERE 
			book_isbn = 9788970840659
		ORDER BY 
			book_uid DESC

			
SELECT 
			*       
		FROM 
			v_inbound_test
		WHERE 
			order_state IN (1, 2)
		ORDER BY 
			inbound_uid DESC
			
SELECT *       
FROM v_inbound_test
WHERE ORDER_STATE <= 3
ORDER BY book_uid;*/

/*SELECT B.* 
FROM tb_order_test A, tb_book_test B
WHERE A.BOOK_UID = B.BOOK_UID 
AND A.ORDER_UID IN (2, 1)
ORDER BY B.BOOK_UID DESC;*/

/*MERGE INTO tb_stock_test A
USING (SELECT * FROM tb_order_test WHERE order_uid IN (2, 3)) B
ON (A.BOOK_UID = B.BOOK_UID)
WHEN MATCHED THEN UPDATE SET A.STOCK_QUANTITY  = A.STOCK_QUANTITY + B.order_quantity; */


/*UPDATE tb_stock_test 
SET stock_quantity = stock_quantity + (SELECT order_quantity FROM tb_order_test WHERE order_uid = 1)
WHERE book_uid = (SELECT book_uid FROM tb_order_test WHERE order_uid = 1);*/

/*UPDATE tb_stock_test 
SET stock_quantity = stock_quantity + (SELECT order_quantity FROM tb_order_test WHERE order_uid IN (2, 3))
WHERE book_uid IN (SELECT book_uid FROM tb_order_test WHERE order_uid IN (2, 3));

SELECT *FROM tb_stock_test a, tb_order_test b WHERE a.book_uid = b.book_uid*/






/*DELETE FROM tb_publisher_test WHERE publisher_uid=3;*/


/*INSERT INTO tb_inbound_test (order_uid, book_uid, inbound_quantity)
SELECT order_uid, book_uid, order_quantity FROM tb_order_test WHERE order_uid IN (1,2,3);*/


/*INSERT INTO tb_inbound_test (order_uid)
SELECT order_uid FROM tb_order_test WHERE order_uid IN (1,2,3);*/

