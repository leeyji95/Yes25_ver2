var start = '2019-01-01';	// 기본값 2019년
var end = '2019-12-31';		// 기본값 2019년

$(document).ready(function() {
	
	//alert(start + ' ' + end);
	loadIncomeView(start, end);
	
	// 검색 카테고리
	$("#choiceYear").change(function() {
		
		var select = $("#choiceYear option:selected").val();
		
		switch(select) {
		case '2019':
			start = '2019-01-01';
			end = '2019-12-31';
			loadIncomeView(start, end);
			break;
		case '2018':
			start = '2018-01-01';
			end = '2018-12-31';
			loadIncomeView(start, end);
			break;
		}
	});
	
});

// 손익계산서 로딩
function loadIncomeView(start, end) {
	$.ajax({
		url : "incomeView.ajax?startDate=" + start + "&endDate=" + end
		, type : "GET"
		, cache : false
		, success : function(data, status) {
			if(status == "success") {
				if(data.status == "OK") {
					// 매출액
					$("input[name=netSales]").val(data.netSales);
					$(".netSales").text(numberFormat(data.netSales));
					
					// 매출원가
					$("input[name=costOfGoodsSold]").val(data.costOfGoodsSold);
					$(".costOfGoodsSold").text(numberFormat(data.costOfGoodsSold));
					
					// 매출총이익 = 매출액 - 매출원가
					grossProfit = $("input[name=netSales]").val() - $("input[name=costOfGoodsSold]").val();
					$("input[name=grossProfit]").val(grossProfit);
					$(".grossProfit").text(numberFormat(grossProfit));
					
					// 판매비와 관리비
					$("input[name=maintenanceSales]").val(data.maintenanceSales);
					$(".maintenanceSales").text(numberFormat(data.maintenanceSales));
					
					// 영업이익 = 매출총이익 - 판관비
					salesIcome = grossProfit - $("input[name=maintenanceSales]").val();
					$("input[name=salesIcome]").val(salesIcome);
					$(".salesIcome").text(numberFormat(salesIcome));

					// 기타 수익
					$("input[name=etcIncome]").val(data.etcIncome);
					$(".etcIncome").text(numberFormat(data.etcIncome));
					
					// 기타 비용
					$("input[name=etcCost]").val(data.etcCost);
					$(".etcCost").text(numberFormat(data.etcCost));
					
					// 법인세비용차감전순이익
					corporateTaxIncome = $("input[name=etcIncome]").val() - $("input[name=etcCost]").val() + salesIcome;
					$("input[name=corporateTaxIncome]").val(corporateTaxIncome);
					$(".corporateTaxIncome").text(numberFormat(corporateTaxIncome));
					
					// 법인세비용
					$("input[name=corporateTax]").val(data.corporateTax);
					$(".corporateTax").text(numberFormat(data.corporateTax));
					
					// 당기순이익
					currentIncome = corporateTaxIncome - $("input[name=corporateTax]").val();
					$("input[name=currentIncome]").val(currentIncome);
					$(".currentIncome").text(numberFormat(currentIncome));
					
				} else {
					alert("손익 계산서 생성 실패 " + data.status + " : " + data.message);
				}
			}
		}
	});
} // end loadIncomeView()
// 숫자 천단위마다 콤마 찍는 함수
function numberFormat(inputNumber) {
	return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}