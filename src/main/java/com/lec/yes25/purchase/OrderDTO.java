package com.lec.yes25.purchase;

import java.sql.Date;

import javax.validation.constraints.Min;

import com.fasterxml.jackson.annotation.JsonFormat;

public class OrderDTO implements DTO {
	private int ord_uid;
	private int ord_set_uid;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date ord_date;
	private int pub_uid;
	private String pub_name;
	private String pub_num;
	private String pub_rep;
	private String pub_contact;
	private String pub_address;
	private int book_uid;
	private String book_subject;
	private String book_author;
	@Min(value=1, message="1 이상의 숫자를 입력해 주세요!")
	private int ord_unit_cost;
	@Min(value=1, message="1 이상의 숫자를 입력해 주세요!")
	private int ord_quantity;
	private int ord_state;
	
	public OrderDTO() {
		super();
	}

	public OrderDTO(int ord_uid, int ord_set_uid, Date ord_date, int pub_uid, String pub_name, String pub_num,
			String pub_rep, String pub_contact, String pub_address, int book_uid, String book_subject,
			String book_author, @Min(value = 1, message = "1 이상의 숫자를 입력해 주세요!") int ord_unit_cost,
			@Min(value = 1, message = "1 이상의 숫자를 입력해 주세요!") int ord_quantity, int ord_state) {
		super();
		this.ord_uid = ord_uid;
		this.ord_set_uid = ord_set_uid;
		this.ord_date = ord_date;
		this.pub_uid = pub_uid;
		this.pub_name = pub_name;
		this.pub_num = pub_num;
		this.pub_rep = pub_rep;
		this.pub_contact = pub_contact;
		this.pub_address = pub_address;
		this.book_uid = book_uid;
		this.book_subject = book_subject;
		this.book_author = book_author;
		this.ord_unit_cost = ord_unit_cost;
		this.ord_quantity = ord_quantity;
		this.ord_state = ord_state;
	}

	// getter & setter
	public int getOrd_uid() {
		return ord_uid;
	}
	public void setOrd_uid(int ord_uid) {
		this.ord_uid = ord_uid;
	}
	public int getOrd_set_uid() {
		return ord_set_uid;
	}
	public void setOrd_set_uid(int ord_set_uid) {
		this.ord_set_uid = ord_set_uid;
	}
	public Date getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(Date ord_date) {
		this.ord_date = ord_date;
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
	public String getPub_num() {
		return pub_num;
	}
	public void setPub_num(String pub_num) {
		this.pub_num = pub_num;
	}
	public String getPub_rep() {
		return pub_rep;
	}
	public void setPub_rep(String pub_rep) {
		this.pub_rep = pub_rep;
	}
	public String getPub_contact() {
		return pub_contact;
	}
	public void setPub_contact(String pub_contact) {
		this.pub_contact = pub_contact;
	}
	public String getPub_address() {
		return pub_address;
	}
	public void setPub_address(String pub_address) {
		this.pub_address = pub_address;
	}
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
	public String getBook_author() {
		return book_author;
	}
	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
	public int getOrd_unit_cost() {
		return ord_unit_cost;
	}
	public void setOrd_unit_cost(int ord_unit_cost) {
		this.ord_unit_cost = ord_unit_cost;
	}
	public int getOrd_quantity() {
		return ord_quantity;
	}
	public void setOrd_quantity(int ord_quantity) {
		this.ord_quantity = ord_quantity;
	}
	public int getOrd_state() {
		return ord_state;
	}
	public void setOrd_state(int ord_state) {
		this.ord_state = ord_state;
	}

}
