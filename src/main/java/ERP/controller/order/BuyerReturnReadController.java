package ERP.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/buyerReturn")
public class BuyerReturnReadController {
	
	@GetMapping
	public String list() {
		return "order/buyerReturn/buyerReturnList";
	}
	
	@GetMapping("{or_retp_no}")
	public String view() {
		return "/order/buyerReturn/buyerReturnView";
	}
}
