package ERP.controller.account;

import javax.inject.Inject;

import org.springframework.http.MediaType;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.account.IAccountService;
import enums.ServiceResult;
//
///account/글번호/form	:		AccountModifyController.form
///account/글번호(PUT)	:		AccountModifyController.update
///account/글번호(DELETE)	:	AccountModifyController.delete
import validate.groups.UpdateGroup;
import vo.account.AccountVO;

@Controller
@RequestMapping("/account/basic/account/{account_no}")
public class AccountModifyController {
	@Inject
	IAccountService service;
	
	@ModelAttribute("currentAction")
	public String currentAction(@PathVariable(required = true) int account_no) {
		return "/account/basic/account/"+account_no;
	}
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}

	
	@PutMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Integer update(
		@Validated(UpdateGroup.class) @ModelAttribute("account") AccountVO account, 
		BindingResult errors
	){
		int result = 0;
		if (!errors.hasErrors()) {
			result =  service.modifyAccount(account);
		}
		return result;
	}
	
	@DeleteMapping
	public String delete(
			@ModelAttribute("account") AccountVO account, 
			BindingResult errors, RedirectAttributes redirectAttributes
			){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.removeAccount(account);
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "redirect:/account/{account_no}";
				break;
			default: // OK
				goPage = "redirect:/account";
				break;
			}
		} else {
			goPage = "redirect:/account/{account_no}";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		
		return goPage;
		
	}
	
}


