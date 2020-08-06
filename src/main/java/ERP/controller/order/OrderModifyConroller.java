package ERP.controller.order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

import ERP.service.order.IOrderService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.order.OrderListVO;
import vo.order.OrderVO;

@Controller
@RequestMapping("/order/order/{or_no}")
public class OrderModifyConroller {
	
	@Inject
	IOrderService service;
	
	
	
	@GetMapping("form")
	public String updateForm(
			@PathVariable(required = true) String or_no, Model model
	) {
		int or_num = Integer.parseInt(or_no);
		OrderVO order = service.readOrder(or_num);
		model.addAttribute("order", order);
		model.addAttribute("currentAction", "/order/estimate"+or_num);
		
		return "order/order/orderForm";
	}
	
	@PutMapping
	public String update(
		@Validated(UpdateGroup.class)
		@ModelAttribute("order") OrderVO order,
		@ModelAttribute("orderList") OrderListVO orderList,
		@RequestParam(required = false) int[] orp_no,
		@RequestParam(required = false) String[] prod_no,
		@RequestParam(required = false) int[] or_no,
		@RequestParam(required = false) int[] orp_qty,
		@RequestParam(required = false) int[] orp_price,
		Errors errors, Model model, @RequestParam(required = false) String currentPage,
		RedirectAttributes redirectAttribute
	) throws IllegalStateException, IOException {
		
	//------------------------------------orderList 담기
		List<OrderListVO> list = new ArrayList<>();
		if(or_no!=null) {
			for(int i= 0; i<or_no.length; i++) {
				OrderListVO vo = new OrderListVO();
				vo.setOr_no(orderList.getOr_no());
				vo.setOrp_no(orp_no[i]);
				vo.setProd_no(prod_no[i]);
				vo.setOrp_qty(orp_qty[i]);
				vo.setOrp_price(orp_price[i]);
				list.add(vo);
			}
		}
		order.setOrderList(list);

	//------------------------------------
		
		model.addAttribute("currentAction", "/order/order/orderList"+order.getOr_no());
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modityOrder(order);
			for(int i=0; i<list.size(); i++) {
				ServiceResult restutList = service.modityOrderList(list.get(i));
			}
			
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도하세요";
				goPage = "redirect:/order/order/"+order.getOr_no()+"/form";
				break;

			default: //ok
				goPage = "redirect:/order/order";
				redirectAttribute.addFlashAttribute("lastUpdate", order);
				break;
			}
		}else {
			goPage = "redirect:/order/order/"+order.getOr_no()+"/form";
		}
		
		model.addAttribute("message", message);
//		return "order/order/orderList";
		return goPage;
	}
	
}
