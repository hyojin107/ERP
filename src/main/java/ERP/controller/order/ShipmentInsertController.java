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
import ERP.service.order.IShipmentService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.order.DeliveryOrderVO;
import vo.order.ShipmentVO;

@Controller
@RequestMapping("/order/shipment")
public class ShipmentInsertController {
	
	@Inject
	IShipmentService service;
	
	@Inject
	IDeliveryOrderService deService;
	
	@ModelAttribute
	public String currentAction() {
		return "/order/shipment/shipment";
	}
	
	@GetMapping("form")
	public String form(
			@RequestParam(required = false) Integer deliv_no, Model model
	) {
		//라디오버튼 눌러서 바로 출하등록 페이지로 올경우
		if(deliv_no!=null) {
			DeliveryOrderVO delivery = deService.readDelivery(deliv_no);
			model.addAttribute("delivery", delivery);
		}
		
		return "order/shipment/shipmentForm";
	}
	
	@PostMapping
	public String insert(
			@Validated(InsertGroup.class) ShipmentVO shipment, BindingResult errors,
			Model model
			
	) {
		String goPage = null;
		String message = null;
		
		System.err.println(shipment);
		System.err.println("출하 인서트 컨트롤러까지 옴");
		
		if(shipment!=null) {
			ServiceResult result = service.createShipment(shipment);
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도하세요";
				goPage = "order/shipmentForm";
				break;

			default: //OK
				goPage = "redirect:/order/shipment";
				break;
			}
		}else {
			goPage = "order/shipmentForm";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
		
//		return "order/shipment/shipmentList";
	}
	
}
