package ERP.controller.order;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.order.IShipmentService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.order.ShipmentVO;

@Controller
@RequestMapping("/order/shipment/{ship_no}")
public class ShipmentModifyConroller {
	@Inject
	IShipmentService service;
	
	@DeleteMapping
	public String delete() {
		
		return "order/shipment/shipmentList";
	}
	
	@GetMapping("form")
	public String updateForm(
			@PathVariable(required = true) String ship_no, Model model
	) {
		int ship_num = Integer.parseInt(ship_no);
		ShipmentVO shipment = service.readShipment(ship_num);
		model.addAttribute("shipment", shipment);
		model.addAttribute("currentAction", "/order/shipment/"+ ship_num);
		
		return "order/shipment/shipmentForm";
	}
	
	@PutMapping
	public String update(
			@Validated(UpdateGroup.class)
			@ModelAttribute("shipment") ShipmentVO shipment,
			Errors errors, Model model, @RequestParam(required = false) String currentPage,
			RedirectAttributes redirectAttribute 
	) throws IllegalStateException, IOException {
		
		System.err.println("   출하 put 매핑");
		model.addAttribute("currentAction", "/order/shipment/shipmentList/" + shipment.getShip_no());
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyShipment(shipment);
			
			switch (result) {
			case FAIL:
				System.err.println("  출하 수정 실패");
				message ="잠시후에 다시 시도하세요";
				goPage = "redirect:/order/shipment/"+shipment.getShip_no()+"/form";
				break;

			default: //OK
				System.err.println("   출하 수정 성공");
				goPage = "redirect:/order/shipment";
				redirectAttribute.addFlashAttribute("lastUpdateShipment", shipment);
				break;
			}
		}else {
			System.err.println("   출하 else 탐");
			goPage ="redierect:/order/shipment/"+shipment.getShip_no()+"/form";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
//		return "order/shipment/shipmentList";
	}
}
