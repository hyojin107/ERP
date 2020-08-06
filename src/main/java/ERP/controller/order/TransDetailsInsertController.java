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

import ERP.service.order.IShipmentService;
import ERP.service.order.ITransDetalisService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.order.ShipmentVO;
import vo.order.TransDetailsVO;

@Controller
@RequestMapping("/order/transDetails")
public class TransDetailsInsertController {
	
	@Inject
	ITransDetalisService service;
	
	@Inject
	IShipmentService shipService;
	
	@ModelAttribute
	public String currentAction() {
		return "/order/transDetails/shipment";
	}
	
	@GetMapping("form")
	public String form(
		@RequestParam(required = false) Integer ship_no, Model model
	) {
		//출하에서 라디오 버튼을 눌러서 온다면
		if(ship_no!=null) {
			ShipmentVO shipment = shipService.readShipment(ship_no);
			model.addAttribute("shipment", shipment);
		}
		
		return "order/transDetails/transDetailsForm";
	}
	
	@PostMapping
	public String insert(
			@Validated(InsertGroup.class) TransDetailsVO transDetails, BindingResult errors,
			Model model
	) {
		String goPage = null;
		String message = null;
		
		System.err.println(transDetails);
		System.err.println("거래명세서 인서트 컨트롤러까지 옴");
		
		if(transDetails!=null) {
			ServiceResult result = service.createTransD(transDetails);
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도하세요";
				goPage = "order/transDetails/transDetailsForm";
				break;

			default: //OK
				goPage = "redirect:/order/transDetails";
				break;
			}
		}else {
			goPage = "order/transDetails/transDetailsForm";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
		
//		return "order/transDetails/transDetailsList";
	}
}
