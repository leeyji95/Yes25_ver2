package com.lec.yes25.financial.ajax;

public class AjaxIcomeResult {
	private String status;			// 처리결과
	private String message;			// 결과 메시지
	
	private int netSales;			// 매출액
	private int costOfGoodsSold;	// 매출원가
	private int maintenanceSales;	// 판매비와 관리비
	private int etcIncome;			// 기타수익 
	private int etcCost;			// 기타비용
	private int corporateTax;		// 법인세비용
	
	// 생성자
	public AjaxIcomeResult() {}

	// getter / setter
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public int getNetSales() {
		return netSales;
	}
	public void setNetSales(int netSales) {
		this.netSales = netSales;
	}

	public int getCostOfGoodsSold() {
		return costOfGoodsSold;
	}
	public void setCostOfGoodsSold(int costOfGoodsSold) {
		this.costOfGoodsSold = costOfGoodsSold;
	}

	public int getMaintenanceSales() {
		return maintenanceSales;
	}
	public void setMaintenanceSales(int maintenanceSales) {
		this.maintenanceSales = maintenanceSales;
	}

	public int getEtcIncome() {
		return etcIncome;
	}
	public void setEtcIncome(int etcIncome) {
		this.etcIncome = etcIncome;
	}

	public int getEtcCost() {
		return etcCost;
	}
	public void setEtcCost(int etcCost) {
		this.etcCost = etcCost;
	}

	public int getCorporateTax() {
		return corporateTax;
	}
	public void setCorporateTax(int corporateTax) {
		this.corporateTax = corporateTax;
	}

}