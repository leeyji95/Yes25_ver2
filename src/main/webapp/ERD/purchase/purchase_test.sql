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

-------------------------------

CREATE OR REPLACE VIEW v_Order
AS SELECT
	O.order_uid ord_uid,
	O.order_set_uid ord_set_uid,
	O.order_date ord_date,
	O.publisher_uid pub_uid,
	P.publisher_name pub_name,
	P.publisher_rep pub_rep,
	P.publisher_contact pub_contact,
	P.publisher_address pub_address,
	B.book_uid,
	B.book_subject,
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

SELECT
	COUNT(*)
FROM 
	v_Order
WHERE
	LOWER(pub_name) LIKE LOWER ('%'||''||'%') AND
	LOWER(book_subject) LIKE LOWER('%'||''||'%') 
	AND ord_date >= '2020-07-01'
	AND ord_date < '2020-08-02'
GROUP BY ord_set_uid;

DELETE FROM TB_ORDER;
SELECT * FROM TB_ORDER;

SELECT COUNT(DISTINCT ORD_SET_UID) FROM V_ORDER;
SELECT
	rnum,
	ord_set_uid,
	ord_date,
	pub_uid,
	pub_name
FROM
	(SELECT
		Rownum AS rnum, T.* 
	FROM 
		(SELECT DISTINCT
			ord_set_uid,
			ord_date,
			pub_uid,
			pub_name
		FROM v_Order
		WHERE
			LOWER(pub_name) LIKE LOWER ('%'||''||'%') 
			AND LOWER(book_subject) LIKE LOWER('%'||''||'%')
			AND ord_date >= '2020-08-01'
			AND ord_date < '2020-08-31'
		ORDER BY ord_date DESC) T)
WHERE RNUM >= 1 AND RNUM < 11; 

SELECT
	rnum,
	ord_uid,
	ord_set_uid,
	ord_date,
	pub_uid,
	pub_name,
	book_uid,
	book_subject,
	ord_unit_cost,
	ord_quantity,
	ord_state
FROM
	(SELECT
		Rownum AS rnum, t.* 
	FROM 
		(SELECT * FROM v_Order
	WHERE
		LOWER(pub_name) LIKE LOWER ('%'||''||'%') AND
		LOWER(book_subject) LIKE LOWER('%'||''||'%')
		AND ord_date >= '2020-08-01'
		AND ord_date < '2020-08-02'
		ORDER BY ord_date DESC) T)
WHERE RNUM >= 1 AND RNUM < 11;


