package com.lec.yes25.financial.ajax;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.lec.yes25.financial.bean.FinancialDTO;

public class AjaxDetailViewResult extends AjaxWriteResult {
	@JsonProperty("data")
	private FinancialDTO list;	// 데이터 목록

	// getter, setter
	public FinancialDTO getList() {
		return list;
	}

	public void setList(FinancialDTO list) {
		this.list = list;
	}
	
}