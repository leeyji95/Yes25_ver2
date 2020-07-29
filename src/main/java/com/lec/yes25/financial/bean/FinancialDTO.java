package com.lec.yes25.financial.bean;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

//stmt_uid         NUMBER    NOT NULL, 전표식별번호
//stmt_date        DATE      NOT NULL, 전표 발행일자
//account_uid      NUMBER    NOT NULL, 계정과목 번호
//stmt_summary     CLOB      NOT NULL, 적요
//stmt_sum         NUMBER    NOT NULL, 금액
//stmt_writer      NUMBER    NOT NULL, 작성자
//stmt_manager     NUMBER    NOT NULL, 담당자
//stmt_approver    NUMBER    NOT NULL, 결제자
//stmt_proceed     NUMBER    DEFAULT 1 NOT NULL, 결제프로세서

public class FinancialDTO {
	private int stmt_uid;		// stmt_uid, 전표식별번호
	private Timestamp regDate;	// stmt_date , 전표 발행일자
	private int account_uid;	// account_uid, 계정과목 번호
	private String summary;	//stmt_summary, 적요
	private int money;		//stmt_sum, 금액
	private int writer;		//stmt_writer, 작성자
	private int manager;	//stmt_manager, 담당자
	private int approver;	//stmt_approver, 결제자
	private int proceed;	//stmt_proceed, 결제진행사항
	
	// 생성자 생성
	public FinancialDTO() {}
	public FinancialDTO(int stmt_uid, Timestamp regDate, int account_uid, String summary, int money, int writer,
			int manager, int approver, int proceed) {
		super();
		this.stmt_uid = stmt_uid;
		this.regDate = regDate;
		this.account_uid = account_uid;
		this.summary = summary;
		this.money = money;
		this.writer = writer;
		this.manager = manager;
		this.approver = approver;
		this.proceed = proceed;
	}


	// getter setter
	public int getStmt_uid() {
		return stmt_uid;
	}
	public void setStmt_uid(int stmt_uid) {
		this.stmt_uid = stmt_uid;
	}
	
	public String getRegDate() {
		return new SimpleDateFormat("yyyy-MM-dd").format(regDate);
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	public int getAccount_uid() {
		return account_uid;
	}
	public void setAccount_uid(int account_uid) {
		this.account_uid = account_uid;
	}
	
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	
	public int getManager() {
		return manager;
	}
	public void setManager(int manager) {
		this.manager = manager;
	}
	
	public int getApprover() {
		return approver;
	}
	public void setApprover(int approver) {
		this.approver = approver;
	}
	
	public int getProceed() {
		return proceed;
	}
	public void setProceed(int proceed) {
		this.proceed = proceed;
	}
}