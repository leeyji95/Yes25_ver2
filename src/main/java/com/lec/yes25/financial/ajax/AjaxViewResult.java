package com.lec.yes25.financial.ajax;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.lec.yes25.financial.bean.FinancialDTO;

public class AjaxViewResult extends AjaxWriteResult {
	@JsonProperty("data")
	private List<FinancialDTO> list;	// 데이터 목록

	// 생성자
	public AjaxViewResult() {}
	
	// getter setter
	public List<FinancialDTO> getList() {
		return list;
	}
	public void setList(List<FinancialDTO> list) {
		this.list = list;
	}
	
}