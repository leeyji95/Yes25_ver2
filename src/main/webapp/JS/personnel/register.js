// ★★★  글 작성 submit 되면 처리(여기서 백그라운드 request 보내줘야함)
$("#frmWrite").submit(function() {
	return chkWrite();
});

// form 에 action 주지 않고 submit 하면 자기 페이지로 request 보내어 리로딩됨
// 그래서 이 chkWrite () 를 false 처리 해야함.


// 새 글 등록 처리
function chkWrite() {

	// XMLHttpRequest 객체 생성
	var xhttp = new XMLHttpRequest();

	// name 이 _csrf 인 값의 token 값 -> 변수에 할당
	var csrf_token = $('[name=_csrf]').val();

	// POST 요청 생성 (요청방식, 요청주소, true/false)
	xhttp.open("POST", "writeOk.ajax", true);

	// request header에 X-CSRFToken 키의 값으로 csrf_token 변수를 입력
	xhttp.setRequestHeader('X-CSRFToken', csrf_token);

	// form 의 모든 name 들을 다 끌고 들어옴.
	var data = $("#frmWrite").serialize();
	// name=aaa&subject=bbb&content=ccc
	// alert(data + "--" + typeof data); // 리턴 Object 임.

	$.ajax({
		url : "writeOk.ajax",
		type : "post",
		dataType : 'json',
		cache : false,
		data : data, // POST 로 ajax request 하는 경우 parameter 담기
		success : function(data, status) {

			// alert("data: " + data);

			if (status == "success") { // 여기서의 success 는 코드 200
				if (data.status == "OK") { // 정상적으로 insert 되었다는 의미

					// loadPage(1); // 첫페이지 리로딩 되도록
					alert("등록 완료되었습니다.");
					location.href = 'main';
				} else {
					alert("등록 실패" + data.status + ": Err메시지: " + data.message);
				}
			}
		}

	});
	// request 후, form 에 입력된 것 reset()
	$('#frmWrite')[0].reset(); // 특정 object 만 reset 하는 애이다.
	// 제이쿼리 는 여러개의 오브젝트를 반환한다. 그래서 제이쿼리 셀렉터에서 특정 애 하나 꺼내어서 reset 해줘야한다.

	return false; // 페이지 리도딩은 안 할 것이다.
} // end chkWrite()

