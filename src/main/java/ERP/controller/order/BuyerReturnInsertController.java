package ERP.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/buyerReturn")
public class BuyerReturnInsertController {
	
	@GetMapping("form")
	public String form() {
		return "order/buyeerReturn/buyerReturnForm";
	}
	
	public String insert() {
		
		return "order/buyerReturn/buyerReturnList";
	}
}
