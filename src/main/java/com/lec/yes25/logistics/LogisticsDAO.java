package com.lec.yes25.logistics;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface LogisticsDAO {
	public int countAll();
	public List<OrderDTO> selectFromOrder();
	public List<OrderDTO> searchByIsbnFromOrder(String book_isbn);
	public List<InboundDTO> searchByIsbnFromInbound(String book_isbn);
	public int insertIntoInbound( int order_uid);
	public int updateByUidInStockFromInbound(int order_uid);
	public int updateByUidIntoOrder(int order_uid);

	public List<BookDTO> selectFromBook();
	public List<BookDTO> searchByIsbnFromBook(String book_isbn);
	public List<OutboundDTO> searchByIsbnFromOutbound(String book_isbn);
	public int insertIntoOutbound(long book_isbn, int outbound_unit_price, int outbound_quantitiy);
	public int updateByUidInStockFromOutbound(long book_isbn, int outbound_quantitiy);
	
	public List<BookDTO> selectByFilter(int classification, String keyword, int category_uid, String fromDate, String toDate);
}
