var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();

$(document).ready(function() {
	loadPage();

	$("#btnQuery").click(function() {
		var state = $("#query select[name=order_state]").val();
		if(state == 1) query1();
		if(state == 2) query2();
	});

	$("#btnUpdate").click(function() {
		update();
	}); 

	

});

function loadPage() {
	
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });

	$.ajax({
		url : "inboundList.ajax",
		type : "GET",
		cache : false,
		dataType : "json",
		success : function(data, status) {
			if (status == "success") {
				listUp1(data);
			}
		}
	});
}



function query1() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });

	 
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	var param = $("#query textarea[name=book_isbn]").val();
	if(regExp.test(param)){
		var temp = param.replace(regExp, "");
		param = temp;
	}
	
	var book_isbn = param.trim().replace(/[^0-9]/g, " ").replace(/ +/g, "|");
	if(book_isbn == null || book_isbn== 0|| book_isbn.length == 0) book_isbn = '[0-9]';
	
	/*alert(book_isbn);*/

		$.ajax({
			url : "inboundQuery1.ajax",
			type : "POST",
			data : { 
				'book_isbn' : book_isbn
			},
			cache : false,
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
	
	return true;
} // end query()

function query2() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	var param = $("#query textarea[name=book_isbn]").val();
	if(regExp.test(param)){
		var temp = param.replace(regExp, "");
		param = temp;
	}
	
	var book_isbn = param.trim().replace(/[^0-9]/g, " ").replace(/ +/g, "|");
	if(book_isbn == null || book_isbn== 0|| book_isbn.length == 0) book_isbn = '[0-9]';
	
	/*alert(book_isbn);*/

	
		$.ajax({
			url : "inboundQuery2.ajax",
			type : "POST",
			data : { 
				'book_isbn' : book_isbn
			},
			cache : false,
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp2(data);
				}
			}
		});
	
	return true;
} // end query()



function update() {
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	var order_uids = [];
	
	$("#list tbody input[name=order_uid]").each(function(){
		if($(this).is(":checked")){
			order_uids.push($(this).val());
		}
	});
	
	
	//alert(order_uids);
	
	if (order_uids.length == 0) {
		alert('입고할 주문번호를 체크해주세요');
	} else {
		if (!confirm(order_uids.length + "건의 발주를 입고 처리합니다"))
			return false;
		var data = $("#frmList").serialize();
		//alert(data);
		
		$.ajax({
			url : "inboundUpdate.ajax",
			type : "POST",
			data : data,
			cache : false,
			success : function(data, status) {
				if (status == "success") {
					if (data.status == "OK") {
						alert("입고 완료" + data.count + "건");
						loadPage();
						
					} else {
						alert("입고 처리 실패" + data.message);
					}
				}
			}
		});
	}
	return true;
}


function listUp1(jsonObj) {
	result = "";

	if (jsonObj.status == "OK") {
		var count = jsonObj.count;

		var i;
		var items = jsonObj.data;
		for (i = 0; i < count; i++) {
			result += "<tr>\n";
			if(i == 0) {
				result += "<td><input type='checkbox' name='order_uid' value='" + items[i].order_uid + "' checked></td>\n";
			} else {
				result += "<td><input type='checkbox' name='order_uid' value='" + items[i].order_uid + "'></td>\n";
			}
			result += "<td>-</td>\n";
			result += "<td>" + items[i].order_uid + "</td>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].book_isbn + "</td>\n";
			result += "<td>" + numberWithCommas(items[i].order_unit_cost) + "원</td>\n";
			result += "<td>" + items[i].order_quantity + "권</td>\n";
			result += "<td>" + items[i].order_date + "</td>\n";
			/*result += "<td>" + items[i].order_state + "</td>\n";*/
			result += "<td>-</td>\n";
			result += "<tr>\n";
		} // end for
		$("#list tbody").html(result);
		
		$(".table-background1 span").html(jsonObj.count);

		return true;
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end updateList()

function listUp2(jsonObj) {
	result = "";
	
	if (jsonObj.status == "OK") {
		var count = jsonObj.count;
		
		var i;
		var items = jsonObj.data;
		for (i = 0; i < count; i++) {
			result += "<tr>\n";
			result += "<td><input type='checkbox' name='order_uid' value='"
				+ items[i].order_uid + "' disabled></td>\n";
			result += "<td>" + items[i].inbound_uid + "</td>\n";
			result += "<td>" + items[i].order_uid + "</td>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].book_isbn + "</td>\n";
			result += "<td>" + numberWithCommas(items[i].order_unit_cost) + "원</td>\n";
			result += "<td>" + items[i].order_quantity + "권</td>\n";
			result += "<td>" + items[i].order_date + "</td>\n";
			/*result += "<td>" + items[i].order_state + "</td>\n";*/
			if(items[i].inbound_date == '1111-11-11') items[i].inbound_date = '-'
				result += "<td>" + items[i].inbound_date + "</td>\n";
			result += "<tr>\n";
		} // end for
		$("#list tbody").html(result);
		
		$(".table-background1 span").html(jsonObj.count);
		
		return true;
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end listUp2()


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

