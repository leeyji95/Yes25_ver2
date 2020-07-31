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

------------------------------

CREATE TABLE tb_order
(
    order_uid          NUMBER    NOT NULL, 
    book_uid           NUMBER    NOT NULL, 
    publisher_uid      NUMBER    NOT NULL, 
    order_unit_cost    INT       NOT NULL, 
    order_quantity     INT       NOT NULL, 
    order_date         DATE      DEFAULT SYSDATE NOT NULL, 
    order_state        INT       DEFAULT 0 NOT NULL, 
    CONSTRAINT tb_order_pk PRIMARY KEY (order_uid, book_uid, publisher_uid)
);

DROP TABLE tb_order CASCADE CONSTRAINT purge;
INSERT INTO tb_order VALUES (order_seq.nextval, 297, 11, 1, 1, sysdate, 0);
INSERT INTO tb_order VALUES (order_seq.nextval, 296, 13, 1, 1, sysdate, 0);
SELECT * FROM tb_order;
-------------------------------

CREATE OR REPLACE VIEW v_Order
AS SELECT
	o.order_uid ord_uid,
	o.order_date ord_date,
	o.publisher_uid pub_uid,
	p.publisher_name pub_name,
	b.book_uid,
	b.book_subject,
	o.order_unit_cost ord_unit_cost,
	o.order_quantity ord_quantity,
	o.order_state ord_state
FROM
	tb_publisher p INNER JOIN tb_book b
	ON p.publisher_uid = b.publisher_uid
	INNER JOIN tb_order o
	ON b.publisher_uid = o.publisher_uid AND b.book_uid = o.book_uid;

------------------------------

DECLARE num number := 1;
BEGIN
  WHILE (num <= 100) LOOP
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'A출판사'||publisher_seq.nextval, '111-11-111'||MOD(publisher_seq.nextval,10)||MOD(publisher_seq.nextval,10), 'A대표자'||publisher_seq.nextval, '010-1111-1111', '주소'||publisher_seq.nextval);
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'B출판사'||publisher_seq.nextval, '222-22-222'||MOD(publisher_seq.nextval,10)||MOD(publisher_seq.nextval,10), 'B대표자'||publisher_seq.nextval, '010-2222-2222', '주소'||publisher_seq.nextval);
	INSERT INTO tb_publisher VALUES (publisher_seq.nextval, 'C출판사'||publisher_seq.nextval, '333-33-333'||MOD(publisher_seq.nextval,10)||MOD(publisher_seq.nextval,10), 'C대표자'||publisher_seq.nextval, '010-3333-3333', '주소'||publisher_seq.nextval);
    num := num + 1;
  END LOOP;
END;

------------------------------

DECLARE num number := 1;
BEGIN
  WHILE (num <= 100) LOOP
	INSERT INTO tb_book VALUES (book_seq.nextval, '자바의 정석'||book_seq.nextval, '남궁성', 'IT 서적입니다.', 22000, sysdate, sysdate, 000||book_seq.nextval, 1, 10);
	INSERT INTO tb_book VALUES (book_seq.nextval, '라플라스의 마녀'||book_seq.nextval, '히가시노 게이고', '소설입니다.', 18000, sysdate, sysdate, 000||book_seq.nextval, 2, 11);
	INSERT INTO tb_book VALUES (book_seq.nextval, ''||book_seq.nextval, '어떤저자', 'IT 서적입니다.', 20000, sysdate, sysdate, 000||book_seq.nextval, 1, 12);
    num := num + 1;
  END LOOP;
END;

INTO tb_order (
	order_uid, 
    book_uid,
    publisher_uid,
    order_unit_cost, 
    order_quantity,
    order_date,
    order_state
	)
VALUES (
	order_seq.nextval,
	#{item.book_uid},
	#{item.pub_uid},
	#{item.ord_unit_cost},
	#{item.ord_quantity},
	SYSDATE,
	0
	);