package ERP.controller.account;

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
@RequestMapping("/account/basic/buyer")
public class BuyerInsertController {
	@Inject
	IBuyerService service;
	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/account/basic/buyer";
	}
	
	@GetMapping("form")
	public String form(Model model) {
		List<RuleVO> ruleList = service.readRuleList();
		model.addAttribute("ruleList", ruleList);
		return "account/buyer/buyerForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("buyer") BuyerVO buyer, BindingResult errors,
		Model model, @RequestParam(required=false) String currentPage
	) {
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createBuyer(buyer, "A");
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "account/buyer/buyerForm";
				break;
			default: // OK
				goPage = "redirect:/account/basic/buyer?page="+currentPage;
				break;
			}
		} else {
			goPage = "account/buyer/buyerForm";
		}

		model.addAttribute("message", message);

		return goPage;
	}
}
