$(document).ready(function() {
	// 계정과목 한글로 변경
	account_uid = $("input[name='accountUid']").val();	
	$("#accountNameUid").text(accountName(account_uid));
	
	// 작성자 한글로 변경
	writerNo = $("input[name='writerNo']").val();
	$("label[for='writerNo']").text(writerNo + " " + userInfo(writerNo));
	// 담당자 한글로 변경
	managerNo = $("input[name='managerNo']").val();
	$("label[for='managerNo']").text(managerNo + " " + userInfo(managerNo));
	// 결재자 한글로 변경
	approverNo = $("input[name='approverNo']").val();
	$("label[for='approverNo']").text(approverNo + " " + userInfo(approverNo));
});




// 계정과목 한글로 변경
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
function userInfo(username) {
	var word = "";

	$.ajax({
		url : "userInfo.ajax?username=" + username
		, type : "GET"
		, cache : false
		, async: false
		, success : function(data, status) {
			if(status == "success"){
				if(data.status == "OK"){
					word = data.data.name + " " + deptName(data.data.deptno);
				}
			}
		}
	});
	
	return word;
	
} // end userInfo()
function deptName(deptNo) {
	switch(deptNo) {
	case 10:
		return '인사팀';
	case 20:
		return '재무팀';
	case 30:
		return '제품팀';
	case 40:
		return '물류팀';
	case 50:
		return '구매팀';
	}
} // end deptName()