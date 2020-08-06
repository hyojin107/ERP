package ERP.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/prod")
public class OrderProdReadController {

	@GetMapping
	public String list() {
		return "order/order_prodList";
	}
	
	@GetMapping("{prod_no}")
	public String view() {
		
		return "order/order_prodView";
	}
}
