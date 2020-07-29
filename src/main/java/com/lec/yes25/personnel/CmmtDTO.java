package com.lec.yes25.personnel;

import java.util.Date;

public class CmmtDTO {
	private int cmmtUid; // commute_uid
	private int username; // username
	private Date cmmtDate; // commute_date
	private Date cmmtStart; // commute_start
	private Date cmmtEnd; // commute_end
	private int cmmtOver; // commute_overtime
	private int cmmtTotal; // commute_total
	private String cmmtState; // commute_state
	private int cmmtIsApply; // commute_is_apply
	
	public CmmtDTO() {
		super();
	}
	
	public CmmtDTO(int cmmtUid, int username, Date cmmtDate, Date cmmtStart, Date cmmtEnd, int cmmtOver, int cmmtTotal,
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
	public Date getCmmtDate() {
		return cmmtDate;
	}
	public void setCmmtDate(Date cmmtDate) {
		this.cmmtDate = cmmtDate;
	}
	public Date getCmmtStart() {
		return cmmtStart;
	}
	public void setCmmtStart(Date cmmtStart) {
		this.cmmtStart = cmmtStart;
	}
	public Date getCmmtEnd() {
		return cmmtEnd;
	}
	public void setCmmtEnd(Date cmmtEnd) {
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
