package com.lec.yes25.personnel;

import java.util.Date;

public class CmmtDTO {
	private int cmmtUid; // commute_uid
	private int username; // username
	private String cmmtDate; // commute_date
	private String cmmtStart; // commute_start
	private String cmmtEnd; // commute_end
	private int cmmtOver; // commute_overtime
	private int cmmtTotal; // commute_total
	private String cmmtState; // commute_state
	private int cmmtIsApply; // commute_is_apply
	
	public CmmtDTO() {
		super();
	}
	
	public CmmtDTO(int cmmtUid, int username, String cmmtDate, String cmmtStart, String cmmtEnd, int cmmtOver, int cmmtTotal,
			String cmmtState, int cmmtIsApply) {
		super();
		this.cmmtUid = cmmtUid;
		this.username = username;
		this.cmmtDate = cmmtDate;
		this.cmmtStart = cmmtStart;
		this.cmmtEnd = cmmtEnd;
		this.cmmtOver = cmmtOver;
		this.cmmtTotal = cmmtTotal;
		this.cmmtState = cmmtState;
		this.cmmtIsApply = cmmtIsApply;
	}
	
	public int getCmmtUid() {
		return cmmtUid;
	}
	public void setCmmtUid(int cmmtUid) {
		this.cmmtUid = cmmtUid;
	}
	public int getUsername() {
		return username;
	}
	public void setUsername(int username) {
		this.username = username;
	}
	public String getCmmtDate() {
		return cmmtDate;
	}
	public void setCmmtDate(String cmmtDate) {
		this.cmmtDate = cmmtDate;
	}
	public String getCmmtStart() {
		return cmmtStart;
	}
	public void setCmmtStart(String cmmtStart) {
		this.cmmtStart = cmmtStart;
	}
	public String getCmmtEnd() {
		return cmmtEnd;
	}
	public void setCmmtEnd(String cmmtEnd) {
		this.cmmtEnd = cmmtEnd;
	}
	public int getCmmtOver() {
		return cmmtOver;
	}
	public void setCmmtOver(int cmmtOver) {
		this.cmmtOver = cmmtOver;
	}
	public int getCmmtTotal() {
		return cmmtTotal;
	}
	public void setCmmtTotal(int cmmtTotal) {
		this.cmmtTotal = cmmtTotal;
	}
	public String getCmmtState() {
		return cmmtState;
	}
	public void setCmmtState(String cmmtState) {
		this.cmmtState = cmmtState;
	}
	public int getCmmtIsApply() {
		return cmmtIsApply;
	}
	public void setCmmtIsApply(int cmmtIsApply) {
		this.cmmtIsApply = cmmtIsApply;
	}
	
	 
}
