package com.lec.yes25.financial.ajax;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.lec.yes25.financial.bean.AccountDTO;

public class AjaxAccountResult extends AjaxWriteResult {
	@JsonProperty("data")
	private List<AccountDTO> list;	// 데이터 목록

	
	// setter, getter
	public List<AccountDTO> getList() {
		return list;
	}
	public void setList(List<AccountDTO> list) {
		this.list = list;
	}

}