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

import ERP.dao.order.IEstimateDAO;
import ERP.dao.order.IOrderDAO;
import ERP.service.order.IOrderService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.order.OrderListVO;
import vo.order.OrderVO;


@Controller
@RequestMapping("/order/order")
public class OrderInsertController {
	@Inject
	IOrderService service;
	
	@Inject
	IOrderDAO dao;
	
	@Inject
	IEstimateDAO estimatedao;
	
	private void attribuet(Model model) {
		model.addAttribute("lprodList", estimatedao.selectAllProdLgu());
	}
	
	@ModelAttribute
	public String currentAction() {
		return "/order/order/order";
	}
	
	@GetMapping("form")
	public String form(
			@ModelAttribute("order") OrderVO order, Model model) {
		attribuet(model);
		return "order/order/orderForm";
	}
	
	@PostMapping
	public String insert(
			@Validated(InsertGroup.class)
			@ModelAttribute("order") OrderVO order, BindingResult errors,
			Model model
			
	) {
		
		//주문서 상품목록   PK만들기
		int orpPK = dao.selectOrpNo();
		int orpSize = order.getOrderList().size();
		if(orpSize != 0) {
			for(OrderListVO listVO : order.getOrderList()) {
				listVO.setOrp_no(orpPK++);
			}
		}
		
		String goPage = null;
		String message = null;
		
		System.out.println("order 인서트 컨트롤러까지 왔음");
		if(order!=null) {
			ServiceResult result = service.createOrder(order);
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도하세요";
				goPage = "order/orderForm";
				break;

			default: //OK
				goPage = "redirect:/order/order";
				break;
			}
		}else {
			goPage = "order/orderForm";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
//		return "order/order/orderList";
	}
}
