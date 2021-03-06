package com.lec.yes25.logistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/logistics/*.ajax")
public class LogisticsAjaxController {

	@RequestMapping("/logistics/inventory.ajax")
	public LogisticsAjaxWriteList inventory(HttpServletRequest request, HttpServletResponse response) { 
		return null;
	}
	
	@RequestMapping("/logistics/inboundList.ajax")
	public LogisticsAjaxWriteList inboundList(HttpServletRequest request, HttpServletResponse response) { 
		new InboundListCommand().execute(request, response);
		return bulidList(request);
	}

	@RequestMapping("/logistics/inboundQuery1.ajax")
	public LogisticsAjaxWriteList inboundQuery1(HttpServletRequest request, HttpServletResponse response) { 
		new InboudQuery1Command().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/inboundQuery2.ajax")
	public LogisticsAjaxWriteList inboundQuery2(HttpServletRequest request, HttpServletResponse response) { 
		new InboudQuery2Command().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/inboundUpdate.ajax")
	public LogisticAjaxWriteResult update(HttpServletRequest request, HttpServletResponse response) {
		new InboundUpdateCommand().execute(request, response);
		return buildResult(request);
	}
	
	@RequestMapping("/logistics/outboundList.ajax")
	public LogisticsAjaxWriteList outboundList(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundListCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundQuery1.ajax")
	public LogisticsAjaxWriteList outboundQuery1(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundQuery1Command().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundQuery2.ajax")
	public LogisticsAjaxWriteList outboundQuery2(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundQuery2Command().execute(request, response);
		return bulidList(request);
	}

	@RequestMapping("/logistics/outboundUpdate.ajax")
	public LogisticAjaxWriteResult outboundUpdate(HttpServletRequest request, HttpServletResponse response) {
		new OutboundUpdateCommand().execute(request, response);
		return buildResult(request);
	}
	
	@RequestMapping("/logistics/stockList.ajax")
	public LogisticsAjaxWriteList stockList(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundListCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/stockQuery.ajax")
	public LogisticsAjaxWriteList stockQuery(HttpServletRequest request, HttpServletResponse response) { 
		new StockQueryCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/excel.ajax")
	public String excel(HttpServletRequest request, HttpServletResponse response) { 
		new ExcelCommand().execute(request, response);
		String returnURL="redirect:/logistics/stock";
		return returnURL;
	}
	
	@RequestMapping("/logistics/inboundKpiList.ajax")
	public LogisticsAjaxWriteList inboundKpiList(HttpServletRequest request, HttpServletResponse response) { 
		new InboundKpiListCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundKpiList.ajax")
	public LogisticsAjaxWriteList OutboundKpiList(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundKpiListCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/inboundKpiUpdate.ajax")
	public LogisticsAjaxWriteList inboundKpiUpdate(HttpServletRequest request, HttpServletResponse response) { 
		new InboundKpiUpdateCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundKpiUpdate.ajax")
	public LogisticsAjaxWriteList OutboundKpiUpdate(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundKpiUpdateCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/inboundKpiInform.ajax")
	public LogisticsAjaxWriteList inboundKpiInform(HttpServletRequest request, HttpServletResponse response) { 
		new InboundKpiInformCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundKpiInform.ajax")
	public LogisticsAjaxWriteList outboundKpiInform(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundKpiInformCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/inboundKpiInformUpdate.ajax")
	public LogisticsAjaxWriteList inboundKpiInformUpdate(HttpServletRequest request, HttpServletResponse response) { 
		new InboundKpiInformUpdateCommand().execute(request, response);
		return bulidList(request);
	}
	
	@RequestMapping("/logistics/outboundKpiInformUpdate.ajax")
	public LogisticsAjaxWriteList outboundKpiInformUpdate(HttpServletRequest request, HttpServletResponse response) { 
		new OutboundKpiInformUpdateCommand().execute(request, response);
		return bulidList(request);
	}
	

	
	public LogisticAjaxWriteResult buildResult(HttpServletRequest request) {
		LogisticAjaxWriteResult result = new LogisticAjaxWriteResult();
		
		result.setStatus((String)request.getAttribute("status"));
		result.setMessage((String)request.getAttribute("message"));
		result.setCount((Integer)request.getAttribute("result"));

		
		return result;
	} // end buildResult
	
	@SuppressWarnings("unchecked")
	public LogisticsAjaxWriteList bulidList(HttpServletRequest request) {
		List<?> data = (List<?>)request.getAttribute("data");
		LogisticsAjaxWriteList result = new LogisticsAjaxWriteList();
		result.setStatus((String)request.getAttribute("status"));
		result.setMessage((String)request.getAttribute("message"));
		
		if(data != null) {
			result.setCount(data.size());
			result.setData(data);
		}
		

		
		return result;
	} // end bulidList;
		
	
	
	
	
	
	
	
	
} // end LogisticsAjaxController
