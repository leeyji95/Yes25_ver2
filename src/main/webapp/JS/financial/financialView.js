$(document).ready(function() {
	// 계정과목 한글로 변경
	account_uid = $("input[name='accountUid']").val();	
	$("#accountNameUid").text(accountName(account_uid));
	
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