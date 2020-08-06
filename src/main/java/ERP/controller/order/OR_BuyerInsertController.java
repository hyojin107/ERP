package ERP.controller.order;

import java.util.List;

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

import ERP.service.IBuyerService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.BuyerVO;
import vo.RuleVO;

@Controller
@RequestMapping("/order/buyer")
public class OR_BuyerInsertController {
	@Inject
	IBuyerService service;
	
	@GetMapping("form")
	public String insertForm(Model model) {
		List<RuleVO> ruleList = service.readRuleList();
		model.addAttribute("ruleList", ruleList);
		model.addAttribute("currentAction", "/buyer");
		return "order/buyer/or_buyerForm";
	}
	
	@PostMapping
	public String insert(@Validated(InsertGroup.class) @ModelAttribute BuyerVO buyer, BindingResult errors
						, @RequestParam(required=false) String currentPage
						, Model model) {
		model.addAttribute("currentAction", "/buyer");
		
		
		
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBuyer(buyer, "M");
			switch(result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "order/buyer/form";
				break;
			default:	//OK
				goPage = "redirect:/order/buyer/buyerList?page="+currentPage;	//상세보기 페이지
				break;
			}
		}else {
			goPage = "order/buyer/form";
		}
		model.addAttribute("message", message);
		return goPage;
	}
}
