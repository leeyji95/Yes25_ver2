var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();


$(document).ready(function() {
	loadPage();

	$("#btnQuery").click(function() {
		query1();
	});

	$("#btnExcel").click(function() {
		excel();
	});
	
	$("#datepicker1, #datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    changeMonth: true,
	    changeYear: true,
	    yearSuffix: '년',
        yearRange: "-100:+0"
	});

});

function loadPage() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	
	$.ajax({
		url : "stockList.ajax",
		type : "GET",
		cache : false,
		dataType : "json",
		success : function(data, status) {
			if (status == "success") {
				listUp1(data);
			}
		}
	});
}

function query1() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	var classification = $("#query select[name=classification]").val();
	
	var param = $("#query input[name=keyword]").val();
	if(regExp.test(param)){
		var temp = param.replace(regExp, "");
		param = temp;
	}
	var keyword = param.trim().replace(/ +/g, "");
	if(keyword == null || keyword== 0 || keyword.length == 0) keyword = 0;
	
	
	var category_uid = $("#query select[name=category_uid]").val();
	
	var fromDate = $("#query input[name=datepicker1]").val();
	if(fromDate == null || fromDate == 0 || fromDate.length == 0) fromDate = 0;
	
	var toDate = $("#query input[name=datepicker2]").val();
	if(toDate == null || toDate== 0 || toDate.length == 0) toDate = 0;
	
/*	alert(classification);
	alert(keyword);
	alert(category_uid);
	alert(fromDate);
	alert(toDate);*/

		$.ajax({
			url : "stockQuery.ajax",
			type : "POST",
			data : { 
				'classification' : classification,
				'keyword' : keyword,
				'category_uid' : category_uid,
				'fromDate': fromDate,
				'toDate': toDate,
			},
			cache : false,
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
	
	return true;
} // end query1()




function listUp1(jsonObj) {
	result = "";

	if (jsonObj.status == "OK") {
		var count = jsonObj.count;

		var i;
		var items = jsonObj.data;
		for (i = 0; i < count; i++) {
			result += "<tr>\n";
			result += "<td>" + (i+1) +"</td>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td name='book_isbn' val='"+ items[i].book_isbn +"'>" + items[i].book_isbn + "</td>\n";
			result += "<td>" + items[i].publisher_name + "</td>\n";
			result += "<td>" + items[i].book_author + "</td>\n";
			result += "<td>" + items[i].category_name + "</td>\n";
			result += "<td>" + items[i].book_pubdate + "</td>\n";
			result += "<td>" + items[i].stock_quantity + "권</td>\n";
			result += "<tr>\n";
		} // end for
		$("#list tbody").html(result);

		return true;
		
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()

/*function excel() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	var classification = $("#query select[name=classification]").val();
	
	var param = $("#query input[name=keyword]").val();
	if(regExp.test(param)){
		var temp = param.replace(regExp, "");
		param = temp;
	}
	var keyword = param.trim().replace(/ +/g, "");
	if(keyword == null || keyword== 0 || keyword.length == 0) keyword = 0;
	
	
	var category_uid = $("#query select[name=category_uid]").val();
	
	var fromDate = $("#query input[name=datepicker1]").val();
	if(fromDate == null || fromDate == 0 || fromDate.length == 0) fromDate = 0;
	
	var toDate = $("#query input[name=datepicker2]").val();
	if(toDate == null || toDate== 0 || toDate.length == 0) toDate = 0;
	
	alert(classification);
	alert(keyword);
	alert(category_uid);
	alert(fromDate);
	alert(toDate);
	
	if (!confirm("엑셀파일 다운로드")) return false;

		$.ajax({
			url : "excel.ajax",
			type : "POST",
			data : { 
				'classification' : classification,
				'keyword' : keyword,
				'category_uid' : category_uid,
				'fromDate': fromDate,
				'toDate': toDate,
			},
			cache : false,
			dataType : "json",
			success : function(data, status) {
				
			}
		});
	
	return true;
} // end excel()
*/

function excel() {
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	var book_isbn = [];
	$("#list tbody td[name=book_isbn]").each(function(){
		book_isbn.push($(this).text());
	});
	
	if(book_isbn.length==0){
		alert('다운로드할 정보가 없습니다');
	} else{
		if(!confirm('엑셀 파일로 다운로드 받으시겠습니까?')) return false;
		
	var book_isbns= "";
	
	for (var i = 0; i < book_isbn.length; i++) {
		book_isbns += "|"+book_isbn[i];
	}
	
	alert(book_isbns);
	
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;

	
	alert(book_isbns);
	
		
		
		$.ajax({
			url : "excel.ajax",
			type : "POST",
			data : { 
				'book_isbns' : book_isbns,
			},
			cache : false,
			dataType : "json",
			success : function(data, status) {
				
			}
		});
		
		return true;
	}
		
} // end excel()

