package com.lec.yes25.logistics;

import java.util.List;

import lombok.Data;

@Data
public class LogisticsAjaxWriteList extends LogisticAjaxWriteResult {
	private List<?> data;

}
