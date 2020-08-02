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
	});

	$("#btnDay").click(function() {
		$("#btnDay").disabled = true;
		$("#btnMonth").disabled = false;
		flag = 0;
		update1();
	});
	
/*	$("#datepicker1, #datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    changeMonth: true,
	    changeYear: true,
	    yearSuffix: '년',
        yearRange: "-100:+0"
	});*/

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
