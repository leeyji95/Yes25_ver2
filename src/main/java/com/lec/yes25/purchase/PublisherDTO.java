package com.lec.yes25.purchase;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

public class PublisherDTO implements DTO {
	private int pub_uid;
	@NotEmpty(message="거래처명을 입력해 주세요!")
	@Pattern(regexp="^[가-힣a-zA-Z0-9]+( [가-힣a-zA-Z0-9]+)*$", message="거래처명 형식이 잘못되었습니다.")
	private String pub_name;
	@NotEmpty(message="사업자 등록번호를 입력해 주세요!")
	@Pattern(regexp="^([0-9]{3})-([0-9]{2})-([0-9]{5})$", message="사업자 등록번호 형식이 잘못되었습니다.")
	private String pub_num;
	@NotEmpty(message="대표자명을 입력해 주세요!")
	@Pattern(regexp="^[가-힣a-zA-Z]{2,}$", message="대표자명 형식이 잘못되었습니다.")
	private String pub_rep;
	@NotEmpty(message="연락처를 입력해 주세요!")
	@Pattern(regexp="^(010|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$", message="연락처 형식이 잘못되었습니다.")
	private String pub_contact;
	@NotEmpty(message="주소를 입력해 주세요!")
	private String pub_address;
	
	public PublisherDTO() {
		super();
	}

	public PublisherDTO(int pub_uid, String pub_name, String pub_num, String pub_rep, String pub_contact,
			String pub_address) {
		super();
		this.pub_uid = pub_uid;
		this.pub_name = pub_name;
		this.pub_num = pub_num;
		this.pub_rep = pub_rep;
		this.pub_contact = pub_contact;
		this.pub_address = pub_address;
	}
	
	// getter & setter
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
}
