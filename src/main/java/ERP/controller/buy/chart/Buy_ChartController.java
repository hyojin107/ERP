package ERP.controller.buy.chart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/buy/chart")
public class Buy_ChartController {
	
	@GetMapping
	public String form() {
		return "buy/chart/chartView";
	}
	
}
