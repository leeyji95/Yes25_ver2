--테이블 삭제
DROP TABLE tb_publisher CASCADE CONSTRAINT purge;
DROP TABLE tb_book CASCADE CONSTRAINT purge;
DROP TABLE tb_category CASCADE CONSTRAINT purge;
DROP TABLE tb_order CASCADE CONSTRAINT purge;
DROP TABLE tb_stock CASCADE CONSTRAINT purge;
DROP TABLE tb_inbound CASCADE CONSTRAINT purge;
DROP TABLE tb_outbound CASCADE CONSTRAINT purge;
DROP TABLE tb_calendar CASCADE CONSTRAINT purge;


-- 시퀀스 삭제
DROP SEQUENCE publisher_seq;
DROP SEQUENCE book_seq;
DROP SEQUENCE category_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE stock_seq;
DROP SEQUENCE inbound_seq;
DROP SEQUENCE outbound_seq;
DROP SEQUENCE calendar_seq;



--시퀀스 생성
CREATE SEQUENCE publisher_seq;
CREATE SEQUENCE book_seq;
CREATE SEQUENCE category_seq;
CREATE SEQUENCE order_seq;
CREATE SEQUENCE stock_seq;
CREATE SEQUENCE inbound_seq;
CREATE SEQUENCE outbound_seq;
CREATE SEQUENCE calendar_seq;


DROP VIEW v_inbound;
DROP VIEW v_outbound;
DROP VIEW v_book_stock;

--테이블 생성

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
       
CREATE TABLE tb_order
(
    order_uid          NUMBER    UNIQUE NOT NULL,
    order_set_uid      NUMBER    NOT NULL,
    book_uid           NUMBER    NOT NULL, 
    publisher_uid      NUMBER    NOT NULL, 
    order_unit_cost    INT       NOT NULL, 
    order_quantity     INT       NOT NULL, 
    order_date         DATE      DEFAULT SYSDATE NOT NULL, 
    order_state        INT       DEFAULT 0 NOT NULL, 
    CONSTRAINT TB_ORDER_PK PRIMARY KEY (order_set_uid, book_uid, publisher_uid)
);

ALTER TABLE tb_order
    ADD CONSTRAINT FK_tb_order_book_uid_tb_book FOREIGN KEY (book_uid)
        REFERENCES tb_book (book_uid);



CREATE TABLE tb_stock
(
    stock_uid    NUMBER    NOT NULL, 
    book_uid     NUMBER    UNIQUE NOT NULL, 
    stock_quantity        NUMBER    DEFAULT 0 NOT NULL,
    CONSTRAINT TB_STOCK_PK PRIMARY KEY (stock_uid),
    CONSTRAINT check_stock_quantity CHECK (stock_quantity >= 0 )
);

ALTER TABLE tb_stock
    ADD CONSTRAINT FK_tb_stock_book_uid_tb FOREIGN KEY (book_uid)
        REFERENCES tb_book (book_uid);


CREATE TABLE tb_inbound
(
    inbound_uid         NUMBER    NOT NULL, 
    order_uid           NUMBER    NOT NULL,
    inbound_date        DATE      DEFAULT SYSDATE NOT NULL,
    CONSTRAINT TB_INBOUND_PK PRIMARY KEY (inbound_uid)
);

ALTER TABLE tb_inbound
    ADD CONSTRAINT FK_tb_inbound_order_uid FOREIGN KEY (order_uid)
        REFERENCES tb_order (order_uid);

CREATE TABLE tb_outbound
(
    outbound_uid           NUMBER          NOT NULL,
    book_uid               NUMBER          NOT NULL,
    outbound_quantity      VARCHAR2(20)    DEFAULT '0' NOT NULL, 
    outbound_unit_price    VARCHAR2(20)    NOT NULL,
    outbound_state         NUMBER          NOT NULL,
    outbound_date          DATE            DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT TB_OUTBOUND_PK PRIMARY KEY (outbound_uid)
);

ALTER TABLE tb_outbound
    ADD CONSTRAINT FK_tb_outbound_book_uid FOREIGN KEY (book_uid)
        REFERENCES tb_book (book_uid);

CREATE OR REPLACE TRIGGER tb_outbound_AI_TRG
BEFORE INSERT ON tb_outbound 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT outbound_seq.NEXTVAL
    INTO :NEW.outbound_uid 
    FROM DUAL;
END;



CREATE TABLE tb_calendar
(
	c_uid         NUMBER        NOT NULL,
	c_month       NUMBER        NOT NULL, 
    c_day        NUMBER        NOT NULL, 
    CONSTRAINT TB_CALENDAR_PK PRIMARY KEY (c_uid),
    CONSTRAINT check_c_month CHECK (c_month >= 1 AND c_month <=12 ),
    CONSTRAINT c_day CHECK (c_day >= 1 AND c_day <=31 )
);


CREATE OR REPLACE VIEW v_inbound
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
FROM tb_order A, tb_book B, tb_inbound C
WHERE A.book_uid = B.book_uid AND A.order_uid = C.order_uid;

CREATE OR REPLACE VIEW v_book_order
AS SELECT A.book_uid
		, A.book_subject
		, A.book_isbn
		, B.order_uid
		, B.order_unit_cost
		, B.order_quantity
		, B.order_date
		, B.order_state
FROM tb_book A, tb_order B
WHERE A.book_uid = B.book_uid;

CREATE OR REPLACE VIEW v_outbound
AS SELECT A.book_uid
			, C.outbound_uid
			, C.outbound_quantity
			, C.outbound_unit_price
			, C.outbound_state
			, C.outbound_date
			, B.book_price
			, B.book_subject
			, B.book_isbn
FROM tb_stock A, tb_book B, tb_outbound C
WHERE A.book_uid = B.book_uid AND A.book_uid = C.book_uid;


CREATE OR REPLACE VIEW v_book_stock
AS SELECT A.book_uid
		, A.book_subject
		, A.book_isbn
		, A.book_author
		, A.book_price
		, A.book_pubdate
		, B.stock_uid
		, B.stock_quantity
		, C.category_uid
		, C.category_name
		, D.PUBLISHER_UID
		, D.publisher_name
FROM tb_book A, tb_stock B, tb_category C, tb_publisher D
WHERE A.book_uid = B.book_uid
AND A.category_uid = C.CATEGORY_UID 
AND A.PUBLISHER_UID = D.PUBLISHER_UID 
;



SELECT * FROM tb_stock;
SELECT * FROM tb_inbound;
SELECT * FROM tb_outbound;
SELECT * FROM tb_book;
SELECT * FROM tb_category;
SELECT * FROM tb_publisher;
SELECT * FROM tb_order;
SELECT * FROM v_inbound;
SELECT * FROM v_outbound;
SELECT * FROM v_book_stock;
SELECT * FROM tb_calendar;


INSERT INTO tb_category (category_uid, category_name, category_parent)
	VALUES (category_seq.NEXTVAL, '문학', NULL);
INSERT INTO tb_category (category_uid, category_name, category_parent)
	VALUES (category_seq.NEXTVAL, '소설', 2);

INSERT INTO tb_publisher (publisher_uid, publisher_name, publisher_num, publisher_rep, publisher_contact, publisher_address)
	VALUES (publisher_seq.NEXTVAL, '예경', 2, '김예경', 1, '서울시');

INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '서양미술사', '곰브리치', '서양 미술의 역사', to_date('2003-07-10', 'yyyy-mm-dd'), 9788970840659, 2, 1, 34200);
INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '동양미술사', '김동양', '동양 미술의 역사', to_date('2003-07-11', 'yyyy-mm-dd'), 9788970840658, 2, 1, 34201);
INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '서양화', '김서양', '서양화의 역사', to_date('2003-07-12', 'yyyy-mm-dd'), 9788970840657, 2, 1, 34202);
INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '미술사', '김미술', '미술의 역사', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840656, 2, 1, 34203);
INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '미술사2', '김미술2', '미술의 역사2', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840636, 2, 1, 34203);
INSERT INTO tb_book (book_uid, book_subject, book_author, book_content, book_pubdate, book_isbn, category_uid, publisher_uid, book_price)
	VALUES (book_seq.NEXTVAL, '미술사3', '김미술3', '미술의 역사3', to_date('2003-07-13', 'yyyy-mm-dd'), 9788970840634, 2, 1, 34205);


INSERT INTO tb_order (order_uid, order_set_uid, book_uid, publisher_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_seq.NEXTVAL, 1, 1, 1, 30000, 30, SYSDATE, 0);
INSERT INTO tb_order (order_uid, order_set_uid, book_uid, publisher_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_seq.NEXTVAL, 2, 1, 1, 30010, 40, SYSDATE, 0);
INSERT INTO tb_order (order_uid, order_set_uid, book_uid, publisher_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_seq.NEXTVAL, 3, 1, 1, 30030, 50, SYSDATE, 0);
INSERT INTO tb_order (order_uid, order_set_uid, book_uid, publisher_uid, order_unit_cost, order_quantity, order_date, order_state)
	VALUES (order_seq.NEXTVAL, 4, 1, 1, 30040, 60, SYSDATE, 0);
INSERT INTO tb_order (order_uid, order_set_uid, book_uid, publisher_uid, order_unit_cost, order_quantity, order_date, order_statee)
	VALUES (order_seq.NEXTVAL, 5, 1, 1, 30040, 70, SYSDATE, 0);



DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 1, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;

DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 2, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;

DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 3, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;

DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 4, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;

DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 5, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 6, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 7, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 8, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 9, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 10, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 11, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;
DECLARE a_cnt NUMBER := 1;
BEGIN DBMS_OUTPUT.ENABLE;
LOOP INSERT INTO tb_calendar(c_uid, c_month, c_day) VALUES(calendar_seq.NEXTVAL, 12, a_cnt);
a_cnt := a_cnt+1;
EXIT WHEN a_cnt > 31;
END LOOP;
END;





