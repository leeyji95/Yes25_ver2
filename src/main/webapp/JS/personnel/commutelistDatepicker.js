var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();


var monthFormatter = new Intl.DateTimeFormat("ko-KR", { month: "long" });
var weekdayFormatter = new Intl.DateTimeFormat("ko-KR", { weekday: "long" });

var dates = [];
dates[0] = new Date(); // defaults to today
dates[1] = addDays(dates[0], 31);

var currentDate = 0; // index into dates[]
var previousDate = 1;

var datesBoxes = $(".date-picker-date");
var displayBoxes = $(".date-picker-display");

// sensible default just in case jQuery doesn't kick in
// makes sure that the experience is still usable, and when $(window).width()
// returns then this variable is updated to the correct value
var windowWidth = 300;
var colourPickerWidth = 300;

var getDateResult = "";
var formattedDate = "";

 // set up dates
 $(document).ready(function() {
 // will work the same the first time as every other
  updateDatePicker();
  
  // update dates shown to correct dates
  $(datesBoxes[0]).text(getDateString(dates[0]));
//  //alert("첫번째 날짜: " + getDateResult);
//  
  $(datesBoxes[1]).text(getDateString(dates[1]));
  //alert("두번쨰 날짜: " + getDateResult);
  
  $(displayBoxes[0]).text(dates[0].getDate() + " " + monthFormatter.format(dates[0]).slice(0,3));
  $(displayBoxes[1]).text(dates[1].getDate() + " " + monthFormatter.format(dates[1]).slice(0,3));
  
 });
 
 
// add event listeners
$(document).ready(function() {
	
  // has to be applied each time, as it's removed when calendar is reset
//  applyDateEventListener(); // 이놈이다!!!!! 이놈떄문에 계속 두번 찍혓다..
  
  // 데이트피커 토글
  $(".date-picker-date").click(function(e) {
    // if active, toggle picker off and return
    var currentlyActive = $(this).hasClass("active");
    if (currentlyActive) {
      $(this).removeClass("active");
      hideDatePicker();
      return;
    }
    
    $(".date-picker-date").removeClass("active");
    $(this).addClass("active");
    
    // update currentDate
    previousDate = currentDate;
    if ($(this)[0].id == "date-picker-date-first") {
      currentDate = 0;
    } else {
      currentDate = 1;
    }
    
    // update calendar
    showDatePicker(e);
    updateDatePicker();

    
  });
  
  $("#date-picker-next-month").click(function() {
    changeMonth("Next");
  });
  
  $("#date-picker-previous-month").click(function() {
    changeMonth("Previous");
  });
  
  $("#date-picker-exit").click(function() {
    hideDatePicker();
  });
  
  $(document).click(function(e) {
    var target = $(e.target);
    var clickedOnPicker = (target.closest("#date-picker-modal").length);
    var clickedOnDate = (target.closest(".date-picker-date").length);
    var isPreviousOrNext = target.hasClass("previous-month") || target.hasClass("next-month");
    
    if (!(clickedOnPicker || clickedOnDate || isPreviousOrNext)) {
      hideDatePicker();
    }
  });
  
});

// called on initialising (set to today) and then every time the month changes
// or on moving between dates
function updateDatePicker(changeMonth = false) {
  
  var datePicker = $("#date-picker");
  var curDate = dates[currentDate]; // shorthand
  
  // check if it needs to update
  // updates if changed month directly (changeMonth) or if switched to other
	// .date-picker-date and month is different (differentMonth)
  var differentMonth = checkChangedMonth();
  if (changeMonth === false && differentMonth === false) { return; }
  
  updatePickerMonth();
  
  // clear out all tr instances other than the header row
  // really just removing all rows and appending header row straight back in
  var headerRow = `
    <tr id="date-picker-weekdays">
      <th>S</th>
      <th>M</th>
      <th>T</th>
      <th>W</th>
      <th>T</th>
      <th>F</th>
      <th>S</th>
    </tr>`;
  // clear all rows
  datePicker.contents().remove();
  datePicker.append(headerRow);
  
  var todayDate = curDate.getDate();
  var firstOfMonth = new Date(curDate.getFullYear(), curDate.getMonth(), 1);
  var firstWeekday = firstOfMonth.getDay(); // 0-indexed; 0 is Sunday, 6 is
											// Saturday
  var lastMonthToInclude = firstWeekday; // happily, this just works as-is.
  var firstOfNextMonth = addMonths(firstOfMonth, 1);
  var lastOfMonth = addDays(firstOfNextMonth, -1).getDate();
  
  var openRow = "<tr class='date-picker-calendar-row'>";
  var closeRow = "</tr>";
  var currentRow = openRow;
  
  // Add in as many of last month as required
  if (lastMonthToInclude > 0) {
    var lastMonthLastDay = addDays(firstOfMonth, -1);
    var lastMonthDays = lastMonthLastDay.getDate();
    var lastMonthStartAdding = lastMonthDays - lastMonthToInclude + 1;
    
    // add days from previous month
    // takes arguments (start loop, end loop <=, counter, 'true' if current
	// month OR class if another month (optional, default "") )
    // addToCalendar(lastMonthStartAdding, lastMonthDays, 0, "previous-month");
    // addToCalendar(lastMonthStartAdding, lastMonthDays, 0, "month-previous");
    addToCalendar(lastMonthStartAdding, lastMonthDays, 0, "previous-month");
  }
  
  // fill out rest of row with current month
  // doesn't matter how many of last month were included, all accounted for
  addToCalendar(1, 7 - lastMonthToInclude, lastMonthToInclude, true);
  
  // reset for current month generation
  currentRow = openRow;
  
  var counter = 7;
  var addedFromCurrentMonth = 7 - firstWeekday + 1;
  
  addToCalendar(addedFromCurrentMonth, lastOfMonth, counter, true);
  
  // at this point, counter = all of this month + whatever was included from
	// last month
  counter = lastMonthToInclude + lastOfMonth;
  var nextMonthToInclude = counter % 7 === 0 ? 0 : 7 - (counter % 7);
  
  addToCalendar(1, nextMonthToInclude, counter, "next-month");
  
  // add event listener again
  applyDateEventListener();
  
  // update current date box
  updateDateShown();
  

  
  // functions scoped to this outer function
  // ############################################################
  function checkChangedMonth() {
    // updates if changed month directly (changeMonth) or if switched to other
	// .date-picker-date and month is different (differentMonth)
    var differentMonth = false;
    // checks if it's the same date again
    if (currentDate !== previousDate) {
      // if either month or year are different then month has changed
      if (dates[0].getMonth() !== dates[1].getMonth() || dates[0].getYear() !== dates[1].getYear() ) {
        differentMonth = true;
      }
    }
    
    return differentMonth;
    
  }
  
  function addToCalendar(start, end, counter, cellClass) {
    
    var currentMonth = cellClass === true ? true : false;
    
    for (var i = start; i <= end; i++) {
      counter += 1;
      if (i === todayDate && currentMonth) {
        currentRow += `<td class="active">${i}</td>`;
      } else if (cellClass && !currentMonth) {
        currentRow += `<td class="${cellClass}">${i}</td>`;
      } else {
        currentRow += `<td>${i}</td>`;
      }
      if (counter % 7 === 0) {
        datePicker.append(currentRow + closeRow);
        currentRow = openRow;
      }
    }
  }
}

function updatePickerMonth() {
  var monthName = monthFormatter.format(dates[currentDate]);
  var year = dates[currentDate].getFullYear();
  var dateText = monthName + " " + year;
  $("#date-picker-month").text(dateText);
}

// 'direction' can be either "Next" or "Previous"
function changeMonth(direction) {
  
  var increment = direction === "Next" ? 1 : -1;
  
  // change month
  dates[currentDate] = addMonths(dates[currentDate], increment);
  
  // change month name in picker
  updatePickerMonth();
  
  // update calendar
  // passes 'true' that month has changed
  updateDatePicker(true);
}

function showDatePicker(e) {
  
  var pxFromTop = $(".date-picker-date").offset().top;
  var datePicker = $("#date-picker-modal");
  datePicker.css("top", pxFromTop + 40);
  // check if right edge of colourPicker will go off the edge of the screen,
	// and if so then reduce left by that amount
  var rightEdge = e.pageX + colourPickerWidth;
  var overflowWidth = rightEdge - 650;
  // alert(rightEdge); //1251
  // alert(overflowWidth); //-455
  // alert(windowWidth); //
  if (overflowWidth > 0) {
    datePicker.css("left", e.pageX - overflowWidth);
  } else {
    datePicker.css("left", e.pageX);
  }
  
  $("#date-picker-modal").removeClass("hidden-2");
}

function hideDatePicker() {
  $(".date-picker-date").removeClass("active");
  $("#date-picker-modal").addClass("hidden-2");
}

function applyDateEventListener() {  // ★★★ 날짜 적용 / 날짜 클릭 시 발생하는 이벤트 함수 ★★★★ 여기서 날짜 파라메타값 보내주기  
  
  $("#date-picker td").click(function() { // 날짜 클릭하면...
    
    // Calendar UI
    $("#date-picker td").removeClass("active");
    $(this).addClass("active");
    
    // update variables
    currentDay = $(this).text(); // 일자 찍힘
    
    // update the current date
    dateSelected(currentDay);  // 선택된 일자로 update 함수 실행

    // change month based on calendar day class
    if ($(this).hasClass("previous-month")) {
      changeMonth("Previous");
    } else if ($(this).hasClass("next-month")) {
      changeMonth("Next");
    } else {
      // clicked in current month; made selection so hide picker again
      hideDatePicker();
    }
  });
  
}
function dateSelected(currentDay) {
	  
	  // update the active .date-picker-date with the current date
	  var activeDate = $( $(".date-picker-date.active")[0] ); 
	  // active 된 date-picker 가진 친구 데려왔어.
	  
	  // get current date and update
	  dates[currentDate].setDate(currentDay);  // 현재 일자로 date 수정
	  //alert("dates[currentDate].setDate(currentDay)" + dates[currentDate].setDate(currentDay));
	  formattedDate = getDateString(dates[currentDate]);
	  
//	  var arr = {'startDate' : formattedDate};
////	  alert(arr[Object.keys(arr)[0]]);
//	  
//	  var start = $('#frm [name=start]').val(arr[Object.keys(arr)[0]]);
//	  alert(start.val());
//	  
//	  var end = $('#frm [name=end]').val(arr[Object.keys(arr)[0]]);
//	  alert(start.val() + " " + end.val());
	  
//	  var date1Text = $('div.date1').text();
//	  alert("date1Text  :::  " +   date1Text);
	  
	  
	  
	  
	  
	  // 요놈이다 
	  // 여기서 날짜 파라메타값 찍기 
	  
	  updateDateShown();
	 
}

function updateDateShown() {
	  formattedDate = getDateString(dates[currentDate]); // getDateResult 결과임.
	  var updateDateBox = $(datesBoxes[currentDate]);
	  
	  var updateDisplayBox = $(displayBoxes[currentDate]) ;// var datesBoxes = $(".date-picker-date");
	  var dayAndMonth = dates[currentDate].getDate() + " " + monthFormatter.format(dates[currentDate]).slice(0,3);
	  
	  updateDateBox.text(formattedDate);// getDateResult 결과를 div text로 쏴줌.
	  updateDisplayBox.text(dayAndMonth);
	  

	}


//courtesy of https://stackoverflow.com/a/15764763/7170445
function getDateString(date) {
  var year = date.getFullYear();

  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;

  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  
//  getDateResult = year + '-' + month + '-' + day ;
  getDateResult = year + '-' + month + '-' + day;
  
//  return year + '년' + month + '월' + day + '일'; // 얘를 파라메타로 보내기
  return getDateResult;
}

// Utilities
// ################################################################
// set location for date picker
$(document).ready(function() {
  updateWidths();
});

$(window).resize(function() {
  updateWidths();
});

function updateWidths() {
  windowWidth = $(window).width();
}

// courtesy of
// https://stackoverflow.com/questions/563406/add-days-to-javascript-date
function addDays(date, days) {
  var result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
}

function addMonths(date, months) {
  var result = new Date(date);
  result.setMonth(result.getMonth() + months);
  return result;
}



//---------------------------------------------------------------------------------------------


var inputStart = "";
var inputEnd = "";
var page = 1 // 현재 페이지
var pageRows = 10 // 한 페이지에 보여지는 게시글 개수

$('.btn').on("click", function(){
	
	// div 의 text  뽑기
	var date1Text = $('div.date1').text();	
	var date2Text = $('div.date2').text();	
//	alert("date1Text : " + date1Text);
//	alert("date2Text : " + date2Text);
	
	$('#startDate').val(date1Text);
	$('#endDate').val(date2Text);

	inputStart = $('#startDate').val();
	inputEnd = $('#endDate').val();
	
	sendParam();
	
	return false;
});

function sendParam(){
	 
	$.ajaxSetup({
		beforeSend: function(xhr) {
		xhr.setRequestHeader(header, token);
      }
	});
	
	var data = $('#frm').serialize();
	
	$.ajax({
		url : "cmmtlist.ajax?page=" + page + "&pageRows=" + pageRows,
		type : "post",
		cache : false,
		data : data, 
		dataType : 'json',
		success : function(data, status) {
			alert("AJAX 성공 : request 성공"); // 최초 로딩 시 뜸 
			if (status == "success") { // 여기서의 success 는 코드 200
				if (data.status == "OK") { // 정상적으로 insert 되었다는 의미
					
					updateList(data);
					
				} else {
					alert("조회실패 " + data.message);
				}
			}
		}
	});
	
}

function updateList(jsonObj){
	
	result = "";  
	
	if(jsonObj.status == "OK"){
		alert(jsonObj.message);
		var count = jsonObj.count;
		
		// 전역변수를 여기서 업데이트합니다.(분명 내가 서버단에 디폴트로 한 값과 다름)
		// 전역 변수 업데이트 !
		window.page = jsonObj.page;
		window.pageRows = jsonObj.pagerows;
		
		var i;
		var items = jsonObj.data; // 배열
		for(i = 0; i < count; i++){
			// result 문자열 조립할 거고, 포문 다끝나면 
			result += "<tr>\n";
			result += "<td>" + items[i].cmmtDate + "</td>\n"; /* 어떤 엘리먼트에도 원하는 값을 꽂아 넣을 수 있다. data-(원하는 이름)*/
			result += "<td>" + items[i].cmmtStart + "</td>\n";
			result += "<td>" + items[i].cmmtEnd + "</td>\n";
			result += "<td>" + items[i].cmmtOver + "시간</td>\n";
			result += "<td>" + items[i].cmmtState + "</td>\n";
			result += "<td>" + items[i].cmmtTotal + "시간</td>\n";
			result += "<td>" + items[i].cmmtIsApply + "</td>\n";
			result += "</tr>\n";
		} // end for
		$("#list tbody").html(result); // 테이블 업데이트 ! 
		
		// 페이지 정보 업데이트 
		$('#pageinfo').text( jsonObj.count + "개 근태현황");
		
		// pageRows
		var txt = "<select id='rows' onchange='changePageRows()'>\n";
		txt += "<option " + ((window.pageRows == 10)?"selected":"") + " value='10'>10개씩</option>\n";
		txt += "<option " + ((window.pageRows == 20)?"selected":"") + " value='20'>20개씩</option>\n";
		txt += "<option " + ((window.pageRows == 50)?"selected":"") + " value='50'>50개씩</option>\n";
		txt += "<option " + ((window.pageRows == 100)?"selected":"") + " value='100'>100개씩</option>\n";		
		txt += "</select>\n";
		$("#pageRows").html(txt);

		// 페이징 업데이트
		var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows);
		$("#pagination").html(pagination);
		
		
		return true;
	} else{
		alert(jsonObj.message);
		return false;
	}
	return false;
} // end updateList

function buildPagination(writePages, totalPage, curPage, pageRows){
	
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
  //■ << 표시 여부
	if(curPage > 1){
		str += "<li><a class='tooltip-top' title='처음'><i class='fas fa-angle-double-left'></i></a></li>\n";
	}
	
  	//■  < 표시 여부
    if (start_page > 1) 
    	str += "<li><a onclick='loadPage(" + (start_page - 1) + ")' class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n";
    
    //■  페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li><a onclick='loadPage(" + k + ")'>" + k + "</a></li>\n";  // k번째 페이지로 이동
	        else
	            str += "<li><a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	//■ > 표시
    if (totalPage > end_page){
    	str += "<li><a onclick='loadPage(" + (end_page + 1) + ")' class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n";
    }

	//■ >> 표시
    if (curPage < totalPage) {
        str += "<li><a onclick='loadPage(" + totalPage + ")' class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n";
    }

    return str;


	
} // end buildPagination()


function changePageRows(){
	window.pageRows = $("#rows").val(); 
	loadPage(window.page);
}

//page 번째 페이지 로딩 
function loadPage(page){
	
	$.ajax({
		url : "cmmtlist.ajax?page=" + page + "&pageRows=" + pageRows
		, type : "get"
		, cache : false
		, success : function(data, status){
			if(status == "success"){
				
				//alert("AJAX 성공 : request 성공"); // 최초 로딩 시 뜸 
				if(updateList(data)){
					
					// 업데이트된 list 에 필요한 이벤트 가동
					// ★만약 위 코드를 $(document).ready() 에 두면 동작 안할 것이다. 
					// 뭐가 완료된 시점에서 뭐가 실행되어야 하는지 정확히 알아야 함. =======>   //클릭하는 리스너는 페이지 로딩이 끝난 시점에 동작하도록 해야 실행된다. 
				} // end if
			}
		}
	});
	
} // end loadPage()


























































