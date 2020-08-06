package ERP.controller.buy;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.dao.buy.IBuy_PurchaseDAO;
import enums.ServiceResult;
import vo.buy.Buy_PurchaseVO;

@Controller
@RequestMapping("/buy/purchase")
public class PurchaseInsert {
	
	@Inject
	IBuy_PurchaseDAO dao;
	
	@GetMapping("form")
	public String form() {
		return "buy/purchase/purchaseForm";
	}
	
	@PostMapping
	public String insert(Buy_PurchaseVO vo, BindingResult errors, Model model) {
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			int cnt = dao.insertPurchase(vo);
			if(cnt<0) {
				message = "잠시 후 다시 시도해주세요";
				goPage = "buy/order/buyOrderForm";
			}
			else {
				System.out.println("매입서 등록 성공");
				goPage = "redirect:/buy/purchase";
			}
		}else {
			goPage = "buy/order/buyOrderForm";
		}
		model.addAttribute("message", message);
		
		return goPage;
	}
	
}
