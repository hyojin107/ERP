package ERP.controller.buy;

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
import validate.groups.UpdateGroup;
import vo.BuyerVO;
import vo.RuleVO;

@Controller
@RequestMapping("/buyer/{buyer_no}")
public class BuyerModify {
	@Inject
	IBuyerService service;
	
	@GetMapping("form")
	public String updateForm(@PathVariable(required = true) String buyer_no, Model model) {
		List<RuleVO> ruleList = service.readRuleList();
		model.addAttribute("ruleList", ruleList);
		if(!model.containsAttribute("buyer")) {
			BuyerVO buyer = service.readBuyer(buyer_no);
			model.addAttribute("buyer", buyer);
		}
		model.addAttribute("currentAction", "/buyer/"+buyer_no);
		return "buyerForm";
	}
	
	@PutMapping
	public String update(@Validated(UpdateGroup.class) @ModelAttribute BuyerVO buyer
						 , BindingResult errors, Model model, RedirectAttributes redirectAttributes) {
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyBuyer(buyer);
			switch(result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				redirectAttributes.addFlashAttribute("buyer", buyer);
				goPage = "redirect:/buyer/{buyer_no}/form";
				break;
			default:
				goPage = "redirect:/buyer/buyerList";
				break;
			}
		}else {
			goPage = "redirect:/buyer/{buyer_no}/form";
			redirectAttributes.addFlashAttribute("buyer", buyer);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.buyer", errors);
		}
		redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
	
	@DeleteMapping
	public String delete(@ModelAttribute("buyer") BuyerVO buyer, BindingResult errors,
						 RedirectAttributes redirectAttributes) {
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.removeBuyer(buyer.getBuyer_no());
			switch (result) {
			case FAIL:
				message = "잠시후에 다시 시도해주세요.";
				goPage = "redirect:/buyer/{buyer_no}";
				break;
			default: // OK
				goPage = "redirect:/buyer/buyerList";
				break;
			}
		} else {
			goPage = "redirect:/buyer/{buyer_no}";
		}
		redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
}

