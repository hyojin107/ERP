package ERP.controller.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.IBuyerService;
import enums.ServiceResult;
//
///buyer/글번호/form	:		BuyerModifyController.form
///buyer/글번호(PUT)	:		BuyerModifyController.update
///buyer/글번호(DELETE)	:	BuyerModifyController.delete
import validate.groups.UpdateGroup;
import vo.BuyerVO;
import vo.RuleVO;

@Controller
@RequestMapping("/account/basic/buyer/{buyer_no}")
public class BuyerModifyController {
	@Inject
	IBuyerService service;
	
	@ModelAttribute("currentAction")
	public String currentAction(@PathVariable(required = true) String buyer_no) {
		return "/account/basic/buyer/"+buyer_no;
	}
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}
	
	@GetMapping("form")
	public String updateForm(@PathVariable(required = true) String buyer_no, Model model) {
		List<RuleVO> ruleList = service.readRuleList();
		model.addAttribute("ruleList", ruleList);
		if(!model.containsAttribute("buyer")) {
			BuyerVO buyer = service.readBuyer(buyer_no);
			model.addAttribute("buyer", buyer);
		}
		return "account/buyer/buyerForm";
	}
	
	@PutMapping
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("buyer") BuyerVO buyer, 
		BindingResult errors,
		RedirectAttributes redirectAttributes
	){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyBuyer(buyer);
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				redirectAttributes.addFlashAttribute("buyer", buyer);
				goPage = "redirect:/account/basic/buyer/{buyer_no}/form";
				break;
			default: // OK
				goPage = "redirect:/account/basic/buyer";
				break;
			}
		} else {
			goPage = "redirect:/account/basic/buyer/{buyer_no}/form";
			redirectAttributes.addFlashAttribute("buyer", buyer);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.buyer", errors);
		}
		redirectAttributes.addFlashAttribute("message", message);

		return goPage;
		
	}
	
	@DeleteMapping
	public String delete(@ModelAttribute("buyer") BuyerVO buyer, BindingResult errors,
			RedirectAttributes redirectAttributes){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.removeBuyer(buyer.getBuyer_no());
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도해주세요.";
				goPage = "redirect:/account/basic/buyer/{buyer_no}";
				break;
			default: // OK
				goPage = "redirect:/account/basic/buyer";
				break;
			}
		} else {
			goPage = "redirect:/account/basic/buyer/{buyer_no}";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
}
