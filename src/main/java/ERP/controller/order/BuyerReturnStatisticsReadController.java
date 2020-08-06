package ERP.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/statistics")
public class BuyerReturnStatisticsReadController {
	
	@GetMapping
	public String list() {
		return "order/buyerReturnStatisticsList";
	}
	
//	@GetMapping
//	public String view() {
//		
//	}
}
