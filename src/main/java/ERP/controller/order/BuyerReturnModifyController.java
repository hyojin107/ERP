package ERP.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/buyerReturn/{or_retp_no}")
public class BuyerReturnModifyController {
	
	@DeleteMapping
	public String delete() {
		return "order/buyerReturn/buyerReturnList";
	}
	
	@GetMapping("form")
	public String form() {
		return "order/buyerReturn/buyerReturnForm";
	}
	
	@PutMapping
	public String update() {
		return "order/buyerReturn/buyerReturnList";
	}
}
