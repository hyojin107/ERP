package ERP.controller.order.ret;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/return")
public class Or_ReturnPModifyController {
	
	@DeleteMapping
	public String delete() {
		
		return null;
	}
	
}
