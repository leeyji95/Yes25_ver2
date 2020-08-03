package com.lec.yes25.logistics;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class OutboundDTO {
	private int book_uid; 
	private int outbound_uid; 
	private int outbound_quantity; 
	private int outbound_unit_price; 
	private int outbound_state; 
	private Timestamp outbound_date;
	private int book_price; 
	private String book_subject; 
	private long book_isbn; 
	
	public String getOutbound_date(){
		return new SimpleDateFormat("yyyy-MM-dd").format(outbound_date);
	}
}
