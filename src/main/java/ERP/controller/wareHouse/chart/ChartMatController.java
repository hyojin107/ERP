package ERP.controller.wareHouse.chart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("chart/matprod")
public class ChartMatController {

	// 차트 : 원자재별, 상품별  입고출고폐기현황 보여주기

	// 원자재별 입고 
	// 원자재별 출고 
	// 원자재별 폐기 
	@GetMapping("matenter")
	public String ChartMatEnterGet() {
		
		return "wh/chart/chartMP";
	}
	
}
