package ERP.controller.order.ret;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/return")
public class Or_ReturnPInsertController {
	
	@GetMapping("form")
	public String form() {
		return "order/ret/orderReturnForm";
	}
	
	@PostMapping
	public String insert() {
		
		return "order/ret/orderReturnList";
	}

}
