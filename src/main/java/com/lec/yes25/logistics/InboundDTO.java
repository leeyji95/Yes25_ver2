package com.lec.yes25.logistics;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class InboundDTO {
	private int inbound_uid; 
	private int order_uid; 
	private int book_uid; 
	private int order_unit_cost; 
	private int order_quantity; 
	private Timestamp order_date;
	private int order_state; 
	private String book_subject; 
	private long book_isbn; 
	private Timestamp inbound_date; 
	
	
	public String getOrder_date(){
		return new SimpleDateFormat("yyyy-MM-dd").format(order_date);
	}
	
	public String getInbound_date(){
		return new SimpleDateFormat("yyyy-MM-dd").format(inbound_date);
	}
}
