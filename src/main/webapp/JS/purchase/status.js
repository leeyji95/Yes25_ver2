var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();

var page = 1; // 현재 페이지 
var pageRows = 10; // 한 페이지에 보여지는 행 개수
var viewItem = undefined; // 가장 최근에 view 한 글 데이터
var keyword_pubName = '';
var keyword_bookSubject = '';
var keyword_startDate = '';
var keyword_endDate = '';

$(document).ready(function(){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	loadPage(page);
	addViewEvent();
	
	$('form input').attr("autocomplete","off");
	
	$('.datePicker').datepicker({
	    format: "yyyy-mm-dd", // 데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
	    maxDate: 0,
	    autoclose : true, // 사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
	    todayHighlight : true ,	// 오늘 날짜에 하이라이팅 기능 기본값 : false 
	    toggleActive : true, // 이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
	    language : "ko" // 달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	});
	
	// 거래처 검색
	$('#search-order').submit(function(e){
		e.preventDefault();
		
		var dateBuf = '';
		
		keyword_pubName = $('#search-order-pub-name').val().trim();
		keyword_bookSubject = $('#search-order-book-subject').val().trim();
		
		keyword_startDate = $('#search-order-startDate').val();
	    console.log(keyword_startDate);
	    
	    keyword_endDate = $('#search-order-endDate').val();
	    console.log(keyword_endDate);
	    
		$.ajax({
			type : 'POST',
			url : 'status/orderList.ajax',
			data : {
					pub_name : keyword_pubName,
					book_subject : keyword_bookSubject,
					startDate : keyword_startDate,
					endDate : keyword_endDate,
					page : 1,
					pageRows : pageRows},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					updateOrderList(data);
				}			
			}
		});
	});
});

function addViewEvent(){
	$('#pub-info').on('show.bs.modal', function(e) {   
		var pub_uid = $(e.relatedTarget).data('pub_uid');
		
		$.ajaxSetup({
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			}
		});
		
		$.ajax({
			type : 'GET',
			url : 'order/viewPub.ajax',
			data : {pub_uid : pub_uid},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						viewItem = data.data[0];
						openPubModal();
						
 					} else {
 						alert("에러발생 " + data.message);
 					}
				}
			}
		});
    });
	
	$('#book-info').on('show.bs.modal', function(e) {   
		var book_uid = $(e.relatedTarget).data('book_uid');
		
		$.ajaxSetup({
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			}
		});
		
		$.ajax({
			type : 'GET',
			url : 'order/viewBook.ajax',
			data : {book_uid : book_uid},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						viewItem = data.data[0];
						openBookModal();
						
 					} else {
 						alert("에러발생 " + data.message);
 					}
				}
			}
		});
    });
} // end addViewEvent()

// page번째 페이지 로딩
function loadPage(page){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		type : 'POST',
		url : 'status/orderList.ajax',
		data : {
				pub_name : keyword_pubName,
				book_subject : keyword_bookSubject,
				startDate : keyword_startDate,
				endDate : keyword_endDate,
				page : page,
				pageRows : pageRows}, 
		cache : false,
		success : function(data, status){
			if(status == "success"){
				updateOrderList(data)
			}
		}
	});
} // end loadPage()

// 거래처 목록 업데이트
function updateOrderList(data){
	result = ""; 
	
	if(data.status == "OK"){
		
		var count = data.count;
		
		// 전역변수 업데이트!
		window.page = data.page;
		window.pageRows = data.pagerows;
		
		var i;
		var items = data.data; // 배열
		for(i = 0; i < count; i++){
			result += "<tr data-ord_uid='" + items[i].ord_uid + "'>\n";
			result += "<td>" + items[i].ord_date + "</td>\n";
			result += "<td data-toggle='modal' data-target='#pub-info' data-pub_uid='" + items[i].pub_uid + "'>" + items[i].pub_name + "</td>\n";
			result += "<td data-toggle='modal' data-target='#book-info' data-book_uid='" + items[i].book_uid + "'>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].ord_unit_cost + "</td>\n";
			result += "<td>" + items[i].ord_quantity + "</td>\n";
			result += "</tr>\n";
		}
		$("#order-list").html(result);
		
		// 페이지 정보 업데이트
		$("#page-info").text(data.page + "/" + data.totalpage + "페이지, " + data.totalcnt + "개의 발주");
		
		// 페이징 업데이트
		var pagination = buildPagination(data.writepages, data.totalpage, data.page, data.pagerows);
		$("#pagination").html(pagination);
		
	} else {
		alert(data.message);
	}
}

//'페이징'을 화면에 출력
function buildPagination(writePages, totalPage, curPage, pageRows){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (start_page ~ end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
    // << 표시 여부
	if(curPage > 1){
		str += "<li class='page-item'><a class='page-link' onclick='loadPage(1)' title='처음'><i class='fa fa-angle-double-left'></i></a></li>\n";
	}
	
  	// < 표시 여부
    if (start_page > 1) 
    	str += "<li class='page-item'><a class='page-link' onclick='loadPage(" + (start_page - 1) + ")' title='이전'><i class='fa fa-angle-left'></i></a></li>\n";
    
    // 페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li class='page-item'><a class='page-link' onclick='loadPage(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li class='page-item active'><a class='page-link' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	// > 표시
    if (totalPage > end_page){
    	str += "<li class='page-item'><a class='page-link' onclick='loadPage(" + (end_page + 1) + ")' title='다음'><i class='fa fa-angle-right'></i></a></li>\n";
    }

	// >> 표시
    if (curPage < totalPage) {
        str += "<li class='page-item'><a class='page-link' onclick='loadPage(" + totalPage + ")' title='맨끝'><i class='fa fa-angle-double-right'></i></a></li>\n";
    }

    return str;
} // end buildPagination()

//거래처 정보 모달창
function openPubModal(){
	$('#pub-info .modal-title').text("거래처 정보");
	$('#pub-info input').attr('readonly', true);
	$('#pub-info input').css({'border': 'none', 'background-color': 'white'});
	
	$("#pub-info input[name='pub_uid']").val(viewItem.pub_uid);
	$("#pub-info input[name='pub_name']").val(viewItem.pub_name);
	$("#pub-info input[name='pub_num']").val(viewItem.pub_num);
	$("#pub-info input[name='pub_rep']").val(viewItem.pub_rep);
	$("#pub-info input[name='pub_contact']").val(viewItem.pub_contact);
	$("#pub-info input[name='pub_address']").val(viewItem.pub_address);
} // end openPubModal()

// 도서 정보 모달창
function openBookModal(){
	$('#book-info input').attr('readonly', true);
	$('#book-info input').css({'border': 'none', 'background-color': 'white'});
	
	$("#book-info input[name='book_uid']").val(viewItem.book_uid);
	$("#book-info input[name='book_subject']").val(viewItem.book_subject);
	$("#book-info input[name='book_author']").val(viewItem.book_author);
	$("#book-info input[name='pub_name']").val(viewItem.pub_name);
	$("#book-info input[name='book_pubdate']").val(viewItem.book_pubdate);
	$("#book-info input[name='ctg_name']").val(viewItem.ctg_name);
	$("#book-info input[name='book_content']").val(viewItem.book_content);
} // end openBookModal()