var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest();

var today = new Date();
var year = today.getFullYear();
var month = today.getMonth() + 1;
//alert(year +"/"+month);

var flag = 0;

$(document).ready(function() {
	loadPage();
	
	$("#btnLeft").click(function() {
		month = month-1;
		if(month>0){
		$(".div_datepicker span#month").html(month);
		query(month);
		} else{
			$("#btnLeft").disabled = true;
		}
	});
	
	$("#btnRight").click(function() {
		month = month+1;
		if(month<13){
		$(".div_datepicker span#month").html(month);
		query(month);
		} else{
			$("#btnRight").disabled = true;
		}
	});

	$("#btnMonth").click(function() {
		$("#btnMonth").disabled = true;
		$("#btnDay").disabled = false;
		flag = 1;
		update2();
		$('.div_datepicker').css("visibility", "hidden");
		$('.div_datepicker span#year').css("visibility", "visible");
		$(this).css('background-color','white');
		$(this).css('color','#007bff');
		
		$("#btnDay").css('color','white');
		$("#btnDay").css('background','#007bff');

	});

	$("#btnDay").click(function() {
		$("#btnDay").disabled = true;
		$("#btnMonth").disabled = false;
		flag = 0;
		update1();
		$('.div_datepicker').css("visibility", "visible");
		
		$(this).css('background-color','white');
		$(this).css('color','#007bff');
		
		$("#btnMonth").css('color','white');
		$("#btnMonth").css('background','#007bff');
	});
	

});

function loadPage() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	 $(".div_datepicker span#month").html(month);
	 
	 
		$.ajax({
			url : "inboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
		
		$.ajax({
			url : "inboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform1(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp2(data);
				}
			}
		});
		
		
		$.ajax({
			url : "outboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform2(data);
				}
			}
		});
		
		
		
}


function query(month) {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	 
		$.ajax({
			url : "inboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
		
		$.ajax({
			url : "inboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform1(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp2(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform2(data);
				}
			}
		});
}

function update1() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	 $(".div_datepicker span#month").html(month);
	 
		$.ajax({
			url : "inboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
		
		$.ajax({
			url : "inboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform1(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiList.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp2(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiInform.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year,
				'month': month
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform2(data);
				}
			}
		});
}



function update2() {
	 $.ajaxSetup({
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader(header, token);
	         }
	    });
	 
	 
		$.ajax({
			url : "inboundKpiUpdate.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp1(data);
				}
			}
		});
		
		$.ajax({
			url : "inboundKpiInformUpdate.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform1(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiUpdate.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					listUp2(data);
				}
			}
		});
		
		$.ajax({
			url : "outboundKpiInformUpdate.ajax",
			type : "POST",
			cache : false,
			data : {
				'year': year
			},
			dataType : "json",
			success : function(data, status) {
				if (status == "success") {
					inform2(data);
				}
			}
		});
}



function listUp1(jsonObj) {
	var chartLabels =[];
	var chartData =[];

	if (jsonObj.status == "OK") {
		var count = jsonObj.count;
		
		var i;
		var items = jsonObj.data;
/*		for (i = 0; i < 31; i++) {
			chartLabels.push(i+1);
		} // end for
*/		
		if(flag == 0){
			for (i = 0; i < count; i++) {
				chartLabels.push(items[i].c_day);
				chartData.push(items[i].c_quantity);
			} // end for
		} else{
			for (i = 0; i < count; i++) {
				chartLabels.push(items[i].c_month);
				chartData.push(items[i].c_quantity);
			} // end for
		}
		
		 var ctx = document.getElementById('myChart1');
		 var myChart = new Chart(ctx, {
			 type: 'line',
			 data: {
				 labels: chartLabels,
				 datasets: [{
					 	label: '입고량',
					 	data: chartData,
					 	backgroundColor: [
					 		'rgba(255, 99, 132, 0.2)'
					 	],
					 	borderColor: [
					 		'rgba(255, 99, 132, 1)'
					 	],
					 	borderWidth: 1
				 }]
			 },
			 options: {
				 	responsive: true,
				 	scales: {
				 			yAxes: [{
				 					ticks: {
				 							beginAtZero: true
				 					}
				 			}]
				 	},
				 	legend: {
				        display: false
				    },
				    tooltips: {
				        callbacks: {
				           label: function(tooltipItem) {
				                  return tooltipItem.yLabel;
				           }
				        }
				    }
			 }
		 });
		
		return true;
		
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()

function listUp2(jsonObj) {
	var chartLabels =[];
	var chartData =[];

	if (jsonObj.status == "OK") {
		
		var count = jsonObj.count;
		var i;
		var items = jsonObj.data;
/*		for (i = 0; i < 31; i++) {
			chartLabels.push(i+1);
		} // end for
*/		
		if(flag == 0){
			for (i = 0; i < count; i++) {
				chartLabels.push(items[i].c_day);
				chartData.push(items[i].c_quantity);
			} // end for
		} else{
			for (i = 0; i < count; i++) {
				chartLabels.push(items[i].c_month);
				chartData.push(items[i].c_quantity);
			} // end for
		}
		
		var ctx = document.getElementById('myChart2');
		var myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: chartLabels,
				datasets: [{
					label: '출고량',
					data: chartData,
					backgroundColor: [
						'rgba(54, 162, 235, 0.2)'
						],
						borderColor: [
							'rgba(54, 162, 235, 1)'
							],
							borderWidth: 1
				}]
			},
			options: {
				responsive: true,
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero: true
						}
					}]
				},
				legend: {
			        display: false
			    },
			    tooltips: {
			        callbacks: {
			           label: function(tooltipItem) {
			                  return tooltipItem.yLabel;
			           }
			        }
			    }
			}
		});
		
		return true;
		
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()

function inform1(jsonObj) {

	if (jsonObj.status == "OK") {
		
		$("strong.item_value1").html(jsonObj.data[0].c_quantity);

		return true;
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()

function inform2(jsonObj) {

	if (jsonObj.status == "OK") {
		
		$("strong.item_value2").html(jsonObj.data[0].c_quantity);
		
		$("strong.item_value3").text($("strong.item_value1").text() - $("strong.item_value2").text());
		
		return true;
	} else {
		alert(jsonObj.message);
		return false;
	} // end if
	return false;
} // end outboundListUp1()
