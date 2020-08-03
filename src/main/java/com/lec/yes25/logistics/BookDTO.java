package com.lec.yes25.logistics;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class BookDTO {
	int book_uid; 
	String book_subject;
	long book_isbn; 
	String book_author;
	int book_price;
	Timestamp book_pubdate;
	int stock_uid; 
	int stock_quantity;
	int category_uid;
	String category_name;
	int publisher_uid;
	String publisher_name;
	
	public String getBook_pubdate(){
		return new SimpleDateFormat("yyyy-MM-dd").format(book_pubdate);
	}
	
}



