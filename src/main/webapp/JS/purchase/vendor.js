var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();

var page = 1; // 현재 페이지 
var pageRows = 10; // 한 페이지에 보여지는 행 개수
var viewItem = undefined; // 가장 최근에 view 한 글 데이터
var searchType = '';
var keyword = '';

$(document).ready(function(){
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	loadPage(page);
	addViewEvent();
	
	$('form input').attr("autocomplete","off");
	
	$.validator.addMethod('pubNameValidation', function(value){
		return /^[가-힣a-zA-Z0-9]+( [가-힣a-zA-Z0-9]+)*$/.test(value);
	}, "거래처명 형식이 잘못되었습니다.");
	
	$.validator.addMethod('pubNumValidation', function(value){
		return /^([0-9]{3})-([0-9]{2})-([0-9]{5})$/.test(value);
	}, "사업자 등록번호 형식이 잘못되었습니다.");
	
	$.validator.addMethod('pubRepValidation', function(value){
		return /^[가-힣a-zA-Z]{2,}$/.test(value);
	}, "대표자명 형식이 잘못되었습니다.");
	
	$.validator.addMethod('pubContactValidation', function(value){
		return /^(010|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/.test(value);
	}, "연락처 형식이 잘못되었습니다.");
	
    // 거래처 등록
    $('#reg-pub').submit(function(e){
    	e.preventDefault();
    }).validate({
    	rules : {
    		pub_name : {required : true, pubNameValidation : true},
			pub_num : {required : true, pubNumValidation : true},
			pub_rep : {required : true, pubRepValidation : true},
			pub_contact : {required : true, pubContactValidation : true},
			pub_address : {required : true}
    	},
    	messages : {
    		pub_name : {required : "거래처명을 입력해 주세요!"},
    		pub_num : {required : "사업자 등록번호를 입력해 주세요!"},
    		pub_rep : {required : "대표자명을 입력해 주세요!"},
    		pub_contact : {required : "연락처를 입력해 주세요!"},
    		pub_address : {required : "주소를 입력해 주세요!"}
    	},
    	submitHandler : function(form){
        	var data = $(form).serialize();
        	
            $.ajax({
                type : 'POST',
                url : 'vendor/insertPub.ajax',
                data : data,
                dataType : 'json',
                success: function(data, status){
                	if(status == "success"){
                		loadPage(1);
                		$("#reg-pub")[0].reset();
    				}	
                },
                error: function(){
                    alert("에러발생 " + data.message);
                }
            });
    	},
    	invalidHandler : function(form, validator){ // 입력값이 잘못된 상태에서 submit 할때 호출
			console.log(validator.numberOfInvalids() + "개의 에러 발생");
    	}
    });

	// 거래처 검색
	$('#pub-search').submit(function(e){
		e.preventDefault();
		
		searchType = $("#pub-search select[name='searchType']").val();
		keyword = $("#pub-search input[name='keyword']").val().trim();

		$.ajax({
			type : 'POST',
			url : 'vendor/pubList.ajax',
			data : {searchType : searchType,
					keyword : keyword,
					page : 1,
					pageRows : pageRows},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					updatePubList(data);
				}			
			}
		});
	});
	
	// 거래처 수정 버튼 (거래처 상세정보 모달창)
	$('#pub-info #update').click(function(){
		setModal('update');
	});
	
	// 거래처 수정 취소 버튼 (거래처 상세정보 모달창)
	$('#pub-info #cancel').click(function(){
		setModal('view');
	});
	
	// 거래처 수정 적용 버튼 (거래처 상세정보 모달창)
	$('#edit-pub').submit(function(e){
    	e.preventDefault();
    }).validate({
    	rules : {
    		pub_name : {required : true, pubNameValidation : true},
			pub_num : {required : true, pubNumValidation : true},
			pub_rep : {required : true, pubRepValidation : true},
			pub_contact : {required : true, pubContactValidation : true},
			pub_address : {required : true}
    	},
    	messages : {
    		pub_name : {required : "거래처명을 입력해 주세요!"},
    		pub_num : {required : "사업자 등록번호를 입력해 주세요!"},
    		pub_rep : {required : "대표자명을 입력해 주세요!"},
    		pub_contact : {required : "연락처를 입력해 주세요!"},
    		pub_address : {required : "주소를 입력해 주세요!"}
    	},
    	submitHandler : function(form){
    		var data = $(form).serialize();
    		
    		$.ajax({
    			type : 'POST',
    			url : 'vendor/updatePubOk.ajax',
    			cache : false,
    			data : data,
    			success : function(data, status){
    				if(status == "success"){
    					if(data.status == "OK"){
    						alert("수정 성공");
    						loadPage(window.page); // 현재 페이지 리로딩
    					} else {
    						alert("수정 실패 " + data.message);
    					}
    					closeModal($('#pub-info'));
    				}
    			}
    		});
    	},
    	invalidHandler : function(form, validator){ // 입력값이 잘못된 상태에서 submit 할때 호출
			console.log(validator.numberOfInvalids() + "개의 에러 발생");
    	}
    });
	
	// 거래처 삭제 버튼 (거래처 상세정보 모달창)
	$('#pub-info #delete').click(function(){
		deleteByUid(viewItem.pub_uid);
	});
	
	// 검색 결과 초기화
	$('#reset-publisher-list').click(function(){
		searchType = '';
		keyword = '';
		$("#pub-search input[name='keyword']").val('');

		$.ajax({
			type : 'POST',
			url : 'vendor/pubList.ajax',
			data : {searchType : searchType,
					keyword : keyword,
					page : 1,
					pageRows : pageRows},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					updatePubList(data);
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
			url : 'vendor/viewPub.ajax',
			data : {pub_uid : pub_uid},
			cache : false,
			success : function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						viewItem = data.data[0];
						setModal('view');
						
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
		url : 'vendor/pubList.ajax',
		data : {searchType : searchType,
				keyword : keyword,
				page : page,
				pageRows : pageRows}, 
		cache : false,
		success : function(data, status){
			if(status == "success"){
				updatePubList(data)
			}
		}
	});
} // end loadPage()

// 거래처 목록 업데이트
function updatePubList(data){
	result = ""; 
	
	if(data.status == "OK"){
		
		var count = data.count;
		
		// 전역변수 업데이트!
		window.page = data.page;
		window.pageRows = data.pagerows;
		
		var i;
		var items = data.data; // 배열
		for(i = 0; i < count; i++){
			result += "<tr data-toggle='modal' data-target='#pub-info' data-pub_uid='" + items[i].pub_uid + "'>\n";
			result += "<td>" + items[i].pub_name + "</td>\n";
			result += "<td>" + items[i].pub_rep + "</td>\n";
			result += "<td>" + items[i].pub_contact + "</td>\n";
			result += "</tr>\n";
		}
		$("#publisher-list").html(result);
		
		// 페이지 정보 업데이트
		$("#page-info").text(data.page + "/" + data.totalpage + "페이지, " + data.totalcnt + "개의 거래처");
		
		// 페이징 업데이트
		var pagination = buildPagination(data.writepages, data.totalpage, data.page, data.pagerows);
		$("#pagination").html(pagination);
		
	} else {
		alert(data.message);
	}
}

// 거래처 삭제
function deleteByUid(pub_uid){
	if(!confirm("데이터를 삭제 하시겠습니까?")) return false;
	
	$.ajaxSetup({
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		type : 'POST',
		url : 'vendor/deletePubOk.ajax',
		cache : false,
		data : {pub_uid : pub_uid},
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					alert("삭제 성공");
					closeModal($('#pub-info'));
					loadPage(window.page); // 현재 페이지 리로딩
				} else {
					alert("삭제 실패 " + data.message);
					return false;
				}
			}
		}
	});
	
	return true;
} // end deleteByUid(pub_uid)

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

// 클릭한 버튼에 따라 모달 속성 변경 (거래처 정보 모달창)
function setModal(mode){
	// 거래처 상세정보 보기
	if(mode == 'view'){
		$('#pub-info .modal-title').text("거래처 정보");
		$('#pub-info input').attr('readonly', true);
		$('#pub-info input').css({'border': 'none', 'background-color': 'white'});
		$('#update-btns').css('display', 'none');
		$('#view-btns').css('display', 'block');
		$('label.error').remove();
		
		$("#pub-info input[name='pub_uid']").val(viewItem.pub_uid);
		$("#pub-info input[name='pub_name']").val(viewItem.pub_name);
		$("#pub-info input[name='pub_num']").val(viewItem.pub_num);
		$("#pub-info input[name='pub_rep']").val(viewItem.pub_rep);
		$("#pub-info input[name='pub_contact']").val(viewItem.pub_contact);
		$("#pub-info input[name='pub_address']").val(viewItem.pub_address);
	}
	
	if(mode == 'update'){
		$('#pub-info .modal-title').text("거래처 수정");
		$('#pub-info input').attr('readonly', false);
		$('#pub-info input').css('border', '1px solid #ced4da');
		$('#pub-info #view-btns').css('display', 'none');
		$('#pub-info #update-btns').css('display', 'block');
	}
} // end setModal(mode)

//모달 배경이 안사라져서 이 방법으로 해결
function closeModal(target){
	target.modal('hide');
} // end closeModal()