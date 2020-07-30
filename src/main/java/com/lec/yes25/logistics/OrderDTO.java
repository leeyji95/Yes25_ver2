package com.lec.yes25.logistics;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class OrderDTO {
	
	private int book_uid;
	private String book_subject;
	private Long book_isbn;
	private int order_unit_cost;
	private int order_quantity;
	private int order_uid;
	private Timestamp order_date;
	private int order_state;
	
	public String getOrder_date(){
		return new SimpleDateFormat("yyyy-MM-dd").format(order_date);
	}
}
