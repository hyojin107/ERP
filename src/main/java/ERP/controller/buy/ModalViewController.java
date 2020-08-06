package ERP.controller.buy;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.service.buy.IModalViewService;
import vo.BuyerVO;
import vo.emp.EmployeeVO;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/buy/document")
public class ModalViewController {
	
	@Inject
	IModalViewService service;
	
	@GetMapping("empModal")
	public String empList(Model model) {
		List<EmployeeVO> empList = service.readEmpModal();
		model.addAttribute("empList", empList);
		return "/buy/document/modalEmp";
	}
	
	@GetMapping("matModal")
	public String matList(Model model) {
		List<MaterialVO> matList = service.readMatModal();
		model.addAttribute("matList", matList);
		return "/buy/document/modalMat";
	}
	
	@GetMapping("buyerModal")
	public String buyerList(Model model) {
		List<BuyerVO> buyerList = service.readBuyerModal();
		model.addAttribute("buyerList", buyerList);
		return "/buy/document/modalBuyer";
	}
	
}
