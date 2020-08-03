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

// 날짜 담기,  변수 선언
var date2 = new Date(),
year = date2.getFullYear(),
month = date2.getMonth(),
day = date2.getDate(),
months = [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];

var h = addZero(date2.getHours());
var m = addZero(date2.getMinutes());
var s = addZero(date2.getSeconds());

var paramDate = year + "-" + months[month] + "-" + day + " " + h + ":" + m + ":" + s;

// [출근버튼을 누르면 ]
$(".goWork").on("click", function () {

	var goworkTime = year + "년 " + months[month] + "월 " + day + "일 " + h + "시 " + m + "분";
	
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
					alert(data.message);
				} else {
					alert("다시 처리해주세요.");
				}
			}
		}
	});
	$(this).removeClass("top-active-button").siblings().addClass("top-active-button");
	//$(this).attr('disabled', true);
	$('#changetext').text('출근시간  :  \n' + goworkTime);
	return false;
});

// [퇴근버튼 누르면]
$(".outWork").on("click", function () {
	
	
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
					
					if(data.countUpdate == 99){
						// 총근무시간 DB에 넣어주기 위한 ajax function 실행 
						alert(data.message);
					} else{
						alert(data.message);
						totalWorkTime();
					}
					
				} else {
					alert("출근을 먼저 등록해주세요");
				}
			}
		}
	});
	$(this).removeClass("top-active-button").siblings().addClass("top-active-button");
	//$(this).attr('disabled', true);
	$('#changetext').text('퇴근시간  :  \n' + outworkTime);
	return false;
});


function totalWorkTime(){
	
	// 총근무시간 넣어줘야 하니까 --> 파라메타로 무엇을 넘겨줘야 할까?
	// 쿼리 생각해보면, 퇴근시간에서 출근시간을 뺀 시간을 hours 로 변환해서  총근무시간 
	
	// 쿼리에서 퇴근시간 과 출근시간을 가져온다. 
	// 시간 차를 hours 로 바꾼다.
	// update 로 해당 username 의 total 업데이트한다. where 오늘날짜와 퇴근날짜가 같아야함.
	
	 $.ajaxSetup({
	     beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	      }
	 });
	  
	$.ajax({
		url : "totalwork.ajax?paramDate=" + paramDate,
		type : "post",
		dataType : 'json',
		cache : false,
		data : paramDate, // 퇴근시간을 ---> 파라메타로 보내주기
		success : function(data, status) {
			if (status == "success") { // 여기서의 success 는 코드 200
				if (data.status == "OK") { // 정상적으로 insert 되었다는 의미
					//alert("/totalwork.ajax 도 성공성공성공성공성공");
				} else {
					alert("/totalwork.ajax 실패......");
				}
			}
		}
	});
	return false;
}








