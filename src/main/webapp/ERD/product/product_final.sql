--테이블삭제
DROP TABLE tb_publisher CASCADE CONSTRAINT purge;
DROP TABLE tb_category CASCADE CONSTRAINT purge;
DROP TABLE tb_book CASCADE CONSTRAINT purge;
DROP TABLE tb_attach CASCADE CONSTRAINT purge;

--시퀀스삭제
DROP SEQUENCE publisher_seq;
DROP SEQUENCE book_seq;
DROP SEQUENCE attach_seq;

--시퀀스생성
CREATE SEQUENCE publisher_seq;
CREATE SEQUENCE book_seq;
CREATE SEQUENCE attach_seq;

--테이블생성
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

--뷰 생성
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
ORDER BY root.CATEGORY_NAME, down1.CATEGORY_NAME, down2.CATEGORY_NAME 
;
--샘플 데이터
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

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '길벗', '02-6522-6511', '김재훈', '구매부', '서울 서초구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '한빛', '02-1232-6511', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '프리렉', '02-1332-6511', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '다락원', '02-1243-6511', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '도우출판', '02-1221-6511', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '제이펍', '02-1232-6521', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '나라원', '02-1232-6541', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_PUBLISHER 
	(PUBLISHER_UID, PUBLISHER_NAME, PUBLISHER_NUM, PUBLISHER_REP, PUBLISHER_CONTACT, PUBLISHER_ADDRESS) 
VALUES
	(publisher_seq.nextval, '넥서스', '02-1232-1511', '이재훈', '총부부', '서울 동작구');

INSERT INTO TB_BOOK 
	(BOOK_UID, BOOK_SUBJECT, BOOK_AUTHOR, BOOK_CONTENT, BOOK_PUBDATE, BOOK_REGDATE, BOOK_ISBN, CATEGORY_UID, PUBLISHER_UID) 
VALUES
	(book_seq.nextval, '자바의 정석', '제임스', '자바를 배워봅시다', SYSDATE, SYSDATE, '12435', 15, 2);

INSERT INTO TB_BOOK 
	(BOOK_UID, BOOK_SUBJECT, BOOK_AUTHOR, BOOK_CONTENT, BOOK_PUBDATE, BOOK_REGDATE, BOOK_ISBN, CATEGORY_UID, PUBLISHER_UID) 
VALUES
	(book_seq.nextval, 'C를 배워보자', '고슬링', 'C를 배워봅시다', SYSDATE, SYSDATE, '12435', 16, 1);
