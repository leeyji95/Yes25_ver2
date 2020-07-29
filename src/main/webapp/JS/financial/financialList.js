var page = 1	// 현재 페이지 
var start = ''		// 시작일
var end	= ''		// 종료일

$(document).ready(function() {
	
	// 오늘 날짜 구하기
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 

	var today = year + "-" + month + "-" + day;

	// 금일 리로딩
	$("#YearMonth").hide();
	loadPage(page, today, today);
	
	// 검색 카테고리
	$("#choiceYearMonth").change(function() {
		$("#YearMonth option").remove();
		
		var select = $("#choiceYearMonth option:selected").val();
		
		switch(select) {
		case 'today':
			start = today;	
			end = today;
			loadPage(page, start, end);
			$("#YearMonth").hide();
			break;
		case 'year':
			selectYear();
			$("#YearMonth").show();
			break;
		case 'month':
			selectMonth();
			$("#YearMonth").show();
			break;
		}
	});
	
});




// select 유동적으로 변경
function selectYear() {
	
	result = "<option value='2020' selected='selected'>2020년</option>\n"
		+ "<option value='2019'>2019년</option>\n"
		+ "<option value='2018'>2018년</option>\n";
	
	$("#YearMonth").html(result);
	
	// 기본 2020년 검색 결과 세팅
	start = '2020-01-01';	
	end = '2020-12-31';
	loadPage(page, start, end);
	
	$("#YearMonth").change(function() {
		select = $("#YearMonth option:selected").val();
		
		switch(select) {
		case '2020':
			start = '2020-01-01';	
			end = '2020-12-31';
			loadPage(page, start, end);
			break;
		case '2019':
			start = '2019-01-01';	
			end = '2019-12-31';
			loadPage(page, start, end);
			break;
		case '2018':
			start = '2018-01-01';	
			end = '2018-12-31';
			loadPage(page, start, end);
			break;
		}
		
	});
	
}
function selectMonth() {
	
	result = "<option value='1' selected='selected'>1월</option>"
		+ "<option value='2'>2월</option>"
		+ "<option value='3'>3월</option>"
		+ "<option value='4'>4월</option>"
		+ "<option value='5'>5월</option>"
		+ "<option value='6'>6월</option>"
		+ "<option value='7'>7월</option>"
		+ "<option value='8'>8월</option>"
		+ "<option value='9'>9월</option>"
		+ "<option value='10'>10월</option>"
		+ "<option value='11'>11월</option>"
		+ "<option value='12'>12월</option>"
	
	$("#YearMonth").html(result);
	
	// 기본 1월 검색 결과 세팅
	loadPage(page, '2020-01-01', '2020-01-01');
	
	$("#YearMonth").change(function() {
		select = $("#YearMonth option:selected").val();
		
		switch(select) {
		case '1':
			start = '2020-01-01';	
			end = '2020-01-31';
			loadPage(page, start, end);
			break;
		case '2':
			start = '2020-02-01';	
			end = '2020-02-29';
			loadPage(page, start, end);
			break;
		case '3':
			start = '2020-03-01';	
			end = '2020-03-31';
			loadPage(page, start, end);
			break;
		case '4':
			start = '2020-04-01';	
			end = '2020-04-30';
			loadPage(page, start, end);
			break;
		case '5':
			start = '2020-05-01';	
			end = '2020-05-31';
			loadPage(page, start, end);
			break;
		case '6':
			start = '2020-06-01';	
			end = '2020-06-30';
			loadPage(page, start, end);
			break;
		case '7':
			start = '2020-07-01';	
			end = '2020-07-31';
			loadPage(page, start, end);
			break;
		case '8':
			start = '2020-08-01';	
			end = '2020-08-31';
			loadPage(page, start, end);
			break;
		case '9':
			start = '2020-09-01';	
			end = '2020-09-30';
			loadPage(page, start, end);
			break;
		case '10':
			start = '2020-10-01';	
			end = '2020-10-31';
			loadPage(page, start, end);
			break;
		case '11':
			start = '2020-11-01';	
			end = '2020-11-30';
			loadPage(page, start, end);
			break;
		case '12':
			start = '2020-12-01';	
			end = '2020-12-31';
			loadPage(page, start, end);
			break;
		}
		
	});
}
//page번째 페이지 로딩
function loadPage(page, start, end) {
	console.log("페이지 로딩 : " + start + ", " + end);
	
	$.ajax({
		url : "financialDeptList.ajax?page=" + page + "&startDate="+ start + "&endDate=" + end
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success") {
				updateList(data);
			}
		}
	});
	
} // end loadPage()
function updateList(jsonObj) {
	$("#list tbody tr").remove();	// 기존 전표 목록 초기화
	$('.pagination>li').remove();	// 기존 페이지 초기화
	
	result = "";
	
	if(jsonObj.status == "OK") {
		var count = jsonObj.count;
		
		// 전역변수 업데이트!
		window.page = jsonObj.page;
		
		var i;
		var items = jsonObj.data;   // 배열
		
    	// 페이징
		for(i = 0; i < count; i++){
			result += "<tr>\n";
			
			// 삭제 버튼
			result += "<td style='width: 5%; text-align: center;'>"
				+ "<button class='stmtUidValue btn btn-default btn-lg skyinfo' style='color: white; width: 100%;' value='" 
				+ items[i].stmt_uid + "'>삭제</button></td>\n";
			// 전표번호
			//tbodyResult += "<td>" + items[i].stmt_uid + "</td>\n";
			// 날짜
			result += "<td style='width: 10%; text-align: center;'>" + items[i].regDate + "</td>\n";
			// 계정과목
			result += "<td style='width: 15%; text-align: center;''>" + accountName(items[i].account_uid) + "</td>\n";
			// 적요
			result += "<td style='width: 35%; text-align: center;'>" + items[i].summary + "</td>\n";
			// 금액
			result += "<td style='width: 20%; text-align: center;'>" + items[i].money + "</td>\n";
			// 결제라인
			result += "<td style='width: 15%; text-align: center;'>" + proceedName(items[i].proceed) + "</td>\n";
						
			result += "</tr>\n";
		} // end for
		$("#list tbody").html(result);  // 테이블 업데이트!
		
		// 만든 삭제 버튼이 눌릴때
		$(".stmtUidValue").click(function(){
			if(confirm('삭제 후 복구가 어렵습니다.\n정말로 삭제하시겠습니까?')) {
				deleteByStmtUid($(this).val());
				loadPage(page);
			} else {
				alert('삭제가 취소되었습니다.');
				loadPage(page);
			}
		});	
		
		// 페이지 정보 업데이트
		$("#pageinfo").text("총 " + jsonObj.page + " 페이지 / " + jsonObj.totalpage + " 페이지(검색된 전표 " + jsonObj.totalcnt + "개)");
		
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
	
	start += '';
	end += '';

	// prev 표시
	if (start_page > 1) {
		str += "<li rel='prev' role='button' class='pointer-left'>"
			+ "<a onclick='loadPage(" + (start_page - 1) + ", \'" + start + "\', \'" + end + "\')\">"
			+ "<span class='icon-pointer-button-square-left'><i class='fas fa-chevron-left'></i></span></a></li>\n";
	} 

	// 페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k) {
	        	str += "<li role='button' data-page='" + k + "'>"
	        		+ "<a onclick=\"loadPage(" + k + ", \'" + start + "\', \'" + end + "\')\">" + k + "</a></li>\n";
	        }
	        else {
	        	str += "<li role='active' data-page='" + k + "'>" + "<a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	        }
	    }
	}
	
	// next 표시
	if (totalPage > end_page){
		str += "<li rel='next' role='button' class='pointer-right'>"
    		+ "<a onclick='loadPage(" + (end_page + 1 ) + ", \'" + start + "\', \'" + end + "\')\">"
    		+ "<span class='icon-pointer-button-square-right'><i class='fas fa-chevron-right'></i></span></a></li>";
    }
	console.log("페이징 : " + start + ", " + end);
	return str;
} // end buildPagination()
//계정과목 검색, 보여주기용
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

//글 삭제
function deleteByStmtUid(stmt_uid) {
	
	$.ajax({
		url : "delete.ajax?stmt_uid=" + stmt_uid
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success"){
				if(data.status == "OK"){
					alert("전표 삭제 성공 " + data.count + "개");
					loadPage(window.page, 2);	// 현재 페이지 리로딩
				} else {
					alert("전표 삭제 실패 " + data.message);
				}
			}
		}
	});
} // end deleteByStmtUid()