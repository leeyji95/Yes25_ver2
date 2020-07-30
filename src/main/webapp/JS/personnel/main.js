var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();
$(document).ready(function() {
    
  $('[data-toggle=offcanvas]').click(function() {
    $('.row-offcanvas').toggleClass('active');
  });
  

  
});


// =====================================
// Get Date
// =====================================
var date = new Date(),
    year = date.getFullYear(),
    month = date.getMonth(),
    day = date.getDate(),
    months = [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];

document.getElementById('daymonthyear').innerHTML = year + "년 " + months[month] + " " + day + "일 "  ;

// =====================================
// Get Time
// =====================================

function addZero(i) {
// This checks to see if the number is below 10 and then prepends a '0' - clever shit :P
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

function newTime() {
    var d = new Date();
    var h = addZero(d.getHours());
    var m = addZero(d.getMinutes());
    var s = addZero(d.getSeconds());
    var x = document.getElementById("hourminutesecond");

    x.innerHTML = h + " : " + m + " : " + s;
}

newTime();
setInterval(newTime, 1000);



//----------------------------------------------------------------
$(document).ready(function() {
	const $app = $('.app');
	const $img = $('.app__img');
	let animation = true;
	let curSlide = 1;
	let scrolledUp, nextSlide;
	
	let pagination = function(slide, target) {
		animation = true;
		if (target === undefined) {
			nextSlide = scrolledUp ? slide - 1 : slide + 1;
		} else {
			nextSlide = target;
		}
	}
	
	let navigateDown = function() {
		if (curSlide > 1) return;
		scrolledUp = false;
		pagination(curSlide);
		curSlide++;
	}

	setTimeout(function() {
		$app.addClass('initial');
	}, 1000);

	setTimeout(function() {
		animation = false;
	}, 4500);

});
 


//  //////////////////////////////////////////_____버_____튼______//////////////////////////////// 
//$(".to-signin").on("click", function () {
//  $(this)
//    .addClass("top-active-button")
//    .siblings()
//    .removeClass("top-active-button");
//});
//
//$(".to-signup").on("click", function () {
//  $(this)
//    .addClass("top-active-button")
//    .siblings()
//    .removeClass("top-active-button");
//});

// 날짜 담기,  변수 선언
var date2 = new Date(),
year = date2.getFullYear(),
month = date2.getMonth(),
day = date2.getDate(),
months = [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];

var h = addZero(date2.getHours());
var m = addZero(date2.getMinutes());
var s = addZero(date2.getSeconds());

// [출근버튼을 누르면 ]
$(".goWork").on("click", function () {

	var paramDate = year + "-" + months[month] + "-" + day + " " + h + ":" + m + ":" + s;
	var goworkTime = year + "년 " + months[month] + "월 " + day + "일 " + h + "시 " + m + "분";
	//alert(paramDate);
	//alert(goworkTime);
	
	 $.ajaxSetup({
	     beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	      }
	 });
	  
	$.ajax({
		url : "gowork.ajax?paramDate=" + paramDate,
		type : "post",
		dataType : 'json',
		cache : false,
		data : paramDate, // POST 로 ajax request 하는 경우 parameter 담기
		success : function(data, status) {
			//alert("goworkDate :::: " + goworkDate);
			if (status == "success") { // 여기서의 success 는 코드 200
				if (data.status == "OK") { // 정상적으로 insert 되었다는 의미
					alert(data.message + " " + goworkTime);
				} else {
					alert("다시 처리해주세요.");
				}
			}
		}
	});
	$(this).removeClass("top-active-button").siblings().addClass("top-active-button");
	//$(this).attr('disabled', true);
	$('#changetext').text('출근시간  :  ' + goworkTime);
	return false;
});

// [퇴근버튼 누르면]
$(".outWork").on("click", function () {
	
	var paramDate = year + "-" + months[month] + "-" + day + " " + h + ":" + m + ":" + s;
	var outworkTime = year + "년 " + months[month] + "월 " + day + "일 " + h + "시 " + m + "분";
	
	 $.ajaxSetup({
	     beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	      }
	 });
	  
	$.ajax({
		url : "outwork.ajax?paramDate=" + paramDate,
		type : "post",
		dataType : 'json',
		cache : false,
		data : paramDate, // POST 로 ajax request 하는 경우 parameter 담기
		success : function(data, status) {
			if (status == "success") { // 여기서의 success 는 코드 200
				if (data.status == "OK") { // 정상적으로 insert 되었다는 의미
					
					// 총근무시간 DB에 넣어주기 위한 ajax function 실행 
					totalWorkTime();
					alert(data.message + "\n " + outworkTime);
					
				} else {
					alert("다시 처리해주세요.");
				}
			}
		}
	});
	$(this).removeClass("top-active-button").siblings().addClass("top-active-button");
	//$(this).attr('disabled', true);
	$('#changetext').text('퇴근시간  :  ' + outworkTime);
	return false;
});


function totalWorkTime(){
	
	// 총근무시간 넣어줘야 하니까 --> 파라메타로 무엇을 넘겨줘야 할까?
	// 쿼리 생각해보면, 퇴근시간에서 출근시간을 뺀 시간을 hours 로 변환해서  총근무시간 
	
	
}








