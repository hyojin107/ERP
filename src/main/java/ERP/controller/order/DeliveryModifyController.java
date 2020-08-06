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

import ERP.service.order.IDeliveryOrderService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.order.DeliveryOrderVO;
import vo.order.EstimateListVO;
import vo.order.EstimateVO;

@Controller
@RequestMapping("/order/delivery/{deliv_no}")
public class DeliveryModifyController {
	
	@Inject
	IDeliveryOrderService service;
	
	
	
	@GetMapping("form")
	public String updateForm(
			@PathVariable(required = true) String deliv_no, Model model
	) {
		//숫자로 변환 deliv_no 가 이제 deliv_no 임!
		int deliv_num = Integer.parseInt(deliv_no);
		DeliveryOrderVO delivery = service.readDelivery(deliv_num);
		model.addAttribute("delivery", delivery);
		model.addAttribute("currentAction", "/order/delivery/"+deliv_num);
		
		return "order/delivery/deliveryForm";
	}
	
	@PutMapping
	public String update(
			@Validated(UpdateGroup.class) 
			@ModelAttribute("delivery") DeliveryOrderVO delivery,
			Errors errors, Model model, @RequestParam(required = false) String currentPage,
			RedirectAttributes redirectAttribute		
	) throws IllegalStateException, IOException {
		
		System.out.println("    put매핑");
		model.addAttribute("currentAction", "/order/delivery/deliveryList"+delivery.getDeliv_no());
		
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyDelivery(delivery);
			
			switch (result) {
			case FAIL:
				System.out.println("    실패");
				message ="잠시후에 다시 시도하세요";
				goPage = "redirect:/order/delivery/"+delivery.getDeliv_no()+"/form";
				break;

			default: //OK
//				goPage = "redirect:/order/delivery/delivery/?page="+currentPage;
				System.out.println("    성공");
				goPage = "redirect:/order/delivery";
				redirectAttribute.addFlashAttribute("lastUpdateDelivery", delivery);
				break;
			}
		}else {
			System.out.println("    엘스탐");
			goPage ="redirect:/order/delivery/"+delivery.getDeliv_no()+"/form";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
//		return "order/delivery/deliveryList";
	}
}
