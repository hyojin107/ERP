package ERP.controller.wareHouse.chart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("chart/period")
public class ChartPeriodController {

	// 기간별 입고, 출고 폐기 현황
	@GetMapping
	public String PeriodGet() {
		return "wh/chart/chartPeriod";
	}
}
