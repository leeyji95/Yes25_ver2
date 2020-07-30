package com.lec.yes25.purchase;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface PurchaseDAO {
	public int insertPub(@Param("dto") PublisherDTO pub_dto); // 삽입
	public List<PublisherDTO> selectPubByUid(int pub_uid); // 읽기
	public int updatePub(@Param("dto") PublisherDTO pub_dto); // 수정
	public int deletePubByUid(int[] pub_uids); // 삭제
	
	public List<BookDTO> selectBookByPubUid(int pub_uid, int fromRow, int pageRows);
	
	public int vendor_countPub(@Param("searchType") String searchType,
							   @Param("keyword") String keyword);
	
	public List<PublisherDTO> vendor_selectPubFromRow(@Param("searchType") String searchType,
													  @Param("keyword") String keyword,
													  @Param("fromRow") int fromRow,
													  @Param("pageRows") int pageRows);
	
	public int order_countPub(@Param("pub_name") String pub_name,
							  @Param("book_subject") String book_subject);
	
	public List<PublisherDTO> order_selectPubFromRow(@Param("pub_name") String pub_name,
													 @Param("book_subject") String book_subject,
													 @Param("fromRow") int fromRow,
													 @Param("pageRows") int pageRows);
	
	public int order_countBook(@Param("pub_name") String pub_name,
			  				   @Param("book_subject") String book_subject);
	
	public List<BookDTO> order_selectBookFromRow(@Param("pub_name") String pub_name,
												 @Param("book_subject") String book_subject,
												 @Param("fromRow") int fromRow,
												 @Param("pageRows") int pageRows);
	
	public List<BookDTO> selectBookByUid(int book_uid);
	
	public int insertOrder(List<OrderDTO> orderList);
	
	public int status_countOrder(@Param("pub_name") String pub_name,
								 @Param("book_subject") String book_subject,
								 @Param("startDate") String startDate,
								 @Param("endDate") String endDate);
	
	public List<OrderDTO> status_selectOrderFromRow(@Param("pub_name") String pub_name,
													@Param("book_subject") String book_subject,
													@Param("startDate") String startDate,
													@Param("endDate") String endDate,
													@Param("fromRow") int fromRow,
													@Param("pageRows") int pageRows);
}
