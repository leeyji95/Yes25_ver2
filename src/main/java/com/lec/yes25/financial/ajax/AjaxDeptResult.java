package com.lec.yes25.financial.ajax;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.lec.yes25.personnel.UserDTO;

public class AjaxDeptResult extends AjaxWriteResult {
	@JsonProperty("data")
	public UserDTO list;
	
	// 생성자
	public AjaxDeptResult() {}

	// setter, getter
	public UserDTO getList() {
		return list;
	}
	public void setList(UserDTO list) {
		this.list = list;
	}
	
}