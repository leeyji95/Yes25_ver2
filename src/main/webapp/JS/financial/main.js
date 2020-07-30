var page = 1		// 현재 페이지
var choice = 1		// 결재 리스트인지 작성 리스트인지 파악
					// 기본 세팅은 결제를 기다리고 있는 전표 목록

$(document).ready(function() {
	// 홈페이지 시작하자마자 1 페이지 로딩, 전표 수정, 삭제 : hide()
	loadPage(page, choice);
	$("#updateBtn").hide();
	$("#deleteBtn").hide();
	
	// 결재 목록과 작성 목록을 선택할 수 있는 버튼 클릭시
	// 각각 페이지 로딩, 버튼 색상 변경
	$("#proceedChoiceBtn").click(function() {
		page = 1;	choice = 1;
		loadPage(page, choice);
		$("#proceedChoiceBtn").attr('class','width100 infohover');
		$("#writeChoiceBtn").attr('class','width100 info');
		$("#updateBtn").hide();
		$("#deleteBtn").hide();
	});
	$("#writeChoiceBtn").click(function() {
		page = 1;	choice = 2;
		loadPage(page, choice);
		$("#proceedChoiceBtn").attr('class','width100 info');
		$("#writeChoiceBtn").attr('class','width100 infohover');
		$("#updateBtn").show();
		$("#deleteBtn").show();
	});
	
	//글 작성 submit 되면
	$("#frmWrite").submit(function(){
		return chkWrite();
	});
	// 한 번 글작성하면 제대로 모달창이 뜨지 않음
	// 아래의 코드를 추가하면 계속 추가 가능
	$("#btnWrite").click(function() {
		//$("#WriteModal").css('display', 'block');
		$("#WriteModal").modal('show');
	});
	
	// 글작성, 스페이스 누르면 계정과목 검색 시작
	$("input[name=account_name]").keypress(function(event) {
		if(event.which === 32) {
			var word = $("input[name=account_name]").val();
			search(word);
		}
	});
	// 취소 버튼 클릭시 현재 페이지 리로딩
	$(".btn-dismiss").click(function(){
		loadPage(window.page, window.choice);  			// 현재 페이지 리로딩
	});
	
	// 글 수정 버튼 누르면 정보 불러오기
	$("#updateBtn").click(function(){
		if($("input:radio[name=stmt_uid]:checked").val()) {
			loadView();
		} else {
			alert('수정할 전표를 선택하지 않았습니다.\n전표를 선택해주세요.');
			return false;
		}
	});
	// 스페이스 누르면 검색 시작
	$("input[name=Uaccount_name]").keypress(function(event) {
		if(event.which === 32) {
			var word = $("input[name=Uaccount_name]").val();
			Usearch(word);
		}
	});
	// 글 수정 submit 되면
	$("#frmUpdate").submit(function(){
		return chkUpdate();
	});

	// 글 삭제 버튼 누르면 삭제 처리
	$("#deleteBtn").click(function(){
		if($("input:radio[name=stmt_uid]:checked").val()) {
			// 정말로 삭제할 것인지 사용자 니즈 탐색 후 삭제하기
			if(confirm('삭제된 전표는 복구가 어렵습니다.\n정말로 삭제하시겠습니까?')) {
				deleteByStmtUid();
			} else{
				alert('전표 삭제를 취소하셨습니다.');
				loadPage(window.page, window.choice);	// 현재 페이지 리로딩
			}
		} else {
			alert('삭제할 전표를 선택하지 않았습니다.\n전표를 선택해주세요.');
		}
		
	});
	
});






// page번째 페이지 로딩
function loadPage(page, choice) {
	// choice 변수를 통해 Flag
	// 결재 리스트인지 작성 리스트인지 파악하여 리스트 정보를 디비에서 받아와야함 
	switch(choice) {
	case 1:
		// 결제를 기다리고 있는 전표 목록
		$.ajax({
			url : "proceedList.ajax?page=" + page
			, type : "GET"
			, cache : false
			, success : function(data, status) {
				if(status == "success") {
					updateList(data);
				}
			}
		});
		break;
	case 2:
		// 작성한 전표 목록
		$.ajax({
			url : "writeList.ajax?page=" + page
			, type : "GET"
			, cache : false
			, success : function(data, status) {
			if(status == "success") {
				updateList(data);
				}
			}
		});
		break;
	}
} // end loadPage()
function updateList(jsonObj) {
	$("#list thead tr").remove();	// 기존 전표 목록 초기화
	$("#list tbody tr").remove();	// 기존 전표 목록 초기화
	$('.pagination>li').remove();	// 기존 페이지 초기화
	
	theadResult = "";
	tbodyResult = "";
	
	if(jsonObj.status == "OK") {
		var count = jsonObj.count;
		
		// 전역변수 업데이트!
		window.page = jsonObj.page;
		
		// 플러그 이용, 제목 변경
		switch(choice) {
			case 1:
				// 결제를 기다리고 있는 전표 목록인 경우
				$("#proceedHeader").attr('class','display-4 d-sm-block');
				$("#writeHeader").attr('class','display-4 d-none');
				break;
			case 2:
				//결제를 기다리고 있는 전표 목록인 경우
				$("#proceedHeader").attr('class','display-4 d-none');
				$("#writeHeader").attr('class','display-4 d-sm-block');
				break;
		}
		
		var i;
		var items = jsonObj.data;   // 배열
		
    	// 페이징
		switch(choice) {
		case 1:
			theadResult = "<th style='width: 15%; text-align: center;'>날짜</th>\n"
				+ "<th style='width: 15%; text-align: center;'>계정과목</th>\n"
				+ "<th style='width: 35%; text-align: center;'>적요</th>\n"
				+ "<th style='width: 20%; text-align: center;'>금액</th>\n"
				+ "<th style='width: 15%; text-align: center;'>결제 진행 사항</th>\n";
			$("#list thead").html(theadResult);  // 테이블 업데이트!
			for(i = 0; i < count; i++){
				tbodyResult += "<tr onclick=location.href='financialView.bn?stmtUid=" + items[i].stmt_uid 
				+ "' class='moveFinancialView'>\n"
				
				// 라디오 버튼 -> 수정과 삭제를 위해
				//tbodyResult += "<td style='width: 5%; text-align: center;'><input type='radio' name='stmt_uid' value='" + items[i].stmt_uid + "'></td>\n";
				// 전표번호
				//tbodyResult += "<td>" + items[i].stmt_uid + "</td>\n";
				// 날짜
				tbodyResult += "<td style='width: 15%; text-align: center;'>" + items[i].regDate + "</td>\n";
				// 계정과목
				tbodyResult += "<td style='width: 15%; text-align: center;''>" + accountName(items[i].account_uid) + "</td>\n";
				//result += "<td style='width: 15%; text-align: center;''>" + items[i].account_uid + "</td>\n";
				// 적요
				tbodyResult += "<td style='width: 35%; text-align: center;'>" + items[i].summary + "</td>\n";
				// 금액
				tbodyResult += "<td style='width: 20%; text-align: center;'>" + items[i].money + "</td>\n";
				// 결제라인
				tbodyResult += "<td style='width: 15%; text-align: center;'>" + proceedName(items[i].proceed) + "</td>\n";
							
				tbodyResult += "</tr>\n";
			} // end for
			$("#list tbody").html(tbodyResult);  // 테이블 업데이트!
			
			break;
		case 2:
			theadResult = "<th style='width: 5%;'></th>\n"
				+ "<th style='width: 15%; text-align: center;'>날짜</th>\n"
				+ "<th style='width: 15%; text-align: center;'>계정과목</th>\n"
				+ "<th style='width: 30%; text-align: center;'>적요</th>\n"
				+ "<th style='width: 20%; text-align: center;'>금액</th>\n"
				+ "<th style='width: 15%; text-align: center;'>결제 진행 사항</th>\n";
			$("#list thead").html(theadResult);  // 테이블 업데이트!
			
			for(i = 0; i < count; i++){
				tbodyResult += "<tr>\n";
				
				// 라디오 버튼 -> 수정과 삭제를 위해
				tbodyResult += "<td style='width: 5%; text-align: center;'><input type='radio' name='stmt_uid' value='" + items[i].stmt_uid + "'></td>\n";
				// 전표번호
				//tbodyResult += "<td>" + items[i].stmt_uid + "</td>\n";
				// 날짜
				tbodyResult += "<td style='width: 15%; text-align: center;'>" + items[i].regDate + "</td>\n";
				// 계정과목
				tbodyResult += "<td style='width: 15%; text-align: center;''>" + accountName(items[i].account_uid) + "</td>\n";
				//result += "<td style='width: 15%; text-align: center;''>" + items[i].account_uid + "</td>\n";
				// 적요
				tbodyResult += "<td style='width: 30%; text-align: center;'>" + items[i].summary + "</td>\n";
				// 금액
				tbodyResult += "<td style='width: 20%; text-align: center;'>" + items[i].money + "</td>\n";
				// 결제라인
				tbodyResult += "<td style='width: 15%; text-align: center;'>" + proceedName(items[i].proceed) + "</td>\n";
							
				tbodyResult += "</tr>\n";
			} // end for
			$("#list tbody").html(tbodyResult);  // 테이블 업데이트!
			
			break;
		}
		
		// 플러그 이용, 페이지 정보 업데이트
		switch(choice) {
			case 1:
				// 결제를 기다리고 있는 전표 목록
				$("#pageinfo").text("총 " + jsonObj.page + " 페이지 / " + jsonObj.totalpage + " 페이지(결제를 기다리고 있는 " + jsonObj.totalcnt + "개의 전표)");
				break;
			case 2:
				$("#pageinfo").text("총 " + jsonObj.page + " 페이지 / " + jsonObj.totalpage + " 페이지(내가 작성한 " + jsonObj.totalcnt + "개의 전표)");
				break;
		}
		
		// 페이징 업데이트
		var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows);
		$("#pagination").html(pagination);
		
		return true;
	} else {
		alert(jsonObj.message);
		return false;
	}
	return false;
} // end updateList()
// 결재라인 한글로 보여주기용
function proceedName(proceed) {
	switch (proceed) {
	case 1:
		return "담당자 결재 대기"
	case 2:
		return "결재자 결재 대기"
	case 3:
		return "최종 승인"
	case 4:
		return "승인 거절"
	}
}
function buildPagination(writePages, totalPage, curPage, pageRows){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성

	// 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
	var start_page = ((parseInt((curPage - 1) / writePages)) * writePages) + 1;
	var end_page = start_page + writePages - 1;
	
	if (end_page >= totalPage){
		end_page = totalPage;
	}

	// prev 표시
	if (start_page > 1) {
		str += "<li rel='prev' role='button' class='pointer-left'>"
			+ "<a onclick='loadPage(" + (start_page - 1) + ", " + choice + ")'>"
			+ "<span class='icon-pointer-button-square-left'><i class='fas fa-chevron-left'></i></span></a></li>\n";
	} 

	// 페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k) {
	        	str += "<li role='button' data-page='" + k + "'><a onclick='loadPage(" + k + ", " + choice + ")'>" + k + "</a></li>\n";
	        }
	        else {
	        	str += "<li role='active' data-page='" + k + "'>" + "<a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	        }
	    }
	}
	
	// next 표시
	if (totalPage > end_page){
		str += "<li rel='next' role='button' class='pointer-right'>"
    		+ "<a onclick='loadPage(" + (end_page + 1 ) + ", " + choice + ")'>"
    		+ "<span class='icon-pointer-button-square-right'><i class='fas fa-chevron-right'></i></span></a></li>";
    }
	
	return str;
} // end buildPagination()

//새 글 작성
function chkWrite() {
	
	// XMLHttpRequest 객체 생성
	var xhttp = new XMLHttpRequest(); 

	// name 값이 csrfmiddlewaretoken인 객체의 value 값을 가져와 csrf_token 이라는 변수에 할당
	var csrf_token = $('[name=_csrf]').val();

	// POST 요청 생성
	xhttp.open("POST", "writeOk.ajax", true);

	// header에 X-CSRFToken 키의 값으로 csrf_token 변수를 입력
	xhttp.setRequestHeader('X-CSRFToken', csrf_token);

	// 해당 폼 안의 name이 있는 것들을 끌어 들어옴, 리턴값은 Object
	var data = $("#frmWrite").serialize();
	

	
	// ajax reques
	$.ajax({
		url : "writeOk.ajax"
		, type : "POST"
		, dataType : 'json'
		, cache : false
		, data : data
		, async: false
		, success : function(data, status){
			if(status == "success"){
				if(data.status = "OK") {
					alert("전표가 생성되었습니다.");
					$("#WriteModal").modal('toggle');		// 모달창 닫기
					$('.modal-backdrop').remove(); 
					loadPage(window.page, window.choice);	// 현재 페이지 리로딩
					$('.btn-dismiss').trigger('click');
				} else {
					alert("전표 생성 실패 " + data.status + " : " + data.message);
				}
			} 
		}
	});
	
	// request 후, form 에 입력된것 reset()
	$("#frmWrite")[0].reset();
	
	return false;
	
} // end chkWrite();
// 계정과목 검색(새 글 작성용), 사용자 검색시
function search(word){ 
	$("#searchList td").remove();
	
	$.ajax({ 
		url : "search.ajax?word=" + word
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success"){
				var result = "";
				
				if(data.status == "OK") {
					var count = data.count;
					
					var i;
					
					// 읽어온 검색 데이터 저장
					var items = data.data;   // 배열
					
					// 검색된 자료만큼 내용 추가
					result += "<td style='border: none;'></td>\n";
					result += "<td style='border: none;'>";
					result += "<div style='border: 1px solid black;'>";
					for(i = 0; i < count; i++){
						result += "<div>"
						result += "<button type='button' class='searchValue' value='" + items[i].account_uid + "'> " + items[i].account_name + "</button>\n";
						result += "</div>"
					} // end for
					result += "</div>\n</td>\n";
					result += "<td style='border: none;'></td>\n";
					result += "<td style='border: none;'></td>\n";
					$("#searchList").append(result);  // 검색 리스트 업데이트
					
					// 스페이스 눌렀던거 공백 제거
					$("input[name='account_name']").val($("input[name='account_name']").val().trim());
					
					// 선택한 검색내용 세팅하고 검색 결과 삭제
					$(".searchValue").click(function(){
						$("input[name='account_uid']").val($(this).val());
						$("input[name='account_name']").val($(this).text());
						$("#searchList td").remove();
					});
				}
			}
		}
	});
} // end search()
// 계정과목 검색, 보여주기용
function accountName(account_uid) {
	var account_name = "";
	
	$.ajax({
		url : "searchName.ajax?account_uid=" + account_uid
		, type : "GET"
		, cache : false
		, async: false
		, success : function(data, status) {
			if(status == "success") {
				if(data.status == "OK"){
					account_name = data.data[0].account_name;
				}
			}
		}
	});
	return account_name;
} // end accountName()

// 글 수정 페이지 로딩
function loadView() {
	
	var stmt_uid = $("input:radio[name=stmt_uid]:checked").val();	// 전표 번호
	var thisLogId = $("input[name='thisLogId']").val();				// 현재 로그인된 아이디
	
	$.ajax({
		url : "viewDetail.ajax?stmt_uid=" + stmt_uid
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success"){
				if(data.status == "OK"){
					// 읽어온 view 데이터를 전역변수에 세팅
					viewItem = data.data[0];
					
					alert(thisLogId + ", " + viewItem.writer + "\n작성자와 현재 로그인한 사람이 일치합니다.");
					
					// 현재 로그인한 사람과 저장된 로그인이 일치하는지 확인
					if(thisLogId == viewItem.writer) {
						//alert('일치한다');
						
						// 팝업에 보여주기
						$("input[name='Umanager']").val(viewItem.manager);
						$("input[name='Uapprover']").val(viewItem.approver);
						$("input[name='UregDate']").val(viewItem.regDate);
						$("input[name='Uaccount_uid']").val(viewItem.account_uid);
						$("input[name='Uaccount_name']").val(accountName(viewItem.account_uid));
						$("input[name='Usummary']").val(viewItem.summary);
						$("input[name='Umoney']").val(viewItem.money);
						$("input[name='Ustmt_uid']").val(viewItem.stmt_uid);
						$("input[name='Uwriter']").val(viewItem.writer);
						
					} else {
						alert('작성자와 로그인한 사번이 일치하지 않습니다.');
						$("#UpdateModal").modal('toggle');
					}
					
				} else {
					alert("수정할 전표 불러오기 실패" + data.message);
				}
			}
		}
	});
} // end loadView();
// 글 수정용 계정과목 검색
function Usearch(word){ 

	$.ajax({ 
		url : "search.ajax?word=" + word
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success"){
				var result = "";
				
				if(data.status == "OK") {
					var count = data.count;
					
					var i;
					
					// 읽어온 검색 데이터 저장
					var items = data.data;   // 배열
					
					// 검색된 자료만큼 내용 추가
					result += "<td style='border: none;'></td>\n";
					result += "<td style='border: none;'>";
					result += "<div style='border: 1px solid black;'>";
					for(i = 0; i < count; i++){
						result += "<div>"
						result += "<button type='button' class='searchValue' value='" + items[i].account_uid + "'> " + items[i].account_name + "</button>\n";
						result += "</div>"
					} // end for
					result += "</div>\n</td>\n";
					result += "<td style='border: none;'></td>\n";
					result += "<td style='border: none;'></td>\n";
					$("#UsearchList").append(result);  // 검색 리스트 업데이트
					
					// 스페이스 눌렀던거 공백 제거
					$("input[name=Uaccount_name]").val($("input[name='Uaccount_name']").val().trim());
					
					// 선택한 검색내용 세팅하고 검색 결과 삭제
					$(".searchValue").click(function(){
						$("input[name='Uaccount_uid']").val($(this).val());
						$("input[name='Uaccount_name']").val($(this).text());
						$("#UsearchList td").remove();
					});
				}
			}
		}
	});
} // end Usearch()
// 글 수정
function chkUpdate() {
	
	// XMLHttpRequest 객체 생성
	var xhttp = new XMLHttpRequest(); 

	// name 값이 csrfmiddlewaretoken인 객체의 value 값을 가져와 csrf_token 이라는 변수에 할당
	var csrf_token = $('[name=_csrf]').val();

	// POST 요청 생성
	xhttp.open("POST", "updateOk.ajax", true);

	// header에 X-CSRFToken 키의 값으로 csrf_token 변수를 입력
	xhttp.setRequestHeader('X-CSRFToken', csrf_token);

	// 해당 폼 안의 name이 있는 것들을 끌어 들어옴, 리턴값은 Object
	var data = $("#frmUpdate").serialize();
	
	$.ajax({
		url : "updateOk.ajax",
		type : "POST",
		cache : false,
		data : data,
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					alert("전표 수정 성공하였습니다.");
					$("#UpdateModal").modal('toggle');		// 모달창 닫기
					$('.modal-backdrop').remove(); 
					loadPage(window.page, window.choice);	// 현재 페이지 리로딩
				} else {
					alert("전표 수정 실패 " + data.status + " : " + data.message);
				}
				
			}
		}
	});
	
	$("#frmUpdate")[0].reset();
	
	return false;
} // end chkUpdate()

// 글 삭제
function deleteByStmtUid() {
	
	var stmt_uid = $("input:radio[name=stmt_uid]:checked").val();

	$.ajax({
		url : "delete.ajax?stmt_uid=" + stmt_uid
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success"){
				if(data.status == "OK"){
					alert("전표 " + data.count + "개가 삭제되었습니다.");
					loadPage(window.page, 2);	// 현재 페이지 리로딩
				} else {
					alert("전표 삭제 실패 " + data.message);
				}
			}
		}
	});
} // end deleteByStmtUid()