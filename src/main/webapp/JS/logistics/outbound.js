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
		update2();
	});

});

function loadPage() {
	
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	
	$.ajax({
		url : "outboundList.ajax",
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
	if(book_isbn == null || book_isbn== 0 || book_isbn.length == 0) book_isbn = '[0-9]';
	
	/*alert(book_isbn);*/

		$.ajax({
			url : "outboundQuery1.ajax",
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
} // end query1()

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
	if(book_isbn == null || book_isbn== 0 || book_isbn.length == 0) book_isbn = '[0-9]';
	
	/*alert(book_isbn);*/

		$.ajax({
			url : "outboundQuery2.ajax",
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
} // end query2()

function update() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	
   var radio = $("#list tbody input[name=book_isbn]:checked"); 
   
   var param1 = radio.parent().parent().find("input[name=book_isbn]").val();
   var param2 = radio.parent().parent().find("input[name=price]").val();
   var param3 = radio.parent().parent().find("input[name=stock_quantity]").val();

   var book_isbn = param1;
   var price = param2;
   var stock_quantity = param3;
	   
	  /* alert(book_isbn);
	   alert(price);
	   alert(stock_quantity);*/
   

		if (!confirm("출고 처리"))
			return false;


		$.ajax({
			url : "outboundUpdate.ajax",
			type : "POST",
			data : {
				'book_isbn' : book_isbn,
				'price' : price,
				'stock_quantity' : stock_quantity
			},
			cache : false,
			success : function(data, status) {
				if (status == "success") {
					if (data.status == "OK") {
						alert("출고 완료" + data.count + "건");
						loadPage();

					} else {
						alert("출고 처리 실패" + data.message);
					}
				}
			}
		});
	
	return true;
}

function update2() {
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	var params = [];
	
	$("#list tbody input[name=book_isbn]").each(function(){
		if($(this).is(":checked")){
			params.push({
				book_isbn : $(this).val(),
				price : $(this).parent().parent().find("input[name=price]").val(),
				stock_quantity : $(this).parent().parent().find("input[name=stock_quantity]").val()
			});
		}
	});
	
	alert(Object.values(params[0]));
	
	
	
	
	if (params.length == 0) {
		alert('입고할 주문번호를 체크해주세요');
	} else {
		if (!confirm(params.length + "건의 발주를 입고 처리합니다"))
			return false;
	
	var jsonData = JSON.stringify(params);
	
	//alert(Object.keys(jsonData));
	//jQuery.ajaxSettings.traditional = true;
		
		
	$.ajax({
		url : "outboundUpdate.ajax",
		type : "POST",
		data : {"jsonData" : jsonData},
		dataType: 'json',
		cache : false,
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					alert("출고 완료" + data.count + "건");
					loadPage();
					
				} else {
					alert("출고 처리 실패" + data.message);
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
				result += "<td><input type='checkbox' name='book_isbn' value='" + items[i].book_isbn + "' checked></td>\n";
			} else {
				result += "<td><input type='checkbox' name='book_isbn' value='" + items[i].book_isbn + "'></td>\n";
			}
			result += "<td>-</td>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].book_isbn + "</td>\n";
			result += "<td><input style='width:80px' type='number' name='price' value='" + items[i].price + "' min='1'>원</td>\n";
			result += "<td><input style='width:50px' type='number' name='stock_quantity' value='" + items[i].stock_quantity + "' min='1' max='"+items[i].stock_quantity+"'>권</td>\n";
			result += "<td>-</td>\n";
			result += "<td>-</td>\n";
			result += "<tr>\n";
		} // end for
		$("#list tbody").html(result);

		return true;
		
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()

function listUp2(jsonObj) {
	result = "";

	if (jsonObj.status == "OK") {
		var count = jsonObj.count;

		var i;
		var items = jsonObj.data;
		for (i = 0; i < count; i++) {
			result += "<tr>\n";
			result += "<td><input type='radio' name='book_isbn' value='"
					+ items[i].book_isbn + "' disabled></td>\n";
			result += "<td>" + items[i].outbound_uid + "</td>\n";
			result += "<td>" + items[i].book_subject + "</td>\n";
			result += "<td>" + items[i].book_isbn + "</td>\n";
			result += "<td>" + numberWithCommas(items[i].outbound_unit_price) + "원</td>\n";
			result += "<td>" + items[i].outbound_quantitiy + "권</td>\n";
			result += "<td>" + numberWithCommas(items[i].outbound_unit_price * items[i].outbound_quantitiy) + "원</td>\n";
			result += "<td>" + items[i].outbound_date + "</td>\n";
			result += "<tr>\n";
		} // end for
		$("#list tbody").html(result);

		return true;
		
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp2()

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

