package com.lec.yes25.financial.bean;

//account_uid     NUMBER           NOT NULL, 
//account_name    VARCHAR2(100)    NOT NULL, 

public class AccountDTO {
	private int account_uid;
	private String account_name;

	
	// getter, getter
	public int getAccount_uid() {
		return account_uid;
	}
	public void setAccount_uid(int account_uid) {
		this.account_uid = account_uid;
	}
	
	public String getAccount_name() {
		return account_name;
	}
	public void setAccount_name(String account_name) {
		this.account_name = account_name;
	}

}