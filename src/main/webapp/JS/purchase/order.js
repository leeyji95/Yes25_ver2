var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();

var page = 1; // 현재 페이지 
var pageRows = 10; // 한 페이지에 보여지는 행 개수
var viewItem = undefined; // 가장 최근에 view 한 글 데이터
var pubName = '';
var bookSubject = '';

$(document).ready(function(){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	addViewEvent();
	
	$('form input').attr("autocomplete","off");

	// 거래처 검색
	function autoSearchPub(){
		pubName = $('#add-order-pub-name').val().trim();
		bookSubject = $('#add-order-book-subject').val().trim();
		
		$.ajax({
			type : 'POST',
			url : 'order/pubList.ajax',
			data : {pub_name : pubName,
					book_subject : bookSubject,
					page : 1,
					pageRows : pageRows},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					updatePubList(data);
				}			
			}
		});
	} // end autoSearchPub()
	
	// 도서명 검색
	function autoSearchBook(){
		pubName = $('#add-order-pub-name').val().trim();
		bookSubject = $('#add-order-book-subject').val().trim();
		
		$.ajax({
			type : 'POST',
			url : 'order/bookList.ajax',
			data : {pub_name : pubName,
					book_subject : bookSubject,
					page : 1,
					pageRows : pageRows},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					updateBookList(data);
				}			
			}
		});
	} // end autoSearchBook()
	
	// 거래처명 입력창에 focus 이벤트 발생시 거래처 검색 실행
	$('#add-order-pub-name').focus(function(){
		if($(this).hasClass('enable-search')){
			$(".nav-link[href='#search-result-tab']").trigger("click");
			autoSearchPub();
			
		} else {
			showPubInfo($('#add-order-pub-uid').val());
			$('#search-result').addClass('none');
			$('#detail-info').removeClass('none');
		}
	});
	
	// 거래처명 입력창에서 keyup 이벤트 발생시 거래처 검색 실행
	$('#add-order-pub-name.enable-search').keyup(function(){
		autoSearchPub();
	});
	
	// 도서명 입력창에 focus 이벤트 발생시 도서 검색 실행
	$('#add-order-book-subject').focus(function(){
		if($(this).hasClass('enable-search')){
			$(".nav-link[href='#search-result-tab']").trigger("click");
			autoSearchBook();
			
		} else {
			showBookInfo($('#add-order-book-uid').val());
			$('#search-result').addClass('none');
			$('#detail-info').removeClass('none');
		}
	});
	
	// 도서명 입력창에서 keyup 이벤트 발생시 도서 검색 실행
	$('#add-order-book-subject.enable-search').keyup(function(){
		autoSearchBook();
	});
	
	// 거래처 선택
	$('#pub-info-select').click(function(){
		var pub_uid = $("#pub-info input[name='pub_uid']").val();
		var pub_name = $("#pub-info input[name='pub_name']").val();
		
		$('#add-order-pub-uid').val(pub_uid);
		$('#add-order-pub-name').val(pub_name);
		$('#add-order-pub-name').attr('readonly', true);
		$('#add-order-pub-name').removeClass('enable-search');
		
		closeModal($('#pub-info'));
		
		$('#add-order-pub-name').focus();
		$('#search-result').addClass('none');
		$('#detail-info').removeClass('none');
	});
	
	// 도서 선택
	$('#book-info-select').click(function(){
		var book_uid = $("#book-info input[name='book_uid']").val();
		var book_subject = $("#book-info input[name='book_subject']").val();
		
		$('#add-order-book-uid').val(book_uid);
		$('#add-order-book-subject').val(book_subject);
		$('#add-order-book-subject').attr('readonly', true);
		$('#add-order-book-subject').removeClass('enable-search');
		
		closeModal($('#book-info'));
		
		$('#add-order-book-subject').focus();
		$('#search-result').addClass('none');
		$('#detail-info').removeClass('none');
	});
	
	// 거래처 선택 취소
	$('#clear-pub-name').click(function(){
		if($('#order-list tr').length != 0){
			var delConfirm = confirm('발주서에 데이터가 존재합니다.\n존재하는 데이터를 삭제하고 거래처를 다시 선택하시겠습니까?');

			if(delConfirm){
				$('#order-parer-title').text("거래처명");
				$('#order-list').empty();
				
			} else {
				return;
			}
		}
			
		$('#add-order-pub-uid').val('');
		$('#add-order-pub-name').val('');
		$('#add-order-pub-name').attr('readonly', false);
		$('#add-order-pub-name').addClass('enable-search');
		
		autoSearchPub();
		$('#detail-info').addClass('none');
		$('#search-result').removeClass('none');
	});
	
	// 도서 선택 취소
	$('#clear-book-subject').click(function(){
		$('#add-order-book-uid').val('');
		$('#add-order-book-subject').val('');
		$('#add-order-book-subject').attr('readonly', false);
		$('#add-order-book-subject').addClass('enable-search');
		
		autoSearchBook();
		$('#detail-info').addClass('none');
		$('#search-result').removeClass('none');
	});
	
	$('#reset').click(function(){
		resetForm();
	});
	
	$.validator.addMethod('validateAcountUid', function(value){
		if(!$('#add-order-pub-uid').val()){
			return false;
		} else {
			return true;
		}
	}, "거래처를 선택해 주세요!");
	
	$.validator.addMethod('validateBookUid', function(value){
		if(!$('#add-order-book-uid').val()){
			return false;
		} else {
			return true;
		}
	}, "도서를 선택해 주세요!");
	
	$.validator.addMethod('validateUnitCost', function(value){
		return /^[1-9]{1}[0-9]*$/.test(value);
	}, "단가 형식이 잘못되었습니다.");
	
	$.validator.addMethod('validateQuantity', function(value){
		return /^[1-9]{1}[0-9]*$/.test(value);
	}, "수량 형식이 잘못되었습니다.");
	
	// 발주 목록 추가
	$('#add-order').submit(function(e){
		e.preventDefault();
	}).validate({
		rules : {
			pub_name : {validateAcountUid : true},
			book_subject : {validateBookUid : true},
			ord_unit_cost : {required : true, min : 1, validateUnitCost : true},
			ord_quantity : {required : true, min : 1, validateQuantity : true}
		},
		messages : {
			ord_unit_cost : {required : "단가를 입력해 주세요!", number : "단가 형식이 잘못되었습니다.", min : "1 이상의 숫자를 입력해 주세요!"},
			ord_quantity : {required : "수량을 입력해 주세요!", number : "수량 형식이 잘못되었습니다.", min : "1 이상의 숫자를 입력해 주세요!"}
		},
		submitHandler : function(form){
			var pub_uid = $('#add-order-pub-uid').val();
			var book_uid = $('#add-order-book-uid').val();
			var pub_name = $('#add-order-pub-name').val();
			var book_subject = $('#add-order-book-subject').val();
			var ord_unit_cost = $('#add-order-order-unit-cost').val();
			var ord_quantity = $('#add-order-order-quantity').val();
			
			var flag = 1;
			var tdData = $('#order-list td:nth-child(2)');
			if(tdData.length){
				for(var i = tdData.length - 1; i > -1; i--){
					console.log(i + "번째 비교중");
					if(book_uid == tdData.eq(i).text()){
						alert('해당 도서는 목록에 이미 존재합니다!');
						flag = 0;
						break;
					}
				}
			}
			
			resetForm();
			
			if(flag != 1){
				$(".nav-link[href='#order-paper-tab']").trigger("click");
				return;
			}
			
			$('#order-parer-title').text("거래처명 : " + pub_name);
			
			var result = '';
			
			result += "<tr>\n";
			result += "<td>" + pub_uid + "</td>\n";
			result += "<td>" + book_uid + "</td>\n";
			result += "<td><input type='checkbox' name='chk'></td>\n";
			result += "<td>" + book_subject + "</td>\n";
			result += "<td><div class='editable-cell'>" + ord_unit_cost + "</div></td>\n";
			result += "<td><div class='editable-cell'>" + ord_quantity + "</div></td>\n";
			result += "</tr>\n";
			
			$('#order-list').append(result);
			$(".nav-link[href='#order-paper-tab']").trigger("click");
		},
    	invalidHandler : function(form, validator){ // 입력값이 잘못된 상태에서 submit 할때 호출
			console.log(validator.numberOfInvalids() + "개의 에러 발생");
    	},
    	errorPlacement : function(error, element){
    		if((element.attr('name') == 'pub_name')||(element.attr('name') == 'book_subject')){
    			error.insertAfter(element.parent());
    		} else {
    			error.insertAfter(element);
    		}
    	}
	});

	// 발주 목록 삭제
	$('#delete-order').click(function(){
	    var checkRows = $("#order-paper-table input[name='chk']:checked");
	    
	    if(checkRows.length == 0){
	    	alert('삭제할 항목을 선택해주세요!');
	    } else {
		    var delConfirm = confirm(checkRows.length + '개의 선택 항목을 삭제하시겠습니까?');
		    
		    if(delConfirm){
		    	for(var i = checkRows.length - 1; i > -1; i--){                     
		    		checkRows.eq(i).closest('tr').remove();
		    	}  
		    }	
	    }
	});
	
	// 발주요청
	$('#insert-order').click(function(){
		var testTable = new Array();
		
		$('#order-list tr').each(function(){
			var rowData = new Array();
			var tdData = $(this).find('td');
			if(tdData.length > 0){
				tdData.each(function(){
					rowData.push($(this).text());
				});
				testTable.push({pub_uid : rowData[0],
								book_uid : rowData[1],
								ord_unit_cost : rowData[4],
								ord_quantity : rowData[5]});
			}
		});
		console.log(testTable);
		console.log(JSON.stringify(testTable));
		
        $.ajax({
            type : 'POST',
            url : 'order/insertOrder.ajax',
            data : JSON.stringify(testTable),
            contentType: 'application/json',
            traditional : true,
            dataType : 'json',
            success: function(data, status){
            	if(status == "success"){
            		if(data.count != 0){
            			alert("발주요청 완료!");
            		} else {
            			alert("발주요청 실패!");
            		}
            		$('#order-list').empty();
            		$('#order-parer-title').text("거래처명");
				}	
            },
            error: function(data){
                alert("에러발생 " + data.message);
            }
        });
	});
	
//	$.validator.addMethod("validateNumberOnly", function(value, element){
//		return validateNumberOnly(value, element);
//	}, "숫자만 넣어라!!!!");
//	
//	$.validator.addClassRules({
//		numberOnly : {
//			required : true,
//			validateNumberOnly : true
//		}
//	});
//	
//	function validateNumberOnly(value, element){
//		var numberOnly = $('.numberOnly');
//		var tdArray = new Array();
//		var arrayIndex = 0;
//		var currentElementIndex = 0;
//		var isValid = true;
//		
//		$(numberOnly).each(function(){
//			var currentElementVal = $(this).val();
//			tdArray[arrayIndex] = currentElementVal;
//			
//			if(currentElementVal == $())
//		})
//	}
});

$(document).on('click', '.editable-cell', function(){
	$(this).attr('contenteditable', 'true');
	$(this).css('padding', '2px');
	$(this).focus();
});

$(document).on('blur', '.editable-cell', function(){
	$(this).removeAttr('contenteditable');
	$(this).css('padding', '0');
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

// 거래처 page번째 페이지 로딩
function loadPubPage(page){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		type : 'POST',
		url : 'order/pubList.ajax',
		data : {pub_name : pubName,
				book_subject : bookSubject,
				page : page,
				pageRows : pageRows},
		cache : false,
		success : function(data, status){
			if(status == "success"){
				updatePubList(data);
			}			
		}
	});
} // end loadPubPage()

// 도서 page번째 페이지 로딩
function loadBookPage(page){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		type : 'POST',
		url : 'order/bookList.ajax',
		data : {pub_name : pubName,
				book_subject : bookSubject,
				page : page,
				pageRows : pageRows},
		cache : false,
		success : function(data, status){
			if(status == "success"){
				updateBookList(data);
			}			
		}
	});
} // end loadBookPage()

// 거래처 목록 업데이트
function updatePubList(data){
	var result = "";
	
	result += "<thead class='thead-inverse'>\n";
    result += "<tr>\n";
    result += "<th>거래처명</th>\n";
    result += "<th>대표자명</th>\n";
    result += "<th>연락처</th>\n";
    result += "<tr>\n";
    result += "</thead>\n";
    result += "<tbody>\n";
	
	if(data.status == "OK"){
		var count = data.count;
		
		// 전역변수 업데이트!
		window.page = data.page;
		window.pageRows = data.pagerows;
		
		var i;
		var items = data.data;   // 배열
		for(i = 0; i < count; i++){
			result += "<tr data-toggle='modal' data-target='#pub-info' data-pub_uid='" + items[i].pub_uid + "'>\n";
			result += "<td>" + items[i].pub_name + "</td>\n";
			result += "<td>" + items[i].pub_rep + "</td>\n";
			result += "<td>" + items[i].pub_contact + "</td>\n";
			result += "</tr>\n";
		}
		result += "</tbody>\n";
		$("#search-result-table").html(result);
		
		// 페이지 정보 업데이트
		$("#page-info").text(data.page + "/" + data.totalpage + "페이지, " + data.totalcnt + "개의 거래처");
		
		// 페이징 업데이트
		var pagination = buildPubPagination(data.writepages, data.totalpage, data.page, data.pagerows);
		$("#pagination").html(pagination);
		
		$('#detail-info').addClass('none');
		$('#search-result').removeClass('none');
		
	} else {
		alert(data.message);
	}
} // end updatePubList(data)

// 도서 목록 업데이트
function updateBookList(data){
	var result = "";
	
	result += "<thead class='thead-inverse'>\n";
    result += "<tr>\n";
    result += "<th>도서명</th>\n";
    result += "<th>저자</th>\n";
    result += "<th>출판사</th>\n";
    result += "<th>카테고리</th>\n";
    result += "<tr>\n";
    result += "</thead>\n"; 
    result += "<tbody>\n"; 
	
	if(data.status == "OK"){
		var count = data.count;
		
		// 전역변수 업데이트!
		window.page = data.page;
		window.pageRows = data.pagerows;
		
		var i;
		var items = data.data;   // 배열
		for(i = 0; i < count; i++){
			result += "<tr data-toggle='modal' data-book_uid='" + items[i].book_uid + "' data-target='#book-info'>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].book_author + "</td>\n";
			result += "<td>" + items[i].pub_name + "</td>\n";
			result += "<td>" + items[i].ctg_name + "</td>\n";
			result += "</tr>\n";
		}
		result += "</tbody>\n"; 
		$("#search-result-table").html(result);
		
		// 페이지 정보 업데이트
		$("#page-info").text(data.page + "/" + data.totalpage + "페이지, " + data.totalcnt + "개의 도서");
		
		// 페이징 업데이트
		var pagination = buildBookPagination(data.writepages, data.totalpage, data.page, data.pagerows);
		$("#pagination").html(pagination);
		
		$('#detail-info').addClass('none');
		$('#search-result').removeClass('none');
		
	} else {
		alert(data.message);
	}
} // end updateBookList(data)

// 거래처 '페이징'을 화면에 출력
function buildPubPagination(writePages, totalPage, curPage, pageRows){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (start_page ~ end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
    // << 표시 여부
	if(curPage > 1){
		str += "<li class='page-item'><a class='page-link' onclick='loadPubPage(1)' title='처음'><i class='fa fa-angle-double-left'></i></a></li>\n";
	}
	
  	// < 표시 여부
    if (start_page > 1) 
    	str += "<li class='page-item'><a class='page-link' onclick='loadPubPage(" + (start_page - 1) + ")' title='이전'><i class='fa fa-angle-left'></i></a></li>\n";
    
    // 페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li class='page-item'><a class='page-link' onclick='loadPubPage(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li class='page-item active'><a class='page-link' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	// > 표시
    if (totalPage > end_page){
    	str += "<li class='page-item'><a class='page-link' onclick='loadPubPage(" + (end_page + 1) + ")' title='다음'><i class='fa fa-angle-right'></i></a></li>\n";
    }

	// >> 표시
    if (curPage < totalPage) {
        str += "<li class='page-item'><a class='page-link' onclick='loadPubPage(" + totalPage + ")' title='맨끝'><i class='fa fa-angle-double-right'></i></a></li>\n";
    }

    return str;
} // end buildPubPagination()

// 도서 '페이징'을 화면에 출력
function buildBookPagination(writePages, totalPage, curPage, pageRows){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (start_page ~ end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
    // << 표시 여부
	if(curPage > 1){
		str += "<li class='page-item'><a class='page-link' onclick='loadBookPage(1)' title='처음'><i class='fa fa-angle-double-left'></i></a></li>\n";
	}
	
  	// < 표시 여부
    if (start_page > 1) 
    	str += "<li class='page-item'><a class='page-link' onclick='loadBookPage(" + (start_page - 1) + ")' title='이전'><i class='fa fa-angle-left'></i></a></li>\n";
    
    // 페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li class='page-item'><a class='page-link' onclick='loadBookPage(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li class='page-item active'><a class='page-link' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	// > 표시
    if (totalPage > end_page){
    	str += "<li class='page-item'><a class='page-link' onclick='loadBookPage(" + (end_page + 1) + ")' title='다음'><i class='fa fa-angle-right'></i></a></li>\n";
    }

	// >> 표시
    if (curPage < totalPage) {
        str += "<li class='page-item'><a class='page-link' onclick='loadBookPage(" + totalPage + ")' title='맨끝'><i class='fa fa-angle-double-right'></i></a></li>\n";
    }

    return str;
} // end buildBookPagination()

// 거래처 정보 모달창
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

// 모달 배경이 안사라져서 이 방법으로 해결
function closeModal(target){
	target.modal('hide');
} // end unloadModal()

// 선택한 거래처 정보 보여주기
function showPubInfo(pub_uid){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		type : 'GET',
		url : 'vendor/viewPub.ajax',
		data : {pub_uid : pub_uid},
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					var item = data.data[0];
					
					$('#detail-info .card-header').text('선택 거래처 정보');
					
					var result = "";

					result += "<tr>\n";
					result += "<th>거래처명</th>\n";
					result += "<td>" + item.pub_name + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>사업자 등록번호</th>\n";
					result += "<td>" + item.pub_num + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>대표자명</th>\n";
					result += "<td>" + item.pub_rep + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>연락처</th>\n";
					result += "<td>" + item.pub_contact + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>주소</th>\n";
					result += "<td>" + item.pub_address + "</td>\n";
					result += "</tr>\n";
					
					$("#detail-info-table").html(result);
					
					} else {
						alert("에러발생 " + data.message);
					}
			}
		}
	});
}

// 선택한 도서 정보 보여주기
function showBookInfo(book_uid){
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
					var item = data.data[0];

					$('#detail-info .card-header').text('선택 도서 정보');
					
					var result = "";

					result += "<tr>\n";
					result += "<th>도서명</th>\n";
					result += "<td>" + item.book_subject + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>저자</th>\n";
					result += "<td>" + item.book_author + "</td>";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>출판사</th>\n";
					result += "<td>" + item.pub_name + "</td>\n";
					result += "</tr>\n";
					result += "<tr>\n";
					result += "<th>출판일</th>\n";
					result += "<td>" + item.book_pubdate + "</td>\n";
					result += "</tr>\n";
					result += "<th>카테고리</th>\n";
					result += "<td>" + item.ctg_name + "</td>\n";
					result += "</tr>\n";
					result += "<th>내용</th>\n";
					result += "<td>" + item.book_content + "</td>\n";
					result += "</tr>\n";
					
					$("#detail-info-table").html(result);
					
					} else {
						alert("에러발생 " + data.message);
					}
			}
		}
	});
}

// 폼 초기화
function resetForm(){
	if(!$('#add-order-pub-uid').val()){
		$('#add-order-pub-uid').val('');
		$('#add-order-pub-name').val('');
		$('#add-order-pub-name').attr('readonly', false);
		$('#add-order-pub-name').addClass('enable-search');
	}
	
	$('#add-order-book-uid').val('');
	$('#add-order-book-subject').val('');
	$('#add-order-book-subject').attr('readonly', false);
	$('#add-order-book-subject').addClass('enable-search');
	
	$('#add-order-order-unit-cost').val('');
	$('#add-order-order-quantity').val('');
	
	$('#page-info').empty();
	$('#search-result-table').empty();
	$('#pagination').empty();
	$('#detail-info').addClass('none');
	$('#search-result').removeClass('none');
}