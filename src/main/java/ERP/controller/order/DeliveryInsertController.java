package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ERP.service.order.IDeliveryOrderService;
import ERP.service.order.IOrderService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.order.DeliveryOrderVO;
import vo.order.OrderVO;

@Controller
@RequestMapping("/order/delivery")
public class DeliveryInsertController {
	
	@Inject
	IOrderService ORservice;
	
	@Inject
	IDeliveryOrderService service;
	
	@ModelAttribute
	public String currentAction() {
		return "/order/delivery/delivery";
	}
	
	@GetMapping("form")
	public String form(@RequestParam(required = false) Integer or_no, Model model) {

		if(or_no!=null) {
			OrderVO orderVO = ORservice.readOrder(or_no);
			model.addAttribute("order", orderVO);
		}
		
//		OrderListVO orderListVO = service.readOrderList(Integer.parseInt(or_no));
		return "order/delivery/deliveryForm";
	}
	
	@PostMapping
	public String insert(
			@Validated(InsertGroup.class) DeliveryOrderVO delivery, BindingResult errors,
			Model model
	) {
		
		String goPage = null;
		String message = null;
		
		System.err.println("출하ㅏ지시서 인서트 컨트롤러까지 옴");
		if(delivery!=null) {
			ServiceResult result = service.createDelivery(delivery);
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도하세요";
				goPage = "order/deliveryForm";
				break;

			default: //OK
				goPage = "redirect:/order/delivery";
				break;
			}
		}else {
			goPage = "order/deliveryForm";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
				
		
//		return "order/delivery/orderList";
	}
}
