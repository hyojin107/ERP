package ERP.controller.order.ret;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/return")
public class Or_ReturnPReadController {
	
	@GetMapping
	public String list() {
		
		return "order/ret/orderReturnList";
	}
	
}
