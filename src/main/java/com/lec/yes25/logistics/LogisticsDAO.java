package com.lec.yes25.logistics;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface LogisticsDAO {
	public int countAll();
	public List<OrderDTO> selectFromOrder();
	public List<OrderDTO> searchByIsbnFromOrder(String book_isbn);
	public List<InboundDTO> searchByIsbnFromInbound(String book_isbn);

	public int insertIntoInbound(int [] order_uids);
	public int updateByUidInStockFromInbound(int [] order_uids);
	public int updateByUidIntoOrder(int [] order_uids);

	public List<BookDTO> selectFromBook();
	public List<BookDTO> searchByIsbnFromBook(String book_isbn);
	public List<OutboundDTO> searchByIsbnFromOutbound(String book_isbn);
	
	public int insertIntoOutbound(List<Map<String, Object>> list);
	public int updateByUidInStockFromOutbound(List<Map<String, Object>> list);
	
	public List<BookDTO> selectByFilter(int classification, String keyword, int category_uid, String fromDate, String toDate);
	
	
	public List<StockDTO1> selectInboundQtyByDay(String year, String month);
	public List<StockDTO2> selectInboundQtyByMonth(String year);
	
	public List<StockDTO1> selectOutboundQtyByDay(String year, String month);
	public List<StockDTO2> selectOutboundQtyByMonth(String year);
	
	public List<InboundQtyDTO> sumInboundQtyByDay(String year, String month);
	public List<InboundQtyDTO> sumInboundQtyByMonth(String year);
	public List<OutboundQtyDTO> sumOutboundQtyByDay(String year, String month);
	public List<OutboundQtyDTO> sumOutboundQtyByMonth(String year);
	
	
}
