package com.lec.yes25.logistics;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface LogisticsDAO {
	public int countAll();
	public List<OrderDTO> selectFromOrder();
	public List<OrderDTO> searchByIsbnFromOrder(String book_isbn);
	public List<InboundDTO> searchByIsbnFromInbound(String book_isbn);
	/*
	 * public int insertIntoInbound(int order_uid); public int
	 * updateByUidInStockFromInbound(int order_uid); public int
	 * updateByUidIntoOrder(int order_uid);
	 */

	public int insertIntoInbound2(int [] order_uids);
	public int updateByUidInStockFromInbound2(int [] order_uids);
	public int updateByUidIntoOrder2(int [] order_uids);

	public List<BookDTO> selectFromBook();
	public List<BookDTO> searchByIsbnFromBook(String book_isbn);
	public List<OutboundDTO> searchByIsbnFromOutbound(String book_isbn);
	public int insertIntoOutbound(long book_isbn, int outbound_unit_price, int outbound_quantitiy);
	public int updateByUidInStockFromOutbound(long book_isbn, int outbound_quantitiy);
	
	public int insertIntoOutbound2(List<Map<String, Object>> list);
	public int updateByUidInStockFromOutbound2(Map<String, Object> map);
	
	public List<BookDTO> selectByFilter(int classification, String keyword, int category_uid, String fromDate, String toDate);
}
