package com.lec.yes25.personnel;

public class AjaxWriteResult {

	private int count; // insert 데이터 개수
	private int countUpdate; // update 데이터 개수
	private String status; // 처리결과
	private String message; // 결과 메세지

	public AjaxWriteResult() {
		super();
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	public int getCountUpdate() {
		return countUpdate;
	}

	public void setCountUpdate(int countUpdate) {
		this.countUpdate = countUpdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
