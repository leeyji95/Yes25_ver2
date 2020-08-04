package com.lec.yes25.logistics;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;

import com.lec.yes25.common.C;
import com.lec.yes25.common.Command;



public class ExcelCommand implements Command {
	
	public static SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
	public static Date date = new Date();
	public static String time = format.format(date);
	
	public static final String TEST_DIRECTORY = "/Stock";
	public static final String TEST_FILE = "stock_"+ time+".xls";
	
	File f =null;
	File f2 = null;
	String sheetName = "재고현황";

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		LogisticsDAO dao = C.sqlSession.getMapper(LogisticsDAO.class);
		List<BookDTO> list = null;
		
		String path = System.getProperty("user.dir") + File.separator +TEST_DIRECTORY;
		f = new File(path);
		
		String book_isbns = request.getParameter("book_isbns");

		
		if(!f.exists()) {
			if(f.mkdir()) {
				System.out.println("폴더 생성 성공");
			} else {
				System.out.println("폴더 생성 실패");
			}
		} else {
			System.out.println("폴더가 이미 존재합니다");
		}
		
		f2= new File(f, TEST_FILE);
		System.out.println(f2.getAbsolutePath());
		
	
		if(!f2.exists()) {
			
			try {
				
				if(f2.createNewFile()) {
					System.out.println("파일 생성 성공");
				} else {
					System.out.println("파일 생성 실패");
				}
			} catch(IOException e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("파일 이미 존재");
			
		}
		
		
		try {
			System.out.println(book_isbns);
			
			list = dao.searchByIsbnFromBook(book_isbns);
			
			//Iterator<BookDTO> iter =list.iterator();
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet1 = workbook.createSheet(sheetName);
			
			
			HSSFRow row = null;
			HSSFCell cell =null;
			int rowIndex = 0;
			
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy년 MM월 dd일");
			Date date1 = new Date();
			String time1 = format1.format(date1);
			
			SimpleDateFormat format2 = new SimpleDateFormat("HH:mm:ss");
			Date date2 = new Date();
			String time2 = format2.format(date2);
			
			row = sheet1.createRow(rowIndex++);
			row.setHeightInPoints(12.5f);
			row = sheet1.createRow(rowIndex++);
			row.setHeightInPoints(18.0f);
			cell = row.createCell(1);
			cell.setCellValue("◑ YES25 재고현황 ("+time1+")");
			cell.setCellStyle(cellStyle(workbook, "title"));
			row = sheet1.createRow(rowIndex++);
			row.setHeightInPoints(12.5f);
			cell = row.createCell(8);
			cell.setCellValue(time2);
			cell.setCellStyle(cellStyle(workbook, "time"));
			row = sheet1.createRow(rowIndex++);
			row.setHeightInPoints(12.5f);
			
			sheet1.setColumnWidth(0, 300);
			sheet1.setColumnWidth(1, 1500);
			sheet1.setColumnWidth(2, 12000);
			sheet1.setColumnWidth(3, 5000);
			sheet1.setColumnWidth(7, 3000);
			sheet1.setColumnWidth(8, 3000);
			
			
			String[] title = {"번호","도서제목","ISBN","출판사명","도서저자","카테고리","출간일자","재고수량"};
			
			cell = row.createCell(0);
			for(int i=1; i<=title.length; i++) {
				
				cell = row.createCell(i);
				cell.setCellValue(title[i-1]);
				cell.setCellStyle(cellStyle(workbook, "head"));

			}
			
			
			Iterator<BookDTO> iterator = list.iterator();

			int i = 1;
			while(iterator.hasNext()) {
				BookDTO dto = iterator.next();
				
				row = sheet1.createRow(rowIndex++);
				int cellIndex = 0;
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue("");
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(i++);
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getBook_subject());
				cell.setCellStyle(cellStyle(workbook, "subject"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(""+dto.getBook_isbn());
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getPublisher_name());
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getBook_author());
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getCategory_name());
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getBook_pubdate());
				cell.setCellStyle(cellStyle(workbook, "data"));
				
				cell = row.createCell(cellIndex++);
				cell.setCellValue(dto.getStock_quantity());
				cell.setCellStyle(cellStyle(workbook, "data"));
			}
			
			
			OutputStream output = new FileOutputStream(f2.getAbsoluteFile());
			
			workbook.write(output);
 			output.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // end execute
	
	public static CellStyle cellStyle(HSSFWorkbook workbook, String kind) {
		CellStyle cellStyle = workbook.createCellStyle();
		HSSFFont font = workbook.createFont();
		
		cellStyle.setVerticalAlignment(CellStyle.ALIGN_CENTER);
		
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);

		if(kind.equals("head")) {
			cellStyle.setFillForegroundColor(HSSFColor.PALE_BLUE.index);
			cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
			font.setBold(true);
			cellStyle.setFont(font);
		} else if(kind.equals("data")) {
			cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		} else if(kind.equals("line")) {
			cellStyle.setFillForegroundColor(HSSFColor.DARK_BLUE.index);
			cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		} else if(kind.equals("title")) {
			font.setBold(true);
			font.setFontHeight((short)280);
			cellStyle.setFont(font);
			cellStyle.setBorderTop(CellStyle.NO_FILL);
			cellStyle.setBorderBottom(CellStyle.NO_FILL);
			cellStyle.setBorderLeft(CellStyle.NO_FILL);
			cellStyle.setBorderRight(CellStyle.NO_FILL);
		} else if(kind.equals("time")) {
			cellStyle.setVerticalAlignment(CellStyle.ALIGN_LEFT);
			cellStyle.setBorderTop(CellStyle.NO_FILL);
			cellStyle.setBorderBottom(CellStyle.NO_FILL);
			cellStyle.setBorderLeft(CellStyle.NO_FILL);
			cellStyle.setBorderRight(CellStyle.NO_FILL);
			
		}
		
		
		
		return cellStyle;
	}
} // end ExcelCommand
