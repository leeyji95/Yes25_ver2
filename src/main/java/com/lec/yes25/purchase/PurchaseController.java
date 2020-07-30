package com.lec.yes25.purchase;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/purchasing/*.do")
public class PurchaseController {	
	@RequestMapping(value = "/purchasing/vendor.do")
	public String showVendorPage() {
		return "purchase/vendor";
	}
	
	@RequestMapping(value = "/purchasing/order.do")
	public String showOrderPage() {
		return "purchase/order";
	}
	
	@RequestMapping(value = "/purchasing/status.do")
	public String showStatusPage() {
		return "purchase/status";
	}
}
