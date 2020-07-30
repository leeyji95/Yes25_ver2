package com.lec.yes25.purchase;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BookDTO implements DTO {
	private int book_uid;
	private String book_subject;
	private int ctg_uid;
	private String ctg_name; 
	private String book_author;
	private int pub_uid;
	private String pub_name;
	private String book_content;
	private int book_price;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date book_pubdate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date book_regdate;
	private int book_isbn;

	public BookDTO() {
		super();
	}

	public BookDTO(int book_uid, String book_subject, int ctg_uid, String ctg_name, String book_author, int pub_uid,
			String pub_name, String book_content, int book_price, Date book_pubdate, Date book_regdate, int book_isbn) {
		super();
		this.book_uid = book_uid;
		this.book_subject = book_subject;
		this.ctg_uid = ctg_uid;
		this.ctg_name = ctg_name;
		this.book_author = book_author;
		this.pub_uid = pub_uid;
		this.pub_name = pub_name;
		this.book_content = book_content;
		this.book_price = book_price;
		this.book_pubdate = book_pubdate;
		this.book_regdate = book_regdate;
		this.book_isbn = book_isbn;
	}

	// getter & setter
	public int getBook_uid() {
		return book_uid;
	}
	public void setBook_uid(int book_uid) {
		this.book_uid = book_uid;
	}
	public String getBook_subject() {
		return book_subject;
	}
	public void setBook_subject(String book_subject) {
		this.book_subject = book_subject;
	}
	public int getCtg_uid() {
		return ctg_uid;
	}
	public void setCtg_uid(int ctg_uid) {
		this.ctg_uid = ctg_uid;
	}
	public String getCtg_name() {
		return ctg_name;
	}
	public void setCtg_name(String ctg_name) {
		this.ctg_name = ctg_name;
	}
	public String getBook_author() {
		return book_author;
	}
	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
	public int getPub_uid() {
		return pub_uid;
	}
	public void setPub_uid(int pub_uid) {
		this.pub_uid = pub_uid;
	}
	public String getPub_name() {
		return pub_name;
	}
	public void setPub_name(String pub_name) {
		this.pub_name = pub_name;
	}
	public String getBook_content() {
		return book_content;
	}
	public void setBook_content(String book_content) {
		this.book_content = book_content;
	}
	public int getBook_price() {
		return book_price;
	}
	public void setBook_price(int book_price) {
		this.book_price = book_price;
	}
	public Date getBook_pubdate() {
		return book_pubdate;
	}
	public void setBook_pubdate(Date book_pubdate) {
		this.book_pubdate = book_pubdate;
	}
	public Date getBook_regdate() {
		return book_regdate;
	}
	public void setBook_regdate(Date book_regdate) {
		this.book_regdate = book_regdate;
	}
	public int getBook_isbn() {
		return book_isbn;
	}
	public void setBook_isbn(int book_isbn) {
		this.book_isbn = book_isbn;
	}
}
